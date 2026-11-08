/* compat51.h: digit_nn.c for both compilers. Keil C51 reads its own keywords and reg52.h; for SDCC the same words
 * are mapped to SDCC's (__code, __idata, __data, __interrupt(n) __using(b)) and 8052.h. */
#ifdef __SDCC
#include <8052.h>
#define code __code
#define idata __idata
#define data __data
#define T0_ISR __interrupt(1) __using(1)
#else
#include <reg52.h>
#define T0_ISR interrupt 1 using 1
#endif
