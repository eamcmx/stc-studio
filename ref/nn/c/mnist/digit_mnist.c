/* digit_mnist.c: the MNIST reader (196-32-10) in C for the 8051, to compare with ref/nn/mnist/digit_mnist.a51, which
 * nn/gen51.py writes. The same network and 8-bit weights (weights.h, made by nn/write_c_headers.py), the same serial
 * protocol (D + 196 characters 1 or 0 in, "=7" + 10 scores in hex out, 19200 baud) and the same display. The inputs
 * are kept as bits, 8 to a byte, first input in bit 7, as in the assembly: 196 bytes do not fit the internal RAM.
 * Written the way digit_nn.c is (byte loop counters where they fit, arrays in idata, layer 1 as additions only, a
 * 16-bit product in layer 2). The program is 7.5 KB, beyond the 2 KB of Keil's evaluation version, so it is compiled
 * with SDCC (tools/sdcc_c.ps1); compat51.h maps the keywords.
 *   DEFINE(TUNED) / -DTUNED  C written for the 8051: a running mask over the input bytes, pointers through the tables,
 *                            8 x 8 unsigned products (MUL AB)
 */
#include "compat51.h"
#include "weights.h"

unsigned char idata pix[(NIN + 7) / 8];   /* the inputs, 8 to a byte, first in bit 7 */
int idata acc[NH];                        /* layer 1 sums */
unsigned char idata hid[NH];              /* hidden values, 0 to 255 */
long idata score[10];                     /* layer 2 sums, one per digit */
unsigned char data dbuf[4];               /* segment patterns for digits 1 to 4 */
unsigned char data digi;                  /* the digit the display shows now */

unsigned char code dsel[4] = { 0xF7, 0xEF, 0xDF, 0xBF };   /* P1.3 to P1.6 low */
unsigned char code segs[10] = { 0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90 };
char code hexd[] = "0123456789ABCDEF";

/* Timer 0, every 256 machine cycles: the next digit of the display (register bank 1, like the assembly) */
void t0_isr(void) T0_ISR
{
    P1 = 0xFF;
    digi = (digi + 1) & 3;
    P0 = dbuf[digi];
    P1 = dsel[digi];
}

static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
static void puts_(char code *s) { while (*s) putc_(*s++); }

void main(void)
{
    unsigned char i, j, k, best, b;
    int a;
    long s;
    unsigned long u;
#ifdef TUNED
    signed char code *w;
    int idata *p;
    unsigned char idata *q;
    signed char wv;
    unsigned char hv, m, mask, byte;
#endif

    dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
    dbuf[2] = dbuf[3] = 0xBF;
    digi = 0;
    TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
    TH1 = TL1 = 0xFD;
    PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
    SCON = 0x50;
    TH0 = TL0 = 0;
    TR1 = 1; TR0 = 1; ET0 = 1; EA = 1;
    puts_("NN READY\r\n");

    for (;;) {
        while (getc_() != 'D') ;
        b = 0;
        for (i = 0; i < NIN; i++) {
            b = (b << 1) | (getc_() == '1');
            if ((i & 7) == 7) { pix[i >> 3] = b; b = 0; }
        }
        if (NIN & 7) pix[NIN >> 3] = b << (8 - (NIN & 7));

        /* layer 1: bias, plus the weights of every lit input */
        for (j = 0; j < NH; j++) acc[j] = B1[j];
#ifdef TUNED
        /* a running mask over the input bytes, a pointer through the table */
        w = &W1[0][0];
        q = pix; byte = *q; mask = 0x80;
        for (i = 0; i < NIN; i++, w += NH) {
            if (byte & mask) {
                p = acc;
                for (j = 0; j < NH; j++) *p++ += w[j];
            }
            mask >>= 1;
            if (!mask) { mask = 0x80; byte = *++q; }
        }
#else
        for (i = 0; i < NIN; i++)
            if (pix[i >> 3] & (0x80 >> (i & 7)))
                for (j = 0; j < NH; j++) acc[j] += W1[i][j];
#endif
        /* ReLU, then >> SH1, at most 255 */
        for (j = 0; j < NH; j++) {
            a = acc[j];
            if (a < 0) hid[j] = 0;
            else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
        }

        /* layer 2: bias plus hidden * weight */
        for (k = 0; k < 10; k++) {
            s = B2[k];
#ifdef TUNED
            w = W2[k];
            for (j = 0; j < NH; j++) {
                wv = w[j];
                hv = hid[j];
                if (wv < 0) { m = -wv; s -= (unsigned int)(hv * m); }
                else { m = wv; s += (unsigned int)(hv * m); }
            }
#else
            for (j = 0; j < NH; j++)
                s += (int)hid[j] * W2[k][j];
#endif
            score[k] = s;
        }

        /* the largest score is the answer */
        best = 0;
        for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;

        dbuf[2] = 0xFF;
        dbuf[3] = segs[best];
        putc_('=');
        putc_('0' + best);
        for (k = 0; k < 10; k++) {
            u = (unsigned long)score[k];
            putc_(' ');
            puthex((unsigned char)(u >> 16));
            puthex((unsigned char)(u >> 8));
            puthex((unsigned char)u);
        }
        putc_('\r');
        putc_('\n');
    }
}
