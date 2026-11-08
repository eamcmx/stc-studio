/* avr_bench.c: runs ref/nn/avr/digit_avr.c on a simulated ATmega328P at 16 MHz (simavr) for a list of inputs and prints,
 * for each, the digit, the ten scores and the cycles of one reading (PB0 high to PB0 low).
 *   gcc -O2 -o avr_bench avr_bench.c $(pkg-config --cflags --libs simavr) -lelf      (tools/avr_run.py does this in WSL)
 *   ./avr_bench <firmware.elf> <inputs.txt> <pix> <go> <digit> <out> <packed 0|1>
 * pix, go, digit and out are the SRAM addresses of those variables (from avr-nm, without the 0x800000 offset); each
 * line of inputs.txt is one input, a string of 0 and 1. Output: one line per input, "digit s0 ... s9 cycles".
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <simavr/sim_avr.h>
#include <simavr/sim_elf.h>
#include <simavr/avr_ioport.h>

static avr_t *avr;
static avr_cycle_count_t t_up, t_down;
static int edges;

static void pb0(struct avr_irq_t *irq, uint32_t value, void *param)
{
    (void)irq; (void)param;
    if (value) t_up = avr->cycle; else { t_down = avr->cycle; edges++; }
}

int main(int argc, char **argv)
{
    if (argc != 8) { fprintf(stderr, "usage: avr_bench fw.elf inputs.txt pix go digit out packed\n"); return 2; }
    elf_firmware_t fw;
    memset(&fw, 0, sizeof fw);
    if (elf_read_firmware(argv[1], &fw)) { fprintf(stderr, "cannot read %s\n", argv[1]); return 2; }
    avr = avr_make_mcu_by_name("atmega328p");
    if (!avr) { fprintf(stderr, "no atmega328p in simavr\n"); return 2; }
    avr_init(avr);
    avr->frequency = 16000000;
    avr_load_firmware(avr, &fw);
    avr_irq_register_notify(avr_io_getirq(avr, AVR_IOCTL_IOPORT_GETIRQ('B'), 0), pb0, NULL);
    unsigned pix = strtoul(argv[3], 0, 0), go = strtoul(argv[4], 0, 0), dig = strtoul(argv[5], 0, 0),
             out = strtoul(argv[6], 0, 0);
    int packed = atoi(argv[7]);
    for (int k = 0; k < 20000; k++) avr_run(avr);          /* past the start-up code, into the wait for go */
    FILE *in = fopen(argv[2], "r");
    if (!in) { fprintf(stderr, "cannot read %s\n", argv[2]); return 2; }
    char line[1024];
    while (fgets(line, sizeof line, in)) {
        int n = (int)strcspn(line, "\r\n");
        line[n] = 0;
        if (!n) continue;
        if (packed) {
            for (int i = 0; i < (n + 7) / 8; i++) avr->data[pix + i] = 0;
            for (int i = 0; i < n; i++) if (line[i] == '1') avr->data[pix + i / 8] |= 0x80 >> (i % 8);
        } else {
            for (int i = 0; i < n; i++) avr->data[pix + i] = line[i] == '1';
        }
        int before = edges;
        avr->data[go] = 1;
        long guard = 0;
        while (edges == before) {
            int state = avr_run(avr);
            if (state == cpu_Done || state == cpu_Crashed || ++guard > 200000000L) { fprintf(stderr, "no answer\n"); return 1; }
        }
        printf("%d", avr->data[dig]);
        for (int s = 0; s < 10; s++) {
            uint8_t *p = &avr->data[out + 4 * s];
            int32_t v = (int32_t)((uint32_t)p[0] | ((uint32_t)p[1] << 8) | ((uint32_t)p[2] << 16) | ((uint32_t)p[3] << 24));
            printf(" %ld", (long)v);
        }
        printf(" %llu\n", (unsigned long long)(t_down - t_up));
    }
    return 0;
}
