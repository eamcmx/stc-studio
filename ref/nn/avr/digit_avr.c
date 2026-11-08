/* digit_avr.c: the same C program as ref/nn/c/digit_nn.c (5 x 7) and ref/nn/c/mnist/digit_mnist.c (-DMNIST, inputs
 * kept as bits), for an 8-bit AVR (ATmega328P, the chip of the Arduino Uno), to compare the two 8-bit processors on the
 * same networks. Weights in flash, read with avr-libc's pgm_read_* (weights_5x7.h, weights_mnist.h, made by
 * nn/write_c_headers.py). Written the way the 8051 C versions are "as written": the table indexed as W1[i][j], a
 * 16-bit product in layer 2, 32-bit sums.
 *
 * No serial port: tools/avr_bench.c (simavr) writes the inputs into pix[], sets go, and reads digit and out[] back.
 * PB0 is high for exactly one reading, from the start of layer 1 to the answer, so the bench counts its cycles.
 *   avr-gcc -mmcu=atmega328p -O2 [-DMNIST] -o digit_avr.elf digit_avr.c      (tools/avr_run.py does this in WSL)
 */
#include <avr/io.h>
#include <avr/pgmspace.h>
#include <stdint.h>
#ifdef MNIST
#include "weights_mnist.h"
#else
#include "weights_5x7.h"
#endif

#ifdef MNIST
volatile uint8_t pix[(NIN + 7) / 8];      /* the inputs, 8 to a byte, first in bit 7 */
#else
volatile uint8_t pix[NIN];                /* the inputs, 0 or 1 */
#endif
int16_t acc[NH];
uint8_t hid[NH];
volatile int32_t out[10];                 /* the ten scores */
volatile uint8_t digit;
volatile uint8_t go;

int main(void)
{
    uint8_t i, j, k, best;
    int16_t a;
    int32_t s;

    DDRB = 1;
    for (;;) {
        while (!go) ;
        go = 0;
        PORTB = 1;                            /* the reading starts */

        for (j = 0; j < NH; j++) acc[j] = (int16_t)pgm_read_word(&B1[j]);
        for (i = 0; i < NIN; i++)
#ifdef MNIST
            if (pix[i >> 3] & (0x80 >> (i & 7)))
#else
            if (pix[i])
#endif
                for (j = 0; j < NH; j++) acc[j] += (int8_t)pgm_read_byte(&W1[i][j]);

        for (j = 0; j < NH; j++) {
            a = acc[j];
            if (a < 0) hid[j] = 0;
            else { a >>= SH1; hid[j] = a > 255 ? 255 : (uint8_t)a; }
        }

        for (k = 0; k < 10; k++) {
            s = (int32_t)pgm_read_dword(&B2[k]);
            for (j = 0; j < NH; j++)
                s += (int16_t)hid[j] * (int8_t)pgm_read_byte(&W2[k][j]);
            out[k] = s;
        }
        best = 0;
        for (k = 1; k < 10; k++) if (out[k] > out[best]) best = k;
        digit = best;

        PORTB = 0;                            /* the answer is ready */
    }
}
