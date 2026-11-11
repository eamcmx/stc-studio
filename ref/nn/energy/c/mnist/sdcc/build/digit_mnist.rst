                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.6.0 #16555 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module digit_mnist
                                      6 	
                                      7 	.optsdcc -mmcs51 --model-small
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _hexd
                                     12 	.globl _segs
                                     13 	.globl _dsel
                                     14 	.globl _W2
                                     15 	.globl _B2
                                     16 	.globl _W1
                                     17 	.globl _B1
                                     18 	.globl _main
                                     19 	.globl _t0_isr
                                     20 	.globl _TF2
                                     21 	.globl _EXF2
                                     22 	.globl _RCLK
                                     23 	.globl _TCLK
                                     24 	.globl _EXEN2
                                     25 	.globl _TR2
                                     26 	.globl _C_T2
                                     27 	.globl _CP_RL2
                                     28 	.globl _T2CON_7
                                     29 	.globl _T2CON_6
                                     30 	.globl _T2CON_5
                                     31 	.globl _T2CON_4
                                     32 	.globl _T2CON_3
                                     33 	.globl _T2CON_2
                                     34 	.globl _T2CON_1
                                     35 	.globl _T2CON_0
                                     36 	.globl _PT2
                                     37 	.globl _ET2
                                     38 	.globl _CY
                                     39 	.globl _AC
                                     40 	.globl _F0
                                     41 	.globl _RS1
                                     42 	.globl _RS0
                                     43 	.globl _OV
                                     44 	.globl _F1
                                     45 	.globl _P
                                     46 	.globl _PS
                                     47 	.globl _PT1
                                     48 	.globl _PX1
                                     49 	.globl _PT0
                                     50 	.globl _PX0
                                     51 	.globl _RD
                                     52 	.globl _WR
                                     53 	.globl _T1
                                     54 	.globl _T0
                                     55 	.globl _INT1
                                     56 	.globl _INT0
                                     57 	.globl _TXD
                                     58 	.globl _RXD
                                     59 	.globl _P3_7
                                     60 	.globl _P3_6
                                     61 	.globl _P3_5
                                     62 	.globl _P3_4
                                     63 	.globl _P3_3
                                     64 	.globl _P3_2
                                     65 	.globl _P3_1
                                     66 	.globl _P3_0
                                     67 	.globl _EA
                                     68 	.globl _ES
                                     69 	.globl _ET1
                                     70 	.globl _EX1
                                     71 	.globl _ET0
                                     72 	.globl _EX0
                                     73 	.globl _P2_7
                                     74 	.globl _P2_6
                                     75 	.globl _P2_5
                                     76 	.globl _P2_4
                                     77 	.globl _P2_3
                                     78 	.globl _P2_2
                                     79 	.globl _P2_1
                                     80 	.globl _P2_0
                                     81 	.globl _SM0
                                     82 	.globl _SM1
                                     83 	.globl _SM2
                                     84 	.globl _REN
                                     85 	.globl _TB8
                                     86 	.globl _RB8
                                     87 	.globl _TI
                                     88 	.globl _RI
                                     89 	.globl _P1_7
                                     90 	.globl _P1_6
                                     91 	.globl _P1_5
                                     92 	.globl _P1_4
                                     93 	.globl _P1_3
                                     94 	.globl _P1_2
                                     95 	.globl _P1_1
                                     96 	.globl _P1_0
                                     97 	.globl _TF1
                                     98 	.globl _TR1
                                     99 	.globl _TF0
                                    100 	.globl _TR0
                                    101 	.globl _IE1
                                    102 	.globl _IT1
                                    103 	.globl _IE0
                                    104 	.globl _IT0
                                    105 	.globl _P0_7
                                    106 	.globl _P0_6
                                    107 	.globl _P0_5
                                    108 	.globl _P0_4
                                    109 	.globl _P0_3
                                    110 	.globl _P0_2
                                    111 	.globl _P0_1
                                    112 	.globl _P0_0
                                    113 	.globl _TH2
                                    114 	.globl _TL2
                                    115 	.globl _RCAP2H
                                    116 	.globl _RCAP2L
                                    117 	.globl _T2CON
                                    118 	.globl _B
                                    119 	.globl _ACC
                                    120 	.globl _PSW
                                    121 	.globl _IP
                                    122 	.globl _P3
                                    123 	.globl _IE
                                    124 	.globl _P2
                                    125 	.globl _SBUF
                                    126 	.globl _SCON
                                    127 	.globl _P1
                                    128 	.globl _TH1
                                    129 	.globl _TH0
                                    130 	.globl _TL1
                                    131 	.globl _TL0
                                    132 	.globl _TMOD
                                    133 	.globl _TCON
                                    134 	.globl _PCON
                                    135 	.globl _DPH
                                    136 	.globl _DPL
                                    137 	.globl _SP
                                    138 	.globl _P0
                                    139 	.globl _score
                                    140 	.globl _hid
                                    141 	.globl _acc
                                    142 	.globl _pix
                                    143 	.globl _digi
                                    144 	.globl _dbuf
                                    145 ;--------------------------------------------------------
                                    146 ; special function registers
                                    147 ;--------------------------------------------------------
                                    148 	.area RSEG    (ABS,DATA)
      000000                        149 	.org 0x0000
                           000080   150 _P0	=	0x0080
                           000081   151 _SP	=	0x0081
                           000082   152 _DPL	=	0x0082
                           000083   153 _DPH	=	0x0083
                           000087   154 _PCON	=	0x0087
                           000088   155 _TCON	=	0x0088
                           000089   156 _TMOD	=	0x0089
                           00008A   157 _TL0	=	0x008a
                           00008B   158 _TL1	=	0x008b
                           00008C   159 _TH0	=	0x008c
                           00008D   160 _TH1	=	0x008d
                           000090   161 _P1	=	0x0090
                           000098   162 _SCON	=	0x0098
                           000099   163 _SBUF	=	0x0099
                           0000A0   164 _P2	=	0x00a0
                           0000A8   165 _IE	=	0x00a8
                           0000B0   166 _P3	=	0x00b0
                           0000B8   167 _IP	=	0x00b8
                           0000D0   168 _PSW	=	0x00d0
                           0000E0   169 _ACC	=	0x00e0
                           0000F0   170 _B	=	0x00f0
                           0000C8   171 _T2CON	=	0x00c8
                           0000CA   172 _RCAP2L	=	0x00ca
                           0000CB   173 _RCAP2H	=	0x00cb
                           0000CC   174 _TL2	=	0x00cc
                           0000CD   175 _TH2	=	0x00cd
                                    176 ;--------------------------------------------------------
                                    177 ; special function bits
                                    178 ;--------------------------------------------------------
                                    179 	.area RSEG    (ABS,DATA)
      000000                        180 	.org 0x0000
                           000080   181 _P0_0	=	0x0080
                           000081   182 _P0_1	=	0x0081
                           000082   183 _P0_2	=	0x0082
                           000083   184 _P0_3	=	0x0083
                           000084   185 _P0_4	=	0x0084
                           000085   186 _P0_5	=	0x0085
                           000086   187 _P0_6	=	0x0086
                           000087   188 _P0_7	=	0x0087
                           000088   189 _IT0	=	0x0088
                           000089   190 _IE0	=	0x0089
                           00008A   191 _IT1	=	0x008a
                           00008B   192 _IE1	=	0x008b
                           00008C   193 _TR0	=	0x008c
                           00008D   194 _TF0	=	0x008d
                           00008E   195 _TR1	=	0x008e
                           00008F   196 _TF1	=	0x008f
                           000090   197 _P1_0	=	0x0090
                           000091   198 _P1_1	=	0x0091
                           000092   199 _P1_2	=	0x0092
                           000093   200 _P1_3	=	0x0093
                           000094   201 _P1_4	=	0x0094
                           000095   202 _P1_5	=	0x0095
                           000096   203 _P1_6	=	0x0096
                           000097   204 _P1_7	=	0x0097
                           000098   205 _RI	=	0x0098
                           000099   206 _TI	=	0x0099
                           00009A   207 _RB8	=	0x009a
                           00009B   208 _TB8	=	0x009b
                           00009C   209 _REN	=	0x009c
                           00009D   210 _SM2	=	0x009d
                           00009E   211 _SM1	=	0x009e
                           00009F   212 _SM0	=	0x009f
                           0000A0   213 _P2_0	=	0x00a0
                           0000A1   214 _P2_1	=	0x00a1
                           0000A2   215 _P2_2	=	0x00a2
                           0000A3   216 _P2_3	=	0x00a3
                           0000A4   217 _P2_4	=	0x00a4
                           0000A5   218 _P2_5	=	0x00a5
                           0000A6   219 _P2_6	=	0x00a6
                           0000A7   220 _P2_7	=	0x00a7
                           0000A8   221 _EX0	=	0x00a8
                           0000A9   222 _ET0	=	0x00a9
                           0000AA   223 _EX1	=	0x00aa
                           0000AB   224 _ET1	=	0x00ab
                           0000AC   225 _ES	=	0x00ac
                           0000AF   226 _EA	=	0x00af
                           0000B0   227 _P3_0	=	0x00b0
                           0000B1   228 _P3_1	=	0x00b1
                           0000B2   229 _P3_2	=	0x00b2
                           0000B3   230 _P3_3	=	0x00b3
                           0000B4   231 _P3_4	=	0x00b4
                           0000B5   232 _P3_5	=	0x00b5
                           0000B6   233 _P3_6	=	0x00b6
                           0000B7   234 _P3_7	=	0x00b7
                           0000B0   235 _RXD	=	0x00b0
                           0000B1   236 _TXD	=	0x00b1
                           0000B2   237 _INT0	=	0x00b2
                           0000B3   238 _INT1	=	0x00b3
                           0000B4   239 _T0	=	0x00b4
                           0000B5   240 _T1	=	0x00b5
                           0000B6   241 _WR	=	0x00b6
                           0000B7   242 _RD	=	0x00b7
                           0000B8   243 _PX0	=	0x00b8
                           0000B9   244 _PT0	=	0x00b9
                           0000BA   245 _PX1	=	0x00ba
                           0000BB   246 _PT1	=	0x00bb
                           0000BC   247 _PS	=	0x00bc
                           0000D0   248 _P	=	0x00d0
                           0000D1   249 _F1	=	0x00d1
                           0000D2   250 _OV	=	0x00d2
                           0000D3   251 _RS0	=	0x00d3
                           0000D4   252 _RS1	=	0x00d4
                           0000D5   253 _F0	=	0x00d5
                           0000D6   254 _AC	=	0x00d6
                           0000D7   255 _CY	=	0x00d7
                           0000AD   256 _ET2	=	0x00ad
                           0000BD   257 _PT2	=	0x00bd
                           0000C8   258 _T2CON_0	=	0x00c8
                           0000C9   259 _T2CON_1	=	0x00c9
                           0000CA   260 _T2CON_2	=	0x00ca
                           0000CB   261 _T2CON_3	=	0x00cb
                           0000CC   262 _T2CON_4	=	0x00cc
                           0000CD   263 _T2CON_5	=	0x00cd
                           0000CE   264 _T2CON_6	=	0x00ce
                           0000CF   265 _T2CON_7	=	0x00cf
                           0000C8   266 _CP_RL2	=	0x00c8
                           0000C9   267 _C_T2	=	0x00c9
                           0000CA   268 _TR2	=	0x00ca
                           0000CB   269 _EXEN2	=	0x00cb
                           0000CC   270 _TCLK	=	0x00cc
                           0000CD   271 _RCLK	=	0x00cd
                           0000CE   272 _EXF2	=	0x00ce
                           0000CF   273 _TF2	=	0x00cf
                                    274 ;--------------------------------------------------------
                                    275 ; overlayable register banks
                                    276 ;--------------------------------------------------------
                                    277 	.area REG_BANK_0	(REL,OVR,DATA)
      000000                        278 	.ds 8
                                    279 	.area REG_BANK_1	(REL,OVR,DATA)
      000008                        280 	.ds 8
                                    281 ;--------------------------------------------------------
                                    282 ; internal ram data
                                    283 ;--------------------------------------------------------
                                    284 	.area DSEG    (DATA)
      000010                        285 _dbuf::
      000010                        286 	.ds 4
      000014                        287 _digi::
      000014                        288 	.ds 1
      000015                        289 _main_i_10000_12:
      000015                        290 	.ds 1
      000016                        291 _main_j_10000_12:
      000016                        292 	.ds 1
      000017                        293 _main_k_10000_12:
      000017                        294 	.ds 1
      000018                        295 _main_best_10000_12:
      000018                        296 	.ds 1
      000019                        297 _main_s_10000_12:
      000019                        298 	.ds 4
      00001D                        299 _main_sloc0_1_0:
      00001D                        300 	.ds 4
                                    301 ;--------------------------------------------------------
                                    302 ; overlayable items in internal ram
                                    303 ;--------------------------------------------------------
                                    304 	.area	OSEG    (OVR,DATA)
                                    305 ;--------------------------------------------------------
                                    306 ; Stack segment in internal ram
                                    307 ;--------------------------------------------------------
                                    308 	.area SSEG
      0000C4                        309 __start__stack:
      0000C4                        310 	.ds	1
                                    311 
                                    312 ;--------------------------------------------------------
                                    313 ; indirectly addressable internal ram data
                                    314 ;--------------------------------------------------------
                                    315 	.area ISEG    (DATA)
      000023                        316 _pix::
      000023                        317 	.ds 25
      00003C                        318 _acc::
      00003C                        319 	.ds 64
      00007C                        320 _hid::
      00007C                        321 	.ds 32
      00009C                        322 _score::
      00009C                        323 	.ds 40
                                    324 ;--------------------------------------------------------
                                    325 ; absolute internal ram data
                                    326 ;--------------------------------------------------------
                                    327 	.area IABS    (ABS,DATA)
                                    328 	.area IABS    (ABS,DATA)
                                    329 ;--------------------------------------------------------
                                    330 ; bit data
                                    331 ;--------------------------------------------------------
                                    332 	.area BSEG    (BIT)
                                    333 ;--------------------------------------------------------
                                    334 ; paged external ram data
                                    335 ;--------------------------------------------------------
                                    336 	.area PSEG    (PAG,XDATA)
                                    337 ;--------------------------------------------------------
                                    338 ; uninitialized external ram data
                                    339 ;--------------------------------------------------------
                                    340 	.area XSEG    (XDATA)
                                    341 ;--------------------------------------------------------
                                    342 ; absolute external ram data
                                    343 ;--------------------------------------------------------
                                    344 	.area XABS    (ABS,XDATA)
                                    345 ;--------------------------------------------------------
                                    346 ; initialized external ram data
                                    347 ;--------------------------------------------------------
                                    348 	.area XISEG   (XDATA)
                                    349 	.area HOME    (CODE)
                                    350 	.area GSINIT0 (CODE)
                                    351 	.area GSINIT1 (CODE)
                                    352 	.area GSINIT2 (CODE)
                                    353 	.area GSINIT3 (CODE)
                                    354 	.area GSINIT4 (CODE)
                                    355 	.area GSINIT5 (CODE)
                                    356 	.area GSINIT  (CODE)
                                    357 	.area GSFINAL (CODE)
                                    358 	.area CSEG    (CODE)
                                    359 ;--------------------------------------------------------
                                    360 ; interrupt vector
                                    361 ;--------------------------------------------------------
                                    362 	.area HOME    (CODE)
      000000                        363 __interrupt_vect:
      000000 02 00 56         [24]  364 	ljmp	__sdcc_gsinit_startup
      000003 32               [24]  365 	reti
      000004                        366 	.ds	7
      00000B 02 00 B2         [24]  367 	ljmp	_t0_isr
                                    368 ; restartable atomic support routines
      00000E                        369 	.ds	2
      000010                        370 sdcc_atomic_exchange_rollback_start::
      000010 00               [12]  371 	nop
      000011 00               [12]  372 	nop
      000012                        373 sdcc_atomic_exchange_pdata_impl:
      000012 E2               [24]  374 	movx	a, @r0
      000013 FB               [12]  375 	mov	r3, a
      000014 EA               [12]  376 	mov	a, r2
      000015 F2               [24]  377 	movx	@r0, a
      000016 80 2C            [24]  378 	sjmp	sdcc_atomic_exchange_exit
      000018 00               [12]  379 	nop
      000019 00               [12]  380 	nop
      00001A                        381 sdcc_atomic_exchange_xdata_impl:
      00001A E0               [24]  382 	movx	a, @dptr
      00001B FB               [12]  383 	mov	r3, a
      00001C EA               [12]  384 	mov	a, r2
      00001D F0               [24]  385 	movx	@dptr, a
      00001E 80 24            [24]  386 	sjmp	sdcc_atomic_exchange_exit
      000020                        387 sdcc_atomic_compare_exchange_idata_impl:
      000020 E6               [12]  388 	mov	a, @r0
      000021 B5 02 02         [24]  389 	cjne	a, ar2, .+#5
      000024 EB               [12]  390 	mov	a, r3
      000025 F6               [12]  391 	mov	@r0, a
      000026 22               [24]  392 	ret
      000027 00               [12]  393 	nop
      000028                        394 sdcc_atomic_compare_exchange_pdata_impl:
      000028 E2               [24]  395 	movx	a, @r0
      000029 B5 02 02         [24]  396 	cjne	a, ar2, .+#5
      00002C EB               [12]  397 	mov	a, r3
      00002D F2               [24]  398 	movx	@r0, a
      00002E 22               [24]  399 	ret
      00002F 00               [12]  400 	nop
      000030                        401 sdcc_atomic_compare_exchange_xdata_impl:
      000030 E0               [24]  402 	movx	a, @dptr
      000031 B5 02 02         [24]  403 	cjne	a, ar2, .+#5
      000034 EB               [12]  404 	mov	a, r3
      000035 F0               [24]  405 	movx	@dptr, a
      000036 22               [24]  406 	ret
      000037                        407 sdcc_atomic_exchange_rollback_end::
                                    408 
      000037                        409 sdcc_atomic_exchange_gptr_impl::
      000037 30 F6 E0         [24]  410 	jnb	b.6, sdcc_atomic_exchange_xdata_impl
      00003A A8 82            [24]  411 	mov	r0, dpl
      00003C 20 F5 D3         [24]  412 	jb	b.5, sdcc_atomic_exchange_pdata_impl
      00003F                        413 sdcc_atomic_exchange_idata_impl:
      00003F EA               [12]  414 	mov	a, r2
      000040 C6               [12]  415 	xch	a, @r0
      000041 F5 82            [12]  416 	mov	dpl, a
      000043 22               [24]  417 	ret
      000044                        418 sdcc_atomic_exchange_exit:
      000044 8B 82            [24]  419 	mov	dpl, r3
      000046 22               [24]  420 	ret
      000047                        421 sdcc_atomic_compare_exchange_gptr_impl::
      000047 30 F6 E6         [24]  422 	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
      00004A A8 82            [24]  423 	mov	r0, dpl
      00004C 20 F5 D9         [24]  424 	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
      00004F 80 CF            [24]  425 	sjmp	sdcc_atomic_compare_exchange_idata_impl
                                    426 ;--------------------------------------------------------
                                    427 ; global & static initialisations
                                    428 ;--------------------------------------------------------
                                    429 	.area HOME    (CODE)
                                    430 	.area GSINIT  (CODE)
                                    431 	.area GSFINAL (CODE)
                                    432 	.area GSINIT  (CODE)
                                    433 	.globl __sdcc_gsinit_startup
                                    434 	.globl __sdcc_program_startup
                                    435 	.globl __start__stack
                                    436 	.globl __mcs51_genXINIT
                                    437 	.globl __mcs51_genXRAMCLEAR
                                    438 	.globl __mcs51_genRAMCLEAR
                                    439 	.area GSFINAL (CODE)
      0000AF 02 00 51         [24]  440 	ljmp	__sdcc_program_startup
                                    441 ;--------------------------------------------------------
                                    442 ; Home
                                    443 ;--------------------------------------------------------
                                    444 	.area HOME    (CODE)
                                    445 	.area HOME    (CODE)
      000051                        446 __sdcc_program_startup:
      000051 12 01 31         [24]  447 	lcall	_main
      000054                        448 __sdcc_program_exit:
      000054 80 FE            [24]  449 	sjmp	.
                                    450 ;	return from main will return to caller
                                    451 ;--------------------------------------------------------
                                    452 ; code
                                    453 ;--------------------------------------------------------
                                    454 	.area CSEG    (CODE)
                                    455 ;------------------------------------------------------------
                                    456 ;Allocation info for local variables in function 't0_isr'
                                    457 ;------------------------------------------------------------
                                    458 ;	digit_mnist.c:26: void t0_isr(void) T0_ISR
                                    459 ;	-----------------------------------------
                                    460 ;	 function t0_isr
                                    461 ;	-----------------------------------------
      0000B2                        462 _t0_isr:
                           00000F   463 	ar7 = 0x0f
                           00000E   464 	ar6 = 0x0e
                           00000D   465 	ar5 = 0x0d
                           00000C   466 	ar4 = 0x0c
                           00000B   467 	ar3 = 0x0b
                           00000A   468 	ar2 = 0x0a
                           000009   469 	ar1 = 0x09
                           000008   470 	ar0 = 0x08
      0000B2 C0 E0            [24]  471 	push	acc
      0000B4 C0 82            [24]  472 	push	dpl
      0000B6 C0 83            [24]  473 	push	dph
      0000B8 C0 D0            [24]  474 	push	psw
      0000BA 75 D0 08         [24]  475 	mov	psw,#0x08
                                    476 ;	digit_mnist.c:28: P1 = 0xFF;
      0000BD 75 90 FF         [24]  477 	mov	_P1,#0xff
                                    478 ;	digit_mnist.c:29: digi = (digi + 1) & 3;
      0000C0 AF 14            [24]  479 	mov	r7,_digi
      0000C2 0F               [12]  480 	inc	r7
      0000C3 74 03            [12]  481 	mov	a,#0x03
      0000C5 5F               [12]  482 	anl	a,r7
                                    483 ;	digit_mnist.c:30: P0 = dbuf[digi];
      0000C6 F5 14            [12]  484 	mov	_digi,a
      0000C8 24 10            [12]  485 	add	a, #_dbuf
      0000CA F9               [12]  486 	mov	r1,a
      0000CB 87 80            [24]  487 	mov	_P0,@r1
                                    488 ;	digit_mnist.c:31: P1 = dsel[digi];
      0000CD E5 14            [12]  489 	mov	a,_digi
      0000CF 90 1E 63         [24]  490 	mov	dptr,#_dsel
      0000D2 93               [24]  491 	movc	a,@a+dptr
      0000D3 F5 90            [12]  492 	mov	_P1,a
                                    493 ;	digit_mnist.c:32: }
      0000D5 D0 D0            [24]  494 	pop	psw
      0000D7 D0 83            [24]  495 	pop	dph
      0000D9 D0 82            [24]  496 	pop	dpl
      0000DB D0 E0            [24]  497 	pop	acc
      0000DD 32               [24]  498 	reti
                                    499 ;	eliminated unneeded push/pop b
                                    500 ;------------------------------------------------------------
                                    501 ;Allocation info for local variables in function 'getc_'
                                    502 ;------------------------------------------------------------
                                    503 ;	digit_mnist.c:34: static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
                                    504 ;	-----------------------------------------
                                    505 ;	 function getc_
                                    506 ;	-----------------------------------------
      0000DE                        507 _getc_:
                           000007   508 	ar7 = 0x07
                           000006   509 	ar6 = 0x06
                           000005   510 	ar5 = 0x05
                           000004   511 	ar4 = 0x04
                           000003   512 	ar3 = 0x03
                           000002   513 	ar2 = 0x02
                           000001   514 	ar1 = 0x01
                           000000   515 	ar0 = 0x00
      0000DE                        516 00101$:
                                    517 ;	assignBit
      0000DE 10 98 02         [24]  518 	jbc	_RI,00120$
      0000E1 80 FB            [24]  519 	sjmp	00101$
      0000E3                        520 00120$:
      0000E3 85 99 82         [24]  521 	mov	dpl, _SBUF
      0000E6 22               [24]  522 	ret
                                    523 ;------------------------------------------------------------
                                    524 ;Allocation info for local variables in function 'putc_'
                                    525 ;------------------------------------------------------------
                                    526 ;c             Allocated to registers 
                                    527 ;------------------------------------------------------------
                                    528 ;	digit_mnist.c:35: static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
                                    529 ;	-----------------------------------------
                                    530 ;	 function putc_
                                    531 ;	-----------------------------------------
      0000E7                        532 _putc_:
      0000E7 85 82 99         [24]  533 	mov	_SBUF,dpl
      0000EA                        534 00101$:
                                    535 ;	assignBit
      0000EA 10 99 02         [24]  536 	jbc	_TI,00120$
      0000ED 80 FB            [24]  537 	sjmp	00101$
      0000EF                        538 00120$:
      0000EF 22               [24]  539 	ret
                                    540 ;------------------------------------------------------------
                                    541 ;Allocation info for local variables in function 'puthex'
                                    542 ;------------------------------------------------------------
                                    543 ;v             Allocated to registers r7 
                                    544 ;------------------------------------------------------------
                                    545 ;	digit_mnist.c:36: static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
                                    546 ;	-----------------------------------------
                                    547 ;	 function puthex
                                    548 ;	-----------------------------------------
      0000F0                        549 _puthex:
      0000F0 E5 82            [12]  550 	mov	a,dpl
      0000F2 FF               [12]  551 	mov	r7,a
      0000F3 C4               [12]  552 	swap	a
      0000F4 54 0F            [12]  553 	anl	a,#0x0f
      0000F6 90 1E 71         [24]  554 	mov	dptr,#_hexd
      0000F9 93               [24]  555 	movc	a,@a+dptr
      0000FA F5 82            [12]  556 	mov	dpl,a
      0000FC C0 07            [24]  557 	push	ar7
      0000FE 12 00 E7         [24]  558 	lcall	_putc_
      000101 D0 07            [24]  559 	pop	ar7
      000103 74 0F            [12]  560 	mov	a,#0x0f
      000105 5F               [12]  561 	anl	a,r7
      000106 90 1E 71         [24]  562 	mov	dptr,#_hexd
      000109 93               [24]  563 	movc	a,@a+dptr
      00010A F5 82            [12]  564 	mov	dpl,a
      00010C 02 00 E7         [24]  565 	ljmp	_putc_
                                    566 ;------------------------------------------------------------
                                    567 ;Allocation info for local variables in function 'puts_'
                                    568 ;------------------------------------------------------------
                                    569 ;s             Allocated to registers 
                                    570 ;------------------------------------------------------------
                                    571 ;	digit_mnist.c:37: static void puts_(char code *s) { while (*s) putc_(*s++); }
                                    572 ;	-----------------------------------------
                                    573 ;	 function puts_
                                    574 ;	-----------------------------------------
      00010F                        575 _puts_:
      00010F AE 82            [24]  576 	mov	r6, dpl
      000111 AF 83            [24]  577 	mov	r7, dph
      000113                        578 00101$:
      000113 8E 82            [24]  579 	mov	dpl,r6
      000115 8F 83            [24]  580 	mov	dph,r7
      000117 E4               [12]  581 	clr	a
      000118 93               [24]  582 	movc	a,@a+dptr
      000119 FD               [12]  583 	mov	r5,a
      00011A 60 14            [24]  584 	jz	00104$
      00011C 8D 82            [24]  585 	mov	dpl,r5
      00011E 0E               [12]  586 	inc	r6
      00011F BE 00 01         [24]  587 	cjne	r6,#0x00,00122$
      000122 0F               [12]  588 	inc	r7
      000123                        589 00122$:
      000123 C0 07            [24]  590 	push	ar7
      000125 C0 06            [24]  591 	push	ar6
      000127 12 00 E7         [24]  592 	lcall	_putc_
      00012A D0 06            [24]  593 	pop	ar6
      00012C D0 07            [24]  594 	pop	ar7
      00012E 80 E3            [24]  595 	sjmp	00101$
      000130                        596 00104$:
      000130 22               [24]  597 	ret
                                    598 ;------------------------------------------------------------
                                    599 ;Allocation info for local variables in function 'main'
                                    600 ;------------------------------------------------------------
                                    601 ;i             Allocated with name '_main_i_10000_12'
                                    602 ;j             Allocated with name '_main_j_10000_12'
                                    603 ;k             Allocated with name '_main_k_10000_12'
                                    604 ;best          Allocated with name '_main_best_10000_12'
                                    605 ;b             Allocated to registers r7 
                                    606 ;a             Allocated to registers r5 r6 
                                    607 ;s             Allocated with name '_main_s_10000_12'
                                    608 ;u             Allocated to registers r3 r4 r5 r6 
                                    609 ;sloc0         Allocated with name '_main_sloc0_1_0'
                                    610 ;------------------------------------------------------------
                                    611 ;	digit_mnist.c:39: void main(void)
                                    612 ;	-----------------------------------------
                                    613 ;	 function main
                                    614 ;	-----------------------------------------
      000131                        615 _main:
                                    616 ;	digit_mnist.c:53: dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
      000131 75 11 AB         [24]  617 	mov	(_dbuf + 0x0001),#0xab
      000134 75 10 AB         [24]  618 	mov	_dbuf,#0xab
                                    619 ;	digit_mnist.c:54: dbuf[2] = dbuf[3] = 0xBF;
      000137 75 13 BF         [24]  620 	mov	(_dbuf + 0x0003),#0xbf
      00013A 75 12 BF         [24]  621 	mov	(_dbuf + 0x0002),#0xbf
                                    622 ;	digit_mnist.c:55: digi = 0;
      00013D 75 14 00         [24]  623 	mov	_digi,#0x00
                                    624 ;	digit_mnist.c:56: TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
      000140 75 89 22         [24]  625 	mov	_TMOD,#0x22
                                    626 ;	digit_mnist.c:57: TH1 = TL1 = 0xFD;
      000143 75 8B FD         [24]  627 	mov	_TL1,#0xfd
      000146 75 8D FD         [24]  628 	mov	_TH1,#0xfd
                                    629 ;	digit_mnist.c:58: PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
      000149 43 87 80         [24]  630 	orl	_PCON,#0x80
                                    631 ;	digit_mnist.c:59: SCON = 0x50;
      00014C 75 98 50         [24]  632 	mov	_SCON,#0x50
                                    633 ;	digit_mnist.c:60: TH0 = TL0 = 0;
      00014F 75 8A 00         [24]  634 	mov	_TL0,#0x00
      000152 75 8C 00         [24]  635 	mov	_TH0,#0x00
                                    636 ;	digit_mnist.c:61: TR1 = 1; TR0 = 1; ET0 = 0;   /* DISPLAY OFF BUILD (nn/energy_build.py) */ EA = 1;
                                    637 ;	assignBit
      000155 D2 8E            [12]  638 	setb	_TR1
                                    639 ;	assignBit
      000157 D2 8C            [12]  640 	setb	_TR0
                                    641 ;	assignBit
      000159 C2 A9            [12]  642 	clr	_ET0
                                    643 ;	assignBit
      00015B D2 AF            [12]  644 	setb	_EA
                                    645 ;	digit_mnist.c:62: puts_("NN READY\r\n");
      00015D 90 1E 82         [24]  646 	mov	dptr,#___str_0
      000160 12 01 0F         [24]  647 	lcall	_puts_
                                    648 ;	digit_mnist.c:65: while (getc_() != 'D') ;
      000163                        649 00101$:
      000163 12 00 DE         [24]  650 	lcall	_getc_
      000166 AF 82            [24]  651 	mov	r7, dpl
      000168 BF 44 F8         [24]  652 	cjne	r7,#0x44,00101$
                                    653 ;	digit_mnist.c:66: b = 0;
      00016B 7F 00            [12]  654 	mov	r7,#0x00
                                    655 ;	digit_mnist.c:67: for (i = 0; i < NIN; i++) {
      00016D 7E 00            [12]  656 	mov	r6,#0x00
      00016F                        657 00125$:
                                    658 ;	digit_mnist.c:68: b = (b << 1) | (getc_() == '1');
      00016F EF               [12]  659 	mov	a,r7
      000170 2F               [12]  660 	add	a,r7
      000171 FD               [12]  661 	mov	r5,a
      000172 C0 06            [24]  662 	push	ar6
      000174 C0 05            [24]  663 	push	ar5
      000176 12 00 DE         [24]  664 	lcall	_getc_
      000179 AC 82            [24]  665 	mov	r4, dpl
      00017B D0 05            [24]  666 	pop	ar5
      00017D D0 06            [24]  667 	pop	ar6
      00017F E4               [12]  668 	clr	a
      000180 BC 31 01         [24]  669 	cjne	r4,#0x31,00352$
      000183 04               [12]  670 	inc	a
      000184                        671 00352$:
      000184 4D               [12]  672 	orl	a,r5
      000185 FF               [12]  673 	mov	r7,a
                                    674 ;	digit_mnist.c:69: if ((i & 7) == 7) { pix[i >> 3] = b; b = 0; }
      000186 8E 05            [24]  675 	mov	ar5,r6
      000188 53 05 07         [24]  676 	anl	ar5,#0x07
      00018B BD 07 0C         [24]  677 	cjne	r5,#0x07,00126$
      00018E EE               [12]  678 	mov	a,r6
      00018F C4               [12]  679 	swap	a
      000190 23               [12]  680 	rl	a
      000191 54 1F            [12]  681 	anl	a,#0x1f
      000193 24 23            [12]  682 	add	a, #_pix
      000195 F8               [12]  683 	mov	r0,a
      000196 A6 07            [24]  684 	mov	@r0,ar7
      000198 7F 00            [12]  685 	mov	r7,#0x00
      00019A                        686 00126$:
                                    687 ;	digit_mnist.c:67: for (i = 0; i < NIN; i++) {
      00019A 0E               [12]  688 	inc	r6
      00019B BE C4 00         [24]  689 	cjne	r6,#0xc4,00356$
      00019E                        690 00356$:
      00019E 40 CF            [24]  691 	jc	00125$
                                    692 ;	digit_mnist.c:71: if (NIN & 7) pix[NIN >> 3] = b << (8 - (NIN & 7));
      0001A0 EF               [12]  693 	mov	a,r7
      0001A1 C4               [12]  694 	swap	a
      0001A2 54 F0            [12]  695 	anl	a,#0xf0
      0001A4 FF               [12]  696 	mov	r7,a
      0001A5 78 3B            [12]  697 	mov	r0,#(_pix + 0x0018)
      0001A7 A6 07            [24]  698 	mov	@r0,ar7
                                    699 ;	digit_mnist.c:74: for (j = 0; j < NH; j++) acc[j] = B1[j];
      0001A9 7F 00            [12]  700 	mov	r7,#0x00
      0001AB                        701 00127$:
      0001AB EF               [12]  702 	mov	a,r7
      0001AC 2F               [12]  703 	add	a,r7
      0001AD 24 3C            [12]  704 	add	a, #_acc
      0001AF F9               [12]  705 	mov	r1,a
      0001B0 EF               [12]  706 	mov	a,r7
      0001B1 75 F0 02         [24]  707 	mov	b,#0x02
      0001B4 A4               [48]  708 	mul	ab
      0001B5 24 3B            [12]  709 	add	a, #_B1
      0001B7 F5 82            [12]  710 	mov	dpl,a
      0001B9 74 04            [12]  711 	mov	a,#(_B1 >> 8)
      0001BB 35 F0            [12]  712 	addc	a, b
      0001BD F5 83            [12]  713 	mov	dph,a
      0001BF E4               [12]  714 	clr	a
      0001C0 93               [24]  715 	movc	a,@a+dptr
      0001C1 FD               [12]  716 	mov	r5,a
      0001C2 A3               [24]  717 	inc	dptr
      0001C3 E4               [12]  718 	clr	a
      0001C4 93               [24]  719 	movc	a,@a+dptr
      0001C5 FE               [12]  720 	mov	r6,a
      0001C6 A7 05            [24]  721 	mov	@r1,ar5
      0001C8 09               [12]  722 	inc	r1
      0001C9 A7 06            [24]  723 	mov	@r1,ar6
      0001CB 19               [12]  724 	dec	r1
      0001CC 0F               [12]  725 	inc	r7
      0001CD BF 20 00         [24]  726 	cjne	r7,#0x20,00358$
      0001D0                        727 00358$:
      0001D0 40 D9            [24]  728 	jc	00127$
                                    729 ;	digit_mnist.c:88: for (i = 0; i < NIN; i++)
      0001D2 75 15 00         [24]  730 	mov	_main_i_10000_12,#0x00
      0001D5                        731 00131$:
                                    732 ;	digit_mnist.c:89: if (pix[i >> 3] & (0x80 >> (i & 7)))
      0001D5 E5 15            [12]  733 	mov	a,_main_i_10000_12
      0001D7 C4               [12]  734 	swap	a
      0001D8 23               [12]  735 	rl	a
      0001D9 54 1F            [12]  736 	anl	a,#0x1f
      0001DB 24 23            [12]  737 	add	a, #_pix
      0001DD F9               [12]  738 	mov	r1,a
      0001DE 87 06            [24]  739 	mov	ar6,@r1
      0001E0 74 07            [12]  740 	mov	a,#0x07
      0001E2 55 15            [12]  741 	anl	a,_main_i_10000_12
      0001E4 F5 F0            [12]  742 	mov	b, a
      0001E6 05 F0            [12]  743 	inc	b
      0001E8 7D 80            [12]  744 	mov	r5,#0x80
      0001EA E4               [12]  745 	clr	a
      0001EB FC               [12]  746 	mov	r4,a
      0001EC 33               [12]  747 	rlc	a
      0001ED 92 D2            [24]  748 	mov	ov,c
      0001EF 80 08            [24]  749 	sjmp	00361$
      0001F1                        750 00360$:
      0001F1 A2 D2            [12]  751 	mov	c,ov
      0001F3 EC               [12]  752 	mov	a,r4
      0001F4 13               [12]  753 	rrc	a
      0001F5 FC               [12]  754 	mov	r4,a
      0001F6 ED               [12]  755 	mov	a,r5
      0001F7 13               [12]  756 	rrc	a
      0001F8 FD               [12]  757 	mov	r5,a
      0001F9                        758 00361$:
      0001F9 D5 F0 F5         [24]  759 	djnz	b,00360$
      0001FC 7B 00            [12]  760 	mov	r3,#0x00
      0001FE EE               [12]  761 	mov	a,r6
      0001FF 52 05            [12]  762 	anl	ar5,a
      000201 EB               [12]  763 	mov	a,r3
      000202 52 04            [12]  764 	anl	ar4,a
      000204 ED               [12]  765 	mov	a,r5
      000205 4C               [12]  766 	orl	a,r4
      000206 60 42            [24]  767 	jz	00132$
                                    768 ;	digit_mnist.c:90: for (j = 0; j < NH; j++) acc[j] += W1[i][j];
      000208 E5 15            [12]  769 	mov	a,_main_i_10000_12
      00020A 75 F0 20         [24]  770 	mov	b,#0x20
      00020D A4               [48]  771 	mul	ab
      00020E 24 7B            [12]  772 	add	a, #_W1
      000210 FD               [12]  773 	mov	r5,a
      000211 74 04            [12]  774 	mov	a,#(_W1 >> 8)
      000213 35 F0            [12]  775 	addc	a, b
      000215 FE               [12]  776 	mov	r6,a
      000216 75 16 00         [24]  777 	mov	_main_j_10000_12,#0x00
      000219                        778 00129$:
      000219 E5 16            [12]  779 	mov	a,_main_j_10000_12
      00021B 25 16            [12]  780 	add	a,_main_j_10000_12
      00021D 24 3C            [12]  781 	add	a, #_acc
      00021F F9               [12]  782 	mov	r1,a
      000220 87 02            [24]  783 	mov	ar2,@r1
      000222 09               [12]  784 	inc	r1
      000223 87 03            [24]  785 	mov	ar3,@r1
      000225 19               [12]  786 	dec	r1
      000226 E5 16            [12]  787 	mov	a,_main_j_10000_12
      000228 2D               [12]  788 	add	a, r5
      000229 F5 82            [12]  789 	mov	dpl,a
      00022B E4               [12]  790 	clr	a
      00022C 3E               [12]  791 	addc	a, r6
      00022D F5 83            [12]  792 	mov	dph,a
      00022F E4               [12]  793 	clr	a
      000230 93               [24]  794 	movc	a,@a+dptr
      000231 FC               [12]  795 	mov	r4,a
      000232 33               [12]  796 	rlc	a
      000233 95 E0            [12]  797 	subb	a,acc
      000235 FF               [12]  798 	mov	r7,a
      000236 EC               [12]  799 	mov	a,r4
      000237 2A               [12]  800 	add	a, r2
      000238 FA               [12]  801 	mov	r2,a
      000239 EF               [12]  802 	mov	a,r7
      00023A 3B               [12]  803 	addc	a, r3
      00023B FB               [12]  804 	mov	r3,a
      00023C A7 02            [24]  805 	mov	@r1,ar2
      00023E 09               [12]  806 	inc	r1
      00023F A7 03            [24]  807 	mov	@r1,ar3
      000241 19               [12]  808 	dec	r1
      000242 05 16            [12]  809 	inc	_main_j_10000_12
      000244 74 E0            [12]  810 	mov	a,#0x100 - 0x20
      000246 25 16            [12]  811 	add	a,_main_j_10000_12
      000248 50 CF            [24]  812 	jnc	00129$
      00024A                        813 00132$:
                                    814 ;	digit_mnist.c:88: for (i = 0; i < NIN; i++)
      00024A 05 15            [12]  815 	inc	_main_i_10000_12
      00024C 74 3C            [12]  816 	mov	a,#0x100 - 0xc4
      00024E 25 15            [12]  817 	add	a,_main_i_10000_12
      000250 40 03            [24]  818 	jc	00364$
      000252 02 01 D5         [24]  819 	ljmp	00131$
      000255                        820 00364$:
                                    821 ;	digit_mnist.c:93: for (j = 0; j < NH; j++) {
      000255 7F 00            [12]  822 	mov	r7,#0x00
      000257                        823 00133$:
                                    824 ;	digit_mnist.c:94: a = acc[j];
      000257 EF               [12]  825 	mov	a,r7
      000258 2F               [12]  826 	add	a,r7
      000259 24 3C            [12]  827 	add	a, #_acc
      00025B F9               [12]  828 	mov	r1,a
      00025C 87 05            [24]  829 	mov	ar5,@r1
      00025E 09               [12]  830 	inc	r1
      00025F 87 06            [24]  831 	mov	ar6,@r1
      000261 19               [12]  832 	dec	r1
                                    833 ;	digit_mnist.c:95: if (a < 0) hid[j] = 0;
      000262 EE               [12]  834 	mov	a,r6
      000263 30 E7 08         [24]  835 	jnb	acc.7,00115$
      000266 EF               [12]  836 	mov	a,r7
      000267 24 7C            [12]  837 	add	a, #_hid
      000269 F8               [12]  838 	mov	r0,a
      00026A 76 00            [12]  839 	mov	@r0,#0x00
      00026C 80 23            [24]  840 	sjmp	00134$
      00026E                        841 00115$:
                                    842 ;	digit_mnist.c:96: else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
      00026E EE               [12]  843 	mov	a,r6
      00026F A2 E7            [12]  844 	mov	c,acc.7
      000271 13               [12]  845 	rrc	a
      000272 CD               [12]  846 	xch	a,r5
      000273 13               [12]  847 	rrc	a
      000274 CD               [12]  848 	xch	a,r5
      000275 FE               [12]  849 	mov	r6,a
      000276 EF               [12]  850 	mov	a,r7
      000277 24 7C            [12]  851 	add	a, #_hid
      000279 F9               [12]  852 	mov	r1,a
      00027A C3               [12]  853 	clr	c
      00027B 74 FF            [12]  854 	mov	a,#0xff
      00027D 9D               [12]  855 	subb	a,r5
      00027E 74 80            [12]  856 	mov	a,#(0x00 ^ 0x80)
      000280 8E F0            [24]  857 	mov	b,r6
      000282 63 F0 80         [24]  858 	xrl	b,#0x80
      000285 95 F0            [12]  859 	subb	a,b
      000287 50 04            [24]  860 	jnc	00147$
                                    861 ;	free result
      000289 7C FF            [12]  862 	mov	r4,#0xff
      00028B 80 02            [24]  863 	sjmp	00148$
      00028D                        864 00147$:
      00028D 8D 04            [24]  865 	mov	ar4,r5
      00028F                        866 00148$:
      00028F A7 04            [24]  867 	mov	@r1,ar4
      000291                        868 00134$:
                                    869 ;	digit_mnist.c:93: for (j = 0; j < NH; j++) {
      000291 0F               [12]  870 	inc	r7
      000292 BF 20 00         [24]  871 	cjne	r7,#0x20,00367$
      000295                        872 00367$:
      000295 40 C0            [24]  873 	jc	00133$
                                    874 ;	digit_mnist.c:100: for (k = 0; k < 10; k++) {
      000297 75 17 00         [24]  875 	mov	_main_k_10000_12,#0x00
      00029A                        876 00137$:
                                    877 ;	digit_mnist.c:101: s = B2[k];
      00029A E5 17            [12]  878 	mov	a,_main_k_10000_12
      00029C 75 F0 04         [24]  879 	mov	b,#0x04
      00029F A4               [48]  880 	mul	ab
      0002A0 24 FB            [12]  881 	add	a, #_B2
      0002A2 F5 82            [12]  882 	mov	dpl,a
      0002A4 74 1C            [12]  883 	mov	a,#(_B2 >> 8)
      0002A6 35 F0            [12]  884 	addc	a, b
      0002A8 F5 83            [12]  885 	mov	dph,a
      0002AA E4               [12]  886 	clr	a
      0002AB 93               [24]  887 	movc	a,@a+dptr
      0002AC F5 19            [12]  888 	mov	_main_s_10000_12,a
      0002AE A3               [24]  889 	inc	dptr
      0002AF E4               [12]  890 	clr	a
      0002B0 93               [24]  891 	movc	a,@a+dptr
      0002B1 F5 1A            [12]  892 	mov	(_main_s_10000_12 + 1),a
      0002B3 A3               [24]  893 	inc	dptr
      0002B4 E4               [12]  894 	clr	a
      0002B5 93               [24]  895 	movc	a,@a+dptr
      0002B6 F5 1B            [12]  896 	mov	(_main_s_10000_12 + 2),a
      0002B8 A3               [24]  897 	inc	dptr
      0002B9 E4               [12]  898 	clr	a
      0002BA 93               [24]  899 	movc	a,@a+dptr
      0002BB F5 1C            [12]  900 	mov	(_main_s_10000_12 + 3),a
                                    901 ;	digit_mnist.c:111: for (j = 0; j < NH; j++)
      0002BD E5 17            [12]  902 	mov	a,_main_k_10000_12
      0002BF 75 F0 20         [24]  903 	mov	b,#0x20
      0002C2 A4               [48]  904 	mul	ab
      0002C3 24 23            [12]  905 	add	a, #_W2
      0002C5 FA               [12]  906 	mov	r2,a
      0002C6 74 1D            [12]  907 	mov	a,#(_W2 >> 8)
      0002C8 35 F0            [12]  908 	addc	a, b
      0002CA FE               [12]  909 	mov	r6,a
      0002CB 75 16 00         [24]  910 	mov	_main_j_10000_12,#0x00
      0002CE                        911 00135$:
                                    912 ;	digit_mnist.c:112: s += (int)hid[j] * W2[k][j];
      0002CE E5 16            [12]  913 	mov	a,_main_j_10000_12
      0002D0 24 7C            [12]  914 	add	a, #_hid
      0002D2 F9               [12]  915 	mov	r1,a
      0002D3 87 04            [24]  916 	mov	ar4,@r1
      0002D5 7B 00            [12]  917 	mov	r3,#0x00
      0002D7 E5 16            [12]  918 	mov	a,_main_j_10000_12
      0002D9 2A               [12]  919 	add	a, r2
      0002DA F5 82            [12]  920 	mov	dpl,a
      0002DC E4               [12]  921 	clr	a
      0002DD 3E               [12]  922 	addc	a, r6
      0002DE F5 83            [12]  923 	mov	dph,a
      0002E0 E4               [12]  924 	clr	a
      0002E1 93               [24]  925 	movc	a,@a+dptr
      0002E2 F5 21            [12]  926 	mov	__mulint_PARM_2, a
      0002E4 33               [12]  927 	rlc	a
      0002E5 95 E0            [12]  928 	subb	a,acc
      0002E7 F5 22            [12]  929 	mov	(__mulint_PARM_2 + 1),a
      0002E9 8C 82            [24]  930 	mov	dpl, r4
      0002EB 8B 83            [24]  931 	mov	dph, r3
      0002ED C0 06            [24]  932 	push	ar6
      0002EF C0 02            [24]  933 	push	ar2
      0002F1 12 04 1A         [24]  934 	lcall	__mulint
      0002F4 AF 82            [24]  935 	mov	r7, dpl
      0002F6 AC 83            [24]  936 	mov	r4, dph
      0002F8 D0 02            [24]  937 	pop	ar2
      0002FA D0 06            [24]  938 	pop	ar6
      0002FC 8F 03            [24]  939 	mov	ar3,r7
      0002FE EC               [12]  940 	mov	a,r4
      0002FF 33               [12]  941 	rlc	a
      000300 95 E0            [12]  942 	subb	a,acc
      000302 FD               [12]  943 	mov	r5,a
      000303 FF               [12]  944 	mov	r7,a
      000304 EB               [12]  945 	mov	a,r3
      000305 25 19            [12]  946 	add	a, _main_s_10000_12
      000307 F5 19            [12]  947 	mov	_main_s_10000_12,a
      000309 EC               [12]  948 	mov	a,r4
      00030A 35 1A            [12]  949 	addc	a, (_main_s_10000_12 + 1)
      00030C F5 1A            [12]  950 	mov	(_main_s_10000_12 + 1),a
      00030E ED               [12]  951 	mov	a,r5
      00030F 35 1B            [12]  952 	addc	a, (_main_s_10000_12 + 2)
      000311 F5 1B            [12]  953 	mov	(_main_s_10000_12 + 2),a
      000313 EF               [12]  954 	mov	a,r7
      000314 35 1C            [12]  955 	addc	a, (_main_s_10000_12 + 3)
      000316 F5 1C            [12]  956 	mov	(_main_s_10000_12 + 3),a
                                    957 ;	digit_mnist.c:111: for (j = 0; j < NH; j++)
      000318 05 16            [12]  958 	inc	_main_j_10000_12
      00031A 74 E0            [12]  959 	mov	a,#0x100 - 0x20
      00031C 25 16            [12]  960 	add	a,_main_j_10000_12
      00031E 50 AE            [24]  961 	jnc	00135$
                                    962 ;	digit_mnist.c:114: score[k] = s;
      000320 E5 17            [12]  963 	mov	a,_main_k_10000_12
      000322 25 17            [12]  964 	add	a,_main_k_10000_12
      000324 25 E0            [12]  965 	add	a,acc
      000326 24 9C            [12]  966 	add	a, #_score
      000328 F8               [12]  967 	mov	r0,a
      000329 A6 19            [24]  968 	mov	@r0,_main_s_10000_12
      00032B 08               [12]  969 	inc	r0
      00032C A6 1A            [24]  970 	mov	@r0,(_main_s_10000_12 + 1)
      00032E 08               [12]  971 	inc	r0
      00032F A6 1B            [24]  972 	mov	@r0,(_main_s_10000_12 + 2)
      000331 08               [12]  973 	inc	r0
      000332 A6 1C            [24]  974 	mov	@r0,(_main_s_10000_12 + 3)
                                    975 ;	digit_mnist.c:100: for (k = 0; k < 10; k++) {
      000334 05 17            [12]  976 	inc	_main_k_10000_12
      000336 74 F6            [12]  977 	mov	a,#0x100 - 0x0a
      000338 25 17            [12]  978 	add	a,_main_k_10000_12
      00033A 40 03            [24]  979 	jc	00370$
      00033C 02 02 9A         [24]  980 	ljmp	00137$
      00033F                        981 00370$:
                                    982 ;	digit_mnist.c:118: best = 0;
      00033F 7F 00            [12]  983 	mov	r7,#0x00
                                    984 ;	digit_mnist.c:119: for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;
      000341 75 18 01         [24]  985 	mov	_main_best_10000_12,#0x01
      000344                        986 00139$:
      000344 E5 18            [12]  987 	mov	a,_main_best_10000_12
      000346 25 18            [12]  988 	add	a,_main_best_10000_12
      000348 25 E0            [12]  989 	add	a,acc
      00034A 24 9C            [12]  990 	add	a, #_score
      00034C F9               [12]  991 	mov	r1,a
      00034D 87 1D            [24]  992 	mov	_main_sloc0_1_0,@r1
      00034F 09               [12]  993 	inc	r1
      000350 87 1E            [24]  994 	mov	(_main_sloc0_1_0 + 1),@r1
      000352 09               [12]  995 	inc	r1
      000353 87 1F            [24]  996 	mov	(_main_sloc0_1_0 + 2),@r1
      000355 09               [12]  997 	inc	r1
      000356 87 20            [24]  998 	mov	(_main_sloc0_1_0 + 3),@r1
      000358 19               [12]  999 	dec	r1
      000359 19               [12] 1000 	dec	r1
      00035A 19               [12] 1001 	dec	r1
      00035B EF               [12] 1002 	mov	a,r7
      00035C 2F               [12] 1003 	add	a,r7
      00035D 25 E0            [12] 1004 	add	a,acc
      00035F 24 9C            [12] 1005 	add	a, #_score
      000361 F9               [12] 1006 	mov	r1,a
      000362 C0 07            [24] 1007 	push	ar7
      000364 87 04            [24] 1008 	mov	ar4,@r1
      000366 09               [12] 1009 	inc	r1
      000367 87 05            [24] 1010 	mov	ar5,@r1
      000369 09               [12] 1011 	inc	r1
      00036A 87 06            [24] 1012 	mov	ar6,@r1
      00036C 09               [12] 1013 	inc	r1
      00036D 87 07            [24] 1014 	mov	ar7,@r1
      00036F 19               [12] 1015 	dec	r1
      000370 19               [12] 1016 	dec	r1
      000371 19               [12] 1017 	dec	r1
      000372 C3               [12] 1018 	clr	c
      000373 EC               [12] 1019 	mov	a,r4
      000374 95 1D            [12] 1020 	subb	a,_main_sloc0_1_0
      000376 ED               [12] 1021 	mov	a,r5
      000377 95 1E            [12] 1022 	subb	a,(_main_sloc0_1_0 + 1)
      000379 EE               [12] 1023 	mov	a,r6
      00037A 95 1F            [12] 1024 	subb	a,(_main_sloc0_1_0 + 2)
      00037C EF               [12] 1025 	mov	a,r7
      00037D 64 80            [12] 1026 	xrl	a,#0x80
      00037F 85 20 F0         [24] 1027 	mov	b,(_main_sloc0_1_0 + 3)
      000382 63 F0 80         [24] 1028 	xrl	b,#0x80
      000385 95 F0            [12] 1029 	subb	a,b
      000387 D0 07            [24] 1030 	pop	ar7
      000389 50 02            [24] 1031 	jnc	00140$
                                   1032 ;	free result
      00038B AF 18            [24] 1033 	mov	r7,_main_best_10000_12
      00038D                       1034 00140$:
      00038D 05 18            [12] 1035 	inc	_main_best_10000_12
      00038F 74 F6            [12] 1036 	mov	a,#0x100 - 0x0a
      000391 25 18            [12] 1037 	add	a,_main_best_10000_12
      000393 50 AF            [24] 1038 	jnc	00139$
                                   1039 ;	digit_mnist.c:121: dbuf[2] = 0xFF;
      000395 75 12 FF         [24] 1040 	mov	(_dbuf + 0x0002),#0xff
                                   1041 ;	digit_mnist.c:122: dbuf[3] = segs[best];
      000398 EF               [12] 1042 	mov	a,r7
      000399 90 1E 67         [24] 1043 	mov	dptr,#_segs
      00039C 93               [24] 1044 	movc	a,@a+dptr
      00039D F5 13            [12] 1045 	mov	(_dbuf + 0x0003), a
                                   1046 ;	digit_mnist.c:123: putc_('=');
      00039F 75 82 3D         [24] 1047 	mov	dpl, #0x3d
      0003A2 C0 07            [24] 1048 	push	ar7
      0003A4 12 00 E7         [24] 1049 	lcall	_putc_
      0003A7 D0 07            [24] 1050 	pop	ar7
                                   1051 ;	digit_mnist.c:124: putc_('0' + best);
      0003A9 74 30            [12] 1052 	mov	a,#0x30
      0003AB 2F               [12] 1053 	add	a, r7
      0003AC F5 82            [12] 1054 	mov	dpl,a
      0003AE 12 00 E7         [24] 1055 	lcall	_putc_
                                   1056 ;	digit_mnist.c:125: for (k = 0; k < 10; k++) {
      0003B1 7F 00            [12] 1057 	mov	r7,#0x00
      0003B3                       1058 00141$:
                                   1059 ;	digit_mnist.c:126: u = (unsigned long)score[k];
      0003B3 EF               [12] 1060 	mov	a,r7
      0003B4 2F               [12] 1061 	add	a,r7
      0003B5 25 E0            [12] 1062 	add	a,acc
      0003B7 24 9C            [12] 1063 	add	a, #_score
      0003B9 F9               [12] 1064 	mov	r1,a
      0003BA 87 03            [24] 1065 	mov	ar3,@r1
      0003BC 09               [12] 1066 	inc	r1
      0003BD 87 04            [24] 1067 	mov	ar4,@r1
      0003BF 09               [12] 1068 	inc	r1
      0003C0 87 05            [24] 1069 	mov	ar5,@r1
      0003C2 09               [12] 1070 	inc	r1
      0003C3 87 06            [24] 1071 	mov	ar6,@r1
      0003C5 19               [12] 1072 	dec	r1
      0003C6 19               [12] 1073 	dec	r1
      0003C7 19               [12] 1074 	dec	r1
                                   1075 ;	digit_mnist.c:127: putc_(' ');
      0003C8 75 82 20         [24] 1076 	mov	dpl, #0x20
      0003CB C0 07            [24] 1077 	push	ar7
      0003CD C0 06            [24] 1078 	push	ar6
      0003CF C0 05            [24] 1079 	push	ar5
      0003D1 C0 04            [24] 1080 	push	ar4
      0003D3 C0 03            [24] 1081 	push	ar3
      0003D5 12 00 E7         [24] 1082 	lcall	_putc_
      0003D8 D0 03            [24] 1083 	pop	ar3
      0003DA D0 04            [24] 1084 	pop	ar4
      0003DC D0 05            [24] 1085 	pop	ar5
                                   1086 ;	digit_mnist.c:128: puthex((unsigned char)(u >> 16));
      0003DE 8D 82            [24] 1087 	mov	dpl,r5
      0003E0 C0 05            [24] 1088 	push	ar5
      0003E2 C0 04            [24] 1089 	push	ar4
      0003E4 C0 03            [24] 1090 	push	ar3
      0003E6 12 00 F0         [24] 1091 	lcall	_puthex
      0003E9 D0 03            [24] 1092 	pop	ar3
      0003EB D0 04            [24] 1093 	pop	ar4
                                   1094 ;	digit_mnist.c:129: puthex((unsigned char)(u >> 8));
      0003ED 8C 82            [24] 1095 	mov	dpl,r4
      0003EF C0 04            [24] 1096 	push	ar4
      0003F1 C0 03            [24] 1097 	push	ar3
      0003F3 12 00 F0         [24] 1098 	lcall	_puthex
      0003F6 D0 03            [24] 1099 	pop	ar3
      0003F8 D0 04            [24] 1100 	pop	ar4
      0003FA D0 05            [24] 1101 	pop	ar5
      0003FC D0 06            [24] 1102 	pop	ar6
                                   1103 ;	digit_mnist.c:130: puthex((unsigned char)u);
      0003FE 8B 82            [24] 1104 	mov	dpl,r3
      000400 12 00 F0         [24] 1105 	lcall	_puthex
      000403 D0 07            [24] 1106 	pop	ar7
                                   1107 ;	digit_mnist.c:125: for (k = 0; k < 10; k++) {
      000405 0F               [12] 1108 	inc	r7
      000406 BF 0A 00         [24] 1109 	cjne	r7,#0x0a,00373$
      000409                       1110 00373$:
      000409 40 A8            [24] 1111 	jc	00141$
                                   1112 ;	digit_mnist.c:132: putc_('\r');
      00040B 75 82 0D         [24] 1113 	mov	dpl, #0x0d
      00040E 12 00 E7         [24] 1114 	lcall	_putc_
                                   1115 ;	digit_mnist.c:133: putc_('\n');
      000411 75 82 0A         [24] 1116 	mov	dpl, #0x0a
      000414 12 00 E7         [24] 1117 	lcall	_putc_
                                   1118 ;	digit_mnist.c:135: }
      000417 02 01 63         [24] 1119 	ljmp	00101$
                                   1120 	.area CSEG    (CODE)
                                   1121 	.area CONST   (CODE)
                                   1122 	.area CONST   (CODE)
      00043B                       1123 _B1:
      00043B F1 FF                 1124 	.byte #0xf1, #0xff	; -15
      00043D 19 00                 1125 	.byte #0x19, #0x00	;  25
      00043F E9 FF                 1126 	.byte #0xe9, #0xff	; -23
      000441 1E 00                 1127 	.byte #0x1e, #0x00	;  30
      000443 B7 FF                 1128 	.byte #0xb7, #0xff	; -73
      000445 FA FF                 1129 	.byte #0xfa, #0xff	; -6
      000447 FC FF                 1130 	.byte #0xfc, #0xff	; -4
      000449 14 00                 1131 	.byte #0x14, #0x00	;  20
      00044B 2C 00                 1132 	.byte #0x2c, #0x00	;  44
      00044D DA FF                 1133 	.byte #0xda, #0xff	; -38
      00044F CC FF                 1134 	.byte #0xcc, #0xff	; -52
      000451 22 00                 1135 	.byte #0x22, #0x00	;  34
      000453 FA FF                 1136 	.byte #0xfa, #0xff	; -6
      000455 FD FF                 1137 	.byte #0xfd, #0xff	; -3
      000457 E1 FF                 1138 	.byte #0xe1, #0xff	; -31
      000459 30 00                 1139 	.byte #0x30, #0x00	;  48
      00045B 1D 00                 1140 	.byte #0x1d, #0x00	;  29
      00045D E0 FF                 1141 	.byte #0xe0, #0xff	; -32
      00045F CA FF                 1142 	.byte #0xca, #0xff	; -54
      000461 01 00                 1143 	.byte #0x01, #0x00	;  1
      000463 00 00                 1144 	.byte #0x00, #0x00	;  0
      000465 2B 00                 1145 	.byte #0x2b, #0x00	;  43
      000467 0E 00                 1146 	.byte #0x0e, #0x00	;  14
      000469 EB FF                 1147 	.byte #0xeb, #0xff	; -21
      00046B FD FF                 1148 	.byte #0xfd, #0xff	; -3
      00046D F7 FF                 1149 	.byte #0xf7, #0xff	; -9
      00046F 35 00                 1150 	.byte #0x35, #0x00	;  53
      000471 02 00                 1151 	.byte #0x02, #0x00	;  2
      000473 26 00                 1152 	.byte #0x26, #0x00	;  38
      000475 33 00                 1153 	.byte #0x33, #0x00	;  51
      000477 1F 00                 1154 	.byte #0x1f, #0x00	;  31
      000479 EC FF                 1155 	.byte #0xec, #0xff	; -20
                                   1156 	.area CSEG    (CODE)
                                   1157 	.area CONST   (CODE)
      00047B                       1158 _W1:
      00047B 00                    1159 	.db #0x00	;  0
      00047C 00                    1160 	.db #0x00	;  0
      00047D 00                    1161 	.db #0x00	;  0
      00047E 00                    1162 	.db #0x00	;  0
      00047F 00                    1163 	.db #0x00	;  0
      000480 00                    1164 	.db #0x00	;  0
      000481 00                    1165 	.db #0x00	;  0
      000482 00                    1166 	.db #0x00	;  0
      000483 00                    1167 	.db #0x00	;  0
      000484 00                    1168 	.db #0x00	;  0
      000485 00                    1169 	.db #0x00	;  0
      000486 00                    1170 	.db #0x00	;  0
      000487 00                    1171 	.db #0x00	;  0
      000488 00                    1172 	.db #0x00	;  0
      000489 00                    1173 	.db #0x00	;  0
      00048A 00                    1174 	.db #0x00	;  0
      00048B 00                    1175 	.db #0x00	;  0
      00048C 00                    1176 	.db #0x00	;  0
      00048D 00                    1177 	.db #0x00	;  0
      00048E 00                    1178 	.db #0x00	;  0
      00048F 00                    1179 	.db #0x00	;  0
      000490 00                    1180 	.db #0x00	;  0
      000491 00                    1181 	.db #0x00	;  0
      000492 00                    1182 	.db #0x00	;  0
      000493 00                    1183 	.db #0x00	;  0
      000494 00                    1184 	.db #0x00	;  0
      000495 00                    1185 	.db #0x00	;  0
      000496 00                    1186 	.db #0x00	;  0
      000497 00                    1187 	.db #0x00	;  0
      000498 00                    1188 	.db #0x00	;  0
      000499 00                    1189 	.db #0x00	;  0
      00049A 00                    1190 	.db #0x00	;  0
      00049B 00                    1191 	.db #0x00	;  0
      00049C 00                    1192 	.db #0x00	;  0
      00049D 00                    1193 	.db #0x00	;  0
      00049E 00                    1194 	.db #0x00	;  0
      00049F 00                    1195 	.db #0x00	;  0
      0004A0 00                    1196 	.db #0x00	;  0
      0004A1 00                    1197 	.db #0x00	;  0
      0004A2 00                    1198 	.db #0x00	;  0
      0004A3 00                    1199 	.db #0x00	;  0
      0004A4 00                    1200 	.db #0x00	;  0
      0004A5 00                    1201 	.db #0x00	;  0
      0004A6 00                    1202 	.db #0x00	;  0
      0004A7 00                    1203 	.db #0x00	;  0
      0004A8 00                    1204 	.db #0x00	;  0
      0004A9 00                    1205 	.db #0x00	;  0
      0004AA 00                    1206 	.db #0x00	;  0
      0004AB 00                    1207 	.db #0x00	;  0
      0004AC 00                    1208 	.db #0x00	;  0
      0004AD 00                    1209 	.db #0x00	;  0
      0004AE 00                    1210 	.db #0x00	;  0
      0004AF 00                    1211 	.db #0x00	;  0
      0004B0 00                    1212 	.db #0x00	;  0
      0004B1 00                    1213 	.db #0x00	;  0
      0004B2 00                    1214 	.db #0x00	;  0
      0004B3 00                    1215 	.db #0x00	;  0
      0004B4 00                    1216 	.db #0x00	;  0
      0004B5 00                    1217 	.db #0x00	;  0
      0004B6 00                    1218 	.db #0x00	;  0
      0004B7 00                    1219 	.db #0x00	;  0
      0004B8 00                    1220 	.db #0x00	;  0
      0004B9 00                    1221 	.db #0x00	;  0
      0004BA 00                    1222 	.db #0x00	;  0
      0004BB 00                    1223 	.db #0x00	;  0
      0004BC 00                    1224 	.db #0x00	;  0
      0004BD 00                    1225 	.db #0x00	;  0
      0004BE 00                    1226 	.db #0x00	;  0
      0004BF 00                    1227 	.db #0x00	;  0
      0004C0 00                    1228 	.db #0x00	;  0
      0004C1 00                    1229 	.db #0x00	;  0
      0004C2 00                    1230 	.db #0x00	;  0
      0004C3 00                    1231 	.db #0x00	;  0
      0004C4 00                    1232 	.db #0x00	;  0
      0004C5 00                    1233 	.db #0x00	;  0
      0004C6 00                    1234 	.db #0x00	;  0
      0004C7 00                    1235 	.db #0x00	;  0
      0004C8 00                    1236 	.db #0x00	;  0
      0004C9 00                    1237 	.db #0x00	;  0
      0004CA 00                    1238 	.db #0x00	;  0
      0004CB 00                    1239 	.db #0x00	;  0
      0004CC 00                    1240 	.db #0x00	;  0
      0004CD 00                    1241 	.db #0x00	;  0
      0004CE 00                    1242 	.db #0x00	;  0
      0004CF 00                    1243 	.db #0x00	;  0
      0004D0 00                    1244 	.db #0x00	;  0
      0004D1 00                    1245 	.db #0x00	;  0
      0004D2 00                    1246 	.db #0x00	;  0
      0004D3 00                    1247 	.db #0x00	;  0
      0004D4 00                    1248 	.db #0x00	;  0
      0004D5 00                    1249 	.db #0x00	;  0
      0004D6 00                    1250 	.db #0x00	;  0
      0004D7 00                    1251 	.db #0x00	;  0
      0004D8 00                    1252 	.db #0x00	;  0
      0004D9 00                    1253 	.db #0x00	;  0
      0004DA 00                    1254 	.db #0x00	;  0
      0004DB 00                    1255 	.db #0x00	;  0
      0004DC 00                    1256 	.db #0x00	;  0
      0004DD 00                    1257 	.db #0x00	;  0
      0004DE 00                    1258 	.db #0x00	;  0
      0004DF 00                    1259 	.db #0x00	;  0
      0004E0 00                    1260 	.db #0x00	;  0
      0004E1 00                    1261 	.db #0x00	;  0
      0004E2 00                    1262 	.db #0x00	;  0
      0004E3 00                    1263 	.db #0x00	;  0
      0004E4 00                    1264 	.db #0x00	;  0
      0004E5 00                    1265 	.db #0x00	;  0
      0004E6 00                    1266 	.db #0x00	;  0
      0004E7 00                    1267 	.db #0x00	;  0
      0004E8 00                    1268 	.db #0x00	;  0
      0004E9 00                    1269 	.db #0x00	;  0
      0004EA 00                    1270 	.db #0x00	;  0
      0004EB 00                    1271 	.db #0x00	;  0
      0004EC 00                    1272 	.db #0x00	;  0
      0004ED 00                    1273 	.db #0x00	;  0
      0004EE 00                    1274 	.db #0x00	;  0
      0004EF 00                    1275 	.db #0x00	;  0
      0004F0 00                    1276 	.db #0x00	;  0
      0004F1 00                    1277 	.db #0x00	;  0
      0004F2 00                    1278 	.db #0x00	;  0
      0004F3 00                    1279 	.db #0x00	;  0
      0004F4 00                    1280 	.db #0x00	;  0
      0004F5 00                    1281 	.db #0x00	;  0
      0004F6 00                    1282 	.db #0x00	;  0
      0004F7 00                    1283 	.db #0x00	;  0
      0004F8 00                    1284 	.db #0x00	;  0
      0004F9 00                    1285 	.db #0x00	;  0
      0004FA 00                    1286 	.db #0x00	;  0
      0004FB 00                    1287 	.db #0x00	;  0
      0004FC 00                    1288 	.db #0x00	;  0
      0004FD 00                    1289 	.db #0x00	;  0
      0004FE 00                    1290 	.db #0x00	;  0
      0004FF 00                    1291 	.db #0x00	;  0
      000500 00                    1292 	.db #0x00	;  0
      000501 00                    1293 	.db #0x00	;  0
      000502 00                    1294 	.db #0x00	;  0
      000503 00                    1295 	.db #0x00	;  0
      000504 00                    1296 	.db #0x00	;  0
      000505 00                    1297 	.db #0x00	;  0
      000506 00                    1298 	.db #0x00	;  0
      000507 00                    1299 	.db #0x00	;  0
      000508 00                    1300 	.db #0x00	;  0
      000509 00                    1301 	.db #0x00	;  0
      00050A 00                    1302 	.db #0x00	;  0
      00050B 00                    1303 	.db #0x00	;  0
      00050C 00                    1304 	.db #0x00	;  0
      00050D 00                    1305 	.db #0x00	;  0
      00050E 00                    1306 	.db #0x00	;  0
      00050F 00                    1307 	.db #0x00	;  0
      000510 00                    1308 	.db #0x00	;  0
      000511 00                    1309 	.db #0x00	;  0
      000512 00                    1310 	.db #0x00	;  0
      000513 00                    1311 	.db #0x00	;  0
      000514 00                    1312 	.db #0x00	;  0
      000515 00                    1313 	.db #0x00	;  0
      000516 00                    1314 	.db #0x00	;  0
      000517 00                    1315 	.db #0x00	;  0
      000518 00                    1316 	.db #0x00	;  0
      000519 00                    1317 	.db #0x00	;  0
      00051A 00                    1318 	.db #0x00	;  0
      00051B 00                    1319 	.db #0x00	;  0
      00051C 00                    1320 	.db #0x00	;  0
      00051D 00                    1321 	.db #0x00	;  0
      00051E 00                    1322 	.db #0x00	;  0
      00051F 00                    1323 	.db #0x00	;  0
      000520 00                    1324 	.db #0x00	;  0
      000521 00                    1325 	.db #0x00	;  0
      000522 00                    1326 	.db #0x00	;  0
      000523 00                    1327 	.db #0x00	;  0
      000524 00                    1328 	.db #0x00	;  0
      000525 00                    1329 	.db #0x00	;  0
      000526 00                    1330 	.db #0x00	;  0
      000527 00                    1331 	.db #0x00	;  0
      000528 00                    1332 	.db #0x00	;  0
      000529 00                    1333 	.db #0x00	;  0
      00052A 00                    1334 	.db #0x00	;  0
      00052B 00                    1335 	.db #0x00	;  0
      00052C 00                    1336 	.db #0x00	;  0
      00052D 00                    1337 	.db #0x00	;  0
      00052E 00                    1338 	.db #0x00	;  0
      00052F 00                    1339 	.db #0x00	;  0
      000530 00                    1340 	.db #0x00	;  0
      000531 00                    1341 	.db #0x00	;  0
      000532 00                    1342 	.db #0x00	;  0
      000533 00                    1343 	.db #0x00	;  0
      000534 00                    1344 	.db #0x00	;  0
      000535 00                    1345 	.db #0x00	;  0
      000536 00                    1346 	.db #0x00	;  0
      000537 00                    1347 	.db #0x00	;  0
      000538 00                    1348 	.db #0x00	;  0
      000539 00                    1349 	.db #0x00	;  0
      00053A 00                    1350 	.db #0x00	;  0
      00053B 00                    1351 	.db #0x00	;  0
      00053C 00                    1352 	.db #0x00	;  0
      00053D 00                    1353 	.db #0x00	;  0
      00053E 00                    1354 	.db #0x00	;  0
      00053F 00                    1355 	.db #0x00	;  0
      000540 00                    1356 	.db #0x00	;  0
      000541 00                    1357 	.db #0x00	;  0
      000542 00                    1358 	.db #0x00	;  0
      000543 00                    1359 	.db #0x00	;  0
      000544 00                    1360 	.db #0x00	;  0
      000545 00                    1361 	.db #0x00	;  0
      000546 00                    1362 	.db #0x00	;  0
      000547 00                    1363 	.db #0x00	;  0
      000548 00                    1364 	.db #0x00	;  0
      000549 00                    1365 	.db #0x00	;  0
      00054A 00                    1366 	.db #0x00	;  0
      00054B 00                    1367 	.db #0x00	;  0
      00054C 00                    1368 	.db #0x00	;  0
      00054D 00                    1369 	.db #0x00	;  0
      00054E 00                    1370 	.db #0x00	;  0
      00054F 00                    1371 	.db #0x00	;  0
      000550 00                    1372 	.db #0x00	;  0
      000551 00                    1373 	.db #0x00	;  0
      000552 00                    1374 	.db #0x00	;  0
      000553 00                    1375 	.db #0x00	;  0
      000554 00                    1376 	.db #0x00	;  0
      000555 00                    1377 	.db #0x00	;  0
      000556 00                    1378 	.db #0x00	;  0
      000557 00                    1379 	.db #0x00	;  0
      000558 00                    1380 	.db #0x00	;  0
      000559 00                    1381 	.db #0x00	;  0
      00055A 00                    1382 	.db #0x00	;  0
      00055B 00                    1383 	.db #0x00	;  0
      00055C 00                    1384 	.db #0x00	;  0
      00055D 00                    1385 	.db #0x00	;  0
      00055E FF                    1386 	.db #0xff	; -1
      00055F 05                    1387 	.db #0x05	;  5
      000560 00                    1388 	.db #0x00	;  0
      000561 00                    1389 	.db #0x00	;  0
      000562 00                    1390 	.db #0x00	;  0
      000563 00                    1391 	.db #0x00	;  0
      000564 00                    1392 	.db #0x00	;  0
      000565 FA                    1393 	.db #0xfa	; -6
      000566 00                    1394 	.db #0x00	;  0
      000567 00                    1395 	.db #0x00	;  0
      000568 00                    1396 	.db #0x00	;  0
      000569 00                    1397 	.db #0x00	;  0
      00056A 05                    1398 	.db #0x05	;  5
      00056B 00                    1399 	.db #0x00	;  0
      00056C FB                    1400 	.db #0xfb	; -5
      00056D 00                    1401 	.db #0x00	;  0
      00056E 01                    1402 	.db #0x01	;  1
      00056F 08                    1403 	.db #0x08	;  8
      000570 00                    1404 	.db #0x00	;  0
      000571 FF                    1405 	.db #0xff	; -1
      000572 00                    1406 	.db #0x00	;  0
      000573 00                    1407 	.db #0x00	;  0
      000574 00                    1408 	.db #0x00	;  0
      000575 FF                    1409 	.db #0xff	; -1
      000576 F8                    1410 	.db #0xf8	; -8
      000577 00                    1411 	.db #0x00	;  0
      000578 03                    1412 	.db #0x03	;  3
      000579 FF                    1413 	.db #0xff	; -1
      00057A 01                    1414 	.db #0x01	;  1
      00057B 00                    1415 	.db #0x00	;  0
      00057C 00                    1416 	.db #0x00	;  0
      00057D 00                    1417 	.db #0x00	;  0
      00057E 00                    1418 	.db #0x00	;  0
      00057F 00                    1419 	.db #0x00	;  0
      000580 00                    1420 	.db #0x00	;  0
      000581 00                    1421 	.db #0x00	;  0
      000582 00                    1422 	.db #0x00	;  0
      000583 00                    1423 	.db #0x00	;  0
      000584 00                    1424 	.db #0x00	;  0
      000585 00                    1425 	.db #0x00	;  0
      000586 00                    1426 	.db #0x00	;  0
      000587 00                    1427 	.db #0x00	;  0
      000588 00                    1428 	.db #0x00	;  0
      000589 00                    1429 	.db #0x00	;  0
      00058A 00                    1430 	.db #0x00	;  0
      00058B 00                    1431 	.db #0x00	;  0
      00058C 00                    1432 	.db #0x00	;  0
      00058D 00                    1433 	.db #0x00	;  0
      00058E 00                    1434 	.db #0x00	;  0
      00058F 00                    1435 	.db #0x00	;  0
      000590 00                    1436 	.db #0x00	;  0
      000591 00                    1437 	.db #0x00	;  0
      000592 00                    1438 	.db #0x00	;  0
      000593 00                    1439 	.db #0x00	;  0
      000594 00                    1440 	.db #0x00	;  0
      000595 00                    1441 	.db #0x00	;  0
      000596 00                    1442 	.db #0x00	;  0
      000597 00                    1443 	.db #0x00	;  0
      000598 00                    1444 	.db #0x00	;  0
      000599 00                    1445 	.db #0x00	;  0
      00059A 00                    1446 	.db #0x00	;  0
      00059B 00                    1447 	.db #0x00	;  0
      00059C 00                    1448 	.db #0x00	;  0
      00059D 00                    1449 	.db #0x00	;  0
      00059E 00                    1450 	.db #0x00	;  0
      00059F 00                    1451 	.db #0x00	;  0
      0005A0 00                    1452 	.db #0x00	;  0
      0005A1 00                    1453 	.db #0x00	;  0
      0005A2 00                    1454 	.db #0x00	;  0
      0005A3 00                    1455 	.db #0x00	;  0
      0005A4 00                    1456 	.db #0x00	;  0
      0005A5 00                    1457 	.db #0x00	;  0
      0005A6 00                    1458 	.db #0x00	;  0
      0005A7 00                    1459 	.db #0x00	;  0
      0005A8 00                    1460 	.db #0x00	;  0
      0005A9 00                    1461 	.db #0x00	;  0
      0005AA 00                    1462 	.db #0x00	;  0
      0005AB 00                    1463 	.db #0x00	;  0
      0005AC 00                    1464 	.db #0x00	;  0
      0005AD 00                    1465 	.db #0x00	;  0
      0005AE 00                    1466 	.db #0x00	;  0
      0005AF 00                    1467 	.db #0x00	;  0
      0005B0 00                    1468 	.db #0x00	;  0
      0005B1 00                    1469 	.db #0x00	;  0
      0005B2 00                    1470 	.db #0x00	;  0
      0005B3 00                    1471 	.db #0x00	;  0
      0005B4 00                    1472 	.db #0x00	;  0
      0005B5 00                    1473 	.db #0x00	;  0
      0005B6 00                    1474 	.db #0x00	;  0
      0005B7 00                    1475 	.db #0x00	;  0
      0005B8 00                    1476 	.db #0x00	;  0
      0005B9 00                    1477 	.db #0x00	;  0
      0005BA 00                    1478 	.db #0x00	;  0
      0005BB 00                    1479 	.db #0x00	;  0
      0005BC 00                    1480 	.db #0x00	;  0
      0005BD 00                    1481 	.db #0x00	;  0
      0005BE 00                    1482 	.db #0x00	;  0
      0005BF 00                    1483 	.db #0x00	;  0
      0005C0 00                    1484 	.db #0x00	;  0
      0005C1 00                    1485 	.db #0x00	;  0
      0005C2 00                    1486 	.db #0x00	;  0
      0005C3 00                    1487 	.db #0x00	;  0
      0005C4 00                    1488 	.db #0x00	;  0
      0005C5 00                    1489 	.db #0x00	;  0
      0005C6 00                    1490 	.db #0x00	;  0
      0005C7 00                    1491 	.db #0x00	;  0
      0005C8 00                    1492 	.db #0x00	;  0
      0005C9 00                    1493 	.db #0x00	;  0
      0005CA 00                    1494 	.db #0x00	;  0
      0005CB 00                    1495 	.db #0x00	;  0
      0005CC 00                    1496 	.db #0x00	;  0
      0005CD 00                    1497 	.db #0x00	;  0
      0005CE 00                    1498 	.db #0x00	;  0
      0005CF 00                    1499 	.db #0x00	;  0
      0005D0 00                    1500 	.db #0x00	;  0
      0005D1 00                    1501 	.db #0x00	;  0
      0005D2 00                    1502 	.db #0x00	;  0
      0005D3 00                    1503 	.db #0x00	;  0
      0005D4 00                    1504 	.db #0x00	;  0
      0005D5 00                    1505 	.db #0x00	;  0
      0005D6 00                    1506 	.db #0x00	;  0
      0005D7 00                    1507 	.db #0x00	;  0
      0005D8 00                    1508 	.db #0x00	;  0
      0005D9 00                    1509 	.db #0x00	;  0
      0005DA 00                    1510 	.db #0x00	;  0
      0005DB 00                    1511 	.db #0x00	;  0
      0005DC 00                    1512 	.db #0x00	;  0
      0005DD 00                    1513 	.db #0x00	;  0
      0005DE 00                    1514 	.db #0x00	;  0
      0005DF 00                    1515 	.db #0x00	;  0
      0005E0 00                    1516 	.db #0x00	;  0
      0005E1 00                    1517 	.db #0x00	;  0
      0005E2 00                    1518 	.db #0x00	;  0
      0005E3 00                    1519 	.db #0x00	;  0
      0005E4 00                    1520 	.db #0x00	;  0
      0005E5 00                    1521 	.db #0x00	;  0
      0005E6 00                    1522 	.db #0x00	;  0
      0005E7 00                    1523 	.db #0x00	;  0
      0005E8 00                    1524 	.db #0x00	;  0
      0005E9 00                    1525 	.db #0x00	;  0
      0005EA 00                    1526 	.db #0x00	;  0
      0005EB 00                    1527 	.db #0x00	;  0
      0005EC 00                    1528 	.db #0x00	;  0
      0005ED 00                    1529 	.db #0x00	;  0
      0005EE 00                    1530 	.db #0x00	;  0
      0005EF 00                    1531 	.db #0x00	;  0
      0005F0 00                    1532 	.db #0x00	;  0
      0005F1 00                    1533 	.db #0x00	;  0
      0005F2 00                    1534 	.db #0x00	;  0
      0005F3 00                    1535 	.db #0x00	;  0
      0005F4 00                    1536 	.db #0x00	;  0
      0005F5 00                    1537 	.db #0x00	;  0
      0005F6 00                    1538 	.db #0x00	;  0
      0005F7 00                    1539 	.db #0x00	;  0
      0005F8 00                    1540 	.db #0x00	;  0
      0005F9 00                    1541 	.db #0x00	;  0
      0005FA 00                    1542 	.db #0x00	;  0
      0005FB 00                    1543 	.db #0x00	;  0
      0005FC 00                    1544 	.db #0x00	;  0
      0005FD 00                    1545 	.db #0x00	;  0
      0005FE 00                    1546 	.db #0x00	;  0
      0005FF 00                    1547 	.db #0x00	;  0
      000600 00                    1548 	.db #0x00	;  0
      000601 00                    1549 	.db #0x00	;  0
      000602 00                    1550 	.db #0x00	;  0
      000603 00                    1551 	.db #0x00	;  0
      000604 00                    1552 	.db #0x00	;  0
      000605 00                    1553 	.db #0x00	;  0
      000606 00                    1554 	.db #0x00	;  0
      000607 00                    1555 	.db #0x00	;  0
      000608 00                    1556 	.db #0x00	;  0
      000609 00                    1557 	.db #0x00	;  0
      00060A 00                    1558 	.db #0x00	;  0
      00060B 00                    1559 	.db #0x00	;  0
      00060C 00                    1560 	.db #0x00	;  0
      00060D 00                    1561 	.db #0x00	;  0
      00060E 00                    1562 	.db #0x00	;  0
      00060F 00                    1563 	.db #0x00	;  0
      000610 00                    1564 	.db #0x00	;  0
      000611 00                    1565 	.db #0x00	;  0
      000612 00                    1566 	.db #0x00	;  0
      000613 00                    1567 	.db #0x00	;  0
      000614 00                    1568 	.db #0x00	;  0
      000615 00                    1569 	.db #0x00	;  0
      000616 00                    1570 	.db #0x00	;  0
      000617 00                    1571 	.db #0x00	;  0
      000618 00                    1572 	.db #0x00	;  0
      000619 00                    1573 	.db #0x00	;  0
      00061A 00                    1574 	.db #0x00	;  0
      00061B 00                    1575 	.db #0x00	;  0
      00061C 00                    1576 	.db #0x00	;  0
      00061D 00                    1577 	.db #0x00	;  0
      00061E 00                    1578 	.db #0x00	;  0
      00061F 00                    1579 	.db #0x00	;  0
      000620 00                    1580 	.db #0x00	;  0
      000621 00                    1581 	.db #0x00	;  0
      000622 00                    1582 	.db #0x00	;  0
      000623 00                    1583 	.db #0x00	;  0
      000624 00                    1584 	.db #0x00	;  0
      000625 00                    1585 	.db #0x00	;  0
      000626 00                    1586 	.db #0x00	;  0
      000627 00                    1587 	.db #0x00	;  0
      000628 00                    1588 	.db #0x00	;  0
      000629 00                    1589 	.db #0x00	;  0
      00062A 00                    1590 	.db #0x00	;  0
      00062B 00                    1591 	.db #0x00	;  0
      00062C 00                    1592 	.db #0x00	;  0
      00062D 00                    1593 	.db #0x00	;  0
      00062E 00                    1594 	.db #0x00	;  0
      00062F 00                    1595 	.db #0x00	;  0
      000630 00                    1596 	.db #0x00	;  0
      000631 00                    1597 	.db #0x00	;  0
      000632 00                    1598 	.db #0x00	;  0
      000633 00                    1599 	.db #0x00	;  0
      000634 00                    1600 	.db #0x00	;  0
      000635 00                    1601 	.db #0x00	;  0
      000636 00                    1602 	.db #0x00	;  0
      000637 00                    1603 	.db #0x00	;  0
      000638 00                    1604 	.db #0x00	;  0
      000639 00                    1605 	.db #0x00	;  0
      00063A 00                    1606 	.db #0x00	;  0
      00063B 00                    1607 	.db #0x00	;  0
      00063C 00                    1608 	.db #0x00	;  0
      00063D 00                    1609 	.db #0x00	;  0
      00063E 00                    1610 	.db #0x00	;  0
      00063F 00                    1611 	.db #0x00	;  0
      000640 00                    1612 	.db #0x00	;  0
      000641 00                    1613 	.db #0x00	;  0
      000642 00                    1614 	.db #0x00	;  0
      000643 00                    1615 	.db #0x00	;  0
      000644 00                    1616 	.db #0x00	;  0
      000645 00                    1617 	.db #0x00	;  0
      000646 00                    1618 	.db #0x00	;  0
      000647 00                    1619 	.db #0x00	;  0
      000648 00                    1620 	.db #0x00	;  0
      000649 00                    1621 	.db #0x00	;  0
      00064A 00                    1622 	.db #0x00	;  0
      00064B 00                    1623 	.db #0x00	;  0
      00064C 00                    1624 	.db #0x00	;  0
      00064D 00                    1625 	.db #0x00	;  0
      00064E 00                    1626 	.db #0x00	;  0
      00064F 00                    1627 	.db #0x00	;  0
      000650 00                    1628 	.db #0x00	;  0
      000651 00                    1629 	.db #0x00	;  0
      000652 00                    1630 	.db #0x00	;  0
      000653 00                    1631 	.db #0x00	;  0
      000654 00                    1632 	.db #0x00	;  0
      000655 00                    1633 	.db #0x00	;  0
      000656 00                    1634 	.db #0x00	;  0
      000657 00                    1635 	.db #0x00	;  0
      000658 00                    1636 	.db #0x00	;  0
      000659 00                    1637 	.db #0x00	;  0
      00065A 00                    1638 	.db #0x00	;  0
      00065B 00                    1639 	.db #0x00	;  0
      00065C 00                    1640 	.db #0x00	;  0
      00065D 00                    1641 	.db #0x00	;  0
      00065E 00                    1642 	.db #0x00	;  0
      00065F 00                    1643 	.db #0x00	;  0
      000660 00                    1644 	.db #0x00	;  0
      000661 00                    1645 	.db #0x00	;  0
      000662 00                    1646 	.db #0x00	;  0
      000663 00                    1647 	.db #0x00	;  0
      000664 00                    1648 	.db #0x00	;  0
      000665 00                    1649 	.db #0x00	;  0
      000666 00                    1650 	.db #0x00	;  0
      000667 00                    1651 	.db #0x00	;  0
      000668 00                    1652 	.db #0x00	;  0
      000669 00                    1653 	.db #0x00	;  0
      00066A 00                    1654 	.db #0x00	;  0
      00066B 00                    1655 	.db #0x00	;  0
      00066C 00                    1656 	.db #0x00	;  0
      00066D 00                    1657 	.db #0x00	;  0
      00066E 00                    1658 	.db #0x00	;  0
      00066F 00                    1659 	.db #0x00	;  0
      000670 00                    1660 	.db #0x00	;  0
      000671 00                    1661 	.db #0x00	;  0
      000672 00                    1662 	.db #0x00	;  0
      000673 00                    1663 	.db #0x00	;  0
      000674 00                    1664 	.db #0x00	;  0
      000675 00                    1665 	.db #0x00	;  0
      000676 00                    1666 	.db #0x00	;  0
      000677 00                    1667 	.db #0x00	;  0
      000678 00                    1668 	.db #0x00	;  0
      000679 00                    1669 	.db #0x00	;  0
      00067A 00                    1670 	.db #0x00	;  0
      00067B 00                    1671 	.db #0x00	;  0
      00067C 00                    1672 	.db #0x00	;  0
      00067D 00                    1673 	.db #0x00	;  0
      00067E 00                    1674 	.db #0x00	;  0
      00067F 00                    1675 	.db #0x00	;  0
      000680 00                    1676 	.db #0x00	;  0
      000681 00                    1677 	.db #0x00	;  0
      000682 00                    1678 	.db #0x00	;  0
      000683 00                    1679 	.db #0x00	;  0
      000684 00                    1680 	.db #0x00	;  0
      000685 00                    1681 	.db #0x00	;  0
      000686 00                    1682 	.db #0x00	;  0
      000687 00                    1683 	.db #0x00	;  0
      000688 00                    1684 	.db #0x00	;  0
      000689 00                    1685 	.db #0x00	;  0
      00068A 00                    1686 	.db #0x00	;  0
      00068B 00                    1687 	.db #0x00	;  0
      00068C 00                    1688 	.db #0x00	;  0
      00068D 00                    1689 	.db #0x00	;  0
      00068E 00                    1690 	.db #0x00	;  0
      00068F 00                    1691 	.db #0x00	;  0
      000690 00                    1692 	.db #0x00	;  0
      000691 00                    1693 	.db #0x00	;  0
      000692 00                    1694 	.db #0x00	;  0
      000693 00                    1695 	.db #0x00	;  0
      000694 00                    1696 	.db #0x00	;  0
      000695 00                    1697 	.db #0x00	;  0
      000696 00                    1698 	.db #0x00	;  0
      000697 00                    1699 	.db #0x00	;  0
      000698 00                    1700 	.db #0x00	;  0
      000699 00                    1701 	.db #0x00	;  0
      00069A 00                    1702 	.db #0x00	;  0
      00069B 02                    1703 	.db #0x02	;  2
      00069C 01                    1704 	.db #0x01	;  1
      00069D 08                    1705 	.db #0x08	;  8
      00069E 00                    1706 	.db #0x00	;  0
      00069F FC                    1707 	.db #0xfc	; -4
      0006A0 FC                    1708 	.db #0xfc	; -4
      0006A1 00                    1709 	.db #0x00	;  0
      0006A2 03                    1710 	.db #0x03	;  3
      0006A3 FF                    1711 	.db #0xff	; -1
      0006A4 00                    1712 	.db #0x00	;  0
      0006A5 03                    1713 	.db #0x03	;  3
      0006A6 02                    1714 	.db #0x02	;  2
      0006A7 00                    1715 	.db #0x00	;  0
      0006A8 F9                    1716 	.db #0xf9	; -7
      0006A9 00                    1717 	.db #0x00	;  0
      0006AA 00                    1718 	.db #0x00	;  0
      0006AB 00                    1719 	.db #0x00	;  0
      0006AC 00                    1720 	.db #0x00	;  0
      0006AD FF                    1721 	.db #0xff	; -1
      0006AE 00                    1722 	.db #0x00	;  0
      0006AF FD                    1723 	.db #0xfd	; -3
      0006B0 FE                    1724 	.db #0xfe	; -2
      0006B1 06                    1725 	.db #0x06	;  6
      0006B2 02                    1726 	.db #0x02	;  2
      0006B3 00                    1727 	.db #0x00	;  0
      0006B4 FB                    1728 	.db #0xfb	; -5
      0006B5 FF                    1729 	.db #0xff	; -1
      0006B6 00                    1730 	.db #0x00	;  0
      0006B7 FE                    1731 	.db #0xfe	; -2
      0006B8 00                    1732 	.db #0x00	;  0
      0006B9 0E                    1733 	.db #0x0e	;  14
      0006BA FE                    1734 	.db #0xfe	; -2
      0006BB 0C                    1735 	.db #0x0c	;  12
      0006BC FB                    1736 	.db #0xfb	; -5
      0006BD 02                    1737 	.db #0x02	;  2
      0006BE FF                    1738 	.db #0xff	; -1
      0006BF 02                    1739 	.db #0x02	;  2
      0006C0 05                    1740 	.db #0x05	;  5
      0006C1 00                    1741 	.db #0x00	;  0
      0006C2 00                    1742 	.db #0x00	;  0
      0006C3 F7                    1743 	.db #0xf7	; -9
      0006C4 02                    1744 	.db #0x02	;  2
      0006C5 01                    1745 	.db #0x01	;  1
      0006C6 FF                    1746 	.db #0xff	; -1
      0006C7 00                    1747 	.db #0x00	;  0
      0006C8 EB                    1748 	.db #0xeb	; -21
      0006C9 00                    1749 	.db #0x00	;  0
      0006CA 05                    1750 	.db #0x05	;  5
      0006CB FE                    1751 	.db #0xfe	; -2
      0006CC 00                    1752 	.db #0x00	;  0
      0006CD F7                    1753 	.db #0xf7	; -9
      0006CE 00                    1754 	.db #0x00	;  0
      0006CF 06                    1755 	.db #0x06	;  6
      0006D0 FD                    1756 	.db #0xfd	; -3
      0006D1 0F                    1757 	.db #0x0f	;  15
      0006D2 FD                    1758 	.db #0xfd	; -3
      0006D3 00                    1759 	.db #0x00	;  0
      0006D4 F8                    1760 	.db #0xf8	; -8
      0006D5 02                    1761 	.db #0x02	;  2
      0006D6 F9                    1762 	.db #0xf9	; -7
      0006D7 0A                    1763 	.db #0x0a	;  10
      0006D8 FD                    1764 	.db #0xfd	; -3
      0006D9 22                    1765 	.db #0x22	;  34
      0006DA FE                    1766 	.db #0xfe	; -2
      0006DB 17                    1767 	.db #0x17	;  23
      0006DC FF                    1768 	.db #0xff	; -1
      0006DD 05                    1769 	.db #0x05	;  5
      0006DE FF                    1770 	.db #0xff	; -1
      0006DF 06                    1771 	.db #0x06	;  6
      0006E0 07                    1772 	.db #0x07	;  7
      0006E1 00                    1773 	.db #0x00	;  0
      0006E2 FD                    1774 	.db #0xfd	; -3
      0006E3 F5                    1775 	.db #0xf5	; -11
      0006E4 08                    1776 	.db #0x08	;  8
      0006E5 13                    1777 	.db #0x13	;  19
      0006E6 F6                    1778 	.db #0xf6	; -10
      0006E7 00                    1779 	.db #0x00	;  0
      0006E8 FC                    1780 	.db #0xfc	; -4
      0006E9 F5                    1781 	.db #0xf5	; -11
      0006EA 05                    1782 	.db #0x05	;  5
      0006EB F9                    1783 	.db #0xf9	; -7
      0006EC F8                    1784 	.db #0xf8	; -8
      0006ED FA                    1785 	.db #0xfa	; -6
      0006EE 00                    1786 	.db #0x00	;  0
      0006EF 06                    1787 	.db #0x06	;  6
      0006F0 F8                    1788 	.db #0xf8	; -8
      0006F1 05                    1789 	.db #0x05	;  5
      0006F2 EE                    1790 	.db #0xee	; -18
      0006F3 00                    1791 	.db #0x00	;  0
      0006F4 02                    1792 	.db #0x02	;  2
      0006F5 0B                    1793 	.db #0x0b	;  11
      0006F6 E6                    1794 	.db #0xe6	; -26
      0006F7 18                    1795 	.db #0x18	;  24
      0006F8 EB                    1796 	.db #0xeb	; -21
      0006F9 11                    1797 	.db #0x11	;  17
      0006FA F5                    1798 	.db #0xf5	; -11
      0006FB 04                    1799 	.db #0x04	;  4
      0006FC FC                    1800 	.db #0xfc	; -4
      0006FD 09                    1801 	.db #0x09	;  9
      0006FE 0B                    1802 	.db #0x0b	;  11
      0006FF 0A                    1803 	.db #0x0a	;  10
      000700 FF                    1804 	.db #0xff	; -1
      000701 00                    1805 	.db #0x00	;  0
      000702 F9                    1806 	.db #0xf9	; -7
      000703 E9                    1807 	.db #0xe9	; -23
      000704 05                    1808 	.db #0x05	;  5
      000705 02                    1809 	.db #0x02	;  2
      000706 06                    1810 	.db #0x06	;  6
      000707 00                    1811 	.db #0x00	;  0
      000708 EF                    1812 	.db #0xef	; -17
      000709 F8                    1813 	.db #0xf8	; -8
      00070A F4                    1814 	.db #0xf4	; -12
      00070B 03                    1815 	.db #0x03	;  3
      00070C F9                    1816 	.db #0xf9	; -7
      00070D E8                    1817 	.db #0xe8	; -24
      00070E 05                    1818 	.db #0x05	;  5
      00070F 04                    1819 	.db #0x04	;  4
      000710 F0                    1820 	.db #0xf0	; -16
      000711 F0                    1821 	.db #0xf0	; -16
      000712 F9                    1822 	.db #0xf9	; -7
      000713 00                    1823 	.db #0x00	;  0
      000714 FA                    1824 	.db #0xfa	; -6
      000715 FC                    1825 	.db #0xfc	; -4
      000716 FA                    1826 	.db #0xfa	; -6
      000717 23                    1827 	.db #0x23	;  35
      000718 ED                    1828 	.db #0xed	; -19
      000719 16                    1829 	.db #0x16	;  22
      00071A FD                    1830 	.db #0xfd	; -3
      00071B F6                    1831 	.db #0xf6	; -10
      00071C 08                    1832 	.db #0x08	;  8
      00071D FE                    1833 	.db #0xfe	; -2
      00071E 04                    1834 	.db #0x04	;  4
      00071F 0B                    1835 	.db #0x0b	;  11
      000720 FE                    1836 	.db #0xfe	; -2
      000721 00                    1837 	.db #0x00	;  0
      000722 FE                    1838 	.db #0xfe	; -2
      000723 FA                    1839 	.db #0xfa	; -6
      000724 EC                    1840 	.db #0xec	; -20
      000725 11                    1841 	.db #0x11	;  17
      000726 FC                    1842 	.db #0xfc	; -4
      000727 00                    1843 	.db #0x00	;  0
      000728 F2                    1844 	.db #0xf2	; -14
      000729 F5                    1845 	.db #0xf5	; -11
      00072A 00                    1846 	.db #0x00	;  0
      00072B FB                    1847 	.db #0xfb	; -5
      00072C 07                    1848 	.db #0x07	;  7
      00072D FA                    1849 	.db #0xfa	; -6
      00072E F9                    1850 	.db #0xf9	; -7
      00072F F2                    1851 	.db #0xf2	; -14
      000730 F9                    1852 	.db #0xf9	; -7
      000731 D5                    1853 	.db #0xd5	; -43
      000732 1D                    1854 	.db #0x1d	;  29
      000733 00                    1855 	.db #0x00	;  0
      000734 02                    1856 	.db #0x02	;  2
      000735 EE                    1857 	.db #0xee	; -18
      000736 FD                    1858 	.db #0xfd	; -3
      000737 18                    1859 	.db #0x18	;  24
      000738 F0                    1860 	.db #0xf0	; -16
      000739 25                    1861 	.db #0x25	;  37
      00073A FD                    1862 	.db #0xfd	; -3
      00073B F0                    1863 	.db #0xf0	; -16
      00073C 06                    1864 	.db #0x06	;  6
      00073D F7                    1865 	.db #0xf7	; -9
      00073E E6                    1866 	.db #0xe6	; -26
      00073F 09                    1867 	.db #0x09	;  9
      000740 00                    1868 	.db #0x00	;  0
      000741 00                    1869 	.db #0x00	;  0
      000742 07                    1870 	.db #0x07	;  7
      000743 FF                    1871 	.db #0xff	; -1
      000744 F7                    1872 	.db #0xf7	; -9
      000745 08                    1873 	.db #0x08	;  8
      000746 00                    1874 	.db #0x00	;  0
      000747 00                    1875 	.db #0x00	;  0
      000748 F8                    1876 	.db #0xf8	; -8
      000749 FD                    1877 	.db #0xfd	; -3
      00074A FB                    1878 	.db #0xfb	; -5
      00074B 03                    1879 	.db #0x03	;  3
      00074C 04                    1880 	.db #0x04	;  4
      00074D 0D                    1881 	.db #0x0d	;  13
      00074E FE                    1882 	.db #0xfe	; -2
      00074F F4                    1883 	.db #0xf4	; -12
      000750 F8                    1884 	.db #0xf8	; -8
      000751 E3                    1885 	.db #0xe3	; -29
      000752 12                    1886 	.db #0x12	;  18
      000753 00                    1887 	.db #0x00	;  0
      000754 F5                    1888 	.db #0xf5	; -11
      000755 FB                    1889 	.db #0xfb	; -5
      000756 10                    1890 	.db #0x10	;  16
      000757 17                    1891 	.db #0x17	;  23
      000758 F3                    1892 	.db #0xf3	; -13
      000759 0E                    1893 	.db #0x0e	;  14
      00075A FF                    1894 	.db #0xff	; -1
      00075B FB                    1895 	.db #0xfb	; -5
      00075C FF                    1896 	.db #0xff	; -1
      00075D EF                    1897 	.db #0xef	; -17
      00075E ED                    1898 	.db #0xed	; -19
      00075F DD                    1899 	.db #0xdd	; -35
      000760 01                    1900 	.db #0x01	;  1
      000761 00                    1901 	.db #0x00	;  0
      000762 FF                    1902 	.db #0xff	; -1
      000763 03                    1903 	.db #0x03	;  3
      000764 03                    1904 	.db #0x03	;  3
      000765 08                    1905 	.db #0x08	;  8
      000766 F5                    1906 	.db #0xf5	; -11
      000767 00                    1907 	.db #0x00	;  0
      000768 F8                    1908 	.db #0xf8	; -8
      000769 07                    1909 	.db #0x07	;  7
      00076A FA                    1910 	.db #0xfa	; -6
      00076B FC                    1911 	.db #0xfc	; -4
      00076C 19                    1912 	.db #0x19	;  25
      00076D 01                    1913 	.db #0x01	;  1
      00076E FE                    1914 	.db #0xfe	; -2
      00076F F5                    1915 	.db #0xf5	; -11
      000770 04                    1916 	.db #0x04	;  4
      000771 01                    1917 	.db #0x01	;  1
      000772 0D                    1918 	.db #0x0d	;  13
      000773 00                    1919 	.db #0x00	;  0
      000774 01                    1920 	.db #0x01	;  1
      000775 F3                    1921 	.db #0xf3	; -13
      000776 0E                    1922 	.db #0x0e	;  14
      000777 0B                    1923 	.db #0x0b	;  11
      000778 F6                    1924 	.db #0xf6	; -10
      000779 22                    1925 	.db #0x22	;  34
      00077A FA                    1926 	.db #0xfa	; -6
      00077B FC                    1927 	.db #0xfc	; -4
      00077C FD                    1928 	.db #0xfd	; -3
      00077D 02                    1929 	.db #0x02	;  2
      00077E FD                    1930 	.db #0xfd	; -3
      00077F E7                    1931 	.db #0xe7	; -25
      000780 F6                    1932 	.db #0xf6	; -10
      000781 00                    1933 	.db #0x00	;  0
      000782 F9                    1934 	.db #0xf9	; -7
      000783 FB                    1935 	.db #0xfb	; -5
      000784 06                    1936 	.db #0x06	;  6
      000785 FF                    1937 	.db #0xff	; -1
      000786 F9                    1938 	.db #0xf9	; -7
      000787 00                    1939 	.db #0x00	;  0
      000788 0A                    1940 	.db #0x0a	;  10
      000789 08                    1941 	.db #0x08	;  8
      00078A F8                    1942 	.db #0xf8	; -8
      00078B 00                    1943 	.db #0x00	;  0
      00078C 06                    1944 	.db #0x06	;  6
      00078D F6                    1945 	.db #0xf6	; -10
      00078E 02                    1946 	.db #0x02	;  2
      00078F 01                    1947 	.db #0x01	;  1
      000790 00                    1948 	.db #0x00	;  0
      000791 1D                    1949 	.db #0x1d	;  29
      000792 05                    1950 	.db #0x05	;  5
      000793 00                    1951 	.db #0x00	;  0
      000794 09                    1952 	.db #0x09	;  9
      000795 01                    1953 	.db #0x01	;  1
      000796 0C                    1954 	.db #0x0c	;  12
      000797 FA                    1955 	.db #0xfa	; -6
      000798 F8                    1956 	.db #0xf8	; -8
      000799 14                    1957 	.db #0x14	;  20
      00079A 08                    1958 	.db #0x08	;  8
      00079B 00                    1959 	.db #0x00	;  0
      00079C 01                    1960 	.db #0x01	;  1
      00079D FF                    1961 	.db #0xff	; -1
      00079E 05                    1962 	.db #0x05	;  5
      00079F 01                    1963 	.db #0x01	;  1
      0007A0 FC                    1964 	.db #0xfc	; -4
      0007A1 00                    1965 	.db #0x00	;  0
      0007A2 FF                    1966 	.db #0xff	; -1
      0007A3 F8                    1967 	.db #0xf8	; -8
      0007A4 FE                    1968 	.db #0xfe	; -2
      0007A5 01                    1969 	.db #0x01	;  1
      0007A6 FE                    1970 	.db #0xfe	; -2
      0007A7 00                    1971 	.db #0x00	;  0
      0007A8 FF                    1972 	.db #0xff	; -1
      0007A9 07                    1973 	.db #0x07	;  7
      0007AA FE                    1974 	.db #0xfe	; -2
      0007AB FE                    1975 	.db #0xfe	; -2
      0007AC 00                    1976 	.db #0x00	;  0
      0007AD 00                    1977 	.db #0x00	;  0
      0007AE 02                    1978 	.db #0x02	;  2
      0007AF FB                    1979 	.db #0xfb	; -5
      0007B0 00                    1980 	.db #0x00	;  0
      0007B1 0C                    1981 	.db #0x0c	;  12
      0007B2 08                    1982 	.db #0x08	;  8
      0007B3 00                    1983 	.db #0x00	;  0
      0007B4 01                    1984 	.db #0x01	;  1
      0007B5 FC                    1985 	.db #0xfc	; -4
      0007B6 07                    1986 	.db #0x07	;  7
      0007B7 FD                    1987 	.db #0xfd	; -3
      0007B8 F6                    1988 	.db #0xf6	; -10
      0007B9 09                    1989 	.db #0x09	;  9
      0007BA 06                    1990 	.db #0x06	;  6
      0007BB 00                    1991 	.db #0x00	;  0
      0007BC 00                    1992 	.db #0x00	;  0
      0007BD 00                    1993 	.db #0x00	;  0
      0007BE 02                    1994 	.db #0x02	;  2
      0007BF 01                    1995 	.db #0x01	;  1
      0007C0 00                    1996 	.db #0x00	;  0
      0007C1 00                    1997 	.db #0x00	;  0
      0007C2 00                    1998 	.db #0x00	;  0
      0007C3 00                    1999 	.db #0x00	;  0
      0007C4 FF                    2000 	.db #0xff	; -1
      0007C5 00                    2001 	.db #0x00	;  0
      0007C6 00                    2002 	.db #0x00	;  0
      0007C7 00                    2003 	.db #0x00	;  0
      0007C8 00                    2004 	.db #0x00	;  0
      0007C9 02                    2005 	.db #0x02	;  2
      0007CA 00                    2006 	.db #0x00	;  0
      0007CB 00                    2007 	.db #0x00	;  0
      0007CC FF                    2008 	.db #0xff	; -1
      0007CD 00                    2009 	.db #0x00	;  0
      0007CE 01                    2010 	.db #0x01	;  1
      0007CF 00                    2011 	.db #0x00	;  0
      0007D0 00                    2012 	.db #0x00	;  0
      0007D1 03                    2013 	.db #0x03	;  3
      0007D2 02                    2014 	.db #0x02	;  2
      0007D3 00                    2015 	.db #0x00	;  0
      0007D4 00                    2016 	.db #0x00	;  0
      0007D5 00                    2017 	.db #0x00	;  0
      0007D6 01                    2018 	.db #0x01	;  1
      0007D7 00                    2019 	.db #0x00	;  0
      0007D8 FD                    2020 	.db #0xfd	; -3
      0007D9 00                    2021 	.db #0x00	;  0
      0007DA 01                    2022 	.db #0x01	;  1
      0007DB 00                    2023 	.db #0x00	;  0
      0007DC 00                    2024 	.db #0x00	;  0
      0007DD 00                    2025 	.db #0x00	;  0
      0007DE 00                    2026 	.db #0x00	;  0
      0007DF 00                    2027 	.db #0x00	;  0
      0007E0 00                    2028 	.db #0x00	;  0
      0007E1 00                    2029 	.db #0x00	;  0
      0007E2 00                    2030 	.db #0x00	;  0
      0007E3 00                    2031 	.db #0x00	;  0
      0007E4 00                    2032 	.db #0x00	;  0
      0007E5 00                    2033 	.db #0x00	;  0
      0007E6 00                    2034 	.db #0x00	;  0
      0007E7 00                    2035 	.db #0x00	;  0
      0007E8 00                    2036 	.db #0x00	;  0
      0007E9 00                    2037 	.db #0x00	;  0
      0007EA 00                    2038 	.db #0x00	;  0
      0007EB 00                    2039 	.db #0x00	;  0
      0007EC 00                    2040 	.db #0x00	;  0
      0007ED 00                    2041 	.db #0x00	;  0
      0007EE 00                    2042 	.db #0x00	;  0
      0007EF 00                    2043 	.db #0x00	;  0
      0007F0 00                    2044 	.db #0x00	;  0
      0007F1 00                    2045 	.db #0x00	;  0
      0007F2 00                    2046 	.db #0x00	;  0
      0007F3 00                    2047 	.db #0x00	;  0
      0007F4 00                    2048 	.db #0x00	;  0
      0007F5 00                    2049 	.db #0x00	;  0
      0007F6 00                    2050 	.db #0x00	;  0
      0007F7 00                    2051 	.db #0x00	;  0
      0007F8 00                    2052 	.db #0x00	;  0
      0007F9 00                    2053 	.db #0x00	;  0
      0007FA 00                    2054 	.db #0x00	;  0
      0007FB 00                    2055 	.db #0x00	;  0
      0007FC 00                    2056 	.db #0x00	;  0
      0007FD 00                    2057 	.db #0x00	;  0
      0007FE 00                    2058 	.db #0x00	;  0
      0007FF 00                    2059 	.db #0x00	;  0
      000800 00                    2060 	.db #0x00	;  0
      000801 00                    2061 	.db #0x00	;  0
      000802 00                    2062 	.db #0x00	;  0
      000803 00                    2063 	.db #0x00	;  0
      000804 00                    2064 	.db #0x00	;  0
      000805 00                    2065 	.db #0x00	;  0
      000806 00                    2066 	.db #0x00	;  0
      000807 00                    2067 	.db #0x00	;  0
      000808 00                    2068 	.db #0x00	;  0
      000809 00                    2069 	.db #0x00	;  0
      00080A 00                    2070 	.db #0x00	;  0
      00080B 00                    2071 	.db #0x00	;  0
      00080C 00                    2072 	.db #0x00	;  0
      00080D 00                    2073 	.db #0x00	;  0
      00080E 00                    2074 	.db #0x00	;  0
      00080F 00                    2075 	.db #0x00	;  0
      000810 00                    2076 	.db #0x00	;  0
      000811 00                    2077 	.db #0x00	;  0
      000812 00                    2078 	.db #0x00	;  0
      000813 00                    2079 	.db #0x00	;  0
      000814 00                    2080 	.db #0x00	;  0
      000815 00                    2081 	.db #0x00	;  0
      000816 00                    2082 	.db #0x00	;  0
      000817 00                    2083 	.db #0x00	;  0
      000818 00                    2084 	.db #0x00	;  0
      000819 00                    2085 	.db #0x00	;  0
      00081A 00                    2086 	.db #0x00	;  0
      00081B 00                    2087 	.db #0x00	;  0
      00081C 00                    2088 	.db #0x00	;  0
      00081D 00                    2089 	.db #0x00	;  0
      00081E 00                    2090 	.db #0x00	;  0
      00081F 00                    2091 	.db #0x00	;  0
      000820 00                    2092 	.db #0x00	;  0
      000821 00                    2093 	.db #0x00	;  0
      000822 00                    2094 	.db #0x00	;  0
      000823 00                    2095 	.db #0x00	;  0
      000824 00                    2096 	.db #0x00	;  0
      000825 00                    2097 	.db #0x00	;  0
      000826 00                    2098 	.db #0x00	;  0
      000827 00                    2099 	.db #0x00	;  0
      000828 00                    2100 	.db #0x00	;  0
      000829 00                    2101 	.db #0x00	;  0
      00082A 00                    2102 	.db #0x00	;  0
      00082B 00                    2103 	.db #0x00	;  0
      00082C 00                    2104 	.db #0x00	;  0
      00082D 00                    2105 	.db #0x00	;  0
      00082E 00                    2106 	.db #0x00	;  0
      00082F 00                    2107 	.db #0x00	;  0
      000830 00                    2108 	.db #0x00	;  0
      000831 00                    2109 	.db #0x00	;  0
      000832 00                    2110 	.db #0x00	;  0
      000833 00                    2111 	.db #0x00	;  0
      000834 00                    2112 	.db #0x00	;  0
      000835 00                    2113 	.db #0x00	;  0
      000836 00                    2114 	.db #0x00	;  0
      000837 00                    2115 	.db #0x00	;  0
      000838 00                    2116 	.db #0x00	;  0
      000839 00                    2117 	.db #0x00	;  0
      00083A 00                    2118 	.db #0x00	;  0
      00083B 04                    2119 	.db #0x04	;  4
      00083C FD                    2120 	.db #0xfd	; -3
      00083D 04                    2121 	.db #0x04	;  4
      00083E 03                    2122 	.db #0x03	;  3
      00083F 07                    2123 	.db #0x07	;  7
      000840 F8                    2124 	.db #0xf8	; -8
      000841 00                    2125 	.db #0x00	;  0
      000842 07                    2126 	.db #0x07	;  7
      000843 02                    2127 	.db #0x02	;  2
      000844 02                    2128 	.db #0x02	;  2
      000845 09                    2129 	.db #0x09	;  9
      000846 04                    2130 	.db #0x04	;  4
      000847 00                    2131 	.db #0x00	;  0
      000848 04                    2132 	.db #0x04	;  4
      000849 FF                    2133 	.db #0xff	; -1
      00084A FC                    2134 	.db #0xfc	; -4
      00084B 01                    2135 	.db #0x01	;  1
      00084C 00                    2136 	.db #0x00	;  0
      00084D 00                    2137 	.db #0x00	;  0
      00084E FB                    2138 	.db #0xfb	; -5
      00084F 0A                    2139 	.db #0x0a	;  10
      000850 FC                    2140 	.db #0xfc	; -4
      000851 03                    2141 	.db #0x03	;  3
      000852 01                    2142 	.db #0x01	;  1
      000853 00                    2143 	.db #0x00	;  0
      000854 FB                    2144 	.db #0xfb	; -5
      000855 FD                    2145 	.db #0xfd	; -3
      000856 03                    2146 	.db #0x03	;  3
      000857 02                    2147 	.db #0x02	;  2
      000858 00                    2148 	.db #0x00	;  0
      000859 FB                    2149 	.db #0xfb	; -5
      00085A F9                    2150 	.db #0xf9	; -7
      00085B 00                    2151 	.db #0x00	;  0
      00085C F8                    2152 	.db #0xf8	; -8
      00085D 02                    2153 	.db #0x02	;  2
      00085E 11                    2154 	.db #0x11	;  17
      00085F 03                    2155 	.db #0x03	;  3
      000860 05                    2156 	.db #0x05	;  5
      000861 00                    2157 	.db #0x00	;  0
      000862 0B                    2158 	.db #0x0b	;  11
      000863 F8                    2159 	.db #0xf8	; -8
      000864 0B                    2160 	.db #0x0b	;  11
      000865 0B                    2161 	.db #0x0b	;  11
      000866 FE                    2162 	.db #0xfe	; -2
      000867 00                    2163 	.db #0x00	;  0
      000868 08                    2164 	.db #0x08	;  8
      000869 FE                    2165 	.db #0xfe	; -2
      00086A 08                    2166 	.db #0x08	;  8
      00086B FD                    2167 	.db #0xfd	; -3
      00086C F8                    2168 	.db #0xf8	; -8
      00086D 01                    2169 	.db #0x01	;  1
      00086E F3                    2170 	.db #0xf3	; -13
      00086F 1B                    2171 	.db #0x1b	;  27
      000870 FD                    2172 	.db #0xfd	; -3
      000871 07                    2173 	.db #0x07	;  7
      000872 F9                    2174 	.db #0xf9	; -7
      000873 00                    2175 	.db #0x00	;  0
      000874 E9                    2176 	.db #0xe9	; -23
      000875 0B                    2177 	.db #0x0b	;  11
      000876 E7                    2178 	.db #0xe7	; -25
      000877 F8                    2179 	.db #0xf8	; -8
      000878 FA                    2180 	.db #0xfa	; -6
      000879 0F                    2181 	.db #0x0f	;  15
      00087A EA                    2182 	.db #0xea	; -22
      00087B 01                    2183 	.db #0x01	;  1
      00087C FB                    2184 	.db #0xfb	; -5
      00087D 00                    2185 	.db #0x00	;  0
      00087E 03                    2186 	.db #0x03	;  3
      00087F FE                    2187 	.db #0xfe	; -2
      000880 F3                    2188 	.db #0xf3	; -13
      000881 00                    2189 	.db #0x00	;  0
      000882 03                    2190 	.db #0x03	;  3
      000883 E6                    2191 	.db #0xe6	; -26
      000884 1B                    2192 	.db #0x1b	;  27
      000885 1C                    2193 	.db #0x1c	;  28
      000886 E8                    2194 	.db #0xe8	; -24
      000887 00                    2195 	.db #0x00	;  0
      000888 07                    2196 	.db #0x07	;  7
      000889 08                    2197 	.db #0x08	;  8
      00088A 0B                    2198 	.db #0x0b	;  11
      00088B E1                    2199 	.db #0xe1	; -31
      00088C F7                    2200 	.db #0xf7	; -9
      00088D F7                    2201 	.db #0xf7	; -9
      00088E EE                    2202 	.db #0xee	; -18
      00088F 04                    2203 	.db #0x04	;  4
      000890 FA                    2204 	.db #0xfa	; -6
      000891 1B                    2205 	.db #0x1b	;  27
      000892 EC                    2206 	.db #0xec	; -20
      000893 00                    2207 	.db #0x00	;  0
      000894 09                    2208 	.db #0x09	;  9
      000895 0A                    2209 	.db #0x0a	;  10
      000896 F5                    2210 	.db #0xf5	; -11
      000897 10                    2211 	.db #0x10	;  16
      000898 F2                    2212 	.db #0xf2	; -14
      000899 0E                    2213 	.db #0x0e	;  14
      00089A F2                    2214 	.db #0xf2	; -14
      00089B 13                    2215 	.db #0x13	;  19
      00089C 03                    2216 	.db #0x03	;  3
      00089D 20                    2217 	.db #0x20	;  32
      00089E 14                    2218 	.db #0x14	;  20
      00089F F5                    2219 	.db #0xf5	; -11
      0008A0 EB                    2220 	.db #0xeb	; -21
      0008A1 00                    2221 	.db #0x00	;  0
      0008A2 02                    2222 	.db #0x02	;  2
      0008A3 EE                    2223 	.db #0xee	; -18
      0008A4 EC                    2224 	.db #0xec	; -20
      0008A5 0D                    2225 	.db #0x0d	;  13
      0008A6 E9                    2226 	.db #0xe9	; -23
      0008A7 00                    2227 	.db #0x00	;  0
      0008A8 0F                    2228 	.db #0x0f	;  15
      0008A9 E7                    2229 	.db #0xe7	; -25
      0008AA 0B                    2230 	.db #0x0b	;  11
      0008AB DD                    2231 	.db #0xdd	; -35
      0008AC E9                    2232 	.db #0xe9	; -23
      0008AD EC                    2233 	.db #0xec	; -20
      0008AE 08                    2234 	.db #0x08	;  8
      0008AF 12                    2235 	.db #0x12	;  18
      0008B0 F4                    2236 	.db #0xf4	; -12
      0008B1 E1                    2237 	.db #0xe1	; -31
      0008B2 D9                    2238 	.db #0xd9	; -39
      0008B3 00                    2239 	.db #0x00	;  0
      0008B4 1C                    2240 	.db #0x1c	;  28
      0008B5 03                    2241 	.db #0x03	;  3
      0008B6 F6                    2242 	.db #0xf6	; -10
      0008B7 29                    2243 	.db #0x29	;  41
      0008B8 ED                    2244 	.db #0xed	; -19
      0008B9 1F                    2245 	.db #0x1f	;  31
      0008BA DF                    2246 	.db #0xdf	; -33
      0008BB FB                    2247 	.db #0xfb	; -5
      0008BC F5                    2248 	.db #0xf5	; -11
      0008BD 12                    2249 	.db #0x12	;  18
      0008BE 04                    2250 	.db #0x04	;  4
      0008BF 01                    2251 	.db #0x01	;  1
      0008C0 14                    2252 	.db #0x14	;  20
      0008C1 00                    2253 	.db #0x00	;  0
      0008C2 04                    2254 	.db #0x04	;  4
      0008C3 E6                    2255 	.db #0xe6	; -26
      0008C4 F8                    2256 	.db #0xf8	; -8
      0008C5 12                    2257 	.db #0x12	;  18
      0008C6 0B                    2258 	.db #0x0b	;  11
      0008C7 00                    2259 	.db #0x00	;  0
      0008C8 F6                    2260 	.db #0xf6	; -10
      0008C9 D8                    2261 	.db #0xd8	; -40
      0008CA 02                    2262 	.db #0x02	;  2
      0008CB DE                    2263 	.db #0xde	; -34
      0008CC F0                    2264 	.db #0xf0	; -16
      0008CD 06                    2265 	.db #0x06	;  6
      0008CE 09                    2266 	.db #0x09	;  9
      0008CF 19                    2267 	.db #0x19	;  25
      0008D0 E9                    2268 	.db #0xe9	; -23
      0008D1 BA                    2269 	.db #0xba	; -70
      0008D2 03                    2270 	.db #0x03	;  3
      0008D3 00                    2271 	.db #0x00	;  0
      0008D4 11                    2272 	.db #0x11	;  17
      0008D5 F9                    2273 	.db #0xf9	; -7
      0008D6 06                    2274 	.db #0x06	;  6
      0008D7 21                    2275 	.db #0x21	;  33
      0008D8 F8                    2276 	.db #0xf8	; -8
      0008D9 05                    2277 	.db #0x05	;  5
      0008DA FA                    2278 	.db #0xfa	; -6
      0008DB FE                    2279 	.db #0xfe	; -2
      0008DC FE                    2280 	.db #0xfe	; -2
      0008DD 02                    2281 	.db #0x02	;  2
      0008DE AC                    2282 	.db #0xac	; -84
      0008DF 17                    2283 	.db #0x17	;  23
      0008E0 0C                    2284 	.db #0x0c	;  12
      0008E1 00                    2285 	.db #0x00	;  0
      0008E2 03                    2286 	.db #0x03	;  3
      0008E3 E0                    2287 	.db #0xe0	; -32
      0008E4 E7                    2288 	.db #0xe7	; -25
      0008E5 10                    2289 	.db #0x10	;  16
      0008E6 EA                    2290 	.db #0xea	; -22
      0008E7 00                    2291 	.db #0x00	;  0
      0008E8 E9                    2292 	.db #0xe9	; -23
      0008E9 F2                    2293 	.db #0xf2	; -14
      0008EA 09                    2294 	.db #0x09	;  9
      0008EB DE                    2295 	.db #0xde	; -34
      0008EC FA                    2296 	.db #0xfa	; -6
      0008ED FF                    2297 	.db #0xff	; -1
      0008EE 0C                    2298 	.db #0x0c	;  12
      0008EF 07                    2299 	.db #0x07	;  7
      0008F0 EC                    2300 	.db #0xec	; -20
      0008F1 C4                    2301 	.db #0xc4	; -60
      0008F2 20                    2302 	.db #0x20	;  32
      0008F3 00                    2303 	.db #0x00	;  0
      0008F4 F9                    2304 	.db #0xf9	; -7
      0008F5 FA                    2305 	.db #0xfa	; -6
      0008F6 FA                    2306 	.db #0xfa	; -6
      0008F7 11                    2307 	.db #0x11	;  17
      0008F8 01                    2308 	.db #0x01	;  1
      0008F9 0C                    2309 	.db #0x0c	;  12
      0008FA 05                    2310 	.db #0x05	;  5
      0008FB C4                    2311 	.db #0xc4	; -60
      0008FC 10                    2312 	.db #0x10	;  16
      0008FD 0E                    2313 	.db #0x0e	;  14
      0008FE C2                    2314 	.db #0xc2	; -62
      0008FF 16                    2315 	.db #0x16	;  22
      000900 0A                    2316 	.db #0x0a	;  10
      000901 00                    2317 	.db #0x00	;  0
      000902 F0                    2318 	.db #0xf0	; -16
      000903 E4                    2319 	.db #0xe4	; -28
      000904 F5                    2320 	.db #0xf5	; -11
      000905 0D                    2321 	.db #0x0d	;  13
      000906 E3                    2322 	.db #0xe3	; -29
      000907 00                    2323 	.db #0x00	;  0
      000908 FA                    2324 	.db #0xfa	; -6
      000909 02                    2325 	.db #0x02	;  2
      00090A F1                    2326 	.db #0xf1	; -15
      00090B E0                    2327 	.db #0xe0	; -32
      00090C 04                    2328 	.db #0x04	;  4
      00090D F9                    2329 	.db #0xf9	; -7
      00090E F8                    2330 	.db #0xf8	; -8
      00090F CC                    2331 	.db #0xcc	; -52
      000910 F9                    2332 	.db #0xf9	; -7
      000911 F6                    2333 	.db #0xf6	; -10
      000912 E4                    2334 	.db #0xe4	; -28
      000913 00                    2335 	.db #0x00	;  0
      000914 F5                    2336 	.db #0xf5	; -11
      000915 FA                    2337 	.db #0xfa	; -6
      000916 0A                    2338 	.db #0x0a	;  10
      000917 20                    2339 	.db #0x20	;  32
      000918 E5                    2340 	.db #0xe5	; -27
      000919 06                    2341 	.db #0x06	;  6
      00091A 10                    2342 	.db #0x10	;  16
      00091B E2                    2343 	.db #0xe2	; -30
      00091C 28                    2344 	.db #0x28	;  40
      00091D 04                    2345 	.db #0x04	;  4
      00091E F3                    2346 	.db #0xf3	; -13
      00091F FF                    2347 	.db #0xff	; -1
      000920 00                    2348 	.db #0x00	;  0
      000921 00                    2349 	.db #0x00	;  0
      000922 E8                    2350 	.db #0xe8	; -24
      000923 EB                    2351 	.db #0xeb	; -21
      000924 F9                    2352 	.db #0xf9	; -7
      000925 0F                    2353 	.db #0x0f	;  15
      000926 E7                    2354 	.db #0xe7	; -25
      000927 00                    2355 	.db #0x00	;  0
      000928 03                    2356 	.db #0x03	;  3
      000929 F6                    2357 	.db #0xf6	; -10
      00092A 0D                    2358 	.db #0x0d	;  13
      00092B ED                    2359 	.db #0xed	; -19
      00092C 10                    2360 	.db #0x10	;  16
      00092D 11                    2361 	.db #0x11	;  17
      00092E F4                    2362 	.db #0xf4	; -12
      00092F D4                    2363 	.db #0xd4	; -44
      000930 07                    2364 	.db #0x07	;  7
      000931 18                    2365 	.db #0x18	;  24
      000932 E9                    2366 	.db #0xe9	; -23
      000933 00                    2367 	.db #0x00	;  0
      000934 F6                    2368 	.db #0xf6	; -10
      000935 09                    2369 	.db #0x09	;  9
      000936 FE                    2370 	.db #0xfe	; -2
      000937 01                    2371 	.db #0x01	;  1
      000938 E3                    2372 	.db #0xe3	; -29
      000939 FD                    2373 	.db #0xfd	; -3
      00093A 1B                    2374 	.db #0x1b	;  27
      00093B EB                    2375 	.db #0xeb	; -21
      00093C FE                    2376 	.db #0xfe	; -2
      00093D FE                    2377 	.db #0xfe	; -2
      00093E 1F                    2378 	.db #0x1f	;  31
      00093F CD                    2379 	.db #0xcd	; -51
      000940 F9                    2380 	.db #0xf9	; -7
      000941 00                    2381 	.db #0x00	;  0
      000942 F0                    2382 	.db #0xf0	; -16
      000943 FE                    2383 	.db #0xfe	; -2
      000944 06                    2384 	.db #0x06	;  6
      000945 0B                    2385 	.db #0x0b	;  11
      000946 EA                    2386 	.db #0xea	; -22
      000947 00                    2387 	.db #0x00	;  0
      000948 F8                    2388 	.db #0xf8	; -8
      000949 FB                    2389 	.db #0xfb	; -5
      00094A 16                    2390 	.db #0x16	;  22
      00094B F4                    2391 	.db #0xf4	; -12
      00094C FD                    2392 	.db #0xfd	; -3
      00094D 0B                    2393 	.db #0x0b	;  11
      00094E 0E                    2394 	.db #0x0e	;  14
      00094F ED                    2395 	.db #0xed	; -19
      000950 F7                    2396 	.db #0xf7	; -9
      000951 02                    2397 	.db #0x02	;  2
      000952 FF                    2398 	.db #0xff	; -1
      000953 00                    2399 	.db #0x00	;  0
      000954 05                    2400 	.db #0x05	;  5
      000955 F8                    2401 	.db #0xf8	; -8
      000956 0F                    2402 	.db #0x0f	;  15
      000957 00                    2403 	.db #0x00	;  0
      000958 DA                    2404 	.db #0xda	; -38
      000959 F8                    2405 	.db #0xf8	; -8
      00095A 11                    2406 	.db #0x11	;  17
      00095B FB                    2407 	.db #0xfb	; -5
      00095C FA                    2408 	.db #0xfa	; -6
      00095D 08                    2409 	.db #0x08	;  8
      00095E 01                    2410 	.db #0x01	;  1
      00095F E0                    2411 	.db #0xe0	; -32
      000960 00                    2412 	.db #0x00	;  0
      000961 00                    2413 	.db #0x00	;  0
      000962 FB                    2414 	.db #0xfb	; -5
      000963 FF                    2415 	.db #0xff	; -1
      000964 04                    2416 	.db #0x04	;  4
      000965 0C                    2417 	.db #0x0c	;  12
      000966 F7                    2418 	.db #0xf7	; -9
      000967 00                    2419 	.db #0x00	;  0
      000968 05                    2420 	.db #0x05	;  5
      000969 FE                    2421 	.db #0xfe	; -2
      00096A 0D                    2422 	.db #0x0d	;  13
      00096B F7                    2423 	.db #0xf7	; -9
      00096C 10                    2424 	.db #0x10	;  16
      00096D F4                    2425 	.db #0xf4	; -12
      00096E F9                    2426 	.db #0xf9	; -7
      00096F F8                    2427 	.db #0xf8	; -8
      000970 01                    2428 	.db #0x01	;  1
      000971 01                    2429 	.db #0x01	;  1
      000972 16                    2430 	.db #0x16	;  22
      000973 00                    2431 	.db #0x00	;  0
      000974 FF                    2432 	.db #0xff	; -1
      000975 F8                    2433 	.db #0xf8	; -8
      000976 10                    2434 	.db #0x10	;  16
      000977 F0                    2435 	.db #0xf0	; -16
      000978 F9                    2436 	.db #0xf9	; -7
      000979 F6                    2437 	.db #0xf6	; -10
      00097A 0D                    2438 	.db #0x0d	;  13
      00097B 00                    2439 	.db #0x00	;  0
      00097C EE                    2440 	.db #0xee	; -18
      00097D 0B                    2441 	.db #0x0b	;  11
      00097E 03                    2442 	.db #0x03	;  3
      00097F F9                    2443 	.db #0xf9	; -7
      000980 F3                    2444 	.db #0xf3	; -13
      000981 00                    2445 	.db #0x00	;  0
      000982 FF                    2446 	.db #0xff	; -1
      000983 02                    2447 	.db #0x02	;  2
      000984 03                    2448 	.db #0x03	;  3
      000985 0D                    2449 	.db #0x0d	;  13
      000986 03                    2450 	.db #0x03	;  3
      000987 00                    2451 	.db #0x00	;  0
      000988 12                    2452 	.db #0x12	;  18
      000989 F4                    2453 	.db #0xf4	; -12
      00098A 06                    2454 	.db #0x06	;  6
      00098B F3                    2455 	.db #0xf3	; -13
      00098C FC                    2456 	.db #0xfc	; -4
      00098D 01                    2457 	.db #0x01	;  1
      00098E F1                    2458 	.db #0xf1	; -15
      00098F FA                    2459 	.db #0xfa	; -6
      000990 00                    2460 	.db #0x00	;  0
      000991 03                    2461 	.db #0x03	;  3
      000992 02                    2462 	.db #0x02	;  2
      000993 00                    2463 	.db #0x00	;  0
      000994 07                    2464 	.db #0x07	;  7
      000995 0A                    2465 	.db #0x0a	;  10
      000996 F9                    2466 	.db #0xf9	; -7
      000997 EE                    2467 	.db #0xee	; -18
      000998 F8                    2468 	.db #0xf8	; -8
      000999 F5                    2469 	.db #0xf5	; -11
      00099A 0C                    2470 	.db #0x0c	;  12
      00099B 00                    2471 	.db #0x00	;  0
      00099C 00                    2472 	.db #0x00	;  0
      00099D 03                    2473 	.db #0x03	;  3
      00099E 03                    2474 	.db #0x03	;  3
      00099F 00                    2475 	.db #0x00	;  0
      0009A0 FC                    2476 	.db #0xfc	; -4
      0009A1 00                    2477 	.db #0x00	;  0
      0009A2 00                    2478 	.db #0x00	;  0
      0009A3 00                    2479 	.db #0x00	;  0
      0009A4 FD                    2480 	.db #0xfd	; -3
      0009A5 00                    2481 	.db #0x00	;  0
      0009A6 00                    2482 	.db #0x00	;  0
      0009A7 00                    2483 	.db #0x00	;  0
      0009A8 FD                    2484 	.db #0xfd	; -3
      0009A9 00                    2485 	.db #0x00	;  0
      0009AA 00                    2486 	.db #0x00	;  0
      0009AB FE                    2487 	.db #0xfe	; -2
      0009AC 03                    2488 	.db #0x03	;  3
      0009AD FD                    2489 	.db #0xfd	; -3
      0009AE 02                    2490 	.db #0x02	;  2
      0009AF 00                    2491 	.db #0x00	;  0
      0009B0 00                    2492 	.db #0x00	;  0
      0009B1 04                    2493 	.db #0x04	;  4
      0009B2 03                    2494 	.db #0x03	;  3
      0009B3 00                    2495 	.db #0x00	;  0
      0009B4 00                    2496 	.db #0x00	;  0
      0009B5 03                    2497 	.db #0x03	;  3
      0009B6 00                    2498 	.db #0x00	;  0
      0009B7 FD                    2499 	.db #0xfd	; -3
      0009B8 FC                    2500 	.db #0xfc	; -4
      0009B9 00                    2501 	.db #0x00	;  0
      0009BA 02                    2502 	.db #0x02	;  2
      0009BB 00                    2503 	.db #0x00	;  0
      0009BC 00                    2504 	.db #0x00	;  0
      0009BD 00                    2505 	.db #0x00	;  0
      0009BE 00                    2506 	.db #0x00	;  0
      0009BF 00                    2507 	.db #0x00	;  0
      0009C0 00                    2508 	.db #0x00	;  0
      0009C1 00                    2509 	.db #0x00	;  0
      0009C2 00                    2510 	.db #0x00	;  0
      0009C3 00                    2511 	.db #0x00	;  0
      0009C4 00                    2512 	.db #0x00	;  0
      0009C5 00                    2513 	.db #0x00	;  0
      0009C6 00                    2514 	.db #0x00	;  0
      0009C7 00                    2515 	.db #0x00	;  0
      0009C8 00                    2516 	.db #0x00	;  0
      0009C9 00                    2517 	.db #0x00	;  0
      0009CA 00                    2518 	.db #0x00	;  0
      0009CB 00                    2519 	.db #0x00	;  0
      0009CC 00                    2520 	.db #0x00	;  0
      0009CD 00                    2521 	.db #0x00	;  0
      0009CE 00                    2522 	.db #0x00	;  0
      0009CF 00                    2523 	.db #0x00	;  0
      0009D0 00                    2524 	.db #0x00	;  0
      0009D1 00                    2525 	.db #0x00	;  0
      0009D2 00                    2526 	.db #0x00	;  0
      0009D3 00                    2527 	.db #0x00	;  0
      0009D4 00                    2528 	.db #0x00	;  0
      0009D5 00                    2529 	.db #0x00	;  0
      0009D6 00                    2530 	.db #0x00	;  0
      0009D7 00                    2531 	.db #0x00	;  0
      0009D8 00                    2532 	.db #0x00	;  0
      0009D9 00                    2533 	.db #0x00	;  0
      0009DA 00                    2534 	.db #0x00	;  0
      0009DB 01                    2535 	.db #0x01	;  1
      0009DC 02                    2536 	.db #0x02	;  2
      0009DD FD                    2537 	.db #0xfd	; -3
      0009DE FC                    2538 	.db #0xfc	; -4
      0009DF 01                    2539 	.db #0x01	;  1
      0009E0 FB                    2540 	.db #0xfb	; -5
      0009E1 00                    2541 	.db #0x00	;  0
      0009E2 FD                    2542 	.db #0xfd	; -3
      0009E3 05                    2543 	.db #0x05	;  5
      0009E4 02                    2544 	.db #0x02	;  2
      0009E5 00                    2545 	.db #0x00	;  0
      0009E6 08                    2546 	.db #0x08	;  8
      0009E7 00                    2547 	.db #0x00	;  0
      0009E8 02                    2548 	.db #0x02	;  2
      0009E9 02                    2549 	.db #0x02	;  2
      0009EA 00                    2550 	.db #0x00	;  0
      0009EB 09                    2551 	.db #0x09	;  9
      0009EC 00                    2552 	.db #0x00	;  0
      0009ED 04                    2553 	.db #0x04	;  4
      0009EE 00                    2554 	.db #0x00	;  0
      0009EF 03                    2555 	.db #0x03	;  3
      0009F0 09                    2556 	.db #0x09	;  9
      0009F1 FD                    2557 	.db #0xfd	; -3
      0009F2 FC                    2558 	.db #0xfc	; -4
      0009F3 00                    2559 	.db #0x00	;  0
      0009F4 FC                    2560 	.db #0xfc	; -4
      0009F5 FF                    2561 	.db #0xff	; -1
      0009F6 FF                    2562 	.db #0xff	; -1
      0009F7 00                    2563 	.db #0x00	;  0
      0009F8 08                    2564 	.db #0x08	;  8
      0009F9 03                    2565 	.db #0x03	;  3
      0009FA FA                    2566 	.db #0xfa	; -6
      0009FB F7                    2567 	.db #0xf7	; -9
      0009FC 07                    2568 	.db #0x07	;  7
      0009FD F7                    2569 	.db #0xf7	; -9
      0009FE 04                    2570 	.db #0x04	;  4
      0009FF 0E                    2571 	.db #0x0e	;  14
      000A00 F2                    2572 	.db #0xf2	; -14
      000A01 00                    2573 	.db #0x00	;  0
      000A02 0A                    2574 	.db #0x0a	;  10
      000A03 00                    2575 	.db #0x00	;  0
      000A04 20                    2576 	.db #0x20	;  32
      000A05 FF                    2577 	.db #0xff	; -1
      000A06 FB                    2578 	.db #0xfb	; -5
      000A07 00                    2579 	.db #0x00	;  0
      000A08 10                    2580 	.db #0x10	;  16
      000A09 F8                    2581 	.db #0xf8	; -8
      000A0A FA                    2582 	.db #0xfa	; -6
      000A0B 08                    2583 	.db #0x08	;  8
      000A0C 01                    2584 	.db #0x01	;  1
      000A0D FB                    2585 	.db #0xfb	; -5
      000A0E F4                    2586 	.db #0xf4	; -12
      000A0F 0D                    2587 	.db #0x0d	;  13
      000A10 1B                    2588 	.db #0x1b	;  27
      000A11 1C                    2589 	.db #0x1c	;  28
      000A12 FD                    2590 	.db #0xfd	; -3
      000A13 00                    2591 	.db #0x00	;  0
      000A14 EF                    2592 	.db #0xef	; -17
      000A15 05                    2593 	.db #0x05	;  5
      000A16 F9                    2594 	.db #0xf9	; -7
      000A17 07                    2595 	.db #0x07	;  7
      000A18 03                    2596 	.db #0x03	;  3
      000A19 08                    2597 	.db #0x08	;  8
      000A1A EB                    2598 	.db #0xeb	; -21
      000A1B FE                    2599 	.db #0xfe	; -2
      000A1C F8                    2600 	.db #0xf8	; -8
      000A1D FE                    2601 	.db #0xfe	; -2
      000A1E 12                    2602 	.db #0x12	;  18
      000A1F F8                    2603 	.db #0xf8	; -8
      000A20 E7                    2604 	.db #0xe7	; -25
      000A21 00                    2605 	.db #0x00	;  0
      000A22 0D                    2606 	.db #0x0d	;  13
      000A23 05                    2607 	.db #0x05	;  5
      000A24 2F                    2608 	.db #0x2f	;  47
      000A25 FD                    2609 	.db #0xfd	; -3
      000A26 F3                    2610 	.db #0xf3	; -13
      000A27 00                    2611 	.db #0x00	;  0
      000A28 08                    2612 	.db #0x08	;  8
      000A29 0E                    2613 	.db #0x0e	;  14
      000A2A 00                    2614 	.db #0x00	;  0
      000A2B FE                    2615 	.db #0xfe	; -2
      000A2C DF                    2616 	.db #0xdf	; -33
      000A2D EC                    2617 	.db #0xec	; -20
      000A2E E2                    2618 	.db #0xe2	; -30
      000A2F 0C                    2619 	.db #0x0c	;  12
      000A30 F4                    2620 	.db #0xf4	; -12
      000A31 1F                    2621 	.db #0x1f	;  31
      000A32 FA                    2622 	.db #0xfa	; -6
      000A33 00                    2623 	.db #0x00	;  0
      000A34 F1                    2624 	.db #0xf1	; -15
      000A35 02                    2625 	.db #0x02	;  2
      000A36 E9                    2626 	.db #0xe9	; -23
      000A37 F9                    2627 	.db #0xf9	; -7
      000A38 EA                    2628 	.db #0xea	; -22
      000A39 08                    2629 	.db #0x08	;  8
      000A3A E2                    2630 	.db #0xe2	; -30
      000A3B 06                    2631 	.db #0x06	;  6
      000A3C FB                    2632 	.db #0xfb	; -5
      000A3D 18                    2633 	.db #0x18	;  24
      000A3E 0C                    2634 	.db #0x0c	;  12
      000A3F 06                    2635 	.db #0x06	;  6
      000A40 FA                    2636 	.db #0xfa	; -6
      000A41 00                    2637 	.db #0x00	;  0
      000A42 01                    2638 	.db #0x01	;  1
      000A43 FD                    2639 	.db #0xfd	; -3
      000A44 24                    2640 	.db #0x24	;  36
      000A45 FF                    2641 	.db #0xff	; -1
      000A46 F4                    2642 	.db #0xf4	; -12
      000A47 00                    2643 	.db #0x00	;  0
      000A48 18                    2644 	.db #0x18	;  24
      000A49 FB                    2645 	.db #0xfb	; -5
      000A4A 19                    2646 	.db #0x19	;  25
      000A4B F4                    2647 	.db #0xf4	; -12
      000A4C EE                    2648 	.db #0xee	; -18
      000A4D F7                    2649 	.db #0xf7	; -9
      000A4E F1                    2650 	.db #0xf1	; -15
      000A4F F9                    2651 	.db #0xf9	; -7
      000A50 E5                    2652 	.db #0xe5	; -27
      000A51 07                    2653 	.db #0x07	;  7
      000A52 C1                    2654 	.db #0xc1	; -63
      000A53 00                    2655 	.db #0x00	;  0
      000A54 0F                    2656 	.db #0x0f	;  15
      000A55 E7                    2657 	.db #0xe7	; -25
      000A56 EF                    2658 	.db #0xef	; -17
      000A57 02                    2659 	.db #0x02	;  2
      000A58 DA                    2660 	.db #0xda	; -38
      000A59 FA                    2661 	.db #0xfa	; -6
      000A5A E1                    2662 	.db #0xe1	; -31
      000A5B 16                    2663 	.db #0x16	;  22
      000A5C FC                    2664 	.db #0xfc	; -4
      000A5D 0A                    2665 	.db #0x0a	;  10
      000A5E 17                    2666 	.db #0x17	;  23
      000A5F F9                    2667 	.db #0xf9	; -7
      000A60 F2                    2668 	.db #0xf2	; -14
      000A61 00                    2669 	.db #0x00	;  0
      000A62 03                    2670 	.db #0x03	;  3
      000A63 FA                    2671 	.db #0xfa	; -6
      000A64 15                    2672 	.db #0x15	;  21
      000A65 07                    2673 	.db #0x07	;  7
      000A66 17                    2674 	.db #0x17	;  23
      000A67 00                    2675 	.db #0x00	;  0
      000A68 11                    2676 	.db #0x11	;  17
      000A69 E2                    2677 	.db #0xe2	; -30
      000A6A 23                    2678 	.db #0x23	;  35
      000A6B EA                    2679 	.db #0xea	; -22
      000A6C F3                    2680 	.db #0xf3	; -13
      000A6D FD                    2681 	.db #0xfd	; -3
      000A6E 08                    2682 	.db #0x08	;  8
      000A6F 05                    2683 	.db #0x05	;  5
      000A70 F7                    2684 	.db #0xf7	; -9
      000A71 CD                    2685 	.db #0xcd	; -51
      000A72 EA                    2686 	.db #0xea	; -22
      000A73 00                    2687 	.db #0x00	;  0
      000A74 1C                    2688 	.db #0x1c	;  28
      000A75 EA                    2689 	.db #0xea	; -22
      000A76 FF                    2690 	.db #0xff	; -1
      000A77 0D                    2691 	.db #0x0d	;  13
      000A78 FA                    2692 	.db #0xfa	; -6
      000A79 FD                    2693 	.db #0xfd	; -3
      000A7A E3                    2694 	.db #0xe3	; -29
      000A7B 4D                    2695 	.db #0x4d	;  77	'M'
      000A7C FB                    2696 	.db #0xfb	; -5
      000A7D 0F                    2697 	.db #0x0f	;  15
      000A7E 08                    2698 	.db #0x08	;  8
      000A7F FC                    2699 	.db #0xfc	; -4
      000A80 03                    2700 	.db #0x03	;  3
      000A81 00                    2701 	.db #0x00	;  0
      000A82 FB                    2702 	.db #0xfb	; -5
      000A83 06                    2703 	.db #0x06	;  6
      000A84 06                    2704 	.db #0x06	;  6
      000A85 12                    2705 	.db #0x12	;  18
      000A86 28                    2706 	.db #0x28	;  40
      000A87 00                    2707 	.db #0x00	;  0
      000A88 13                    2708 	.db #0x13	;  19
      000A89 DF                    2709 	.db #0xdf	; -33
      000A8A 34                    2710 	.db #0x34	;  52	'4'
      000A8B CF                    2711 	.db #0xcf	; -49
      000A8C E4                    2712 	.db #0xe4	; -28
      000A8D 0F                    2713 	.db #0x0f	;  15
      000A8E 0C                    2714 	.db #0x0c	;  12
      000A8F 04                    2715 	.db #0x04	;  4
      000A90 00                    2716 	.db #0x00	;  0
      000A91 B8                    2717 	.db #0xb8	; -72
      000A92 2A                    2718 	.db #0x2a	;  42
      000A93 00                    2719 	.db #0x00	;  0
      000A94 FA                    2720 	.db #0xfa	; -6
      000A95 E4                    2721 	.db #0xe4	; -28
      000A96 00                    2722 	.db #0x00	;  0
      000A97 15                    2723 	.db #0x15	;  21
      000A98 0C                    2724 	.db #0x0c	;  12
      000A99 F9                    2725 	.db #0xf9	; -7
      000A9A 06                    2726 	.db #0x06	;  6
      000A9B 0E                    2727 	.db #0x0e	;  14
      000A9C FD                    2728 	.db #0xfd	; -3
      000A9D 17                    2729 	.db #0x17	;  23
      000A9E 8D                    2730 	.db #0x8d	; -115
      000A9F F5                    2731 	.db #0xf5	; -11
      000AA0 11                    2732 	.db #0x11	;  17
      000AA1 00                    2733 	.db #0x00	;  0
      000AA2 04                    2734 	.db #0x04	;  4
      000AA3 09                    2735 	.db #0x09	;  9
      000AA4 FF                    2736 	.db #0xff	; -1
      000AA5 14                    2737 	.db #0x14	;  20
      000AA6 F8                    2738 	.db #0xf8	; -8
      000AA7 00                    2739 	.db #0x00	;  0
      000AA8 00                    2740 	.db #0x00	;  0
      000AA9 18                    2741 	.db #0x18	;  24
      000AAA 27                    2742 	.db #0x27	;  39
      000AAB DC                    2743 	.db #0xdc	; -36
      000AAC 03                    2744 	.db #0x03	;  3
      000AAD F8                    2745 	.db #0xf8	; -8
      000AAE 12                    2746 	.db #0x12	;  18
      000AAF 19                    2747 	.db #0x19	;  25
      000AB0 EE                    2748 	.db #0xee	; -18
      000AB1 E7                    2749 	.db #0xe7	; -25
      000AB2 20                    2750 	.db #0x20	;  32
      000AB3 00                    2751 	.db #0x00	;  0
      000AB4 FA                    2752 	.db #0xfa	; -6
      000AB5 E4                    2753 	.db #0xe4	; -28
      000AB6 0B                    2754 	.db #0x0b	;  11
      000AB7 17                    2755 	.db #0x17	;  23
      000AB8 02                    2756 	.db #0x02	;  2
      000AB9 F2                    2757 	.db #0xf2	; -14
      000ABA 05                    2758 	.db #0x05	;  5
      000ABB E5                    2759 	.db #0xe5	; -27
      000ABC 05                    2760 	.db #0x05	;  5
      000ABD 18                    2761 	.db #0x18	;  24
      000ABE CF                    2762 	.db #0xcf	; -49
      000ABF 45                    2763 	.db #0x45	;  69	'E'
      000AC0 0D                    2764 	.db #0x0d	;  13
      000AC1 00                    2765 	.db #0x00	;  0
      000AC2 00                    2766 	.db #0x00	;  0
      000AC3 14                    2767 	.db #0x14	;  20
      000AC4 F4                    2768 	.db #0xf4	; -12
      000AC5 0D                    2769 	.db #0x0d	;  13
      000AC6 18                    2770 	.db #0x18	;  24
      000AC7 00                    2771 	.db #0x00	;  0
      000AC8 F6                    2772 	.db #0xf6	; -10
      000AC9 0A                    2773 	.db #0x0a	;  10
      000ACA 10                    2774 	.db #0x10	;  16
      000ACB C9                    2775 	.db #0xc9	; -55
      000ACC 09                    2776 	.db #0x09	;  9
      000ACD 00                    2777 	.db #0x00	;  0
      000ACE 08                    2778 	.db #0x08	;  8
      000ACF E2                    2779 	.db #0xe2	; -30
      000AD0 F2                    2780 	.db #0xf2	; -14
      000AD1 17                    2781 	.db #0x17	;  23
      000AD2 BB                    2782 	.db #0xbb	; -69
      000AD3 00                    2783 	.db #0x00	;  0
      000AD4 FA                    2784 	.db #0xfa	; -6
      000AD5 0E                    2785 	.db #0x0e	;  14
      000AD6 1A                    2786 	.db #0x1a	;  26
      000AD7 29                    2787 	.db #0x29	;  41
      000AD8 EB                    2788 	.db #0xeb	; -21
      000AD9 E3                    2789 	.db #0xe3	; -29
      000ADA 13                    2790 	.db #0x13	;  19
      000ADB D5                    2791 	.db #0xd5	; -43
      000ADC 00                    2792 	.db #0x00	;  0
      000ADD 0F                    2793 	.db #0x0f	;  15
      000ADE 1A                    2794 	.db #0x1a	;  26
      000ADF 06                    2795 	.db #0x06	;  6
      000AE0 01                    2796 	.db #0x01	;  1
      000AE1 00                    2797 	.db #0x00	;  0
      000AE2 FD                    2798 	.db #0xfd	; -3
      000AE3 13                    2799 	.db #0x13	;  19
      000AE4 02                    2800 	.db #0x02	;  2
      000AE5 07                    2801 	.db #0x07	;  7
      000AE6 18                    2802 	.db #0x18	;  24
      000AE7 00                    2803 	.db #0x00	;  0
      000AE8 F5                    2804 	.db #0xf5	; -11
      000AE9 EB                    2805 	.db #0xeb	; -21
      000AEA 05                    2806 	.db #0x05	;  5
      000AEB CC                    2807 	.db #0xcc	; -52
      000AEC FF                    2808 	.db #0xff	; -1
      000AED 18                    2809 	.db #0x18	;  24
      000AEE 10                    2810 	.db #0x10	;  16
      000AEF A8                    2811 	.db #0xa8	; -88
      000AF0 F3                    2812 	.db #0xf3	; -13
      000AF1 0D                    2813 	.db #0x0d	;  13
      000AF2 E8                    2814 	.db #0xe8	; -24
      000AF3 00                    2815 	.db #0x00	;  0
      000AF4 07                    2816 	.db #0x07	;  7
      000AF5 F7                    2817 	.db #0xf7	; -9
      000AF6 13                    2818 	.db #0x13	;  19
      000AF7 29                    2819 	.db #0x29	;  41
      000AF8 04                    2820 	.db #0x04	;  4
      000AF9 D5                    2821 	.db #0xd5	; -43
      000AFA FA                    2822 	.db #0xfa	; -6
      000AFB D7                    2823 	.db #0xd7	; -41
      000AFC E3                    2824 	.db #0xe3	; -29
      000AFD 04                    2825 	.db #0x04	;  4
      000AFE 13                    2826 	.db #0x13	;  19
      000AFF CB                    2827 	.db #0xcb	; -53
      000B00 06                    2828 	.db #0x06	;  6
      000B01 00                    2829 	.db #0x00	;  0
      000B02 F1                    2830 	.db #0xf1	; -15
      000B03 15                    2831 	.db #0x15	;  21
      000B04 11                    2832 	.db #0x11	;  17
      000B05 10                    2833 	.db #0x10	;  16
      000B06 19                    2834 	.db #0x19	;  25
      000B07 00                    2835 	.db #0x00	;  0
      000B08 F7                    2836 	.db #0xf7	; -9
      000B09 EB                    2837 	.db #0xeb	; -21
      000B0A 06                    2838 	.db #0x06	;  6
      000B0B E8                    2839 	.db #0xe8	; -24
      000B0C 03                    2840 	.db #0x03	;  3
      000B0D 09                    2841 	.db #0x09	;  9
      000B0E F2                    2842 	.db #0xf2	; -14
      000B0F E0                    2843 	.db #0xe0	; -32
      000B10 FF                    2844 	.db #0xff	; -1
      000B11 10                    2845 	.db #0x10	;  16
      000B12 FB                    2846 	.db #0xfb	; -5
      000B13 00                    2847 	.db #0x00	;  0
      000B14 F4                    2848 	.db #0xf4	; -12
      000B15 F0                    2849 	.db #0xf0	; -16
      000B16 1F                    2850 	.db #0x1f	;  31
      000B17 0B                    2851 	.db #0x0b	;  11
      000B18 EC                    2852 	.db #0xec	; -20
      000B19 B2                    2853 	.db #0xb2	; -78
      000B1A 01                    2854 	.db #0x01	;  1
      000B1B E6                    2855 	.db #0xe6	; -26
      000B1C F2                    2856 	.db #0xf2	; -14
      000B1D 07                    2857 	.db #0x07	;  7
      000B1E 10                    2858 	.db #0x10	;  16
      000B1F D1                    2859 	.db #0xd1	; -47
      000B20 FF                    2860 	.db #0xff	; -1
      000B21 00                    2861 	.db #0x00	;  0
      000B22 F8                    2862 	.db #0xf8	; -8
      000B23 08                    2863 	.db #0x08	;  8
      000B24 05                    2864 	.db #0x05	;  5
      000B25 09                    2865 	.db #0x09	;  9
      000B26 16                    2866 	.db #0x16	;  22
      000B27 00                    2867 	.db #0x00	;  0
      000B28 FC                    2868 	.db #0xfc	; -4
      000B29 FB                    2869 	.db #0xfb	; -5
      000B2A 09                    2870 	.db #0x09	;  9
      000B2B 08                    2871 	.db #0x08	;  8
      000B2C F9                    2872 	.db #0xf9	; -7
      000B2D FA                    2873 	.db #0xfa	; -6
      000B2E 09                    2874 	.db #0x09	;  9
      000B2F 1B                    2875 	.db #0x1b	;  27
      000B30 F5                    2876 	.db #0xf5	; -11
      000B31 02                    2877 	.db #0x02	;  2
      000B32 12                    2878 	.db #0x12	;  18
      000B33 00                    2879 	.db #0x00	;  0
      000B34 01                    2880 	.db #0x01	;  1
      000B35 FC                    2881 	.db #0xfc	; -4
      000B36 18                    2882 	.db #0x18	;  24
      000B37 04                    2883 	.db #0x04	;  4
      000B38 1A                    2884 	.db #0x1a	;  26
      000B39 C3                    2885 	.db #0xc3	; -61
      000B3A 15                    2886 	.db #0x15	;  21
      000B3B 01                    2887 	.db #0x01	;  1
      000B3C F8                    2888 	.db #0xf8	; -8
      000B3D 12                    2889 	.db #0x12	;  18
      000B3E 06                    2890 	.db #0x06	;  6
      000B3F F5                    2891 	.db #0xf5	; -11
      000B40 E7                    2892 	.db #0xe7	; -25
      000B41 00                    2893 	.db #0x00	;  0
      000B42 0B                    2894 	.db #0x0b	;  11
      000B43 03                    2895 	.db #0x03	;  3
      000B44 FB                    2896 	.db #0xfb	; -5
      000B45 0B                    2897 	.db #0x0b	;  11
      000B46 09                    2898 	.db #0x09	;  9
      000B47 00                    2899 	.db #0x00	;  0
      000B48 FE                    2900 	.db #0xfe	; -2
      000B49 F2                    2901 	.db #0xf2	; -14
      000B4A 08                    2902 	.db #0x08	;  8
      000B4B EB                    2903 	.db #0xeb	; -21
      000B4C 04                    2904 	.db #0x04	;  4
      000B4D 0A                    2905 	.db #0x0a	;  10
      000B4E FE                    2906 	.db #0xfe	; -2
      000B4F 13                    2907 	.db #0x13	;  19
      000B50 01                    2908 	.db #0x01	;  1
      000B51 02                    2909 	.db #0x02	;  2
      000B52 0A                    2910 	.db #0x0a	;  10
      000B53 00                    2911 	.db #0x00	;  0
      000B54 04                    2912 	.db #0x04	;  4
      000B55 04                    2913 	.db #0x04	;  4
      000B56 12                    2914 	.db #0x12	;  18
      000B57 EF                    2915 	.db #0xef	; -17
      000B58 0B                    2916 	.db #0x0b	;  11
      000B59 EE                    2917 	.db #0xee	; -18
      000B5A 02                    2918 	.db #0x02	;  2
      000B5B 00                    2919 	.db #0x00	;  0
      000B5C 00                    2920 	.db #0x00	;  0
      000B5D 04                    2921 	.db #0x04	;  4
      000B5E 02                    2922 	.db #0x02	;  2
      000B5F FF                    2923 	.db #0xff	; -1
      000B60 FC                    2924 	.db #0xfc	; -4
      000B61 00                    2925 	.db #0x00	;  0
      000B62 FE                    2926 	.db #0xfe	; -2
      000B63 00                    2927 	.db #0x00	;  0
      000B64 01                    2928 	.db #0x01	;  1
      000B65 00                    2929 	.db #0x00	;  0
      000B66 00                    2930 	.db #0x00	;  0
      000B67 00                    2931 	.db #0x00	;  0
      000B68 FD                    2932 	.db #0xfd	; -3
      000B69 FD                    2933 	.db #0xfd	; -3
      000B6A 00                    2934 	.db #0x00	;  0
      000B6B 01                    2935 	.db #0x01	;  1
      000B6C 05                    2936 	.db #0x05	;  5
      000B6D FC                    2937 	.db #0xfc	; -4
      000B6E 03                    2938 	.db #0x03	;  3
      000B6F FE                    2939 	.db #0xfe	; -2
      000B70 01                    2940 	.db #0x01	;  1
      000B71 03                    2941 	.db #0x03	;  3
      000B72 03                    2942 	.db #0x03	;  3
      000B73 00                    2943 	.db #0x00	;  0
      000B74 00                    2944 	.db #0x00	;  0
      000B75 02                    2945 	.db #0x02	;  2
      000B76 00                    2946 	.db #0x00	;  0
      000B77 FD                    2947 	.db #0xfd	; -3
      000B78 FD                    2948 	.db #0xfd	; -3
      000B79 00                    2949 	.db #0x00	;  0
      000B7A 01                    2950 	.db #0x01	;  1
      000B7B 00                    2951 	.db #0x00	;  0
      000B7C 00                    2952 	.db #0x00	;  0
      000B7D 00                    2953 	.db #0x00	;  0
      000B7E 00                    2954 	.db #0x00	;  0
      000B7F 00                    2955 	.db #0x00	;  0
      000B80 00                    2956 	.db #0x00	;  0
      000B81 00                    2957 	.db #0x00	;  0
      000B82 00                    2958 	.db #0x00	;  0
      000B83 00                    2959 	.db #0x00	;  0
      000B84 00                    2960 	.db #0x00	;  0
      000B85 00                    2961 	.db #0x00	;  0
      000B86 00                    2962 	.db #0x00	;  0
      000B87 00                    2963 	.db #0x00	;  0
      000B88 00                    2964 	.db #0x00	;  0
      000B89 00                    2965 	.db #0x00	;  0
      000B8A 00                    2966 	.db #0x00	;  0
      000B8B 00                    2967 	.db #0x00	;  0
      000B8C 00                    2968 	.db #0x00	;  0
      000B8D 00                    2969 	.db #0x00	;  0
      000B8E 00                    2970 	.db #0x00	;  0
      000B8F 00                    2971 	.db #0x00	;  0
      000B90 00                    2972 	.db #0x00	;  0
      000B91 00                    2973 	.db #0x00	;  0
      000B92 00                    2974 	.db #0x00	;  0
      000B93 00                    2975 	.db #0x00	;  0
      000B94 00                    2976 	.db #0x00	;  0
      000B95 00                    2977 	.db #0x00	;  0
      000B96 00                    2978 	.db #0x00	;  0
      000B97 00                    2979 	.db #0x00	;  0
      000B98 00                    2980 	.db #0x00	;  0
      000B99 00                    2981 	.db #0x00	;  0
      000B9A 00                    2982 	.db #0x00	;  0
      000B9B FE                    2983 	.db #0xfe	; -2
      000B9C 02                    2984 	.db #0x02	;  2
      000B9D F9                    2985 	.db #0xf9	; -7
      000B9E 05                    2986 	.db #0x05	;  5
      000B9F 00                    2987 	.db #0x00	;  0
      000BA0 04                    2988 	.db #0x04	;  4
      000BA1 00                    2989 	.db #0x00	;  0
      000BA2 03                    2990 	.db #0x03	;  3
      000BA3 FD                    2991 	.db #0xfd	; -3
      000BA4 03                    2992 	.db #0x03	;  3
      000BA5 F7                    2993 	.db #0xf7	; -9
      000BA6 02                    2994 	.db #0x02	;  2
      000BA7 00                    2995 	.db #0x00	;  0
      000BA8 04                    2996 	.db #0x04	;  4
      000BA9 01                    2997 	.db #0x01	;  1
      000BAA FF                    2998 	.db #0xff	; -1
      000BAB 03                    2999 	.db #0x03	;  3
      000BAC 00                    3000 	.db #0x00	;  0
      000BAD 02                    3001 	.db #0x02	;  2
      000BAE 00                    3002 	.db #0x00	;  0
      000BAF 04                    3003 	.db #0x04	;  4
      000BB0 05                    3004 	.db #0x05	;  5
      000BB1 06                    3005 	.db #0x06	;  6
      000BB2 FB                    3006 	.db #0xfb	; -5
      000BB3 00                    3007 	.db #0x00	;  0
      000BB4 08                    3008 	.db #0x08	;  8
      000BB5 FE                    3009 	.db #0xfe	; -2
      000BB6 00                    3010 	.db #0x00	;  0
      000BB7 FC                    3011 	.db #0xfc	; -4
      000BB8 01                    3012 	.db #0x01	;  1
      000BB9 01                    3013 	.db #0x01	;  1
      000BBA F9                    3014 	.db #0xf9	; -7
      000BBB 03                    3015 	.db #0x03	;  3
      000BBC 1E                    3016 	.db #0x1e	;  30
      000BBD FA                    3017 	.db #0xfa	; -6
      000BBE 03                    3018 	.db #0x03	;  3
      000BBF 15                    3019 	.db #0x15	;  21
      000BC0 F8                    3020 	.db #0xf8	; -8
      000BC1 00                    3021 	.db #0x00	;  0
      000BC2 FF                    3022 	.db #0xff	; -1
      000BC3 F9                    3023 	.db #0xf9	; -7
      000BC4 25                    3024 	.db #0x25	;  37
      000BC5 F6                    3025 	.db #0xf6	; -10
      000BC6 F5                    3026 	.db #0xf5	; -11
      000BC7 00                    3027 	.db #0x00	;  0
      000BC8 04                    3028 	.db #0x04	;  4
      000BC9 EA                    3029 	.db #0xea	; -22
      000BCA EB                    3030 	.db #0xeb	; -21
      000BCB 0C                    3031 	.db #0x0c	;  12
      000BCC F9                    3032 	.db #0xf9	; -7
      000BCD 03                    3033 	.db #0x03	;  3
      000BCE F2                    3034 	.db #0xf2	; -14
      000BCF 17                    3035 	.db #0x17	;  23
      000BD0 12                    3036 	.db #0x12	;  18
      000BD1 15                    3037 	.db #0x15	;  21
      000BD2 FE                    3038 	.db #0xfe	; -2
      000BD3 00                    3039 	.db #0x00	;  0
      000BD4 05                    3040 	.db #0x05	;  5
      000BD5 EB                    3041 	.db #0xeb	; -21
      000BD6 03                    3042 	.db #0x03	;  3
      000BD7 F6                    3043 	.db #0xf6	; -10
      000BD8 FB                    3044 	.db #0xfb	; -5
      000BD9 06                    3045 	.db #0x06	;  6
      000BDA E3                    3046 	.db #0xe3	; -29
      000BDB FB                    3047 	.db #0xfb	; -5
      000BDC 09                    3048 	.db #0x09	;  9
      000BDD 04                    3049 	.db #0x04	;  4
      000BDE F3                    3050 	.db #0xf3	; -13
      000BDF 18                    3051 	.db #0x18	;  24
      000BE0 0B                    3052 	.db #0x0b	;  11
      000BE1 00                    3053 	.db #0x00	;  0
      000BE2 FF                    3054 	.db #0xff	; -1
      000BE3 E8                    3055 	.db #0xe8	; -24
      000BE4 0F                    3056 	.db #0x0f	;  15
      000BE5 FB                    3057 	.db #0xfb	; -5
      000BE6 E5                    3058 	.db #0xe5	; -27
      000BE7 00                    3059 	.db #0x00	;  0
      000BE8 01                    3060 	.db #0x01	;  1
      000BE9 F6                    3061 	.db #0xf6	; -10
      000BEA 0B                    3062 	.db #0x0b	;  11
      000BEB 1B                    3063 	.db #0x1b	;  27
      000BEC FD                    3064 	.db #0xfd	; -3
      000BED 07                    3065 	.db #0x07	;  7
      000BEE F5                    3066 	.db #0xf5	; -11
      000BEF F6                    3067 	.db #0xf6	; -10
      000BF0 12                    3068 	.db #0x12	;  18
      000BF1 03                    3069 	.db #0x03	;  3
      000BF2 F9                    3070 	.db #0xf9	; -7
      000BF3 00                    3071 	.db #0x00	;  0
      000BF4 15                    3072 	.db #0x15	;  21
      000BF5 E9                    3073 	.db #0xe9	; -23
      000BF6 E4                    3074 	.db #0xe4	; -28
      000BF7 F2                    3075 	.db #0xf2	; -14
      000BF8 FB                    3076 	.db #0xfb	; -5
      000BF9 F7                    3077 	.db #0xf7	; -9
      000BFA DA                    3078 	.db #0xda	; -38
      000BFB 14                    3079 	.db #0x14	;  20
      000BFC 18                    3080 	.db #0x18	;  24
      000BFD 0B                    3081 	.db #0x0b	;  11
      000BFE 0D                    3082 	.db #0x0d	;  13
      000BFF 00                    3083 	.db #0x00	;  0
      000C00 07                    3084 	.db #0x07	;  7
      000C01 00                    3085 	.db #0x00	;  0
      000C02 02                    3086 	.db #0x02	;  2
      000C03 0C                    3087 	.db #0x0c	;  12
      000C04 12                    3088 	.db #0x12	;  18
      000C05 0B                    3089 	.db #0x0b	;  11
      000C06 EC                    3090 	.db #0xec	; -20
      000C07 00                    3091 	.db #0x00	;  0
      000C08 01                    3092 	.db #0x01	;  1
      000C09 09                    3093 	.db #0x09	;  9
      000C0A 15                    3094 	.db #0x15	;  21
      000C0B 07                    3095 	.db #0x07	;  7
      000C0C F5                    3096 	.db #0xf5	; -11
      000C0D 02                    3097 	.db #0x02	;  2
      000C0E FB                    3098 	.db #0xfb	; -5
      000C0F EC                    3099 	.db #0xec	; -20
      000C10 08                    3100 	.db #0x08	;  8
      000C11 04                    3101 	.db #0x04	;  4
      000C12 E8                    3102 	.db #0xe8	; -24
      000C13 00                    3103 	.db #0x00	;  0
      000C14 29                    3104 	.db #0x29	;  41
      000C15 F5                    3105 	.db #0xf5	; -11
      000C16 F3                    3106 	.db #0xf3	; -13
      000C17 D6                    3107 	.db #0xd6	; -42
      000C18 F7                    3108 	.db #0xf7	; -9
      000C19 04                    3109 	.db #0x04	;  4
      000C1A EC                    3110 	.db #0xec	; -20
      000C1B 1E                    3111 	.db #0x1e	;  30
      000C1C 0A                    3112 	.db #0x0a	;  10
      000C1D 0F                    3113 	.db #0x0f	;  15
      000C1E 23                    3114 	.db #0x23	;  35
      000C1F F4                    3115 	.db #0xf4	; -12
      000C20 FC                    3116 	.db #0xfc	; -4
      000C21 00                    3117 	.db #0x00	;  0
      000C22 04                    3118 	.db #0x04	;  4
      000C23 22                    3119 	.db #0x22	;  34
      000C24 25                    3120 	.db #0x25	;  37
      000C25 FB                    3121 	.db #0xfb	; -5
      000C26 16                    3122 	.db #0x16	;  22
      000C27 00                    3123 	.db #0x00	;  0
      000C28 FB                    3124 	.db #0xfb	; -5
      000C29 F6                    3125 	.db #0xf6	; -10
      000C2A 23                    3126 	.db #0x23	;  35
      000C2B 1A                    3127 	.db #0x1a	;  26
      000C2C E0                    3128 	.db #0xe0	; -32
      000C2D 04                    3129 	.db #0x04	;  4
      000C2E 0E                    3130 	.db #0x0e	;  14
      000C2F F3                    3131 	.db #0xf3	; -13
      000C30 F9                    3132 	.db #0xf9	; -7
      000C31 C1                    3133 	.db #0xc1	; -63
      000C32 EC                    3134 	.db #0xec	; -20
      000C33 00                    3135 	.db #0x00	;  0
      000C34 EA                    3136 	.db #0xea	; -22
      000C35 F2                    3137 	.db #0xf2	; -14
      000C36 0A                    3138 	.db #0x0a	;  10
      000C37 EB                    3139 	.db #0xeb	; -21
      000C38 F7                    3140 	.db #0xf7	; -9
      000C39 EB                    3141 	.db #0xeb	; -21
      000C3A 29                    3142 	.db #0x29	;  41
      000C3B F7                    3143 	.db #0xf7	; -9
      000C3C F6                    3144 	.db #0xf6	; -10
      000C3D 0B                    3145 	.db #0x0b	;  11
      000C3E 13                    3146 	.db #0x13	;  19
      000C3F CE                    3147 	.db #0xce	; -50
      000C40 08                    3148 	.db #0x08	;  8
      000C41 00                    3149 	.db #0x00	;  0
      000C42 08                    3150 	.db #0x08	;  8
      000C43 2F                    3151 	.db #0x2f	;  47
      000C44 29                    3152 	.db #0x29	;  41
      000C45 08                    3153 	.db #0x08	;  8
      000C46 04                    3154 	.db #0x04	;  4
      000C47 00                    3155 	.db #0x00	;  0
      000C48 F5                    3156 	.db #0xf5	; -11
      000C49 1D                    3157 	.db #0x1d	;  29
      000C4A 26                    3158 	.db #0x26	;  38
      000C4B 3C                    3159 	.db #0x3c	;  60
      000C4C F7                    3160 	.db #0xf7	; -9
      000C4D 02                    3161 	.db #0x02	;  2
      000C4E 0A                    3162 	.db #0x0a	;  10
      000C4F 15                    3163 	.db #0x15	;  21
      000C50 F1                    3164 	.db #0xf1	; -15
      000C51 CC                    3165 	.db #0xcc	; -52
      000C52 41                    3166 	.db #0x41	;  65	'A'
      000C53 00                    3167 	.db #0x00	;  0
      000C54 C8                    3168 	.db #0xc8	; -56
      000C55 EC                    3169 	.db #0xec	; -20
      000C56 F9                    3170 	.db #0xf9	; -7
      000C57 E1                    3171 	.db #0xe1	; -31
      000C58 1D                    3172 	.db #0x1d	;  29
      000C59 E3                    3173 	.db #0xe3	; -29
      000C5A 1A                    3174 	.db #0x1a	;  26
      000C5B F9                    3175 	.db #0xf9	; -7
      000C5C FA                    3176 	.db #0xfa	; -6
      000C5D F6                    3177 	.db #0xf6	; -10
      000C5E 81                    3178 	.db #0x81	; -127
      000C5F 0C                    3179 	.db #0x0c	;  12
      000C60 0D                    3180 	.db #0x0d	;  13
      000C61 00                    3181 	.db #0x00	;  0
      000C62 06                    3182 	.db #0x06	;  6
      000C63 06                    3183 	.db #0x06	;  6
      000C64 04                    3184 	.db #0x04	;  4
      000C65 F7                    3185 	.db #0xf7	; -9
      000C66 0D                    3186 	.db #0x0d	;  13
      000C67 00                    3187 	.db #0x00	;  0
      000C68 02                    3188 	.db #0x02	;  2
      000C69 07                    3189 	.db #0x07	;  7
      000C6A 2B                    3190 	.db #0x2b	;  43
      000C6B 06                    3191 	.db #0x06	;  6
      000C6C 0B                    3192 	.db #0x0b	;  11
      000C6D F7                    3193 	.db #0xf7	; -9
      000C6E 05                    3194 	.db #0x05	;  5
      000C6F 53                    3195 	.db #0x53	;  83	'S'
      000C70 00                    3196 	.db #0x00	;  0
      000C71 2A                    3197 	.db #0x2a	;  42
      000C72 12                    3198 	.db #0x12	;  18
      000C73 00                    3199 	.db #0x00	;  0
      000C74 13                    3200 	.db #0x13	;  19
      000C75 FC                    3201 	.db #0xfc	; -4
      000C76 0C                    3202 	.db #0x0c	;  12
      000C77 02                    3203 	.db #0x02	;  2
      000C78 01                    3204 	.db #0x01	;  1
      000C79 E7                    3205 	.db #0xe7	; -25
      000C7A E8                    3206 	.db #0xe8	; -24
      000C7B 17                    3207 	.db #0x17	;  23
      000C7C F9                    3208 	.db #0xf9	; -7
      000C7D 06                    3209 	.db #0x06	;  6
      000C7E 07                    3210 	.db #0x07	;  7
      000C7F 69                    3211 	.db #0x69	;  105	'i'
      000C80 15                    3212 	.db #0x15	;  21
      000C81 00                    3213 	.db #0x00	;  0
      000C82 FE                    3214 	.db #0xfe	; -2
      000C83 0E                    3215 	.db #0x0e	;  14
      000C84 11                    3216 	.db #0x11	;  17
      000C85 EB                    3217 	.db #0xeb	; -21
      000C86 23                    3218 	.db #0x23	;  35
      000C87 00                    3219 	.db #0x00	;  0
      000C88 FB                    3220 	.db #0xfb	; -5
      000C89 FF                    3221 	.db #0xff	; -1
      000C8A E7                    3222 	.db #0xe7	; -25
      000C8B 21                    3223 	.db #0x21	;  33
      000C8C 0C                    3224 	.db #0x0c	;  12
      000C8D DA                    3225 	.db #0xda	; -38
      000C8E 10                    3226 	.db #0x10	;  16
      000C8F C1                    3227 	.db #0xc1	; -63
      000C90 FA                    3228 	.db #0xfa	; -6
      000C91 31                    3229 	.db #0x31	;  49	'1'
      000C92 CC                    3230 	.db #0xcc	; -52
      000C93 00                    3231 	.db #0x00	;  0
      000C94 FA                    3232 	.db #0xfa	; -6
      000C95 F9                    3233 	.db #0xf9	; -7
      000C96 0E                    3234 	.db #0x0e	;  14
      000C97 2B                    3235 	.db #0x2b	;  43
      000C98 09                    3236 	.db #0x09	;  9
      000C99 DC                    3237 	.db #0xdc	; -36
      000C9A F1                    3238 	.db #0xf1	; -15
      000C9B FF                    3239 	.db #0xff	; -1
      000C9C EA                    3240 	.db #0xea	; -22
      000C9D FE                    3241 	.db #0xfe	; -2
      000C9E 23                    3242 	.db #0x23	;  35
      000C9F 04                    3243 	.db #0x04	;  4
      000CA0 0B                    3244 	.db #0x0b	;  11
      000CA1 00                    3245 	.db #0x00	;  0
      000CA2 ED                    3246 	.db #0xed	; -19
      000CA3 13                    3247 	.db #0x13	;  19
      000CA4 03                    3248 	.db #0x03	;  3
      000CA5 F9                    3249 	.db #0xf9	; -7
      000CA6 22                    3250 	.db #0x22	;  34
      000CA7 00                    3251 	.db #0x00	;  0
      000CA8 F5                    3252 	.db #0xf5	; -11
      000CA9 ED                    3253 	.db #0xed	; -19
      000CAA D8                    3254 	.db #0xd8	; -40
      000CAB 1C                    3255 	.db #0x1c	;  28
      000CAC 05                    3256 	.db #0x05	;  5
      000CAD 24                    3257 	.db #0x24	;  36
      000CAE F7                    3258 	.db #0xf7	; -9
      000CAF AC                    3259 	.db #0xac	; -84
      000CB0 FF                    3260 	.db #0xff	; -1
      000CB1 04                    3261 	.db #0x04	;  4
      000CB2 0C                    3262 	.db #0x0c	;  12
      000CB3 00                    3263 	.db #0x00	;  0
      000CB4 FF                    3264 	.db #0xff	; -1
      000CB5 FF                    3265 	.db #0xff	; -1
      000CB6 0C                    3266 	.db #0x0c	;  12
      000CB7 48                    3267 	.db #0x48	;  72	'H'
      000CB8 1E                    3268 	.db #0x1e	;  30
      000CB9 CB                    3269 	.db #0xcb	; -53
      000CBA 01                    3270 	.db #0x01	;  1
      000CBB DD                    3271 	.db #0xdd	; -35
      000CBC FF                    3272 	.db #0xff	; -1
      000CBD FB                    3273 	.db #0xfb	; -5
      000CBE 0C                    3274 	.db #0x0c	;  12
      000CBF BA                    3275 	.db #0xba	; -70
      000CC0 E5                    3276 	.db #0xe5	; -27
      000CC1 00                    3277 	.db #0x00	;  0
      000CC2 FE                    3278 	.db #0xfe	; -2
      000CC3 10                    3279 	.db #0x10	;  16
      000CC4 09                    3280 	.db #0x09	;  9
      000CC5 F1                    3281 	.db #0xf1	; -15
      000CC6 17                    3282 	.db #0x17	;  23
      000CC7 00                    3283 	.db #0x00	;  0
      000CC8 FB                    3284 	.db #0xfb	; -5
      000CC9 E4                    3285 	.db #0xe4	; -28
      000CCA D8                    3286 	.db #0xd8	; -40
      000CCB 0F                    3287 	.db #0x0f	;  15
      000CCC 00                    3288 	.db #0x00	;  0
      000CCD 23                    3289 	.db #0x23	;  35
      000CCE 06                    3290 	.db #0x06	;  6
      000CCF F4                    3291 	.db #0xf4	; -12
      000CD0 FE                    3292 	.db #0xfe	; -2
      000CD1 FF                    3293 	.db #0xff	; -1
      000CD2 1B                    3294 	.db #0x1b	;  27
      000CD3 00                    3295 	.db #0x00	;  0
      000CD4 01                    3296 	.db #0x01	;  1
      000CD5 FB                    3297 	.db #0xfb	; -5
      000CD6 0D                    3298 	.db #0x0d	;  13
      000CD7 28                    3299 	.db #0x28	;  40
      000CD8 1C                    3300 	.db #0x1c	;  28
      000CD9 D9                    3301 	.db #0xd9	; -39
      000CDA FA                    3302 	.db #0xfa	; -6
      000CDB DE                    3303 	.db #0xde	; -34
      000CDC FD                    3304 	.db #0xfd	; -3
      000CDD 19                    3305 	.db #0x19	;  25
      000CDE 09                    3306 	.db #0x09	;  9
      000CDF D3                    3307 	.db #0xd3	; -45
      000CE0 04                    3308 	.db #0x04	;  4
      000CE1 00                    3309 	.db #0x00	;  0
      000CE2 04                    3310 	.db #0x04	;  4
      000CE3 FC                    3311 	.db #0xfc	; -4
      000CE4 08                    3312 	.db #0x08	;  8
      000CE5 09                    3313 	.db #0x09	;  9
      000CE6 00                    3314 	.db #0x00	;  0
      000CE7 00                    3315 	.db #0x00	;  0
      000CE8 04                    3316 	.db #0x04	;  4
      000CE9 EF                    3317 	.db #0xef	; -17
      000CEA DF                    3318 	.db #0xdf	; -33
      000CEB 22                    3319 	.db #0x22	;  34
      000CEC 07                    3320 	.db #0x07	;  7
      000CED EF                    3321 	.db #0xef	; -17
      000CEE 19                    3322 	.db #0x19	;  25
      000CEF 26                    3323 	.db #0x26	;  38
      000CF0 13                    3324 	.db #0x13	;  19
      000CF1 F3                    3325 	.db #0xf3	; -13
      000CF2 FE                    3326 	.db #0xfe	; -2
      000CF3 00                    3327 	.db #0x00	;  0
      000CF4 01                    3328 	.db #0x01	;  1
      000CF5 EA                    3329 	.db #0xea	; -22
      000CF6 F8                    3330 	.db #0xf8	; -8
      000CF7 18                    3331 	.db #0x18	;  24
      000CF8 2C                    3332 	.db #0x2c	;  44
      000CF9 DB                    3333 	.db #0xdb	; -37
      000CFA EF                    3334 	.db #0xef	; -17
      000CFB F9                    3335 	.db #0xf9	; -7
      000CFC FA                    3336 	.db #0xfa	; -6
      000CFD 15                    3337 	.db #0x15	;  21
      000CFE 04                    3338 	.db #0x04	;  4
      000CFF FA                    3339 	.db #0xfa	; -6
      000D00 E9                    3340 	.db #0xe9	; -23
      000D01 00                    3341 	.db #0x00	;  0
      000D02 0B                    3342 	.db #0x0b	;  11
      000D03 F0                    3343 	.db #0xf0	; -16
      000D04 07                    3344 	.db #0x07	;  7
      000D05 F9                    3345 	.db #0xf9	; -7
      000D06 0F                    3346 	.db #0x0f	;  15
      000D07 00                    3347 	.db #0x00	;  0
      000D08 0D                    3348 	.db #0x0d	;  13
      000D09 EC                    3349 	.db #0xec	; -20
      000D0A FC                    3350 	.db #0xfc	; -4
      000D0B FA                    3351 	.db #0xfa	; -6
      000D0C 1F                    3352 	.db #0x1f	;  31
      000D0D E0                    3353 	.db #0xe0	; -32
      000D0E F8                    3354 	.db #0xf8	; -8
      000D0F 10                    3355 	.db #0x10	;  16
      000D10 FF                    3356 	.db #0xff	; -1
      000D11 F1                    3357 	.db #0xf1	; -15
      000D12 0C                    3358 	.db #0x0c	;  12
      000D13 00                    3359 	.db #0x00	;  0
      000D14 11                    3360 	.db #0x11	;  17
      000D15 FA                    3361 	.db #0xfa	; -6
      000D16 03                    3362 	.db #0x03	;  3
      000D17 F5                    3363 	.db #0xf5	; -11
      000D18 30                    3364 	.db #0x30	;  48	'0'
      000D19 EC                    3365 	.db #0xec	; -20
      000D1A 09                    3366 	.db #0x09	;  9
      000D1B 00                    3367 	.db #0x00	;  0
      000D1C FF                    3368 	.db #0xff	; -1
      000D1D 06                    3369 	.db #0x06	;  6
      000D1E FE                    3370 	.db #0xfe	; -2
      000D1F 00                    3371 	.db #0x00	;  0
      000D20 00                    3372 	.db #0x00	;  0
      000D21 00                    3373 	.db #0x00	;  0
      000D22 FC                    3374 	.db #0xfc	; -4
      000D23 01                    3375 	.db #0x01	;  1
      000D24 02                    3376 	.db #0x02	;  2
      000D25 00                    3377 	.db #0x00	;  0
      000D26 FE                    3378 	.db #0xfe	; -2
      000D27 00                    3379 	.db #0x00	;  0
      000D28 FE                    3380 	.db #0xfe	; -2
      000D29 FD                    3381 	.db #0xfd	; -3
      000D2A 00                    3382 	.db #0x00	;  0
      000D2B FF                    3383 	.db #0xff	; -1
      000D2C 02                    3384 	.db #0x02	;  2
      000D2D FE                    3385 	.db #0xfe	; -2
      000D2E 00                    3386 	.db #0x00	;  0
      000D2F FF                    3387 	.db #0xff	; -1
      000D30 00                    3388 	.db #0x00	;  0
      000D31 00                    3389 	.db #0x00	;  0
      000D32 03                    3390 	.db #0x03	;  3
      000D33 00                    3391 	.db #0x00	;  0
      000D34 00                    3392 	.db #0x00	;  0
      000D35 00                    3393 	.db #0x00	;  0
      000D36 04                    3394 	.db #0x04	;  4
      000D37 FE                    3395 	.db #0xfe	; -2
      000D38 01                    3396 	.db #0x01	;  1
      000D39 01                    3397 	.db #0x01	;  1
      000D3A 01                    3398 	.db #0x01	;  1
      000D3B 00                    3399 	.db #0x00	;  0
      000D3C 00                    3400 	.db #0x00	;  0
      000D3D 00                    3401 	.db #0x00	;  0
      000D3E 00                    3402 	.db #0x00	;  0
      000D3F 00                    3403 	.db #0x00	;  0
      000D40 00                    3404 	.db #0x00	;  0
      000D41 00                    3405 	.db #0x00	;  0
      000D42 00                    3406 	.db #0x00	;  0
      000D43 00                    3407 	.db #0x00	;  0
      000D44 00                    3408 	.db #0x00	;  0
      000D45 00                    3409 	.db #0x00	;  0
      000D46 00                    3410 	.db #0x00	;  0
      000D47 00                    3411 	.db #0x00	;  0
      000D48 00                    3412 	.db #0x00	;  0
      000D49 00                    3413 	.db #0x00	;  0
      000D4A 00                    3414 	.db #0x00	;  0
      000D4B 00                    3415 	.db #0x00	;  0
      000D4C 00                    3416 	.db #0x00	;  0
      000D4D 00                    3417 	.db #0x00	;  0
      000D4E 00                    3418 	.db #0x00	;  0
      000D4F 00                    3419 	.db #0x00	;  0
      000D50 00                    3420 	.db #0x00	;  0
      000D51 00                    3421 	.db #0x00	;  0
      000D52 00                    3422 	.db #0x00	;  0
      000D53 00                    3423 	.db #0x00	;  0
      000D54 00                    3424 	.db #0x00	;  0
      000D55 00                    3425 	.db #0x00	;  0
      000D56 00                    3426 	.db #0x00	;  0
      000D57 00                    3427 	.db #0x00	;  0
      000D58 00                    3428 	.db #0x00	;  0
      000D59 00                    3429 	.db #0x00	;  0
      000D5A 00                    3430 	.db #0x00	;  0
      000D5B 00                    3431 	.db #0x00	;  0
      000D5C 08                    3432 	.db #0x08	;  8
      000D5D FB                    3433 	.db #0xfb	; -5
      000D5E FF                    3434 	.db #0xff	; -1
      000D5F 05                    3435 	.db #0x05	;  5
      000D60 00                    3436 	.db #0x00	;  0
      000D61 00                    3437 	.db #0x00	;  0
      000D62 F9                    3438 	.db #0xf9	; -7
      000D63 04                    3439 	.db #0x04	;  4
      000D64 02                    3440 	.db #0x02	;  2
      000D65 FA                    3441 	.db #0xfa	; -6
      000D66 04                    3442 	.db #0x04	;  4
      000D67 00                    3443 	.db #0x00	;  0
      000D68 07                    3444 	.db #0x07	;  7
      000D69 04                    3445 	.db #0x04	;  4
      000D6A FD                    3446 	.db #0xfd	; -3
      000D6B 0E                    3447 	.db #0x0e	;  14
      000D6C FD                    3448 	.db #0xfd	; -3
      000D6D 05                    3449 	.db #0x05	;  5
      000D6E 00                    3450 	.db #0x00	;  0
      000D6F 07                    3451 	.db #0x07	;  7
      000D70 11                    3452 	.db #0x11	;  17
      000D71 FC                    3453 	.db #0xfc	; -4
      000D72 FC                    3454 	.db #0xfc	; -4
      000D73 00                    3455 	.db #0x00	;  0
      000D74 F6                    3456 	.db #0xf6	; -10
      000D75 FC                    3457 	.db #0xfc	; -4
      000D76 FE                    3458 	.db #0xfe	; -2
      000D77 FE                    3459 	.db #0xfe	; -2
      000D78 01                    3460 	.db #0x01	;  1
      000D79 01                    3461 	.db #0x01	;  1
      000D7A FC                    3462 	.db #0xfc	; -4
      000D7B 1A                    3463 	.db #0x1a	;  26
      000D7C 03                    3464 	.db #0x03	;  3
      000D7D 08                    3465 	.db #0x08	;  8
      000D7E FC                    3466 	.db #0xfc	; -4
      000D7F FA                    3467 	.db #0xfa	; -6
      000D80 F9                    3468 	.db #0xf9	; -7
      000D81 00                    3469 	.db #0x00	;  0
      000D82 02                    3470 	.db #0x02	;  2
      000D83 F7                    3471 	.db #0xf7	; -9
      000D84 03                    3472 	.db #0x03	;  3
      000D85 F6                    3473 	.db #0xf6	; -10
      000D86 EB                    3474 	.db #0xeb	; -21
      000D87 00                    3475 	.db #0x00	;  0
      000D88 01                    3476 	.db #0x01	;  1
      000D89 FA                    3477 	.db #0xfa	; -6
      000D8A EF                    3478 	.db #0xef	; -17
      000D8B 09                    3479 	.db #0x09	;  9
      000D8C FC                    3480 	.db #0xfc	; -4
      000D8D 14                    3481 	.db #0x14	;  20
      000D8E 0D                    3482 	.db #0x0d	;  13
      000D8F 08                    3483 	.db #0x08	;  8
      000D90 26                    3484 	.db #0x26	;  38
      000D91 06                    3485 	.db #0x06	;  6
      000D92 F9                    3486 	.db #0xf9	; -7
      000D93 00                    3487 	.db #0x00	;  0
      000D94 0B                    3488 	.db #0x0b	;  11
      000D95 F3                    3489 	.db #0xf3	; -13
      000D96 F8                    3490 	.db #0xf8	; -8
      000D97 F6                    3491 	.db #0xf6	; -10
      000D98 FB                    3492 	.db #0xfb	; -5
      000D99 E9                    3493 	.db #0xe9	; -23
      000D9A E1                    3494 	.db #0xe1	; -31
      000D9B 11                    3495 	.db #0x11	;  17
      000D9C 0F                    3496 	.db #0x0f	;  15
      000D9D FF                    3497 	.db #0xff	; -1
      000D9E E8                    3498 	.db #0xe8	; -24
      000D9F FE                    3499 	.db #0xfe	; -2
      000DA0 F4                    3500 	.db #0xf4	; -12
      000DA1 00                    3501 	.db #0x00	;  0
      000DA2 0C                    3502 	.db #0x0c	;  12
      000DA3 04                    3503 	.db #0x04	;  4
      000DA4 0E                    3504 	.db #0x0e	;  14
      000DA5 FE                    3505 	.db #0xfe	; -2
      000DA6 FA                    3506 	.db #0xfa	; -6
      000DA7 00                    3507 	.db #0x00	;  0
      000DA8 FC                    3508 	.db #0xfc	; -4
      000DA9 EF                    3509 	.db #0xef	; -17
      000DAA FB                    3510 	.db #0xfb	; -5
      000DAB 1E                    3511 	.db #0x1e	;  30
      000DAC F9                    3512 	.db #0xf9	; -7
      000DAD FE                    3513 	.db #0xfe	; -2
      000DAE 02                    3514 	.db #0x02	;  2
      000DAF FD                    3515 	.db #0xfd	; -3
      000DB0 12                    3516 	.db #0x12	;  18
      000DB1 14                    3517 	.db #0x14	;  20
      000DB2 0C                    3518 	.db #0x0c	;  12
      000DB3 00                    3519 	.db #0x00	;  0
      000DB4 29                    3520 	.db #0x29	;  41
      000DB5 F5                    3521 	.db #0xf5	; -11
      000DB6 F9                    3522 	.db #0xf9	; -7
      000DB7 D3                    3523 	.db #0xd3	; -45
      000DB8 E0                    3524 	.db #0xe0	; -32
      000DB9 F9                    3525 	.db #0xf9	; -7
      000DBA ED                    3526 	.db #0xed	; -19
      000DBB 14                    3527 	.db #0x14	;  20
      000DBC 29                    3528 	.db #0x29	;  41
      000DBD 01                    3529 	.db #0x01	;  1
      000DBE FC                    3530 	.db #0xfc	; -4
      000DBF F6                    3531 	.db #0xf6	; -10
      000DC0 08                    3532 	.db #0x08	;  8
      000DC1 00                    3533 	.db #0x00	;  0
      000DC2 19                    3534 	.db #0x19	;  25
      000DC3 0A                    3535 	.db #0x0a	;  10
      000DC4 0C                    3536 	.db #0x0c	;  12
      000DC5 FB                    3537 	.db #0xfb	; -5
      000DC6 F7                    3538 	.db #0xf7	; -9
      000DC7 00                    3539 	.db #0x00	;  0
      000DC8 F6                    3540 	.db #0xf6	; -10
      000DC9 E2                    3541 	.db #0xe2	; -30
      000DCA FA                    3542 	.db #0xfa	; -6
      000DCB 1D                    3543 	.db #0x1d	;  29
      000DCC E0                    3544 	.db #0xe0	; -32
      000DCD FE                    3545 	.db #0xfe	; -2
      000DCE 0D                    3546 	.db #0x0d	;  13
      000DCF FD                    3547 	.db #0xfd	; -3
      000DD0 12                    3548 	.db #0x12	;  18
      000DD1 02                    3549 	.db #0x02	;  2
      000DD2 DB                    3550 	.db #0xdb	; -37
      000DD3 00                    3551 	.db #0x00	;  0
      000DD4 4C                    3552 	.db #0x4c	;  76	'L'
      000DD5 F8                    3553 	.db #0xf8	; -8
      000DD6 FF                    3554 	.db #0xff	; -1
      000DD7 E3                    3555 	.db #0xe3	; -29
      000DD8 F8                    3556 	.db #0xf8	; -8
      000DD9 03                    3557 	.db #0x03	;  3
      000DDA F6                    3558 	.db #0xf6	; -10
      000DDB D7                    3559 	.db #0xd7	; -41
      000DDC 2E                    3560 	.db #0x2e	;  46
      000DDD FF                    3561 	.db #0xff	; -1
      000DDE 03                    3562 	.db #0x03	;  3
      000DDF DA                    3563 	.db #0xda	; -38
      000DE0 FE                    3564 	.db #0xfe	; -2
      000DE1 00                    3565 	.db #0x00	;  0
      000DE2 0D                    3566 	.db #0x0d	;  13
      000DE3 0B                    3567 	.db #0x0b	;  11
      000DE4 F7                    3568 	.db #0xf7	; -9
      000DE5 F5                    3569 	.db #0xf5	; -11
      000DE6 0B                    3570 	.db #0x0b	;  11
      000DE7 00                    3571 	.db #0x00	;  0
      000DE8 F4                    3572 	.db #0xf4	; -12
      000DE9 08                    3573 	.db #0x08	;  8
      000DEA E5                    3574 	.db #0xe5	; -27
      000DEB 22                    3575 	.db #0x22	;  34
      000DEC F2                    3576 	.db #0xf2	; -14
      000DED D7                    3577 	.db #0xd7	; -41
      000DEE F9                    3578 	.db #0xf9	; -7
      000DEF 05                    3579 	.db #0x05	;  5
      000DF0 2D                    3580 	.db #0x2d	;  45
      000DF1 CB                    3581 	.db #0xcb	; -53
      000DF2 E6                    3582 	.db #0xe6	; -26
      000DF3 00                    3583 	.db #0x00	;  0
      000DF4 16                    3584 	.db #0x16	;  22
      000DF5 EC                    3585 	.db #0xec	; -20
      000DF6 FA                    3586 	.db #0xfa	; -6
      000DF7 E5                    3587 	.db #0xe5	; -27
      000DF8 F0                    3588 	.db #0xf0	; -16
      000DF9 E9                    3589 	.db #0xe9	; -23
      000DFA 37                    3590 	.db #0x37	;  55	'7'
      000DFB EF                    3591 	.db #0xef	; -17
      000DFC DE                    3592 	.db #0xde	; -34
      000DFD 02                    3593 	.db #0x02	;  2
      000DFE E8                    3594 	.db #0xe8	; -24
      000DFF F3                    3595 	.db #0xf3	; -13
      000E00 F2                    3596 	.db #0xf2	; -14
      000E01 00                    3597 	.db #0x00	;  0
      000E02 FA                    3598 	.db #0xfa	; -6
      000E03 EB                    3599 	.db #0xeb	; -21
      000E04 E4                    3600 	.db #0xe4	; -28
      000E05 30                    3601 	.db #0x30	;  48	'0'
      000E06 15                    3602 	.db #0x15	;  21
      000E07 00                    3603 	.db #0x00	;  0
      000E08 00                    3604 	.db #0x00	;  0
      000E09 13                    3605 	.db #0x13	;  19
      000E0A F1                    3606 	.db #0xf1	; -15
      000E0B 15                    3607 	.db #0x15	;  21
      000E0C E8                    3608 	.db #0xe8	; -24
      000E0D DC                    3609 	.db #0xdc	; -36
      000E0E 09                    3610 	.db #0x09	;  9
      000E0F 1C                    3611 	.db #0x1c	;  28
      000E10 1B                    3612 	.db #0x1b	;  27
      000E11 F0                    3613 	.db #0xf0	; -16
      000E12 2B                    3614 	.db #0x2b	;  43
      000E13 00                    3615 	.db #0x00	;  0
      000E14 A7                    3616 	.db #0xa7	; -89
      000E15 E7                    3617 	.db #0xe7	; -25
      000E16 F2                    3618 	.db #0xf2	; -14
      000E17 D7                    3619 	.db #0xd7	; -41
      000E18 0D                    3620 	.db #0x0d	;  13
      000E19 EA                    3621 	.db #0xea	; -22
      000E1A 19                    3622 	.db #0x19	;  25
      000E1B 09                    3623 	.db #0x09	;  9
      000E1C FC                    3624 	.db #0xfc	; -4
      000E1D F9                    3625 	.db #0xf9	; -7
      000E1E DE                    3626 	.db #0xde	; -34
      000E1F 31                    3627 	.db #0x31	;  49	'1'
      000E20 0B                    3628 	.db #0x0b	;  11
      000E21 00                    3629 	.db #0x00	;  0
      000E22 07                    3630 	.db #0x07	;  7
      000E23 EB                    3631 	.db #0xeb	; -21
      000E24 F1                    3632 	.db #0xf1	; -15
      000E25 28                    3633 	.db #0x28	;  40
      000E26 FD                    3634 	.db #0xfd	; -3
      000E27 00                    3635 	.db #0x00	;  0
      000E28 F7                    3636 	.db #0xf7	; -9
      000E29 F8                    3637 	.db #0xf8	; -8
      000E2A E8                    3638 	.db #0xe8	; -24
      000E2B 33                    3639 	.db #0x33	;  51	'3'
      000E2C 0E                    3640 	.db #0x0e	;  14
      000E2D D6                    3641 	.db #0xd6	; -42
      000E2E 01                    3642 	.db #0x01	;  1
      000E2F 2A                    3643 	.db #0x2a	;  42
      000E30 00                    3644 	.db #0x00	;  0
      000E31 22                    3645 	.db #0x22	;  34
      000E32 F7                    3646 	.db #0xf7	; -9
      000E33 00                    3647 	.db #0x00	;  0
      000E34 02                    3648 	.db #0x02	;  2
      000E35 EF                    3649 	.db #0xef	; -17
      000E36 DD                    3650 	.db #0xdd	; -35
      000E37 DF                    3651 	.db #0xdf	; -33
      000E38 03                    3652 	.db #0x03	;  3
      000E39 00                    3653 	.db #0x00	;  0
      000E3A EF                    3654 	.db #0xef	; -17
      000E3B 39                    3655 	.db #0x39	;  57	'9'
      000E3C 02                    3656 	.db #0x02	;  2
      000E3D F4                    3657 	.db #0xf4	; -12
      000E3E 20                    3658 	.db #0x20	;  32
      000E3F 27                    3659 	.db #0x27	;  39
      000E40 10                    3660 	.db #0x10	;  16
      000E41 00                    3661 	.db #0x00	;  0
      000E42 00                    3662 	.db #0x00	;  0
      000E43 FD                    3663 	.db #0xfd	; -3
      000E44 01                    3664 	.db #0x01	;  1
      000E45 1C                    3665 	.db #0x1c	;  28
      000E46 0A                    3666 	.db #0x0a	;  10
      000E47 00                    3667 	.db #0x00	;  0
      000E48 FD                    3668 	.db #0xfd	; -3
      000E49 0E                    3669 	.db #0x0e	;  14
      000E4A 05                    3670 	.db #0x05	;  5
      000E4B 1A                    3671 	.db #0x1a	;  26
      000E4C 0D                    3672 	.db #0x0d	;  13
      000E4D 11                    3673 	.db #0x11	;  17
      000E4E E9                    3674 	.db #0xe9	; -23
      000E4F BB                    3675 	.db #0xbb	; -69
      000E50 0A                    3676 	.db #0x0a	;  10
      000E51 04                    3677 	.db #0x04	;  4
      000E52 01                    3678 	.db #0x01	;  1
      000E53 00                    3679 	.db #0x00	;  0
      000E54 F4                    3680 	.db #0xf4	; -12
      000E55 FF                    3681 	.db #0xff	; -1
      000E56 98                    3682 	.db #0x98	; -104
      000E57 E6                    3683 	.db #0xe6	; -26
      000E58 F6                    3684 	.db #0xf6	; -10
      000E59 04                    3685 	.db #0x04	;  4
      000E5A DF                    3686 	.db #0xdf	; -33
      000E5B 18                    3687 	.db #0x18	;  24
      000E5C FF                    3688 	.db #0xff	; -1
      000E5D 01                    3689 	.db #0x01	;  1
      000E5E 1E                    3690 	.db #0x1e	;  30
      000E5F D8                    3691 	.db #0xd8	; -40
      000E60 FA                    3692 	.db #0xfa	; -6
      000E61 00                    3693 	.db #0x00	;  0
      000E62 15                    3694 	.db #0x15	;  21
      000E63 02                    3695 	.db #0x02	;  2
      000E64 FE                    3696 	.db #0xfe	; -2
      000E65 F2                    3697 	.db #0xf2	; -14
      000E66 07                    3698 	.db #0x07	;  7
      000E67 00                    3699 	.db #0x00	;  0
      000E68 F7                    3700 	.db #0xf7	; -9
      000E69 01                    3701 	.db #0x01	;  1
      000E6A EB                    3702 	.db #0xeb	; -21
      000E6B 12                    3703 	.db #0x12	;  18
      000E6C 0A                    3704 	.db #0x0a	;  10
      000E6D 43                    3705 	.db #0x43	;  67	'C'
      000E6E EE                    3706 	.db #0xee	; -18
      000E6F D6                    3707 	.db #0xd6	; -42
      000E70 18                    3708 	.db #0x18	;  24
      000E71 FF                    3709 	.db #0xff	; -1
      000E72 11                    3710 	.db #0x11	;  17
      000E73 00                    3711 	.db #0x00	;  0
      000E74 FD                    3712 	.db #0xfd	; -3
      000E75 FA                    3713 	.db #0xfa	; -6
      000E76 86                    3714 	.db #0x86	; -122
      000E77 10                    3715 	.db #0x10	;  16
      000E78 13                    3716 	.db #0x13	;  19
      000E79 FF                    3717 	.db #0xff	; -1
      000E7A E7                    3718 	.db #0xe7	; -25
      000E7B FE                    3719 	.db #0xfe	; -2
      000E7C FE                    3720 	.db #0xfe	; -2
      000E7D FB                    3721 	.db #0xfb	; -5
      000E7E 00                    3722 	.db #0x00	;  0
      000E7F C3                    3723 	.db #0xc3	; -61
      000E80 D7                    3724 	.db #0xd7	; -41
      000E81 00                    3725 	.db #0x00	;  0
      000E82 0D                    3726 	.db #0x0d	;  13
      000E83 01                    3727 	.db #0x01	;  1
      000E84 F6                    3728 	.db #0xf6	; -10
      000E85 D6                    3729 	.db #0xd6	; -42
      000E86 11                    3730 	.db #0x11	;  17
      000E87 00                    3731 	.db #0x00	;  0
      000E88 02                    3732 	.db #0x02	;  2
      000E89 E8                    3733 	.db #0xe8	; -24
      000E8A D7                    3734 	.db #0xd7	; -41
      000E8B FE                    3735 	.db #0xfe	; -2
      000E8C 01                    3736 	.db #0x01	;  1
      000E8D 1E                    3737 	.db #0x1e	;  30
      000E8E FA                    3738 	.db #0xfa	; -6
      000E8F 0F                    3739 	.db #0x0f	;  15
      000E90 0E                    3740 	.db #0x0e	;  14
      000E91 E5                    3741 	.db #0xe5	; -27
      000E92 F7                    3742 	.db #0xf7	; -9
      000E93 00                    3743 	.db #0x00	;  0
      000E94 0A                    3744 	.db #0x0a	;  10
      000E95 FF                    3745 	.db #0xff	; -1
      000E96 9E                    3746 	.db #0x9e	; -98
      000E97 2B                    3747 	.db #0x2b	;  43
      000E98 1A                    3748 	.db #0x1a	;  26
      000E99 0C                    3749 	.db #0x0c	;  12
      000E9A 02                    3750 	.db #0x02	;  2
      000E9B EC                    3751 	.db #0xec	; -20
      000E9C FE                    3752 	.db #0xfe	; -2
      000E9D F4                    3753 	.db #0xf4	; -12
      000E9E F3                    3754 	.db #0xf3	; -13
      000E9F F2                    3755 	.db #0xf2	; -14
      000EA0 EA                    3756 	.db #0xea	; -22
      000EA1 00                    3757 	.db #0x00	;  0
      000EA2 08                    3758 	.db #0x08	;  8
      000EA3 FA                    3759 	.db #0xfa	; -6
      000EA4 05                    3760 	.db #0x05	;  5
      000EA5 CD                    3761 	.db #0xcd	; -51
      000EA6 0E                    3762 	.db #0x0e	;  14
      000EA7 00                    3763 	.db #0x00	;  0
      000EA8 FF                    3764 	.db #0xff	; -1
      000EA9 ED                    3765 	.db #0xed	; -19
      000EAA E5                    3766 	.db #0xe5	; -27
      000EAB 19                    3767 	.db #0x19	;  25
      000EAC 1C                    3768 	.db #0x1c	;  28
      000EAD FA                    3769 	.db #0xfa	; -6
      000EAE 24                    3770 	.db #0x24	;  36
      000EAF 10                    3771 	.db #0x10	;  16
      000EB0 00                    3772 	.db #0x00	;  0
      000EB1 0A                    3773 	.db #0x0a	;  10
      000EB2 FE                    3774 	.db #0xfe	; -2
      000EB3 00                    3775 	.db #0x00	;  0
      000EB4 0C                    3776 	.db #0x0c	;  12
      000EB5 EB                    3777 	.db #0xeb	; -21
      000EB6 BF                    3778 	.db #0xbf	; -65
      000EB7 0C                    3779 	.db #0x0c	;  12
      000EB8 12                    3780 	.db #0x12	;  18
      000EB9 06                    3781 	.db #0x06	;  6
      000EBA 09                    3782 	.db #0x09	;  9
      000EBB FD                    3783 	.db #0xfd	; -3
      000EBC 08                    3784 	.db #0x08	;  8
      000EBD 08                    3785 	.db #0x08	;  8
      000EBE 02                    3786 	.db #0x02	;  2
      000EBF 06                    3787 	.db #0x06	;  6
      000EC0 FD                    3788 	.db #0xfd	; -3
      000EC1 00                    3789 	.db #0x00	;  0
      000EC2 FD                    3790 	.db #0xfd	; -3
      000EC3 F1                    3791 	.db #0xf1	; -15
      000EC4 05                    3792 	.db #0x05	;  5
      000EC5 EA                    3793 	.db #0xea	; -22
      000EC6 13                    3794 	.db #0x13	;  19
      000EC7 00                    3795 	.db #0x00	;  0
      000EC8 F7                    3796 	.db #0xf7	; -9
      000EC9 E6                    3797 	.db #0xe6	; -26
      000ECA F1                    3798 	.db #0xf1	; -15
      000ECB 0E                    3799 	.db #0x0e	;  14
      000ECC 17                    3800 	.db #0x17	;  23
      000ECD DB                    3801 	.db #0xdb	; -37
      000ECE 0D                    3802 	.db #0x0d	;  13
      000ECF F8                    3803 	.db #0xf8	; -8
      000ED0 F8                    3804 	.db #0xf8	; -8
      000ED1 FB                    3805 	.db #0xfb	; -5
      000ED2 F4                    3806 	.db #0xf4	; -12
      000ED3 00                    3807 	.db #0x00	;  0
      000ED4 04                    3808 	.db #0x04	;  4
      000ED5 06                    3809 	.db #0x06	;  6
      000ED6 EA                    3810 	.db #0xea	; -22
      000ED7 05                    3811 	.db #0x05	;  5
      000ED8 28                    3812 	.db #0x28	;  40
      000ED9 0A                    3813 	.db #0x0a	;  10
      000EDA 04                    3814 	.db #0x04	;  4
      000EDB 00                    3815 	.db #0x00	;  0
      000EDC 00                    3816 	.db #0x00	;  0
      000EDD 00                    3817 	.db #0x00	;  0
      000EDE 00                    3818 	.db #0x00	;  0
      000EDF 00                    3819 	.db #0x00	;  0
      000EE0 00                    3820 	.db #0x00	;  0
      000EE1 00                    3821 	.db #0x00	;  0
      000EE2 00                    3822 	.db #0x00	;  0
      000EE3 00                    3823 	.db #0x00	;  0
      000EE4 00                    3824 	.db #0x00	;  0
      000EE5 00                    3825 	.db #0x00	;  0
      000EE6 00                    3826 	.db #0x00	;  0
      000EE7 00                    3827 	.db #0x00	;  0
      000EE8 00                    3828 	.db #0x00	;  0
      000EE9 00                    3829 	.db #0x00	;  0
      000EEA 00                    3830 	.db #0x00	;  0
      000EEB 00                    3831 	.db #0x00	;  0
      000EEC 00                    3832 	.db #0x00	;  0
      000EED 00                    3833 	.db #0x00	;  0
      000EEE 00                    3834 	.db #0x00	;  0
      000EEF 00                    3835 	.db #0x00	;  0
      000EF0 00                    3836 	.db #0x00	;  0
      000EF1 00                    3837 	.db #0x00	;  0
      000EF2 00                    3838 	.db #0x00	;  0
      000EF3 00                    3839 	.db #0x00	;  0
      000EF4 00                    3840 	.db #0x00	;  0
      000EF5 00                    3841 	.db #0x00	;  0
      000EF6 00                    3842 	.db #0x00	;  0
      000EF7 00                    3843 	.db #0x00	;  0
      000EF8 00                    3844 	.db #0x00	;  0
      000EF9 00                    3845 	.db #0x00	;  0
      000EFA 00                    3846 	.db #0x00	;  0
      000EFB 00                    3847 	.db #0x00	;  0
      000EFC 00                    3848 	.db #0x00	;  0
      000EFD 00                    3849 	.db #0x00	;  0
      000EFE 00                    3850 	.db #0x00	;  0
      000EFF 00                    3851 	.db #0x00	;  0
      000F00 00                    3852 	.db #0x00	;  0
      000F01 00                    3853 	.db #0x00	;  0
      000F02 00                    3854 	.db #0x00	;  0
      000F03 00                    3855 	.db #0x00	;  0
      000F04 00                    3856 	.db #0x00	;  0
      000F05 00                    3857 	.db #0x00	;  0
      000F06 00                    3858 	.db #0x00	;  0
      000F07 00                    3859 	.db #0x00	;  0
      000F08 00                    3860 	.db #0x00	;  0
      000F09 00                    3861 	.db #0x00	;  0
      000F0A 00                    3862 	.db #0x00	;  0
      000F0B 00                    3863 	.db #0x00	;  0
      000F0C 00                    3864 	.db #0x00	;  0
      000F0D 00                    3865 	.db #0x00	;  0
      000F0E 00                    3866 	.db #0x00	;  0
      000F0F 00                    3867 	.db #0x00	;  0
      000F10 00                    3868 	.db #0x00	;  0
      000F11 00                    3869 	.db #0x00	;  0
      000F12 00                    3870 	.db #0x00	;  0
      000F13 00                    3871 	.db #0x00	;  0
      000F14 00                    3872 	.db #0x00	;  0
      000F15 00                    3873 	.db #0x00	;  0
      000F16 00                    3874 	.db #0x00	;  0
      000F17 00                    3875 	.db #0x00	;  0
      000F18 00                    3876 	.db #0x00	;  0
      000F19 00                    3877 	.db #0x00	;  0
      000F1A 00                    3878 	.db #0x00	;  0
      000F1B 03                    3879 	.db #0x03	;  3
      000F1C 00                    3880 	.db #0x00	;  0
      000F1D 0A                    3881 	.db #0x0a	;  10
      000F1E FA                    3882 	.db #0xfa	; -6
      000F1F 00                    3883 	.db #0x00	;  0
      000F20 00                    3884 	.db #0x00	;  0
      000F21 00                    3885 	.db #0x00	;  0
      000F22 F2                    3886 	.db #0xf2	; -14
      000F23 FB                    3887 	.db #0xfb	; -5
      000F24 F6                    3888 	.db #0xf6	; -10
      000F25 F2                    3889 	.db #0xf2	; -14
      000F26 07                    3890 	.db #0x07	;  7
      000F27 00                    3891 	.db #0x00	;  0
      000F28 F5                    3892 	.db #0xf5	; -11
      000F29 06                    3893 	.db #0x06	;  6
      000F2A 00                    3894 	.db #0x00	;  0
      000F2B 0A                    3895 	.db #0x0a	;  10
      000F2C F4                    3896 	.db #0xf4	; -12
      000F2D 08                    3897 	.db #0x08	;  8
      000F2E 00                    3898 	.db #0x00	;  0
      000F2F 08                    3899 	.db #0x08	;  8
      000F30 1F                    3900 	.db #0x1f	;  31
      000F31 FC                    3901 	.db #0xfc	; -4
      000F32 F5                    3902 	.db #0xf5	; -11
      000F33 00                    3903 	.db #0x00	;  0
      000F34 02                    3904 	.db #0x02	;  2
      000F35 F3                    3905 	.db #0xf3	; -13
      000F36 00                    3906 	.db #0x00	;  0
      000F37 05                    3907 	.db #0x05	;  5
      000F38 FF                    3908 	.db #0xff	; -1
      000F39 FF                    3909 	.db #0xff	; -1
      000F3A 02                    3910 	.db #0x02	;  2
      000F3B 1F                    3911 	.db #0x1f	;  31
      000F3C 0D                    3912 	.db #0x0d	;  13
      000F3D F8                    3913 	.db #0xf8	; -8
      000F3E F0                    3914 	.db #0xf0	; -16
      000F3F FF                    3915 	.db #0xff	; -1
      000F40 F0                    3916 	.db #0xf0	; -16
      000F41 00                    3917 	.db #0x00	;  0
      000F42 00                    3918 	.db #0x00	;  0
      000F43 F3                    3919 	.db #0xf3	; -13
      000F44 D2                    3920 	.db #0xd2	; -46
      000F45 EB                    3921 	.db #0xeb	; -21
      000F46 FF                    3922 	.db #0xff	; -1
      000F47 00                    3923 	.db #0x00	;  0
      000F48 FB                    3924 	.db #0xfb	; -5
      000F49 ED                    3925 	.db #0xed	; -19
      000F4A E9                    3926 	.db #0xe9	; -23
      000F4B EE                    3927 	.db #0xee	; -18
      000F4C F4                    3928 	.db #0xf4	; -12
      000F4D 03                    3929 	.db #0x03	;  3
      000F4E D9                    3930 	.db #0xd9	; -39
      000F4F 00                    3931 	.db #0x00	;  0
      000F50 21                    3932 	.db #0x21	;  33
      000F51 0D                    3933 	.db #0x0d	;  13
      000F52 F6                    3934 	.db #0xf6	; -10
      000F53 00                    3935 	.db #0x00	;  0
      000F54 21                    3936 	.db #0x21	;  33
      000F55 E2                    3937 	.db #0xe2	; -30
      000F56 F7                    3938 	.db #0xf7	; -9
      000F57 EE                    3939 	.db #0xee	; -18
      000F58 F4                    3940 	.db #0xf4	; -12
      000F59 F0                    3941 	.db #0xf0	; -16
      000F5A 03                    3942 	.db #0x03	;  3
      000F5B 22                    3943 	.db #0x22	;  34
      000F5C 13                    3944 	.db #0x13	;  19
      000F5D 0E                    3945 	.db #0x0e	;  14
      000F5E FF                    3946 	.db #0xff	; -1
      000F5F EB                    3947 	.db #0xeb	; -21
      000F60 F5                    3948 	.db #0xf5	; -11
      000F61 00                    3949 	.db #0x00	;  0
      000F62 11                    3950 	.db #0x11	;  17
      000F63 EE                    3951 	.db #0xee	; -18
      000F64 D1                    3952 	.db #0xd1	; -47
      000F65 E9                    3953 	.db #0xe9	; -23
      000F66 FE                    3954 	.db #0xfe	; -2
      000F67 00                    3955 	.db #0x00	;  0
      000F68 FC                    3956 	.db #0xfc	; -4
      000F69 03                    3957 	.db #0x03	;  3
      000F6A 06                    3958 	.db #0x06	;  6
      000F6B FB                    3959 	.db #0xfb	; -5
      000F6C 02                    3960 	.db #0x02	;  2
      000F6D F5                    3961 	.db #0xf5	; -11
      000F6E FE                    3962 	.db #0xfe	; -2
      000F6F F0                    3963 	.db #0xf0	; -16
      000F70 25                    3964 	.db #0x25	;  37
      000F71 10                    3965 	.db #0x10	;  16
      000F72 F7                    3966 	.db #0xf7	; -9
      000F73 00                    3967 	.db #0x00	;  0
      000F74 1C                    3968 	.db #0x1c	;  28
      000F75 F7                    3969 	.db #0xf7	; -9
      000F76 F5                    3970 	.db #0xf5	; -11
      000F77 FF                    3971 	.db #0xff	; -1
      000F78 ED                    3972 	.db #0xed	; -19
      000F79 EC                    3973 	.db #0xec	; -20
      000F7A 14                    3974 	.db #0x14	;  20
      000F7B FC                    3975 	.db #0xfc	; -4
      000F7C 2C                    3976 	.db #0x2c	;  44
      000F7D 13                    3977 	.db #0x13	;  19
      000F7E ED                    3978 	.db #0xed	; -19
      000F7F F3                    3979 	.db #0xf3	; -13
      000F80 F6                    3980 	.db #0xf6	; -10
      000F81 00                    3981 	.db #0x00	;  0
      000F82 0F                    3982 	.db #0x0f	;  15
      000F83 E8                    3983 	.db #0xe8	; -24
      000F84 CF                    3984 	.db #0xcf	; -49
      000F85 F9                    3985 	.db #0xf9	; -7
      000F86 00                    3986 	.db #0x00	;  0
      000F87 00                    3987 	.db #0x00	;  0
      000F88 02                    3988 	.db #0x02	;  2
      000F89 F9                    3989 	.db #0xf9	; -7
      000F8A F4                    3990 	.db #0xf4	; -12
      000F8B EB                    3991 	.db #0xeb	; -21
      000F8C 08                    3992 	.db #0x08	;  8
      000F8D F4                    3993 	.db #0xf4	; -12
      000F8E F6                    3994 	.db #0xf6	; -10
      000F8F 0F                    3995 	.db #0x0f	;  15
      000F90 34                    3996 	.db #0x34	;  52	'4'
      000F91 09                    3997 	.db #0x09	;  9
      000F92 FE                    3998 	.db #0xfe	; -2
      000F93 00                    3999 	.db #0x00	;  0
      000F94 50                    4000 	.db #0x50	;  80	'P'
      000F95 EE                    4001 	.db #0xee	; -18
      000F96 FC                    4002 	.db #0xfc	; -4
      000F97 11                    4003 	.db #0x11	;  17
      000F98 02                    4004 	.db #0x02	;  2
      000F99 FC                    4005 	.db #0xfc	; -4
      000F9A FA                    4006 	.db #0xfa	; -6
      000F9B F2                    4007 	.db #0xf2	; -14
      000F9C FE                    4008 	.db #0xfe	; -2
      000F9D 14                    4009 	.db #0x14	;  20
      000F9E FD                    4010 	.db #0xfd	; -3
      000F9F 0D                    4011 	.db #0x0d	;  13
      000FA0 F1                    4012 	.db #0xf1	; -15
      000FA1 00                    4013 	.db #0x00	;  0
      000FA2 1B                    4014 	.db #0x1b	;  27
      000FA3 CB                    4015 	.db #0xcb	; -53
      000FA4 CC                    4016 	.db #0xcc	; -52
      000FA5 07                    4017 	.db #0x07	;  7
      000FA6 1D                    4018 	.db #0x1d	;  29
      000FA7 00                    4019 	.db #0x00	;  0
      000FA8 17                    4020 	.db #0x17	;  23
      000FA9 10                    4021 	.db #0x10	;  16
      000FAA E4                    4022 	.db #0xe4	; -28
      000FAB F8                    4023 	.db #0xf8	; -8
      000FAC F2                    4024 	.db #0xf2	; -14
      000FAD F8                    4025 	.db #0xf8	; -8
      000FAE FE                    4026 	.db #0xfe	; -2
      000FAF FE                    4027 	.db #0xfe	; -2
      000FB0 37                    4028 	.db #0x37	;  55	'7'
      000FB1 EE                    4029 	.db #0xee	; -18
      000FB2 1A                    4030 	.db #0x1a	;  26
      000FB3 00                    4031 	.db #0x00	;  0
      000FB4 31                    4032 	.db #0x31	;  49	'1'
      000FB5 08                    4033 	.db #0x08	;  8
      000FB6 0E                    4034 	.db #0x0e	;  14
      000FB7 0D                    4035 	.db #0x0d	;  13
      000FB8 14                    4036 	.db #0x14	;  20
      000FB9 FD                    4037 	.db #0xfd	; -3
      000FBA 0F                    4038 	.db #0x0f	;  15
      000FBB FF                    4039 	.db #0xff	; -1
      000FBC BB                    4040 	.db #0xbb	; -69
      000FBD 16                    4041 	.db #0x16	;  22
      000FBE F9                    4042 	.db #0xf9	; -7
      000FBF 0A                    4043 	.db #0x0a	;  10
      000FC0 F6                    4044 	.db #0xf6	; -10
      000FC1 00                    4045 	.db #0x00	;  0
      000FC2 1C                    4046 	.db #0x1c	;  28
      000FC3 E5                    4047 	.db #0xe5	; -27
      000FC4 E0                    4048 	.db #0xe0	; -32
      000FC5 31                    4049 	.db #0x31	;  49	'1'
      000FC6 1A                    4050 	.db #0x1a	;  26
      000FC7 00                    4051 	.db #0x00	;  0
      000FC8 05                    4052 	.db #0x05	;  5
      000FC9 04                    4053 	.db #0x04	;  4
      000FCA EA                    4054 	.db #0xea	; -22
      000FCB 07                    4055 	.db #0x07	;  7
      000FCC 0F                    4056 	.db #0x0f	;  15
      000FCD 00                    4057 	.db #0x00	;  0
      000FCE 06                    4058 	.db #0x06	;  6
      000FCF 16                    4059 	.db #0x16	;  22
      000FD0 E1                    4060 	.db #0xe1	; -31
      000FD1 0F                    4061 	.db #0x0f	;  15
      000FD2 10                    4062 	.db #0x10	;  16
      000FD3 00                    4063 	.db #0x00	;  0
      000FD4 E2                    4064 	.db #0xe2	; -30
      000FD5 0D                    4065 	.db #0x0d	;  13
      000FD6 07                    4066 	.db #0x07	;  7
      000FD7 F3                    4067 	.db #0xf3	; -13
      000FD8 04                    4068 	.db #0x04	;  4
      000FD9 0C                    4069 	.db #0x0c	;  12
      000FDA 0F                    4070 	.db #0x0f	;  15
      000FDB FF                    4071 	.db #0xff	; -1
      000FDC CD                    4072 	.db #0xcd	; -51
      000FDD EA                    4073 	.db #0xea	; -22
      000FDE 01                    4074 	.db #0x01	;  1
      000FDF 1D                    4075 	.db #0x1d	;  29
      000FE0 0B                    4076 	.db #0x0b	;  11
      000FE1 00                    4077 	.db #0x00	;  0
      000FE2 1D                    4078 	.db #0x1d	;  29
      000FE3 09                    4079 	.db #0x09	;  9
      000FE4 01                    4080 	.db #0x01	;  1
      000FE5 26                    4081 	.db #0x26	;  38
      000FE6 ED                    4082 	.db #0xed	; -19
      000FE7 00                    4083 	.db #0x00	;  0
      000FE8 16                    4084 	.db #0x16	;  22
      000FE9 04                    4085 	.db #0x04	;  4
      000FEA F5                    4086 	.db #0xf5	; -11
      000FEB EF                    4087 	.db #0xef	; -17
      000FEC 32                    4088 	.db #0x32	;  50	'2'
      000FED 0A                    4089 	.db #0x0a	;  10
      000FEE 05                    4090 	.db #0x05	;  5
      000FEF 17                    4091 	.db #0x17	;  23
      000FF0 C6                    4092 	.db #0xc6	; -58
      000FF1 03                    4093 	.db #0x03	;  3
      000FF2 DC                    4094 	.db #0xdc	; -36
      000FF3 00                    4095 	.db #0x00	;  0
      000FF4 F5                    4096 	.db #0xf5	; -11
      000FF5 DC                    4097 	.db #0xdc	; -36
      000FF6 00                    4098 	.db #0x00	;  0
      000FF7 D6                    4099 	.db #0xd6	; -42
      000FF8 0F                    4100 	.db #0x0f	;  15
      000FF9 21                    4101 	.db #0x21	;  33
      000FFA 02                    4102 	.db #0x02	;  2
      000FFB 0B                    4103 	.db #0x0b	;  11
      000FFC 10                    4104 	.db #0x10	;  16
      000FFD E2                    4105 	.db #0xe2	; -30
      000FFE 0A                    4106 	.db #0x0a	;  10
      000FFF FD                    4107 	.db #0xfd	; -3
      001000 13                    4108 	.db #0x13	;  19
      001001 00                    4109 	.db #0x00	;  0
      001002 09                    4110 	.db #0x09	;  9
      001003 06                    4111 	.db #0x06	;  6
      001004 04                    4112 	.db #0x04	;  4
      001005 29                    4113 	.db #0x29	;  41
      001006 FF                    4114 	.db #0xff	; -1
      001007 00                    4115 	.db #0x00	;  0
      001008 FE                    4116 	.db #0xfe	; -2
      001009 14                    4117 	.db #0x14	;  20
      00100A F4                    4118 	.db #0xf4	; -12
      00100B E5                    4119 	.db #0xe5	; -27
      00100C FF                    4120 	.db #0xff	; -1
      00100D 4B                    4121 	.db #0x4b	;  75	'K'
      00100E F1                    4122 	.db #0xf1	; -15
      00100F E8                    4123 	.db #0xe8	; -24
      001010 0E                    4124 	.db #0x0e	;  14
      001011 F4                    4125 	.db #0xf4	; -12
      001012 F2                    4126 	.db #0xf2	; -14
      001013 00                    4127 	.db #0x00	;  0
      001014 F2                    4128 	.db #0xf2	; -14
      001015 EC                    4129 	.db #0xec	; -20
      001016 FC                    4130 	.db #0xfc	; -4
      001017 D8                    4131 	.db #0xd8	; -40
      001018 EF                    4132 	.db #0xef	; -17
      001019 0C                    4133 	.db #0x0c	;  12
      00101A 04                    4134 	.db #0x04	;  4
      00101B 04                    4135 	.db #0x04	;  4
      00101C FA                    4136 	.db #0xfa	; -6
      00101D FD                    4137 	.db #0xfd	; -3
      00101E 0C                    4138 	.db #0x0c	;  12
      00101F DA                    4139 	.db #0xda	; -38
      001020 FE                    4140 	.db #0xfe	; -2
      001021 00                    4141 	.db #0x00	;  0
      001022 07                    4142 	.db #0x07	;  7
      001023 02                    4143 	.db #0x02	;  2
      001024 F0                    4144 	.db #0xf0	; -16
      001025 15                    4145 	.db #0x15	;  21
      001026 0E                    4146 	.db #0x0e	;  14
      001027 00                    4147 	.db #0x00	;  0
      001028 09                    4148 	.db #0x09	;  9
      001029 12                    4149 	.db #0x12	;  18
      00102A 01                    4150 	.db #0x01	;  1
      00102B F0                    4151 	.db #0xf0	; -16
      00102C E8                    4152 	.db #0xe8	; -24
      00102D 2E                    4153 	.db #0x2e	;  46
      00102E F4                    4154 	.db #0xf4	; -12
      00102F F1                    4155 	.db #0xf1	; -15
      001030 17                    4156 	.db #0x17	;  23
      001031 FA                    4157 	.db #0xfa	; -6
      001032 07                    4158 	.db #0x07	;  7
      001033 00                    4159 	.db #0x00	;  0
      001034 16                    4160 	.db #0x16	;  22
      001035 EF                    4161 	.db #0xef	; -17
      001036 E2                    4162 	.db #0xe2	; -30
      001037 00                    4163 	.db #0x00	;  0
      001038 D3                    4164 	.db #0xd3	; -45
      001039 17                    4165 	.db #0x17	;  23
      00103A F5                    4166 	.db #0xf5	; -11
      00103B 07                    4167 	.db #0x07	;  7
      00103C 02                    4168 	.db #0x02	;  2
      00103D F4                    4169 	.db #0xf4	; -12
      00103E 0E                    4170 	.db #0x0e	;  14
      00103F FA                    4171 	.db #0xfa	; -6
      001040 D7                    4172 	.db #0xd7	; -41
      001041 00                    4173 	.db #0x00	;  0
      001042 F5                    4174 	.db #0xf5	; -11
      001043 F1                    4175 	.db #0xf1	; -15
      001044 F9                    4176 	.db #0xf9	; -7
      001045 F0                    4177 	.db #0xf0	; -16
      001046 10                    4178 	.db #0x10	;  16
      001047 00                    4179 	.db #0x00	;  0
      001048 1B                    4180 	.db #0x1b	;  27
      001049 F0                    4181 	.db #0xf0	; -16
      00104A F1                    4182 	.db #0xf1	; -15
      00104B F7                    4183 	.db #0xf7	; -9
      00104C DA                    4184 	.db #0xda	; -38
      00104D F2                    4185 	.db #0xf2	; -14
      00104E F5                    4186 	.db #0xf5	; -11
      00104F 0F                    4187 	.db #0x0f	;  15
      001050 01                    4188 	.db #0x01	;  1
      001051 F5                    4189 	.db #0xf5	; -11
      001052 EB                    4190 	.db #0xeb	; -21
      001053 00                    4191 	.db #0x00	;  0
      001054 11                    4192 	.db #0x11	;  17
      001055 DB                    4193 	.db #0xdb	; -37
      001056 C8                    4194 	.db #0xc8	; -56
      001057 06                    4195 	.db #0x06	;  6
      001058 D6                    4196 	.db #0xd6	; -42
      001059 1D                    4197 	.db #0x1d	;  29
      00105A 2D                    4198 	.db #0x2d	;  45
      00105B 17                    4199 	.db #0x17	;  23
      00105C 26                    4200 	.db #0x26	;  38
      00105D E2                    4201 	.db #0xe2	; -30
      00105E 08                    4202 	.db #0x08	;  8
      00105F 16                    4203 	.db #0x16	;  22
      001060 E7                    4204 	.db #0xe7	; -25
      001061 00                    4205 	.db #0x00	;  0
      001062 09                    4206 	.db #0x09	;  9
      001063 F2                    4207 	.db #0xf2	; -14
      001064 01                    4208 	.db #0x01	;  1
      001065 EF                    4209 	.db #0xef	; -17
      001066 11                    4210 	.db #0x11	;  17
      001067 00                    4211 	.db #0x00	;  0
      001068 1C                    4212 	.db #0x1c	;  28
      001069 DF                    4213 	.db #0xdf	; -33
      00106A FE                    4214 	.db #0xfe	; -2
      00106B 0E                    4215 	.db #0x0e	;  14
      00106C ED                    4216 	.db #0xed	; -19
      00106D EB                    4217 	.db #0xeb	; -21
      00106E 1D                    4218 	.db #0x1d	;  29
      00106F 03                    4219 	.db #0x03	;  3
      001070 EC                    4220 	.db #0xec	; -20
      001071 0D                    4221 	.db #0x0d	;  13
      001072 F4                    4222 	.db #0xf4	; -12
      001073 00                    4223 	.db #0x00	;  0
      001074 19                    4224 	.db #0x19	;  25
      001075 E2                    4225 	.db #0xe2	; -30
      001076 CD                    4226 	.db #0xcd	; -51
      001077 00                    4227 	.db #0x00	;  0
      001078 E8                    4228 	.db #0xe8	; -24
      001079 2B                    4229 	.db #0x2b	;  43
      00107A 29                    4230 	.db #0x29	;  41
      00107B F7                    4231 	.db #0xf7	; -9
      00107C 10                    4232 	.db #0x10	;  16
      00107D 06                    4233 	.db #0x06	;  6
      00107E 0D                    4234 	.db #0x0d	;  13
      00107F 0D                    4235 	.db #0x0d	;  13
      001080 01                    4236 	.db #0x01	;  1
      001081 00                    4237 	.db #0x00	;  0
      001082 F4                    4238 	.db #0xf4	; -12
      001083 F2                    4239 	.db #0xf2	; -14
      001084 00                    4240 	.db #0x00	;  0
      001085 F0                    4241 	.db #0xf0	; -16
      001086 03                    4242 	.db #0x03	;  3
      001087 00                    4243 	.db #0x00	;  0
      001088 18                    4244 	.db #0x18	;  24
      001089 F3                    4245 	.db #0xf3	; -13
      00108A FF                    4246 	.db #0xff	; -1
      00108B 09                    4247 	.db #0x09	;  9
      00108C F1                    4248 	.db #0xf1	; -15
      00108D F5                    4249 	.db #0xf5	; -11
      00108E 16                    4250 	.db #0x16	;  22
      00108F 0A                    4251 	.db #0x0a	;  10
      001090 F3                    4252 	.db #0xf3	; -13
      001091 FE                    4253 	.db #0xfe	; -2
      001092 F6                    4254 	.db #0xf6	; -10
      001093 00                    4255 	.db #0x00	;  0
      001094 F6                    4256 	.db #0xf6	; -10
      001095 03                    4257 	.db #0x03	;  3
      001096 EA                    4258 	.db #0xea	; -22
      001097 F1                    4259 	.db #0xf1	; -15
      001098 07                    4260 	.db #0x07	;  7
      001099 1F                    4261 	.db #0x1f	;  31
      00109A FC                    4262 	.db #0xfc	; -4
      00109B 00                    4263 	.db #0x00	;  0
      00109C FD                    4264 	.db #0xfd	; -3
      00109D 00                    4265 	.db #0x00	;  0
      00109E 00                    4266 	.db #0x00	;  0
      00109F 00                    4267 	.db #0x00	;  0
      0010A0 00                    4268 	.db #0x00	;  0
      0010A1 00                    4269 	.db #0x00	;  0
      0010A2 00                    4270 	.db #0x00	;  0
      0010A3 FF                    4271 	.db #0xff	; -1
      0010A4 00                    4272 	.db #0x00	;  0
      0010A5 00                    4273 	.db #0x00	;  0
      0010A6 FD                    4274 	.db #0xfd	; -3
      0010A7 00                    4275 	.db #0x00	;  0
      0010A8 00                    4276 	.db #0x00	;  0
      0010A9 FE                    4277 	.db #0xfe	; -2
      0010AA 00                    4278 	.db #0x00	;  0
      0010AB FF                    4279 	.db #0xff	; -1
      0010AC 00                    4280 	.db #0x00	;  0
      0010AD 00                    4281 	.db #0x00	;  0
      0010AE 03                    4282 	.db #0x03	;  3
      0010AF 00                    4283 	.db #0x00	;  0
      0010B0 00                    4284 	.db #0x00	;  0
      0010B1 00                    4285 	.db #0x00	;  0
      0010B2 02                    4286 	.db #0x02	;  2
      0010B3 00                    4287 	.db #0x00	;  0
      0010B4 00                    4288 	.db #0x00	;  0
      0010B5 03                    4289 	.db #0x03	;  3
      0010B6 FE                    4290 	.db #0xfe	; -2
      0010B7 00                    4291 	.db #0x00	;  0
      0010B8 00                    4292 	.db #0x00	;  0
      0010B9 01                    4293 	.db #0x01	;  1
      0010BA 02                    4294 	.db #0x02	;  2
      0010BB 00                    4295 	.db #0x00	;  0
      0010BC 00                    4296 	.db #0x00	;  0
      0010BD 00                    4297 	.db #0x00	;  0
      0010BE 00                    4298 	.db #0x00	;  0
      0010BF 00                    4299 	.db #0x00	;  0
      0010C0 00                    4300 	.db #0x00	;  0
      0010C1 00                    4301 	.db #0x00	;  0
      0010C2 00                    4302 	.db #0x00	;  0
      0010C3 00                    4303 	.db #0x00	;  0
      0010C4 00                    4304 	.db #0x00	;  0
      0010C5 00                    4305 	.db #0x00	;  0
      0010C6 00                    4306 	.db #0x00	;  0
      0010C7 00                    4307 	.db #0x00	;  0
      0010C8 00                    4308 	.db #0x00	;  0
      0010C9 00                    4309 	.db #0x00	;  0
      0010CA 00                    4310 	.db #0x00	;  0
      0010CB 00                    4311 	.db #0x00	;  0
      0010CC 00                    4312 	.db #0x00	;  0
      0010CD 00                    4313 	.db #0x00	;  0
      0010CE 00                    4314 	.db #0x00	;  0
      0010CF 00                    4315 	.db #0x00	;  0
      0010D0 00                    4316 	.db #0x00	;  0
      0010D1 00                    4317 	.db #0x00	;  0
      0010D2 00                    4318 	.db #0x00	;  0
      0010D3 00                    4319 	.db #0x00	;  0
      0010D4 00                    4320 	.db #0x00	;  0
      0010D5 00                    4321 	.db #0x00	;  0
      0010D6 00                    4322 	.db #0x00	;  0
      0010D7 00                    4323 	.db #0x00	;  0
      0010D8 00                    4324 	.db #0x00	;  0
      0010D9 00                    4325 	.db #0x00	;  0
      0010DA 00                    4326 	.db #0x00	;  0
      0010DB 0A                    4327 	.db #0x0a	;  10
      0010DC FE                    4328 	.db #0xfe	; -2
      0010DD 00                    4329 	.db #0x00	;  0
      0010DE 08                    4330 	.db #0x08	;  8
      0010DF 01                    4331 	.db #0x01	;  1
      0010E0 00                    4332 	.db #0x00	;  0
      0010E1 00                    4333 	.db #0x00	;  0
      0010E2 FB                    4334 	.db #0xfb	; -5
      0010E3 FF                    4335 	.db #0xff	; -1
      0010E4 EF                    4336 	.db #0xef	; -17
      0010E5 FE                    4337 	.db #0xfe	; -2
      0010E6 FD                    4338 	.db #0xfd	; -3
      0010E7 00                    4339 	.db #0x00	;  0
      0010E8 02                    4340 	.db #0x02	;  2
      0010E9 03                    4341 	.db #0x03	;  3
      0010EA 03                    4342 	.db #0x03	;  3
      0010EB FC                    4343 	.db #0xfc	; -4
      0010EC FF                    4344 	.db #0xff	; -1
      0010ED 00                    4345 	.db #0x00	;  0
      0010EE FF                    4346 	.db #0xff	; -1
      0010EF 01                    4347 	.db #0x01	;  1
      0010F0 FF                    4348 	.db #0xff	; -1
      0010F1 03                    4349 	.db #0x03	;  3
      0010F2 FC                    4350 	.db #0xfc	; -4
      0010F3 00                    4351 	.db #0x00	;  0
      0010F4 03                    4352 	.db #0x03	;  3
      0010F5 FF                    4353 	.db #0xff	; -1
      0010F6 FF                    4354 	.db #0xff	; -1
      0010F7 FD                    4355 	.db #0xfd	; -3
      0010F8 02                    4356 	.db #0x02	;  2
      0010F9 00                    4357 	.db #0x00	;  0
      0010FA 04                    4358 	.db #0x04	;  4
      0010FB 0C                    4359 	.db #0x0c	;  12
      0010FC 18                    4360 	.db #0x18	;  24
      0010FD FD                    4361 	.db #0xfd	; -3
      0010FE FC                    4362 	.db #0xfc	; -4
      0010FF 0C                    4363 	.db #0x0c	;  12
      001100 E9                    4364 	.db #0xe9	; -23
      001101 00                    4365 	.db #0x00	;  0
      001102 EB                    4366 	.db #0xeb	; -21
      001103 E3                    4367 	.db #0xe3	; -29
      001104 D5                    4368 	.db #0xd5	; -43
      001105 00                    4369 	.db #0x00	;  0
      001106 09                    4370 	.db #0x09	;  9
      001107 00                    4371 	.db #0x00	;  0
      001108 0A                    4372 	.db #0x0a	;  10
      001109 F9                    4373 	.db #0xf9	; -7
      00110A F6                    4374 	.db #0xf6	; -10
      00110B FF                    4375 	.db #0xff	; -1
      00110C 0A                    4376 	.db #0x0a	;  10
      00110D FD                    4377 	.db #0xfd	; -3
      00110E 08                    4378 	.db #0x08	;  8
      00110F F8                    4379 	.db #0xf8	; -8
      001110 01                    4380 	.db #0x01	;  1
      001111 10                    4381 	.db #0x10	;  16
      001112 F7                    4382 	.db #0xf7	; -9
      001113 00                    4383 	.db #0x00	;  0
      001114 0E                    4384 	.db #0x0e	;  14
      001115 03                    4385 	.db #0x03	;  3
      001116 FA                    4386 	.db #0xfa	; -6
      001117 05                    4387 	.db #0x05	;  5
      001118 FD                    4388 	.db #0xfd	; -3
      001119 EC                    4389 	.db #0xec	; -20
      00111A 02                    4390 	.db #0x02	;  2
      00111B F3                    4391 	.db #0xf3	; -13
      00111C 20                    4392 	.db #0x20	;  32
      00111D F8                    4393 	.db #0xf8	; -8
      00111E 02                    4394 	.db #0x02	;  2
      00111F F4                    4395 	.db #0xf4	; -12
      001120 E8                    4396 	.db #0xe8	; -24
      001121 00                    4397 	.db #0x00	;  0
      001122 E7                    4398 	.db #0xe7	; -25
      001123 FA                    4399 	.db #0xfa	; -6
      001124 A2                    4400 	.db #0xa2	; -94
      001125 DC                    4401 	.db #0xdc	; -36
      001126 0E                    4402 	.db #0x0e	;  14
      001127 00                    4403 	.db #0x00	;  0
      001128 20                    4404 	.db #0x20	;  32
      001129 DD                    4405 	.db #0xdd	; -35
      00112A EE                    4406 	.db #0xee	; -18
      00112B FB                    4407 	.db #0xfb	; -5
      00112C E9                    4408 	.db #0xe9	; -23
      00112D E8                    4409 	.db #0xe8	; -24
      00112E 03                    4410 	.db #0x03	;  3
      00112F F1                    4411 	.db #0xf1	; -15
      001130 06                    4412 	.db #0x06	;  6
      001131 F3                    4413 	.db #0xf3	; -13
      001132 0A                    4414 	.db #0x0a	;  10
      001133 00                    4415 	.db #0x00	;  0
      001134 27                    4416 	.db #0x27	;  39
      001135 0C                    4417 	.db #0x0c	;  12
      001136 04                    4418 	.db #0x04	;  4
      001137 0C                    4419 	.db #0x0c	;  12
      001138 E9                    4420 	.db #0xe9	; -23
      001139 04                    4421 	.db #0x04	;  4
      00113A 07                    4422 	.db #0x07	;  7
      00113B FE                    4423 	.db #0xfe	; -2
      00113C 16                    4424 	.db #0x16	;  22
      00113D FB                    4425 	.db #0xfb	; -5
      00113E FB                    4426 	.db #0xfb	; -5
      00113F 11                    4427 	.db #0x11	;  17
      001140 F3                    4428 	.db #0xf3	; -13
      001141 00                    4429 	.db #0x00	;  0
      001142 EE                    4430 	.db #0xee	; -18
      001143 FB                    4431 	.db #0xfb	; -5
      001144 AF                    4432 	.db #0xaf	; -81
      001145 B4                    4433 	.db #0xb4	; -76
      001146 EC                    4434 	.db #0xec	; -20
      001147 00                    4435 	.db #0x00	;  0
      001148 25                    4436 	.db #0x25	;  37
      001149 05                    4437 	.db #0x05	;  5
      00114A FD                    4438 	.db #0xfd	; -3
      00114B FE                    4439 	.db #0xfe	; -2
      00114C F7                    4440 	.db #0xf7	; -9
      00114D F5                    4441 	.db #0xf5	; -11
      00114E 0C                    4442 	.db #0x0c	;  12
      00114F FA                    4443 	.db #0xfa	; -6
      001150 F2                    4444 	.db #0xf2	; -14
      001151 09                    4445 	.db #0x09	;  9
      001152 07                    4446 	.db #0x07	;  7
      001153 00                    4447 	.db #0x00	;  0
      001154 13                    4448 	.db #0x13	;  19
      001155 10                    4449 	.db #0x10	;  16
      001156 01                    4450 	.db #0x01	;  1
      001157 E6                    4451 	.db #0xe6	; -26
      001158 F2                    4452 	.db #0xf2	; -14
      001159 08                    4453 	.db #0x08	;  8
      00115A F2                    4454 	.db #0xf2	; -14
      00115B EA                    4455 	.db #0xea	; -22
      00115C E6                    4456 	.db #0xe6	; -26
      00115D 0B                    4457 	.db #0x0b	;  11
      00115E FF                    4458 	.db #0xff	; -1
      00115F 0A                    4459 	.db #0x0a	;  10
      001160 EB                    4460 	.db #0xeb	; -21
      001161 00                    4461 	.db #0x00	;  0
      001162 16                    4462 	.db #0x16	;  22
      001163 EE                    4463 	.db #0xee	; -18
      001164 E1                    4464 	.db #0xe1	; -31
      001165 B1                    4465 	.db #0xb1	; -79
      001166 03                    4466 	.db #0x03	;  3
      001167 00                    4467 	.db #0x00	;  0
      001168 35                    4468 	.db #0x35	;  53	'5'
      001169 11                    4469 	.db #0x11	;  17
      00116A F4                    4470 	.db #0xf4	; -12
      00116B 17                    4471 	.db #0x17	;  23
      00116C 05                    4472 	.db #0x05	;  5
      00116D 11                    4473 	.db #0x11	;  17
      00116E 20                    4474 	.db #0x20	;  32
      00116F F8                    4475 	.db #0xf8	; -8
      001170 DC                    4476 	.db #0xdc	; -36
      001171 F9                    4477 	.db #0xf9	; -7
      001172 16                    4478 	.db #0x16	;  22
      001173 00                    4479 	.db #0x00	;  0
      001174 28                    4480 	.db #0x28	;  40
      001175 1B                    4481 	.db #0x1b	;  27
      001176 06                    4482 	.db #0x06	;  6
      001177 F1                    4483 	.db #0xf1	; -15
      001178 FC                    4484 	.db #0xfc	; -4
      001179 10                    4485 	.db #0x10	;  16
      00117A F1                    4486 	.db #0xf1	; -15
      00117B F8                    4487 	.db #0xf8	; -8
      00117C CF                    4488 	.db #0xcf	; -49
      00117D 1B                    4489 	.db #0x1b	;  27
      00117E 0D                    4490 	.db #0x0d	;  13
      00117F 06                    4491 	.db #0x06	;  6
      001180 FB                    4492 	.db #0xfb	; -5
      001181 00                    4493 	.db #0x00	;  0
      001182 35                    4494 	.db #0x35	;  53	'5'
      001183 FE                    4495 	.db #0xfe	; -2
      001184 16                    4496 	.db #0x16	;  22
      001185 CB                    4497 	.db #0xcb	; -53
      001186 FB                    4498 	.db #0xfb	; -5
      001187 00                    4499 	.db #0x00	;  0
      001188 21                    4500 	.db #0x21	;  33
      001189 F5                    4501 	.db #0xf5	; -11
      00118A E5                    4502 	.db #0xe5	; -27
      00118B EB                    4503 	.db #0xeb	; -21
      00118C 1A                    4504 	.db #0x1a	;  26
      00118D 25                    4505 	.db #0x25	;  37
      00118E 0C                    4506 	.db #0x0c	;  12
      00118F 13                    4507 	.db #0x13	;  19
      001190 9E                    4508 	.db #0x9e	; -98
      001191 08                    4509 	.db #0x08	;  8
      001192 FE                    4510 	.db #0xfe	; -2
      001193 00                    4511 	.db #0x00	;  0
      001194 0F                    4512 	.db #0x0f	;  15
      001195 20                    4513 	.db #0x20	;  32
      001196 08                    4514 	.db #0x08	;  8
      001197 FA                    4515 	.db #0xfa	; -6
      001198 0A                    4516 	.db #0x0a	;  10
      001199 17                    4517 	.db #0x17	;  23
      00119A 10                    4518 	.db #0x10	;  16
      00119B F3                    4519 	.db #0xf3	; -13
      00119C DB                    4520 	.db #0xdb	; -37
      00119D 02                    4521 	.db #0x02	;  2
      00119E 14                    4522 	.db #0x14	;  20
      00119F 1D                    4523 	.db #0x1d	;  29
      0011A0 FE                    4524 	.db #0xfe	; -2
      0011A1 00                    4525 	.db #0x00	;  0
      0011A2 14                    4526 	.db #0x14	;  20
      0011A3 05                    4527 	.db #0x05	;  5
      0011A4 0D                    4528 	.db #0x0d	;  13
      0011A5 E4                    4529 	.db #0xe4	; -28
      0011A6 ED                    4530 	.db #0xed	; -19
      0011A7 00                    4531 	.db #0x00	;  0
      0011A8 16                    4532 	.db #0x16	;  22
      0011A9 F7                    4533 	.db #0xf7	; -9
      0011AA EC                    4534 	.db #0xec	; -20
      0011AB F0                    4535 	.db #0xf0	; -16
      0011AC FD                    4536 	.db #0xfd	; -3
      0011AD 2B                    4537 	.db #0x2b	;  43
      0011AE F4                    4538 	.db #0xf4	; -12
      0011AF 18                    4539 	.db #0x18	;  24
      0011B0 E7                    4540 	.db #0xe7	; -25
      0011B1 F0                    4541 	.db #0xf0	; -16
      0011B2 E2                    4542 	.db #0xe2	; -30
      0011B3 00                    4543 	.db #0x00	;  0
      0011B4 ED                    4544 	.db #0xed	; -19
      0011B5 FD                    4545 	.db #0xfd	; -3
      0011B6 07                    4546 	.db #0x07	;  7
      0011B7 EC                    4547 	.db #0xec	; -20
      0011B8 18                    4548 	.db #0x18	;  24
      0011B9 21                    4549 	.db #0x21	;  33
      0011BA 27                    4550 	.db #0x27	;  39
      0011BB F4                    4551 	.db #0xf4	; -12
      0011BC FB                    4552 	.db #0xfb	; -5
      0011BD D8                    4553 	.db #0xd8	; -40
      0011BE 05                    4554 	.db #0x05	;  5
      0011BF 04                    4555 	.db #0x04	;  4
      0011C0 05                    4556 	.db #0x05	;  5
      0011C1 00                    4557 	.db #0x00	;  0
      0011C2 07                    4558 	.db #0x07	;  7
      0011C3 13                    4559 	.db #0x13	;  19
      0011C4 09                    4560 	.db #0x09	;  9
      0011C5 0D                    4561 	.db #0x0d	;  13
      0011C6 F1                    4562 	.db #0xf1	; -15
      0011C7 00                    4563 	.db #0x00	;  0
      0011C8 0E                    4564 	.db #0x0e	;  14
      0011C9 1A                    4565 	.db #0x1a	;  26
      0011CA ED                    4566 	.db #0xed	; -19
      0011CB F3                    4567 	.db #0xf3	; -13
      0011CC F4                    4568 	.db #0xf4	; -12
      0011CD 1C                    4569 	.db #0x1c	;  28
      0011CE FA                    4570 	.db #0xfa	; -6
      0011CF F8                    4571 	.db #0xf8	; -8
      0011D0 FB                    4572 	.db #0xfb	; -5
      0011D1 FB                    4573 	.db #0xfb	; -5
      0011D2 F3                    4574 	.db #0xf3	; -13
      0011D3 00                    4575 	.db #0x00	;  0
      0011D4 01                    4576 	.db #0x01	;  1
      0011D5 09                    4577 	.db #0x09	;  9
      0011D6 16                    4578 	.db #0x16	;  22
      0011D7 EF                    4579 	.db #0xef	; -17
      0011D8 E5                    4580 	.db #0xe5	; -27
      0011D9 01                    4581 	.db #0x01	;  1
      0011DA 28                    4582 	.db #0x28	;  40
      0011DB 02                    4583 	.db #0x02	;  2
      0011DC F7                    4584 	.db #0xf7	; -9
      0011DD CC                    4585 	.db #0xcc	; -52
      0011DE 06                    4586 	.db #0x06	;  6
      0011DF 0B                    4587 	.db #0x0b	;  11
      0011E0 CC                    4588 	.db #0xcc	; -52
      0011E1 00                    4589 	.db #0x00	;  0
      0011E2 F8                    4590 	.db #0xf8	; -8
      0011E3 15                    4591 	.db #0x15	;  21
      0011E4 10                    4592 	.db #0x10	;  16
      0011E5 0D                    4593 	.db #0x0d	;  13
      0011E6 0E                    4594 	.db #0x0e	;  14
      0011E7 00                    4595 	.db #0x00	;  0
      0011E8 17                    4596 	.db #0x17	;  23
      0011E9 11                    4597 	.db #0x11	;  17
      0011EA F9                    4598 	.db #0xf9	; -7
      0011EB FF                    4599 	.db #0xff	; -1
      0011EC E7                    4600 	.db #0xe7	; -25
      0011ED E6                    4601 	.db #0xe6	; -26
      0011EE 03                    4602 	.db #0x03	;  3
      0011EF 00                    4603 	.db #0x00	;  0
      0011F0 FA                    4604 	.db #0xfa	; -6
      0011F1 F8                    4605 	.db #0xf8	; -8
      0011F2 F8                    4606 	.db #0xf8	; -8
      0011F3 00                    4607 	.db #0x00	;  0
      0011F4 1A                    4608 	.db #0x1a	;  26
      0011F5 F7                    4609 	.db #0xf7	; -9
      0011F6 13                    4610 	.db #0x13	;  19
      0011F7 FE                    4611 	.db #0xfe	; -2
      0011F8 E1                    4612 	.db #0xe1	; -31
      0011F9 13                    4613 	.db #0x13	;  19
      0011FA F4                    4614 	.db #0xf4	; -12
      0011FB FA                    4615 	.db #0xfa	; -6
      0011FC 1D                    4616 	.db #0x1d	;  29
      0011FD DD                    4617 	.db #0xdd	; -35
      0011FE 0F                    4618 	.db #0x0f	;  15
      0011FF 0C                    4619 	.db #0x0c	;  12
      001200 D6                    4620 	.db #0xd6	; -42
      001201 00                    4621 	.db #0x00	;  0
      001202 E9                    4622 	.db #0xe9	; -23
      001203 0B                    4623 	.db #0x0b	;  11
      001204 01                    4624 	.db #0x01	;  1
      001205 31                    4625 	.db #0x31	;  49	'1'
      001206 0C                    4626 	.db #0x0c	;  12
      001207 00                    4627 	.db #0x00	;  0
      001208 0D                    4628 	.db #0x0d	;  13
      001209 0D                    4629 	.db #0x0d	;  13
      00120A 07                    4630 	.db #0x07	;  7
      00120B 02                    4631 	.db #0x02	;  2
      00120C F1                    4632 	.db #0xf1	; -15
      00120D E3                    4633 	.db #0xe3	; -29
      00120E 0D                    4634 	.db #0x0d	;  13
      00120F 13                    4635 	.db #0x13	;  19
      001210 EE                    4636 	.db #0xee	; -18
      001211 ED                    4637 	.db #0xed	; -19
      001212 07                    4638 	.db #0x07	;  7
      001213 00                    4639 	.db #0x00	;  0
      001214 0C                    4640 	.db #0x0c	;  12
      001215 E6                    4641 	.db #0xe6	; -26
      001216 05                    4642 	.db #0x05	;  5
      001217 10                    4643 	.db #0x10	;  16
      001218 DE                    4644 	.db #0xde	; -34
      001219 28                    4645 	.db #0x28	;  40
      00121A FB                    4646 	.db #0xfb	; -5
      00121B 00                    4647 	.db #0x00	;  0
      00121C 27                    4648 	.db #0x27	;  39
      00121D F7                    4649 	.db #0xf7	; -9
      00121E 05                    4650 	.db #0x05	;  5
      00121F 1B                    4651 	.db #0x1b	;  27
      001220 E5                    4652 	.db #0xe5	; -27
      001221 00                    4653 	.db #0x00	;  0
      001222 00                    4654 	.db #0x00	;  0
      001223 E9                    4655 	.db #0xe9	; -23
      001224 F8                    4656 	.db #0xf8	; -8
      001225 09                    4657 	.db #0x09	;  9
      001226 08                    4658 	.db #0x08	;  8
      001227 00                    4659 	.db #0x00	;  0
      001228 0E                    4660 	.db #0x0e	;  14
      001229 F0                    4661 	.db #0xf0	; -16
      00122A 04                    4662 	.db #0x04	;  4
      00122B 02                    4663 	.db #0x02	;  2
      00122C F6                    4664 	.db #0xf6	; -10
      00122D FF                    4665 	.db #0xff	; -1
      00122E 08                    4666 	.db #0x08	;  8
      00122F 04                    4667 	.db #0x04	;  4
      001230 F5                    4668 	.db #0xf5	; -11
      001231 FB                    4669 	.db #0xfb	; -5
      001232 17                    4670 	.db #0x17	;  23
      001233 00                    4671 	.db #0x00	;  0
      001234 07                    4672 	.db #0x07	;  7
      001235 08                    4673 	.db #0x08	;  8
      001236 EC                    4674 	.db #0xec	; -20
      001237 E9                    4675 	.db #0xe9	; -23
      001238 E9                    4676 	.db #0xe9	; -23
      001239 2E                    4677 	.db #0x2e	;  46
      00123A F0                    4678 	.db #0xf0	; -16
      00123B 02                    4679 	.db #0x02	;  2
      00123C 01                    4680 	.db #0x01	;  1
      00123D 20                    4681 	.db #0x20	;  32
      00123E F8                    4682 	.db #0xf8	; -8
      00123F FD                    4683 	.db #0xfd	; -3
      001240 FB                    4684 	.db #0xfb	; -5
      001241 00                    4685 	.db #0x00	;  0
      001242 FD                    4686 	.db #0xfd	; -3
      001243 F4                    4687 	.db #0xf4	; -12
      001244 04                    4688 	.db #0x04	;  4
      001245 11                    4689 	.db #0x11	;  17
      001246 FE                    4690 	.db #0xfe	; -2
      001247 00                    4691 	.db #0x00	;  0
      001248 10                    4692 	.db #0x10	;  16
      001249 EB                    4693 	.db #0xeb	; -21
      00124A FB                    4694 	.db #0xfb	; -5
      00124B 19                    4695 	.db #0x19	;  25
      00124C FA                    4696 	.db #0xfa	; -6
      00124D F0                    4697 	.db #0xf0	; -16
      00124E 0D                    4698 	.db #0x0d	;  13
      00124F 0C                    4699 	.db #0x0c	;  12
      001250 EC                    4700 	.db #0xec	; -20
      001251 0B                    4701 	.db #0x0b	;  11
      001252 14                    4702 	.db #0x14	;  20
      001253 00                    4703 	.db #0x00	;  0
      001254 EF                    4704 	.db #0xef	; -17
      001255 1F                    4705 	.db #0x1f	;  31
      001256 EB                    4706 	.db #0xeb	; -21
      001257 F4                    4707 	.db #0xf4	; -12
      001258 FE                    4708 	.db #0xfe	; -2
      001259 0D                    4709 	.db #0x0d	;  13
      00125A FF                    4710 	.db #0xff	; -1
      00125B 00                    4711 	.db #0x00	;  0
      00125C 00                    4712 	.db #0x00	;  0
      00125D 00                    4713 	.db #0x00	;  0
      00125E 00                    4714 	.db #0x00	;  0
      00125F 00                    4715 	.db #0x00	;  0
      001260 00                    4716 	.db #0x00	;  0
      001261 00                    4717 	.db #0x00	;  0
      001262 00                    4718 	.db #0x00	;  0
      001263 00                    4719 	.db #0x00	;  0
      001264 00                    4720 	.db #0x00	;  0
      001265 00                    4721 	.db #0x00	;  0
      001266 00                    4722 	.db #0x00	;  0
      001267 00                    4723 	.db #0x00	;  0
      001268 00                    4724 	.db #0x00	;  0
      001269 00                    4725 	.db #0x00	;  0
      00126A 00                    4726 	.db #0x00	;  0
      00126B 00                    4727 	.db #0x00	;  0
      00126C 00                    4728 	.db #0x00	;  0
      00126D 00                    4729 	.db #0x00	;  0
      00126E 00                    4730 	.db #0x00	;  0
      00126F 00                    4731 	.db #0x00	;  0
      001270 00                    4732 	.db #0x00	;  0
      001271 00                    4733 	.db #0x00	;  0
      001272 00                    4734 	.db #0x00	;  0
      001273 00                    4735 	.db #0x00	;  0
      001274 00                    4736 	.db #0x00	;  0
      001275 00                    4737 	.db #0x00	;  0
      001276 00                    4738 	.db #0x00	;  0
      001277 00                    4739 	.db #0x00	;  0
      001278 00                    4740 	.db #0x00	;  0
      001279 00                    4741 	.db #0x00	;  0
      00127A 00                    4742 	.db #0x00	;  0
      00127B 00                    4743 	.db #0x00	;  0
      00127C 00                    4744 	.db #0x00	;  0
      00127D 00                    4745 	.db #0x00	;  0
      00127E 00                    4746 	.db #0x00	;  0
      00127F 00                    4747 	.db #0x00	;  0
      001280 00                    4748 	.db #0x00	;  0
      001281 00                    4749 	.db #0x00	;  0
      001282 00                    4750 	.db #0x00	;  0
      001283 00                    4751 	.db #0x00	;  0
      001284 00                    4752 	.db #0x00	;  0
      001285 00                    4753 	.db #0x00	;  0
      001286 00                    4754 	.db #0x00	;  0
      001287 00                    4755 	.db #0x00	;  0
      001288 00                    4756 	.db #0x00	;  0
      001289 00                    4757 	.db #0x00	;  0
      00128A 00                    4758 	.db #0x00	;  0
      00128B 00                    4759 	.db #0x00	;  0
      00128C 00                    4760 	.db #0x00	;  0
      00128D 00                    4761 	.db #0x00	;  0
      00128E 00                    4762 	.db #0x00	;  0
      00128F 00                    4763 	.db #0x00	;  0
      001290 00                    4764 	.db #0x00	;  0
      001291 00                    4765 	.db #0x00	;  0
      001292 00                    4766 	.db #0x00	;  0
      001293 00                    4767 	.db #0x00	;  0
      001294 00                    4768 	.db #0x00	;  0
      001295 00                    4769 	.db #0x00	;  0
      001296 00                    4770 	.db #0x00	;  0
      001297 00                    4771 	.db #0x00	;  0
      001298 00                    4772 	.db #0x00	;  0
      001299 00                    4773 	.db #0x00	;  0
      00129A 00                    4774 	.db #0x00	;  0
      00129B 03                    4775 	.db #0x03	;  3
      00129C FE                    4776 	.db #0xfe	; -2
      00129D 04                    4777 	.db #0x04	;  4
      00129E FB                    4778 	.db #0xfb	; -5
      00129F 00                    4779 	.db #0x00	;  0
      0012A0 FF                    4780 	.db #0xff	; -1
      0012A1 00                    4781 	.db #0x00	;  0
      0012A2 02                    4782 	.db #0x02	;  2
      0012A3 05                    4783 	.db #0x05	;  5
      0012A4 FA                    4784 	.db #0xfa	; -6
      0012A5 0D                    4785 	.db #0x0d	;  13
      0012A6 FC                    4786 	.db #0xfc	; -4
      0012A7 00                    4787 	.db #0x00	;  0
      0012A8 04                    4788 	.db #0x04	;  4
      0012A9 FD                    4789 	.db #0xfd	; -3
      0012AA FE                    4790 	.db #0xfe	; -2
      0012AB FE                    4791 	.db #0xfe	; -2
      0012AC FC                    4792 	.db #0xfc	; -4
      0012AD 06                    4793 	.db #0x06	;  6
      0012AE FB                    4794 	.db #0xfb	; -5
      0012AF 00                    4795 	.db #0x00	;  0
      0012B0 02                    4796 	.db #0x02	;  2
      0012B1 FA                    4797 	.db #0xfa	; -6
      0012B2 04                    4798 	.db #0x04	;  4
      0012B3 00                    4799 	.db #0x00	;  0
      0012B4 01                    4800 	.db #0x01	;  1
      0012B5 05                    4801 	.db #0x05	;  5
      0012B6 00                    4802 	.db #0x00	;  0
      0012B7 03                    4803 	.db #0x03	;  3
      0012B8 FD                    4804 	.db #0xfd	; -3
      0012B9 FF                    4805 	.db #0xff	; -1
      0012BA FB                    4806 	.db #0xfb	; -5
      0012BB 0F                    4807 	.db #0x0f	;  15
      0012BC 1C                    4808 	.db #0x1c	;  28
      0012BD FC                    4809 	.db #0xfc	; -4
      0012BE EF                    4810 	.db #0xef	; -17
      0012BF F7                    4811 	.db #0xf7	; -9
      0012C0 EE                    4812 	.db #0xee	; -18
      0012C1 00                    4813 	.db #0x00	;  0
      0012C2 D2                    4814 	.db #0xd2	; -46
      0012C3 14                    4815 	.db #0x14	;  20
      0012C4 E4                    4816 	.db #0xe4	; -28
      0012C5 18                    4817 	.db #0x18	;  24
      0012C6 0D                    4818 	.db #0x0d	;  13
      0012C7 00                    4819 	.db #0x00	;  0
      0012C8 FD                    4820 	.db #0xfd	; -3
      0012C9 0A                    4821 	.db #0x0a	;  10
      0012CA EA                    4822 	.db #0xea	; -22
      0012CB 0C                    4823 	.db #0x0c	;  12
      0012CC F9                    4824 	.db #0xf9	; -7
      0012CD 0C                    4825 	.db #0x0c	;  12
      0012CE 06                    4826 	.db #0x06	;  6
      0012CF F0                    4827 	.db #0xf0	; -16
      0012D0 EC                    4828 	.db #0xec	; -20
      0012D1 0F                    4829 	.db #0x0f	;  15
      0012D2 03                    4830 	.db #0x03	;  3
      0012D3 00                    4831 	.db #0x00	;  0
      0012D4 FB                    4832 	.db #0xfb	; -5
      0012D5 29                    4833 	.db #0x29	;  41
      0012D6 EE                    4834 	.db #0xee	; -18
      0012D7 F1                    4835 	.db #0xf1	; -15
      0012D8 F5                    4836 	.db #0xf5	; -11
      0012D9 FC                    4837 	.db #0xfc	; -4
      0012DA FC                    4838 	.db #0xfc	; -4
      0012DB FF                    4839 	.db #0xff	; -1
      0012DC 22                    4840 	.db #0x22	;  34
      0012DD EE                    4841 	.db #0xee	; -18
      0012DE F8                    4842 	.db #0xf8	; -8
      0012DF 0F                    4843 	.db #0x0f	;  15
      0012E0 EA                    4844 	.db #0xea	; -22
      0012E1 00                    4845 	.db #0x00	;  0
      0012E2 A3                    4846 	.db #0xa3	; -93
      0012E3 1C                    4847 	.db #0x1c	;  28
      0012E4 E2                    4848 	.db #0xe2	; -30
      0012E5 FC                    4849 	.db #0xfc	; -4
      0012E6 06                    4850 	.db #0x06	;  6
      0012E7 00                    4851 	.db #0x00	;  0
      0012E8 03                    4852 	.db #0x03	;  3
      0012E9 F9                    4853 	.db #0xf9	; -7
      0012EA E9                    4854 	.db #0xe9	; -23
      0012EB 09                    4855 	.db #0x09	;  9
      0012EC 0C                    4856 	.db #0x0c	;  12
      0012ED F0                    4857 	.db #0xf0	; -16
      0012EE 0C                    4858 	.db #0x0c	;  12
      0012EF 0A                    4859 	.db #0x0a	;  10
      0012F0 E4                    4860 	.db #0xe4	; -28
      0012F1 FF                    4861 	.db #0xff	; -1
      0012F2 F9                    4862 	.db #0xf9	; -7
      0012F3 00                    4863 	.db #0x00	;  0
      0012F4 FC                    4864 	.db #0xfc	; -4
      0012F5 36                    4865 	.db #0x36	;  54	'6'
      0012F6 F7                    4866 	.db #0xf7	; -9
      0012F7 E3                    4867 	.db #0xe3	; -29
      0012F8 EE                    4868 	.db #0xee	; -18
      0012F9 11                    4869 	.db #0x11	;  17
      0012FA 07                    4870 	.db #0x07	;  7
      0012FB F7                    4871 	.db #0xf7	; -9
      0012FC 15                    4872 	.db #0x15	;  21
      0012FD F5                    4873 	.db #0xf5	; -11
      0012FE FF                    4874 	.db #0xff	; -1
      0012FF 0F                    4875 	.db #0x0f	;  15
      001300 03                    4876 	.db #0x03	;  3
      001301 00                    4877 	.db #0x00	;  0
      001302 81                    4878 	.db #0x81	; -127
      001303 2C                    4879 	.db #0x2c	;  44
      001304 FC                    4880 	.db #0xfc	; -4
      001305 03                    4881 	.db #0x03	;  3
      001306 04                    4882 	.db #0x04	;  4
      001307 00                    4883 	.db #0x00	;  0
      001308 FF                    4884 	.db #0xff	; -1
      001309 17                    4885 	.db #0x17	;  23
      00130A E0                    4886 	.db #0xe0	; -32
      00130B F4                    4887 	.db #0xf4	; -12
      00130C FE                    4888 	.db #0xfe	; -2
      00130D F7                    4889 	.db #0xf7	; -9
      00130E 38                    4890 	.db #0x38	;  56	'8'
      00130F 00                    4891 	.db #0x00	;  0
      001310 D4                    4892 	.db #0xd4	; -44
      001311 FB                    4893 	.db #0xfb	; -5
      001312 11                    4894 	.db #0x11	;  17
      001313 00                    4895 	.db #0x00	;  0
      001314 FB                    4896 	.db #0xfb	; -5
      001315 1D                    4897 	.db #0x1d	;  29
      001316 03                    4898 	.db #0x03	;  3
      001317 F0                    4899 	.db #0xf0	; -16
      001318 FE                    4900 	.db #0xfe	; -2
      001319 F2                    4901 	.db #0xf2	; -14
      00131A F3                    4902 	.db #0xf3	; -13
      00131B 0A                    4903 	.db #0x0a	;  10
      00131C 00                    4904 	.db #0x00	;  0
      00131D 05                    4905 	.db #0x05	;  5
      00131E 02                    4906 	.db #0x02	;  2
      00131F EF                    4907 	.db #0xef	; -17
      001320 0E                    4908 	.db #0x0e	;  14
      001321 00                    4909 	.db #0x00	;  0
      001322 90                    4910 	.db #0x90	; -112
      001323 2C                    4911 	.db #0x2c	;  44
      001324 26                    4912 	.db #0x26	;  38
      001325 DF                    4913 	.db #0xdf	; -33
      001326 E7                    4914 	.db #0xe7	; -25
      001327 00                    4915 	.db #0x00	;  0
      001328 20                    4916 	.db #0x20	;  32
      001329 30                    4917 	.db #0x30	;  48	'0'
      00132A D5                    4918 	.db #0xd5	; -43
      00132B 08                    4919 	.db #0x08	;  8
      00132C F5                    4920 	.db #0xf5	; -11
      00132D FF                    4921 	.db #0xff	; -1
      00132E 22                    4922 	.db #0x22	;  34
      00132F F3                    4923 	.db #0xf3	; -13
      001330 B4                    4924 	.db #0xb4	; -76
      001331 FC                    4925 	.db #0xfc	; -4
      001332 03                    4926 	.db #0x03	;  3
      001333 00                    4927 	.db #0x00	;  0
      001334 01                    4928 	.db #0x01	;  1
      001335 17                    4929 	.db #0x17	;  23
      001336 11                    4930 	.db #0x11	;  17
      001337 F6                    4931 	.db #0xf6	; -10
      001338 04                    4932 	.db #0x04	;  4
      001339 FD                    4933 	.db #0xfd	; -3
      00133A 22                    4934 	.db #0x22	;  34
      00133B 0C                    4935 	.db #0x0c	;  12
      00133C E8                    4936 	.db #0xe8	; -24
      00133D 1D                    4937 	.db #0x1d	;  29
      00133E 05                    4938 	.db #0x05	;  5
      00133F 04                    4939 	.db #0x04	;  4
      001340 10                    4940 	.db #0x10	;  16
      001341 00                    4941 	.db #0x00	;  0
      001342 D3                    4942 	.db #0xd3	; -45
      001343 0D                    4943 	.db #0x0d	;  13
      001344 26                    4944 	.db #0x26	;  38
      001345 BC                    4945 	.db #0xbc	; -68
      001346 E7                    4946 	.db #0xe7	; -25
      001347 00                    4947 	.db #0x00	;  0
      001348 22                    4948 	.db #0x22	;  34
      001349 F6                    4949 	.db #0xf6	; -10
      00134A DD                    4950 	.db #0xdd	; -35
      00134B F4                    4951 	.db #0xf4	; -12
      00134C E7                    4952 	.db #0xe7	; -25
      00134D 0E                    4953 	.db #0x0e	;  14
      00134E D9                    4954 	.db #0xd9	; -39
      00134F 08                    4955 	.db #0x08	;  8
      001350 DF                    4956 	.db #0xdf	; -33
      001351 18                    4957 	.db #0x18	;  24
      001352 0A                    4958 	.db #0x0a	;  10
      001353 00                    4959 	.db #0x00	;  0
      001354 18                    4960 	.db #0x18	;  24
      001355 10                    4961 	.db #0x10	;  16
      001356 FA                    4962 	.db #0xfa	; -6
      001357 F5                    4963 	.db #0xf5	; -11
      001358 19                    4964 	.db #0x19	;  25
      001359 0E                    4965 	.db #0x0e	;  14
      00135A 26                    4966 	.db #0x26	;  38
      00135B EC                    4967 	.db #0xec	; -20
      00135C DC                    4968 	.db #0xdc	; -36
      00135D EC                    4969 	.db #0xec	; -20
      00135E 16                    4970 	.db #0x16	;  22
      00135F 16                    4971 	.db #0x16	;  22
      001360 E7                    4972 	.db #0xe7	; -25
      001361 00                    4973 	.db #0x00	;  0
      001362 DF                    4974 	.db #0xdf	; -33
      001363 FD                    4975 	.db #0xfd	; -3
      001364 04                    4976 	.db #0x04	;  4
      001365 CC                    4977 	.db #0xcc	; -52
      001366 F6                    4978 	.db #0xf6	; -10
      001367 00                    4979 	.db #0x00	;  0
      001368 1B                    4980 	.db #0x1b	;  27
      001369 1B                    4981 	.db #0x1b	;  27
      00136A FE                    4982 	.db #0xfe	; -2
      00136B EA                    4983 	.db #0xea	; -22
      00136C F3                    4984 	.db #0xf3	; -13
      00136D 1D                    4985 	.db #0x1d	;  29
      00136E 03                    4986 	.db #0x03	;  3
      00136F 01                    4987 	.db #0x01	;  1
      001370 FD                    4988 	.db #0xfd	; -3
      001371 F7                    4989 	.db #0xf7	; -9
      001372 FB                    4990 	.db #0xfb	; -5
      001373 00                    4991 	.db #0x00	;  0
      001374 FF                    4992 	.db #0xff	; -1
      001375 1D                    4993 	.db #0x1d	;  29
      001376 FD                    4994 	.db #0xfd	; -3
      001377 EC                    4995 	.db #0xec	; -20
      001378 16                    4996 	.db #0x16	;  22
      001379 05                    4997 	.db #0x05	;  5
      00137A 06                    4998 	.db #0x06	;  6
      00137B FC                    4999 	.db #0xfc	; -4
      00137C E8                    5000 	.db #0xe8	; -24
      00137D E3                    5001 	.db #0xe3	; -29
      00137E EC                    5002 	.db #0xec	; -20
      00137F 06                    5003 	.db #0x06	;  6
      001380 CA                    5004 	.db #0xca	; -54
      001381 00                    5005 	.db #0x00	;  0
      001382 F3                    5006 	.db #0xf3	; -13
      001383 FE                    5007 	.db #0xfe	; -2
      001384 0A                    5008 	.db #0x0a	;  10
      001385 F5                    5009 	.db #0xf5	; -11
      001386 06                    5010 	.db #0x06	;  6
      001387 00                    5011 	.db #0x00	;  0
      001388 0E                    5012 	.db #0x0e	;  14
      001389 2C                    5013 	.db #0x2c	;  44
      00138A F3                    5014 	.db #0xf3	; -13
      00138B ED                    5015 	.db #0xed	; -19
      00138C 18                    5016 	.db #0x18	;  24
      00138D FA                    5017 	.db #0xfa	; -6
      00138E EA                    5018 	.db #0xea	; -22
      00138F FC                    5019 	.db #0xfc	; -4
      001390 05                    5020 	.db #0x05	;  5
      001391 FF                    5021 	.db #0xff	; -1
      001392 F4                    5022 	.db #0xf4	; -12
      001393 00                    5023 	.db #0x00	;  0
      001394 13                    5024 	.db #0x13	;  19
      001395 36                    5025 	.db #0x36	;  54	'6'
      001396 0A                    5026 	.db #0x0a	;  10
      001397 E9                    5027 	.db #0xe9	; -23
      001398 F6                    5028 	.db #0xf6	; -10
      001399 F8                    5029 	.db #0xf8	; -8
      00139A FB                    5030 	.db #0xfb	; -5
      00139B 09                    5031 	.db #0x09	;  9
      00139C 11                    5032 	.db #0x11	;  17
      00139D E7                    5033 	.db #0xe7	; -25
      00139E 01                    5034 	.db #0x01	;  1
      00139F 03                    5035 	.db #0x03	;  3
      0013A0 B7                    5036 	.db #0xb7	; -73
      0013A1 00                    5037 	.db #0x00	;  0
      0013A2 F5                    5038 	.db #0xf5	; -11
      0013A3 08                    5039 	.db #0x08	;  8
      0013A4 07                    5040 	.db #0x07	;  7
      0013A5 10                    5041 	.db #0x10	;  16
      0013A6 F5                    5042 	.db #0xf5	; -11
      0013A7 00                    5043 	.db #0x00	;  0
      0013A8 FB                    5044 	.db #0xfb	; -5
      0013A9 18                    5045 	.db #0x18	;  24
      0013AA F2                    5046 	.db #0xf2	; -14
      0013AB 04                    5047 	.db #0x04	;  4
      0013AC 04                    5048 	.db #0x04	;  4
      0013AD F4                    5049 	.db #0xf4	; -12
      0013AE F4                    5050 	.db #0xf4	; -12
      0013AF FB                    5051 	.db #0xfb	; -5
      0013B0 F6                    5052 	.db #0xf6	; -10
      0013B1 04                    5053 	.db #0x04	;  4
      0013B2 11                    5054 	.db #0x11	;  17
      0013B3 00                    5055 	.db #0x00	;  0
      0013B4 FD                    5056 	.db #0xfd	; -3
      0013B5 26                    5057 	.db #0x26	;  38
      0013B6 0C                    5058 	.db #0x0c	;  12
      0013B7 F2                    5059 	.db #0xf2	; -14
      0013B8 EB                    5060 	.db #0xeb	; -21
      0013B9 14                    5061 	.db #0x14	;  20
      0013BA D8                    5062 	.db #0xd8	; -40
      0013BB F8                    5063 	.db #0xf8	; -8
      0013BC 1F                    5064 	.db #0x1f	;  31
      0013BD F8                    5065 	.db #0xf8	; -8
      0013BE FB                    5066 	.db #0xfb	; -5
      0013BF 04                    5067 	.db #0x04	;  4
      0013C0 D8                    5068 	.db #0xd8	; -40
      0013C1 00                    5069 	.db #0x00	;  0
      0013C2 EF                    5070 	.db #0xef	; -17
      0013C3 03                    5071 	.db #0x03	;  3
      0013C4 0F                    5072 	.db #0x0f	;  15
      0013C5 15                    5073 	.db #0x15	;  21
      0013C6 F1                    5074 	.db #0xf1	; -15
      0013C7 00                    5075 	.db #0x00	;  0
      0013C8 06                    5076 	.db #0x06	;  6
      0013C9 08                    5077 	.db #0x08	;  8
      0013CA F7                    5078 	.db #0xf7	; -9
      0013CB 0C                    5079 	.db #0x0c	;  12
      0013CC D4                    5080 	.db #0xd4	; -44
      0013CD EF                    5081 	.db #0xef	; -17
      0013CE 0B                    5082 	.db #0x0b	;  11
      0013CF 09                    5083 	.db #0x09	;  9
      0013D0 05                    5084 	.db #0x05	;  5
      0013D1 07                    5085 	.db #0x07	;  7
      0013D2 0A                    5086 	.db #0x0a	;  10
      0013D3 00                    5087 	.db #0x00	;  0
      0013D4 F2                    5088 	.db #0xf2	; -14
      0013D5 13                    5089 	.db #0x13	;  19
      0013D6 09                    5090 	.db #0x09	;  9
      0013D7 F8                    5091 	.db #0xf8	; -8
      0013D8 E4                    5092 	.db #0xe4	; -28
      0013D9 0B                    5093 	.db #0x0b	;  11
      0013DA E2                    5094 	.db #0xe2	; -30
      0013DB 0E                    5095 	.db #0x0e	;  14
      0013DC 18                    5096 	.db #0x18	;  24
      0013DD 1B                    5097 	.db #0x1b	;  27
      0013DE F4                    5098 	.db #0xf4	; -12
      0013DF 16                    5099 	.db #0x16	;  22
      0013E0 EE                    5100 	.db #0xee	; -18
      0013E1 00                    5101 	.db #0x00	;  0
      0013E2 07                    5102 	.db #0x07	;  7
      0013E3 F0                    5103 	.db #0xf0	; -16
      0013E4 FE                    5104 	.db #0xfe	; -2
      0013E5 08                    5105 	.db #0x08	;  8
      0013E6 EF                    5106 	.db #0xef	; -17
      0013E7 00                    5107 	.db #0x00	;  0
      0013E8 03                    5108 	.db #0x03	;  3
      0013E9 ED                    5109 	.db #0xed	; -19
      0013EA FC                    5110 	.db #0xfc	; -4
      0013EB 0C                    5111 	.db #0x0c	;  12
      0013EC E7                    5112 	.db #0xe7	; -25
      0013ED F4                    5113 	.db #0xf4	; -12
      0013EE 01                    5114 	.db #0x01	;  1
      0013EF 0C                    5115 	.db #0x0c	;  12
      0013F0 04                    5116 	.db #0x04	;  4
      0013F1 09                    5117 	.db #0x09	;  9
      0013F2 0D                    5118 	.db #0x0d	;  13
      0013F3 00                    5119 	.db #0x00	;  0
      0013F4 ED                    5120 	.db #0xed	; -19
      0013F5 17                    5121 	.db #0x17	;  23
      0013F6 F9                    5122 	.db #0xf9	; -7
      0013F7 F6                    5123 	.db #0xf6	; -10
      0013F8 DA                    5124 	.db #0xda	; -38
      0013F9 08                    5125 	.db #0x08	;  8
      0013FA FD                    5126 	.db #0xfd	; -3
      0013FB F8                    5127 	.db #0xf8	; -8
      0013FC 0F                    5128 	.db #0x0f	;  15
      0013FD 0D                    5129 	.db #0x0d	;  13
      0013FE F9                    5130 	.db #0xf9	; -7
      0013FF 0C                    5131 	.db #0x0c	;  12
      001400 04                    5132 	.db #0x04	;  4
      001401 00                    5133 	.db #0x00	;  0
      001402 F9                    5134 	.db #0xf9	; -7
      001403 F0                    5135 	.db #0xf0	; -16
      001404 08                    5136 	.db #0x08	;  8
      001405 0C                    5137 	.db #0x0c	;  12
      001406 F7                    5138 	.db #0xf7	; -9
      001407 00                    5139 	.db #0x00	;  0
      001408 FF                    5140 	.db #0xff	; -1
      001409 F0                    5141 	.db #0xf0	; -16
      00140A 09                    5142 	.db #0x09	;  9
      00140B 0B                    5143 	.db #0x0b	;  11
      00140C F5                    5144 	.db #0xf5	; -11
      00140D 00                    5145 	.db #0x00	;  0
      00140E 0B                    5146 	.db #0x0b	;  11
      00140F 04                    5147 	.db #0x04	;  4
      001410 FC                    5148 	.db #0xfc	; -4
      001411 FE                    5149 	.db #0xfe	; -2
      001412 FA                    5150 	.db #0xfa	; -6
      001413 00                    5151 	.db #0x00	;  0
      001414 00                    5152 	.db #0x00	;  0
      001415 0D                    5153 	.db #0x0d	;  13
      001416 F8                    5154 	.db #0xf8	; -8
      001417 07                    5155 	.db #0x07	;  7
      001418 F8                    5156 	.db #0xf8	; -8
      001419 10                    5157 	.db #0x10	;  16
      00141A FC                    5158 	.db #0xfc	; -4
      00141B 00                    5159 	.db #0x00	;  0
      00141C FA                    5160 	.db #0xfa	; -6
      00141D 00                    5161 	.db #0x00	;  0
      00141E FF                    5162 	.db #0xff	; -1
      00141F 00                    5163 	.db #0x00	;  0
      001420 01                    5164 	.db #0x01	;  1
      001421 00                    5165 	.db #0x00	;  0
      001422 00                    5166 	.db #0x00	;  0
      001423 02                    5167 	.db #0x02	;  2
      001424 01                    5168 	.db #0x01	;  1
      001425 00                    5169 	.db #0x00	;  0
      001426 FD                    5170 	.db #0xfd	; -3
      001427 00                    5171 	.db #0x00	;  0
      001428 00                    5172 	.db #0x00	;  0
      001429 FB                    5173 	.db #0xfb	; -5
      00142A 03                    5174 	.db #0x03	;  3
      00142B 00                    5175 	.db #0x00	;  0
      00142C 00                    5176 	.db #0x00	;  0
      00142D 00                    5177 	.db #0x00	;  0
      00142E 02                    5178 	.db #0x02	;  2
      00142F 04                    5179 	.db #0x04	;  4
      001430 00                    5180 	.db #0x00	;  0
      001431 00                    5181 	.db #0x00	;  0
      001432 FE                    5182 	.db #0xfe	; -2
      001433 00                    5183 	.db #0x00	;  0
      001434 00                    5184 	.db #0x00	;  0
      001435 06                    5185 	.db #0x06	;  6
      001436 FC                    5186 	.db #0xfc	; -4
      001437 05                    5187 	.db #0x05	;  5
      001438 00                    5188 	.db #0x00	;  0
      001439 01                    5189 	.db #0x01	;  1
      00143A 00                    5190 	.db #0x00	;  0
      00143B 00                    5191 	.db #0x00	;  0
      00143C 00                    5192 	.db #0x00	;  0
      00143D 00                    5193 	.db #0x00	;  0
      00143E 00                    5194 	.db #0x00	;  0
      00143F 00                    5195 	.db #0x00	;  0
      001440 00                    5196 	.db #0x00	;  0
      001441 00                    5197 	.db #0x00	;  0
      001442 00                    5198 	.db #0x00	;  0
      001443 00                    5199 	.db #0x00	;  0
      001444 00                    5200 	.db #0x00	;  0
      001445 00                    5201 	.db #0x00	;  0
      001446 00                    5202 	.db #0x00	;  0
      001447 00                    5203 	.db #0x00	;  0
      001448 00                    5204 	.db #0x00	;  0
      001449 00                    5205 	.db #0x00	;  0
      00144A 00                    5206 	.db #0x00	;  0
      00144B 00                    5207 	.db #0x00	;  0
      00144C 00                    5208 	.db #0x00	;  0
      00144D 00                    5209 	.db #0x00	;  0
      00144E 00                    5210 	.db #0x00	;  0
      00144F 00                    5211 	.db #0x00	;  0
      001450 00                    5212 	.db #0x00	;  0
      001451 00                    5213 	.db #0x00	;  0
      001452 00                    5214 	.db #0x00	;  0
      001453 00                    5215 	.db #0x00	;  0
      001454 00                    5216 	.db #0x00	;  0
      001455 00                    5217 	.db #0x00	;  0
      001456 00                    5218 	.db #0x00	;  0
      001457 00                    5219 	.db #0x00	;  0
      001458 00                    5220 	.db #0x00	;  0
      001459 00                    5221 	.db #0x00	;  0
      00145A 00                    5222 	.db #0x00	;  0
      00145B 00                    5223 	.db #0x00	;  0
      00145C 02                    5224 	.db #0x02	;  2
      00145D 03                    5225 	.db #0x03	;  3
      00145E F7                    5226 	.db #0xf7	; -9
      00145F 03                    5227 	.db #0x03	;  3
      001460 FD                    5228 	.db #0xfd	; -3
      001461 00                    5229 	.db #0x00	;  0
      001462 01                    5230 	.db #0x01	;  1
      001463 01                    5231 	.db #0x01	;  1
      001464 00                    5232 	.db #0x00	;  0
      001465 0D                    5233 	.db #0x0d	;  13
      001466 00                    5234 	.db #0x00	;  0
      001467 00                    5235 	.db #0x00	;  0
      001468 FD                    5236 	.db #0xfd	; -3
      001469 01                    5237 	.db #0x01	;  1
      00146A 03                    5238 	.db #0x03	;  3
      00146B 01                    5239 	.db #0x01	;  1
      00146C 03                    5240 	.db #0x03	;  3
      00146D 08                    5241 	.db #0x08	;  8
      00146E 00                    5242 	.db #0x00	;  0
      00146F F8                    5243 	.db #0xf8	; -8
      001470 FD                    5244 	.db #0xfd	; -3
      001471 01                    5245 	.db #0x01	;  1
      001472 FE                    5246 	.db #0xfe	; -2
      001473 00                    5247 	.db #0x00	;  0
      001474 F9                    5248 	.db #0xf9	; -7
      001475 0D                    5249 	.db #0x0d	;  13
      001476 F9                    5250 	.db #0xf9	; -7
      001477 01                    5251 	.db #0x01	;  1
      001478 F9                    5252 	.db #0xf9	; -7
      001479 0B                    5253 	.db #0x0b	;  11
      00147A F9                    5254 	.db #0xf9	; -7
      00147B F8                    5255 	.db #0xf8	; -8
      00147C F8                    5256 	.db #0xf8	; -8
      00147D F4                    5257 	.db #0xf4	; -12
      00147E F1                    5258 	.db #0xf1	; -15
      00147F FD                    5259 	.db #0xfd	; -3
      001480 E9                    5260 	.db #0xe9	; -23
      001481 00                    5261 	.db #0x00	;  0
      001482 FF                    5262 	.db #0xff	; -1
      001483 0E                    5263 	.db #0x0e	;  14
      001484 11                    5264 	.db #0x11	;  17
      001485 1B                    5265 	.db #0x1b	;  27
      001486 FA                    5266 	.db #0xfa	; -6
      001487 00                    5267 	.db #0x00	;  0
      001488 ED                    5268 	.db #0xed	; -19
      001489 FF                    5269 	.db #0xff	; -1
      00148A FC                    5270 	.db #0xfc	; -4
      00148B F6                    5271 	.db #0xf6	; -10
      00148C 07                    5272 	.db #0x07	;  7
      00148D FF                    5273 	.db #0xff	; -1
      00148E 19                    5274 	.db #0x19	;  25
      00148F F8                    5275 	.db #0xf8	; -8
      001490 DD                    5276 	.db #0xdd	; -35
      001491 FE                    5277 	.db #0xfe	; -2
      001492 1A                    5278 	.db #0x1a	;  26
      001493 00                    5279 	.db #0x00	;  0
      001494 EB                    5280 	.db #0xeb	; -21
      001495 24                    5281 	.db #0x24	;  36
      001496 FD                    5282 	.db #0xfd	; -3
      001497 01                    5283 	.db #0x01	;  1
      001498 EE                    5284 	.db #0xee	; -18
      001499 FD                    5285 	.db #0xfd	; -3
      00149A E8                    5286 	.db #0xe8	; -24
      00149B EE                    5287 	.db #0xee	; -18
      00149C 0E                    5288 	.db #0x0e	;  14
      00149D EE                    5289 	.db #0xee	; -18
      00149E F1                    5290 	.db #0xf1	; -15
      00149F FA                    5291 	.db #0xfa	; -6
      0014A0 0D                    5292 	.db #0x0d	;  13
      0014A1 00                    5293 	.db #0x00	;  0
      0014A2 0E                    5294 	.db #0x0e	;  14
      0014A3 12                    5295 	.db #0x12	;  18
      0014A4 F3                    5296 	.db #0xf3	; -13
      0014A5 1B                    5297 	.db #0x1b	;  27
      0014A6 F8                    5298 	.db #0xf8	; -8
      0014A7 00                    5299 	.db #0x00	;  0
      0014A8 AA                    5300 	.db #0xaa	; -86
      0014A9 E1                    5301 	.db #0xe1	; -31
      0014AA FE                    5302 	.db #0xfe	; -2
      0014AB 0A                    5303 	.db #0x0a	;  10
      0014AC 13                    5304 	.db #0x13	;  19
      0014AD FA                    5305 	.db #0xfa	; -6
      0014AE 1D                    5306 	.db #0x1d	;  29
      0014AF F3                    5307 	.db #0xf3	; -13
      0014B0 C3                    5308 	.db #0xc3	; -61
      0014B1 FF                    5309 	.db #0xff	; -1
      0014B2 10                    5310 	.db #0x10	;  16
      0014B3 00                    5311 	.db #0x00	;  0
      0014B4 F7                    5312 	.db #0xf7	; -9
      0014B5 12                    5313 	.db #0x12	;  18
      0014B6 0A                    5314 	.db #0x0a	;  10
      0014B7 0F                    5315 	.db #0x0f	;  15
      0014B8 08                    5316 	.db #0x08	;  8
      0014B9 F5                    5317 	.db #0xf5	; -11
      0014BA F3                    5318 	.db #0xf3	; -13
      0014BB F5                    5319 	.db #0xf5	; -11
      0014BC 19                    5320 	.db #0x19	;  25
      0014BD EC                    5321 	.db #0xec	; -20
      0014BE FA                    5322 	.db #0xfa	; -6
      0014BF FC                    5323 	.db #0xfc	; -4
      0014C0 12                    5324 	.db #0x12	;  18
      0014C1 00                    5325 	.db #0x00	;  0
      0014C2 F9                    5326 	.db #0xf9	; -7
      0014C3 17                    5327 	.db #0x17	;  23
      0014C4 0E                    5328 	.db #0x0e	;  14
      0014C5 24                    5329 	.db #0x24	;  36
      0014C6 F6                    5330 	.db #0xf6	; -10
      0014C7 00                    5331 	.db #0x00	;  0
      0014C8 A3                    5332 	.db #0xa3	; -93
      0014C9 F9                    5333 	.db #0xf9	; -7
      0014CA FA                    5334 	.db #0xfa	; -6
      0014CB FC                    5335 	.db #0xfc	; -4
      0014CC 0B                    5336 	.db #0x0b	;  11
      0014CD F8                    5337 	.db #0xf8	; -8
      0014CE 44                    5338 	.db #0x44	;  68	'D'
      0014CF EC                    5339 	.db #0xec	; -20
      0014D0 BA                    5340 	.db #0xba	; -70
      0014D1 06                    5341 	.db #0x06	;  6
      0014D2 F6                    5342 	.db #0xf6	; -10
      0014D3 00                    5343 	.db #0x00	;  0
      0014D4 E6                    5344 	.db #0xe6	; -26
      0014D5 0D                    5345 	.db #0x0d	;  13
      0014D6 0E                    5346 	.db #0x0e	;  14
      0014D7 08                    5347 	.db #0x08	;  8
      0014D8 FA                    5348 	.db #0xfa	; -6
      0014D9 FE                    5349 	.db #0xfe	; -2
      0014DA 07                    5350 	.db #0x07	;  7
      0014DB 22                    5351 	.db #0x22	;  34
      0014DC 07                    5352 	.db #0x07	;  7
      0014DD ED                    5353 	.db #0xed	; -19
      0014DE 03                    5354 	.db #0x03	;  3
      0014DF EB                    5355 	.db #0xeb	; -21
      0014E0 17                    5356 	.db #0x17	;  23
      0014E1 00                    5357 	.db #0x00	;  0
      0014E2 DE                    5358 	.db #0xde	; -34
      0014E3 FF                    5359 	.db #0xff	; -1
      0014E4 33                    5360 	.db #0x33	;  51	'3'
      0014E5 08                    5361 	.db #0x08	;  8
      0014E6 FC                    5362 	.db #0xfc	; -4
      0014E7 00                    5363 	.db #0x00	;  0
      0014E8 96                    5364 	.db #0x96	; -106
      0014E9 FE                    5365 	.db #0xfe	; -2
      0014EA E3                    5366 	.db #0xe3	; -29
      0014EB F8                    5367 	.db #0xf8	; -8
      0014EC FA                    5368 	.db #0xfa	; -6
      0014ED E5                    5369 	.db #0xe5	; -27
      0014EE E2                    5370 	.db #0xe2	; -30
      0014EF E5                    5371 	.db #0xe5	; -27
      0014F0 E8                    5372 	.db #0xe8	; -24
      0014F1 11                    5373 	.db #0x11	;  17
      0014F2 FB                    5374 	.db #0xfb	; -5
      0014F3 00                    5375 	.db #0x00	;  0
      0014F4 F0                    5376 	.db #0xf0	; -16
      0014F5 0A                    5377 	.db #0x0a	;  10
      0014F6 03                    5378 	.db #0x03	;  3
      0014F7 08                    5379 	.db #0x08	;  8
      0014F8 FA                    5380 	.db #0xfa	; -6
      0014F9 FE                    5381 	.db #0xfe	; -2
      0014FA 26                    5382 	.db #0x26	;  38
      0014FB 03                    5383 	.db #0x03	;  3
      0014FC E3                    5384 	.db #0xe3	; -29
      0014FD FD                    5385 	.db #0xfd	; -3
      0014FE F3                    5386 	.db #0xf3	; -13
      0014FF FC                    5387 	.db #0xfc	; -4
      001500 2C                    5388 	.db #0x2c	;  44
      001501 00                    5389 	.db #0x00	;  0
      001502 C6                    5390 	.db #0xc6	; -58
      001503 06                    5391 	.db #0x06	;  6
      001504 12                    5392 	.db #0x12	;  18
      001505 16                    5393 	.db #0x16	;  22
      001506 0D                    5394 	.db #0x0d	;  13
      001507 00                    5395 	.db #0x00	;  0
      001508 A5                    5396 	.db #0xa5	; -91
      001509 F8                    5397 	.db #0xf8	; -8
      00150A F1                    5398 	.db #0xf1	; -15
      00150B 09                    5399 	.db #0x09	;  9
      00150C E1                    5400 	.db #0xe1	; -31
      00150D F5                    5401 	.db #0xf5	; -11
      00150E BC                    5402 	.db #0xbc	; -68
      00150F 06                    5403 	.db #0x06	;  6
      001510 03                    5404 	.db #0x03	;  3
      001511 09                    5405 	.db #0x09	;  9
      001512 22                    5406 	.db #0x22	;  34
      001513 00                    5407 	.db #0x00	;  0
      001514 12                    5408 	.db #0x12	;  18
      001515 FA                    5409 	.db #0xfa	; -6
      001516 05                    5410 	.db #0x05	;  5
      001517 08                    5411 	.db #0x08	;  8
      001518 07                    5412 	.db #0x07	;  7
      001519 13                    5413 	.db #0x13	;  19
      00151A FE                    5414 	.db #0xfe	; -2
      00151B EB                    5415 	.db #0xeb	; -21
      00151C E0                    5416 	.db #0xe0	; -32
      00151D CF                    5417 	.db #0xcf	; -49
      00151E 0C                    5418 	.db #0x0c	;  12
      00151F F6                    5419 	.db #0xf6	; -10
      001520 D2                    5420 	.db #0xd2	; -46
      001521 00                    5421 	.db #0x00	;  0
      001522 F5                    5422 	.db #0xf5	; -11
      001523 05                    5423 	.db #0x05	;  5
      001524 FB                    5424 	.db #0xfb	; -5
      001525 F2                    5425 	.db #0xf2	; -14
      001526 EF                    5426 	.db #0xef	; -17
      001527 00                    5427 	.db #0x00	;  0
      001528 CB                    5428 	.db #0xcb	; -53
      001529 28                    5429 	.db #0x28	;  40
      00152A 18                    5430 	.db #0x18	;  24
      00152B 12                    5431 	.db #0x12	;  18
      00152C 26                    5432 	.db #0x26	;  38
      00152D 0B                    5433 	.db #0x0b	;  11
      00152E E8                    5434 	.db #0xe8	; -24
      00152F 09                    5435 	.db #0x09	;  9
      001530 F9                    5436 	.db #0xf9	; -7
      001531 EE                    5437 	.db #0xee	; -18
      001532 0F                    5438 	.db #0x0f	;  15
      001533 00                    5439 	.db #0x00	;  0
      001534 06                    5440 	.db #0x06	;  6
      001535 29                    5441 	.db #0x29	;  41
      001536 FE                    5442 	.db #0xfe	; -2
      001537 0C                    5443 	.db #0x0c	;  12
      001538 08                    5444 	.db #0x08	;  8
      001539 06                    5445 	.db #0x06	;  6
      00153A 02                    5446 	.db #0x02	;  2
      00153B 05                    5447 	.db #0x05	;  5
      00153C 21                    5448 	.db #0x21	;  33
      00153D ED                    5449 	.db #0xed	; -19
      00153E FC                    5450 	.db #0xfc	; -4
      00153F 0D                    5451 	.db #0x0d	;  13
      001540 E0                    5452 	.db #0xe0	; -32
      001541 00                    5453 	.db #0x00	;  0
      001542 F1                    5454 	.db #0xf1	; -15
      001543 F7                    5455 	.db #0xf7	; -9
      001544 F9                    5456 	.db #0xf9	; -7
      001545 EF                    5457 	.db #0xef	; -17
      001546 FB                    5458 	.db #0xfb	; -5
      001547 00                    5459 	.db #0x00	;  0
      001548 F8                    5460 	.db #0xf8	; -8
      001549 F3                    5461 	.db #0xf3	; -13
      00154A 0A                    5462 	.db #0x0a	;  10
      00154B FC                    5463 	.db #0xfc	; -4
      00154C 2C                    5464 	.db #0x2c	;  44
      00154D 02                    5465 	.db #0x02	;  2
      00154E E5                    5466 	.db #0xe5	; -27
      00154F EE                    5467 	.db #0xee	; -18
      001550 00                    5468 	.db #0x00	;  0
      001551 00                    5469 	.db #0x00	;  0
      001552 FE                    5470 	.db #0xfe	; -2
      001553 00                    5471 	.db #0x00	;  0
      001554 F0                    5472 	.db #0xf0	; -16
      001555 29                    5473 	.db #0x29	;  41
      001556 00                    5474 	.db #0x00	;  0
      001557 00                    5475 	.db #0x00	;  0
      001558 F1                    5476 	.db #0xf1	; -15
      001559 0B                    5477 	.db #0x0b	;  11
      00155A FD                    5478 	.db #0xfd	; -3
      00155B 09                    5479 	.db #0x09	;  9
      00155C 20                    5480 	.db #0x20	;  32
      00155D 22                    5481 	.db #0x22	;  34
      00155E F5                    5482 	.db #0xf5	; -11
      00155F 01                    5483 	.db #0x01	;  1
      001560 FE                    5484 	.db #0xfe	; -2
      001561 00                    5485 	.db #0x00	;  0
      001562 F3                    5486 	.db #0xf3	; -13
      001563 ED                    5487 	.db #0xed	; -19
      001564 F4                    5488 	.db #0xf4	; -12
      001565 07                    5489 	.db #0x07	;  7
      001566 02                    5490 	.db #0x02	;  2
      001567 00                    5491 	.db #0x00	;  0
      001568 FC                    5492 	.db #0xfc	; -4
      001569 E9                    5493 	.db #0xe9	; -23
      00156A 0A                    5494 	.db #0x0a	;  10
      00156B FE                    5495 	.db #0xfe	; -2
      00156C F5                    5496 	.db #0xf5	; -11
      00156D 06                    5497 	.db #0x06	;  6
      00156E E9                    5498 	.db #0xe9	; -23
      00156F 11                    5499 	.db #0x11	;  17
      001570 03                    5500 	.db #0x03	;  3
      001571 0C                    5501 	.db #0x0c	;  12
      001572 F7                    5502 	.db #0xf7	; -9
      001573 00                    5503 	.db #0x00	;  0
      001574 F4                    5504 	.db #0xf4	; -12
      001575 0D                    5505 	.db #0x0d	;  13
      001576 0A                    5506 	.db #0x0a	;  10
      001577 F7                    5507 	.db #0xf7	; -9
      001578 E4                    5508 	.db #0xe4	; -28
      001579 06                    5509 	.db #0x06	;  6
      00157A F3                    5510 	.db #0xf3	; -13
      00157B 12                    5511 	.db #0x12	;  18
      00157C 17                    5512 	.db #0x17	;  23
      00157D 32                    5513 	.db #0x32	;  50	'2'
      00157E F9                    5514 	.db #0xf9	; -7
      00157F 06                    5515 	.db #0x06	;  6
      001580 19                    5516 	.db #0x19	;  25
      001581 00                    5517 	.db #0x00	;  0
      001582 01                    5518 	.db #0x01	;  1
      001583 FA                    5519 	.db #0xfa	; -6
      001584 F4                    5520 	.db #0xf4	; -12
      001585 F8                    5521 	.db #0xf8	; -8
      001586 E0                    5522 	.db #0xe0	; -32
      001587 00                    5523 	.db #0x00	;  0
      001588 02                    5524 	.db #0x02	;  2
      001589 EF                    5525 	.db #0xef	; -17
      00158A 05                    5526 	.db #0x05	;  5
      00158B FF                    5527 	.db #0xff	; -1
      00158C C5                    5528 	.db #0xc5	; -59
      00158D 05                    5529 	.db #0x05	;  5
      00158E FC                    5530 	.db #0xfc	; -4
      00158F 06                    5531 	.db #0x06	;  6
      001590 04                    5532 	.db #0x04	;  4
      001591 01                    5533 	.db #0x01	;  1
      001592 FE                    5534 	.db #0xfe	; -2
      001593 00                    5535 	.db #0x00	;  0
      001594 F3                    5536 	.db #0xf3	; -13
      001595 0C                    5537 	.db #0x0c	;  12
      001596 08                    5538 	.db #0x08	;  8
      001597 F3                    5539 	.db #0xf3	; -13
      001598 D1                    5540 	.db #0xd1	; -47
      001599 F7                    5541 	.db #0xf7	; -9
      00159A F2                    5542 	.db #0xf2	; -14
      00159B F9                    5543 	.db #0xf9	; -7
      00159C FA                    5544 	.db #0xfa	; -6
      00159D 28                    5545 	.db #0x28	;  40
      00159E F5                    5546 	.db #0xf5	; -11
      00159F F7                    5547 	.db #0xf7	; -9
      0015A0 0E                    5548 	.db #0x0e	;  14
      0015A1 00                    5549 	.db #0x00	;  0
      0015A2 F1                    5550 	.db #0xf1	; -15
      0015A3 EE                    5551 	.db #0xee	; -18
      0015A4 07                    5552 	.db #0x07	;  7
      0015A5 04                    5553 	.db #0x04	;  4
      0015A6 E5                    5554 	.db #0xe5	; -27
      0015A7 00                    5555 	.db #0x00	;  0
      0015A8 ED                    5556 	.db #0xed	; -19
      0015A9 EF                    5557 	.db #0xef	; -17
      0015AA 06                    5558 	.db #0x06	;  6
      0015AB 02                    5559 	.db #0x02	;  2
      0015AC E0                    5560 	.db #0xe0	; -32
      0015AD F5                    5561 	.db #0xf5	; -11
      0015AE FE                    5562 	.db #0xfe	; -2
      0015AF 09                    5563 	.db #0x09	;  9
      0015B0 F2                    5564 	.db #0xf2	; -14
      0015B1 ED                    5565 	.db #0xed	; -19
      0015B2 FF                    5566 	.db #0xff	; -1
      0015B3 00                    5567 	.db #0x00	;  0
      0015B4 E7                    5568 	.db #0xe7	; -25
      0015B5 17                    5569 	.db #0x17	;  23
      0015B6 00                    5570 	.db #0x00	;  0
      0015B7 FC                    5571 	.db #0xfc	; -4
      0015B8 DF                    5572 	.db #0xdf	; -33
      0015B9 04                    5573 	.db #0x04	;  4
      0015BA F9                    5574 	.db #0xf9	; -7
      0015BB FC                    5575 	.db #0xfc	; -4
      0015BC F9                    5576 	.db #0xf9	; -7
      0015BD 0B                    5577 	.db #0x0b	;  11
      0015BE FE                    5578 	.db #0xfe	; -2
      0015BF 01                    5579 	.db #0x01	;  1
      0015C0 11                    5580 	.db #0x11	;  17
      0015C1 00                    5581 	.db #0x00	;  0
      0015C2 01                    5582 	.db #0x01	;  1
      0015C3 FE                    5583 	.db #0xfe	; -2
      0015C4 03                    5584 	.db #0x03	;  3
      0015C5 07                    5585 	.db #0x07	;  7
      0015C6 FF                    5586 	.db #0xff	; -1
      0015C7 00                    5587 	.db #0x00	;  0
      0015C8 F9                    5588 	.db #0xf9	; -7
      0015C9 FB                    5589 	.db #0xfb	; -5
      0015CA 13                    5590 	.db #0x13	;  19
      0015CB FB                    5591 	.db #0xfb	; -5
      0015CC FD                    5592 	.db #0xfd	; -3
      0015CD FE                    5593 	.db #0xfe	; -2
      0015CE F5                    5594 	.db #0xf5	; -11
      0015CF 01                    5595 	.db #0x01	;  1
      0015D0 FF                    5596 	.db #0xff	; -1
      0015D1 F8                    5597 	.db #0xf8	; -8
      0015D2 F8                    5598 	.db #0xf8	; -8
      0015D3 00                    5599 	.db #0x00	;  0
      0015D4 FF                    5600 	.db #0xff	; -1
      0015D5 16                    5601 	.db #0x16	;  22
      0015D6 0E                    5602 	.db #0x0e	;  14
      0015D7 02                    5603 	.db #0x02	;  2
      0015D8 02                    5604 	.db #0x02	;  2
      0015D9 0E                    5605 	.db #0x0e	;  14
      0015DA FA                    5606 	.db #0xfa	; -6
      0015DB 01                    5607 	.db #0x01	;  1
      0015DC FE                    5608 	.db #0xfe	; -2
      0015DD FF                    5609 	.db #0xff	; -1
      0015DE 00                    5610 	.db #0x00	;  0
      0015DF 02                    5611 	.db #0x02	;  2
      0015E0 03                    5612 	.db #0x03	;  3
      0015E1 00                    5613 	.db #0x00	;  0
      0015E2 00                    5614 	.db #0x00	;  0
      0015E3 00                    5615 	.db #0x00	;  0
      0015E4 FE                    5616 	.db #0xfe	; -2
      0015E5 FE                    5617 	.db #0xfe	; -2
      0015E6 FD                    5618 	.db #0xfd	; -3
      0015E7 00                    5619 	.db #0x00	;  0
      0015E8 00                    5620 	.db #0x00	;  0
      0015E9 00                    5621 	.db #0x00	;  0
      0015EA 00                    5622 	.db #0x00	;  0
      0015EB 00                    5623 	.db #0x00	;  0
      0015EC FE                    5624 	.db #0xfe	; -2
      0015ED 00                    5625 	.db #0x00	;  0
      0015EE FF                    5626 	.db #0xff	; -1
      0015EF 02                    5627 	.db #0x02	;  2
      0015F0 01                    5628 	.db #0x01	;  1
      0015F1 04                    5629 	.db #0x04	;  4
      0015F2 01                    5630 	.db #0x01	;  1
      0015F3 00                    5631 	.db #0x00	;  0
      0015F4 00                    5632 	.db #0x00	;  0
      0015F5 02                    5633 	.db #0x02	;  2
      0015F6 FE                    5634 	.db #0xfe	; -2
      0015F7 02                    5635 	.db #0x02	;  2
      0015F8 02                    5636 	.db #0x02	;  2
      0015F9 FF                    5637 	.db #0xff	; -1
      0015FA FF                    5638 	.db #0xff	; -1
      0015FB 00                    5639 	.db #0x00	;  0
      0015FC 00                    5640 	.db #0x00	;  0
      0015FD 00                    5641 	.db #0x00	;  0
      0015FE 00                    5642 	.db #0x00	;  0
      0015FF 00                    5643 	.db #0x00	;  0
      001600 00                    5644 	.db #0x00	;  0
      001601 00                    5645 	.db #0x00	;  0
      001602 00                    5646 	.db #0x00	;  0
      001603 00                    5647 	.db #0x00	;  0
      001604 00                    5648 	.db #0x00	;  0
      001605 00                    5649 	.db #0x00	;  0
      001606 00                    5650 	.db #0x00	;  0
      001607 00                    5651 	.db #0x00	;  0
      001608 00                    5652 	.db #0x00	;  0
      001609 00                    5653 	.db #0x00	;  0
      00160A 00                    5654 	.db #0x00	;  0
      00160B 00                    5655 	.db #0x00	;  0
      00160C 00                    5656 	.db #0x00	;  0
      00160D 00                    5657 	.db #0x00	;  0
      00160E 00                    5658 	.db #0x00	;  0
      00160F 00                    5659 	.db #0x00	;  0
      001610 00                    5660 	.db #0x00	;  0
      001611 00                    5661 	.db #0x00	;  0
      001612 00                    5662 	.db #0x00	;  0
      001613 00                    5663 	.db #0x00	;  0
      001614 00                    5664 	.db #0x00	;  0
      001615 00                    5665 	.db #0x00	;  0
      001616 00                    5666 	.db #0x00	;  0
      001617 00                    5667 	.db #0x00	;  0
      001618 00                    5668 	.db #0x00	;  0
      001619 00                    5669 	.db #0x00	;  0
      00161A 00                    5670 	.db #0x00	;  0
      00161B 01                    5671 	.db #0x01	;  1
      00161C 01                    5672 	.db #0x01	;  1
      00161D 08                    5673 	.db #0x08	;  8
      00161E 02                    5674 	.db #0x02	;  2
      00161F 04                    5675 	.db #0x04	;  4
      001620 01                    5676 	.db #0x01	;  1
      001621 00                    5677 	.db #0x00	;  0
      001622 F8                    5678 	.db #0xf8	; -8
      001623 FC                    5679 	.db #0xfc	; -4
      001624 0B                    5680 	.db #0x0b	;  11
      001625 F3                    5681 	.db #0xf3	; -13
      001626 F6                    5682 	.db #0xf6	; -10
      001627 00                    5683 	.db #0x00	;  0
      001628 02                    5684 	.db #0x02	;  2
      001629 FE                    5685 	.db #0xfe	; -2
      00162A 04                    5686 	.db #0x04	;  4
      00162B FD                    5687 	.db #0xfd	; -3
      00162C F6                    5688 	.db #0xf6	; -10
      00162D 07                    5689 	.db #0x07	;  7
      00162E 08                    5690 	.db #0x08	;  8
      00162F F7                    5691 	.db #0xf7	; -9
      001630 FA                    5692 	.db #0xfa	; -6
      001631 FC                    5693 	.db #0xfc	; -4
      001632 07                    5694 	.db #0x07	;  7
      001633 00                    5695 	.db #0x00	;  0
      001634 02                    5696 	.db #0x02	;  2
      001635 14                    5697 	.db #0x14	;  20
      001636 FA                    5698 	.db #0xfa	; -6
      001637 0F                    5699 	.db #0x0f	;  15
      001638 F3                    5700 	.db #0xf3	; -13
      001639 05                    5701 	.db #0x05	;  5
      00163A FD                    5702 	.db #0xfd	; -3
      00163B 07                    5703 	.db #0x07	;  7
      00163C 08                    5704 	.db #0x08	;  8
      00163D E3                    5705 	.db #0xe3	; -29
      00163E FB                    5706 	.db #0xfb	; -5
      00163F EF                    5707 	.db #0xef	; -17
      001640 09                    5708 	.db #0x09	;  9
      001641 00                    5709 	.db #0x00	;  0
      001642 23                    5710 	.db #0x23	;  35
      001643 0A                    5711 	.db #0x0a	;  10
      001644 FF                    5712 	.db #0xff	; -1
      001645 07                    5713 	.db #0x07	;  7
      001646 EC                    5714 	.db #0xec	; -20
      001647 00                    5715 	.db #0x00	;  0
      001648 EF                    5716 	.db #0xef	; -17
      001649 F2                    5717 	.db #0xf2	; -14
      00164A 1F                    5718 	.db #0x1f	;  31
      00164B 0F                    5719 	.db #0x0f	;  15
      00164C 0A                    5720 	.db #0x0a	;  10
      00164D 09                    5721 	.db #0x09	;  9
      00164E 1E                    5722 	.db #0x1e	;  30
      00164F F9                    5723 	.db #0xf9	; -7
      001650 ED                    5724 	.db #0xed	; -19
      001651 F4                    5725 	.db #0xf4	; -12
      001652 05                    5726 	.db #0x05	;  5
      001653 00                    5727 	.db #0x00	;  0
      001654 F5                    5728 	.db #0xf5	; -11
      001655 F9                    5729 	.db #0xf9	; -7
      001656 FF                    5730 	.db #0xff	; -1
      001657 03                    5731 	.db #0x03	;  3
      001658 DF                    5732 	.db #0xdf	; -33
      001659 FC                    5733 	.db #0xfc	; -4
      00165A FA                    5734 	.db #0xfa	; -6
      00165B FF                    5735 	.db #0xff	; -1
      00165C D9                    5736 	.db #0xd9	; -39
      00165D 00                    5737 	.db #0x00	;  0
      00165E 0B                    5738 	.db #0x0b	;  11
      00165F FA                    5739 	.db #0xfa	; -6
      001660 09                    5740 	.db #0x09	;  9
      001661 00                    5741 	.db #0x00	;  0
      001662 27                    5742 	.db #0x27	;  39
      001663 EE                    5743 	.db #0xee	; -18
      001664 1C                    5744 	.db #0x1c	;  28
      001665 F7                    5745 	.db #0xf7	; -9
      001666 E5                    5746 	.db #0xe5	; -27
      001667 00                    5747 	.db #0x00	;  0
      001668 EF                    5748 	.db #0xef	; -17
      001669 EE                    5749 	.db #0xee	; -18
      00166A 0E                    5750 	.db #0x0e	;  14
      00166B 04                    5751 	.db #0x04	;  4
      00166C 24                    5752 	.db #0x24	;  36
      00166D 07                    5753 	.db #0x07	;  7
      00166E 27                    5754 	.db #0x27	;  39
      00166F FB                    5755 	.db #0xfb	; -5
      001670 D1                    5756 	.db #0xd1	; -47
      001671 FD                    5757 	.db #0xfd	; -3
      001672 02                    5758 	.db #0x02	;  2
      001673 00                    5759 	.db #0x00	;  0
      001674 EF                    5760 	.db #0xef	; -17
      001675 06                    5761 	.db #0x06	;  6
      001676 FC                    5762 	.db #0xfc	; -4
      001677 FE                    5763 	.db #0xfe	; -2
      001678 1D                    5764 	.db #0x1d	;  29
      001679 EE                    5765 	.db #0xee	; -18
      00167A D6                    5766 	.db #0xd6	; -42
      00167B F2                    5767 	.db #0xf2	; -14
      00167C EF                    5768 	.db #0xef	; -17
      00167D FC                    5769 	.db #0xfc	; -4
      00167E F7                    5770 	.db #0xf7	; -9
      00167F FD                    5771 	.db #0xfd	; -3
      001680 0B                    5772 	.db #0x0b	;  11
      001681 00                    5773 	.db #0x00	;  0
      001682 16                    5774 	.db #0x16	;  22
      001683 D5                    5775 	.db #0xd5	; -43
      001684 00                    5776 	.db #0x00	;  0
      001685 0E                    5777 	.db #0x0e	;  14
      001686 FD                    5778 	.db #0xfd	; -3
      001687 00                    5779 	.db #0x00	;  0
      001688 EE                    5780 	.db #0xee	; -18
      001689 E2                    5781 	.db #0xe2	; -30
      00168A 0E                    5782 	.db #0x0e	;  14
      00168B 01                    5783 	.db #0x01	;  1
      00168C 21                    5784 	.db #0x21	;  33
      00168D F5                    5785 	.db #0xf5	; -11
      00168E 29                    5786 	.db #0x29	;  41
      00168F FA                    5787 	.db #0xfa	; -6
      001690 F3                    5788 	.db #0xf3	; -13
      001691 03                    5789 	.db #0x03	;  3
      001692 12                    5790 	.db #0x12	;  18
      001693 00                    5791 	.db #0x00	;  0
      001694 F2                    5792 	.db #0xf2	; -14
      001695 FE                    5793 	.db #0xfe	; -2
      001696 02                    5794 	.db #0x02	;  2
      001697 15                    5795 	.db #0x15	;  21
      001698 FB                    5796 	.db #0xfb	; -5
      001699 05                    5797 	.db #0x05	;  5
      00169A 03                    5798 	.db #0x03	;  3
      00169B F7                    5799 	.db #0xf7	; -9
      00169C FB                    5800 	.db #0xfb	; -5
      00169D 06                    5801 	.db #0x06	;  6
      00169E EB                    5802 	.db #0xeb	; -21
      00169F EE                    5803 	.db #0xee	; -18
      0016A0 20                    5804 	.db #0x20	;  32
      0016A1 00                    5805 	.db #0x00	;  0
      0016A2 19                    5806 	.db #0x19	;  25
      0016A3 CD                    5807 	.db #0xcd	; -51
      0016A4 18                    5808 	.db #0x18	;  24
      0016A5 00                    5809 	.db #0x00	;  0
      0016A6 07                    5810 	.db #0x07	;  7
      0016A7 00                    5811 	.db #0x00	;  0
      0016A8 E7                    5812 	.db #0xe7	; -25
      0016A9 DE                    5813 	.db #0xde	; -34
      0016AA 02                    5814 	.db #0x02	;  2
      0016AB E9                    5815 	.db #0xe9	; -23
      0016AC 13                    5816 	.db #0x13	;  19
      0016AD F8                    5817 	.db #0xf8	; -8
      0016AE ED                    5818 	.db #0xed	; -19
      0016AF F9                    5819 	.db #0xf9	; -7
      0016B0 12                    5820 	.db #0x12	;  18
      0016B1 01                    5821 	.db #0x01	;  1
      0016B2 18                    5822 	.db #0x18	;  24
      0016B3 00                    5823 	.db #0x00	;  0
      0016B4 00                    5824 	.db #0x00	;  0
      0016B5 F8                    5825 	.db #0xf8	; -8
      0016B6 FF                    5826 	.db #0xff	; -1
      0016B7 12                    5827 	.db #0x12	;  18
      0016B8 F9                    5828 	.db #0xf9	; -7
      0016B9 15                    5829 	.db #0x15	;  21
      0016BA 09                    5830 	.db #0x09	;  9
      0016BB FA                    5831 	.db #0xfa	; -6
      0016BC E2                    5832 	.db #0xe2	; -30
      0016BD 00                    5833 	.db #0x00	;  0
      0016BE FC                    5834 	.db #0xfc	; -4
      0016BF F8                    5835 	.db #0xf8	; -8
      0016C0 12                    5836 	.db #0x12	;  18
      0016C1 00                    5837 	.db #0x00	;  0
      0016C2 FC                    5838 	.db #0xfc	; -4
      0016C3 CF                    5839 	.db #0xcf	; -49
      0016C4 13                    5840 	.db #0x13	;  19
      0016C5 06                    5841 	.db #0x06	;  6
      0016C6 0A                    5842 	.db #0x0a	;  10
      0016C7 00                    5843 	.db #0x00	;  0
      0016C8 09                    5844 	.db #0x09	;  9
      0016C9 1B                    5845 	.db #0x1b	;  27
      0016CA 10                    5846 	.db #0x10	;  16
      0016CB F8                    5847 	.db #0xf8	; -8
      0016CC 16                    5848 	.db #0x16	;  22
      0016CD FE                    5849 	.db #0xfe	; -2
      0016CE DB                    5850 	.db #0xdb	; -37
      0016CF F7                    5851 	.db #0xf7	; -9
      0016D0 09                    5852 	.db #0x09	;  9
      0016D1 02                    5853 	.db #0x02	;  2
      0016D2 1C                    5854 	.db #0x1c	;  28
      0016D3 00                    5855 	.db #0x00	;  0
      0016D4 FB                    5856 	.db #0xfb	; -5
      0016D5 EB                    5857 	.db #0xeb	; -21
      0016D6 0A                    5858 	.db #0x0a	;  10
      0016D7 14                    5859 	.db #0x14	;  20
      0016D8 FD                    5860 	.db #0xfd	; -3
      0016D9 1B                    5861 	.db #0x1b	;  27
      0016DA 07                    5862 	.db #0x07	;  7
      0016DB F8                    5863 	.db #0xf8	; -8
      0016DC 07                    5864 	.db #0x07	;  7
      0016DD 07                    5865 	.db #0x07	;  7
      0016DE FB                    5866 	.db #0xfb	; -5
      0016DF 06                    5867 	.db #0x06	;  6
      0016E0 F5                    5868 	.db #0xf5	; -11
      0016E1 00                    5869 	.db #0x00	;  0
      0016E2 F6                    5870 	.db #0xf6	; -10
      0016E3 F5                    5871 	.db #0xf5	; -11
      0016E4 02                    5872 	.db #0x02	;  2
      0016E5 07                    5873 	.db #0x07	;  7
      0016E6 D4                    5874 	.db #0xd4	; -44
      0016E7 00                    5875 	.db #0x00	;  0
      0016E8 F6                    5876 	.db #0xf6	; -10
      0016E9 11                    5877 	.db #0x11	;  17
      0016EA 15                    5878 	.db #0x15	;  21
      0016EB F2                    5879 	.db #0xf2	; -14
      0016EC 22                    5880 	.db #0x22	;  34
      0016ED 0F                    5881 	.db #0x0f	;  15
      0016EE 06                    5882 	.db #0x06	;  6
      0016EF 07                    5883 	.db #0x07	;  7
      0016F0 F6                    5884 	.db #0xf6	; -10
      0016F1 FC                    5885 	.db #0xfc	; -4
      0016F2 1A                    5886 	.db #0x1a	;  26
      0016F3 00                    5887 	.db #0x00	;  0
      0016F4 0D                    5888 	.db #0x0d	;  13
      0016F5 E4                    5889 	.db #0xe4	; -28
      0016F6 0B                    5890 	.db #0x0b	;  11
      0016F7 22                    5891 	.db #0x22	;  34
      0016F8 F9                    5892 	.db #0xf9	; -7
      0016F9 16                    5893 	.db #0x16	;  22
      0016FA FE                    5894 	.db #0xfe	; -2
      0016FB 14                    5895 	.db #0x14	;  20
      0016FC 1A                    5896 	.db #0x1a	;  26
      0016FD 2B                    5897 	.db #0x2b	;  43
      0016FE 0D                    5898 	.db #0x0d	;  13
      0016FF 03                    5899 	.db #0x03	;  3
      001700 11                    5900 	.db #0x11	;  17
      001701 00                    5901 	.db #0x00	;  0
      001702 FD                    5902 	.db #0xfd	; -3
      001703 05                    5903 	.db #0x05	;  5
      001704 F1                    5904 	.db #0xf1	; -15
      001705 F3                    5905 	.db #0xf3	; -13
      001706 EE                    5906 	.db #0xee	; -18
      001707 00                    5907 	.db #0x00	;  0
      001708 F2                    5908 	.db #0xf2	; -14
      001709 EA                    5909 	.db #0xea	; -22
      00170A 0B                    5910 	.db #0x0b	;  11
      00170B FA                    5911 	.db #0xfa	; -6
      00170C FF                    5912 	.db #0xff	; -1
      00170D F7                    5913 	.db #0xf7	; -9
      00170E E6                    5914 	.db #0xe6	; -26
      00170F 03                    5915 	.db #0x03	;  3
      001710 01                    5916 	.db #0x01	;  1
      001711 03                    5917 	.db #0x03	;  3
      001712 0D                    5918 	.db #0x0d	;  13
      001713 00                    5919 	.db #0x00	;  0
      001714 EB                    5920 	.db #0xeb	; -21
      001715 EA                    5921 	.db #0xea	; -22
      001716 0B                    5922 	.db #0x0b	;  11
      001717 0C                    5923 	.db #0x0c	;  12
      001718 F2                    5924 	.db #0xf2	; -14
      001719 FD                    5925 	.db #0xfd	; -3
      00171A 11                    5926 	.db #0x11	;  17
      00171B 00                    5927 	.db #0x00	;  0
      00171C 05                    5928 	.db #0x05	;  5
      00171D 32                    5929 	.db #0x32	;  50	'2'
      00171E 03                    5930 	.db #0x03	;  3
      00171F 0A                    5931 	.db #0x0a	;  10
      001720 11                    5932 	.db #0x11	;  17
      001721 00                    5933 	.db #0x00	;  0
      001722 06                    5934 	.db #0x06	;  6
      001723 11                    5935 	.db #0x11	;  17
      001724 FA                    5936 	.db #0xfa	; -6
      001725 F1                    5937 	.db #0xf1	; -15
      001726 EB                    5938 	.db #0xeb	; -21
      001727 00                    5939 	.db #0x00	;  0
      001728 EB                    5940 	.db #0xeb	; -21
      001729 EC                    5941 	.db #0xec	; -20
      00172A 04                    5942 	.db #0x04	;  4
      00172B F7                    5943 	.db #0xf7	; -9
      00172C C2                    5944 	.db #0xc2	; -62
      00172D F8                    5945 	.db #0xf8	; -8
      00172E E3                    5946 	.db #0xe3	; -29
      00172F FE                    5947 	.db #0xfe	; -2
      001730 0C                    5948 	.db #0x0c	;  12
      001731 F9                    5949 	.db #0xf9	; -7
      001732 0B                    5950 	.db #0x0b	;  11
      001733 00                    5951 	.db #0x00	;  0
      001734 FB                    5952 	.db #0xfb	; -5
      001735 02                    5953 	.db #0x02	;  2
      001736 05                    5954 	.db #0x05	;  5
      001737 F7                    5955 	.db #0xf7	; -9
      001738 E4                    5956 	.db #0xe4	; -28
      001739 EF                    5957 	.db #0xef	; -17
      00173A 13                    5958 	.db #0x13	;  19
      00173B 01                    5959 	.db #0x01	;  1
      00173C F4                    5960 	.db #0xf4	; -12
      00173D 27                    5961 	.db #0x27	;  39
      00173E 00                    5962 	.db #0x00	;  0
      00173F FA                    5963 	.db #0xfa	; -6
      001740 29                    5964 	.db #0x29	;  41
      001741 00                    5965 	.db #0x00	;  0
      001742 F1                    5966 	.db #0xf1	; -15
      001743 05                    5967 	.db #0x05	;  5
      001744 E2                    5968 	.db #0xe2	; -30
      001745 FA                    5969 	.db #0xfa	; -6
      001746 DE                    5970 	.db #0xde	; -34
      001747 00                    5971 	.db #0x00	;  0
      001748 FB                    5972 	.db #0xfb	; -5
      001749 DA                    5973 	.db #0xda	; -38
      00174A 02                    5974 	.db #0x02	;  2
      00174B DE                    5975 	.db #0xde	; -34
      00174C DA                    5976 	.db #0xda	; -38
      00174D 0B                    5977 	.db #0x0b	;  11
      00174E F9                    5978 	.db #0xf9	; -7
      00174F 00                    5979 	.db #0x00	;  0
      001750 01                    5980 	.db #0x01	;  1
      001751 F5                    5981 	.db #0xf5	; -11
      001752 06                    5982 	.db #0x06	;  6
      001753 00                    5983 	.db #0x00	;  0
      001754 FB                    5984 	.db #0xfb	; -5
      001755 0F                    5985 	.db #0x0f	;  15
      001756 05                    5986 	.db #0x05	;  5
      001757 F3                    5987 	.db #0xf3	; -13
      001758 D4                    5988 	.db #0xd4	; -44
      001759 F8                    5989 	.db #0xf8	; -8
      00175A F0                    5990 	.db #0xf0	; -16
      00175B F4                    5991 	.db #0xf4	; -12
      00175C F5                    5992 	.db #0xf5	; -11
      00175D 2C                    5993 	.db #0x2c	;  44
      00175E F4                    5994 	.db #0xf4	; -12
      00175F F7                    5995 	.db #0xf7	; -9
      001760 24                    5996 	.db #0x24	;  36
      001761 00                    5997 	.db #0x00	;  0
      001762 F5                    5998 	.db #0xf5	; -11
      001763 FB                    5999 	.db #0xfb	; -5
      001764 FA                    6000 	.db #0xfa	; -6
      001765 0C                    6001 	.db #0x0c	;  12
      001766 E6                    6002 	.db #0xe6	; -26
      001767 00                    6003 	.db #0x00	;  0
      001768 00                    6004 	.db #0x00	;  0
      001769 F4                    6005 	.db #0xf4	; -12
      00176A 0A                    6006 	.db #0x0a	;  10
      00176B F8                    6007 	.db #0xf8	; -8
      00176C EF                    6008 	.db #0xef	; -17
      00176D FD                    6009 	.db #0xfd	; -3
      00176E 0A                    6010 	.db #0x0a	;  10
      00176F F4                    6011 	.db #0xf4	; -12
      001770 FF                    6012 	.db #0xff	; -1
      001771 04                    6013 	.db #0x04	;  4
      001772 F4                    6014 	.db #0xf4	; -12
      001773 00                    6015 	.db #0x00	;  0
      001774 FE                    6016 	.db #0xfe	; -2
      001775 0F                    6017 	.db #0x0f	;  15
      001776 13                    6018 	.db #0x13	;  19
      001777 10                    6019 	.db #0x10	;  16
      001778 EE                    6020 	.db #0xee	; -18
      001779 E1                    6021 	.db #0xe1	; -31
      00177A 13                    6022 	.db #0x13	;  19
      00177B 07                    6023 	.db #0x07	;  7
      00177C FE                    6024 	.db #0xfe	; -2
      00177D 05                    6025 	.db #0x05	;  5
      00177E F9                    6026 	.db #0xf9	; -7
      00177F 04                    6027 	.db #0x04	;  4
      001780 15                    6028 	.db #0x15	;  21
      001781 00                    6029 	.db #0x00	;  0
      001782 F7                    6030 	.db #0xf7	; -9
      001783 0E                    6031 	.db #0x0e	;  14
      001784 04                    6032 	.db #0x04	;  4
      001785 04                    6033 	.db #0x04	;  4
      001786 F5                    6034 	.db #0xf5	; -11
      001787 00                    6035 	.db #0x00	;  0
      001788 FE                    6036 	.db #0xfe	; -2
      001789 04                    6037 	.db #0x04	;  4
      00178A 08                    6038 	.db #0x08	;  8
      00178B FC                    6039 	.db #0xfc	; -4
      00178C FE                    6040 	.db #0xfe	; -2
      00178D 00                    6041 	.db #0x00	;  0
      00178E F1                    6042 	.db #0xf1	; -15
      00178F F8                    6043 	.db #0xf8	; -8
      001790 F8                    6044 	.db #0xf8	; -8
      001791 00                    6045 	.db #0x00	;  0
      001792 FD                    6046 	.db #0xfd	; -3
      001793 00                    6047 	.db #0x00	;  0
      001794 02                    6048 	.db #0x02	;  2
      001795 02                    6049 	.db #0x02	;  2
      001796 11                    6050 	.db #0x11	;  17
      001797 06                    6051 	.db #0x06	;  6
      001798 02                    6052 	.db #0x02	;  2
      001799 EA                    6053 	.db #0xea	; -22
      00179A 02                    6054 	.db #0x02	;  2
      00179B 00                    6055 	.db #0x00	;  0
      00179C 00                    6056 	.db #0x00	;  0
      00179D 00                    6057 	.db #0x00	;  0
      00179E 00                    6058 	.db #0x00	;  0
      00179F 00                    6059 	.db #0x00	;  0
      0017A0 00                    6060 	.db #0x00	;  0
      0017A1 00                    6061 	.db #0x00	;  0
      0017A2 00                    6062 	.db #0x00	;  0
      0017A3 00                    6063 	.db #0x00	;  0
      0017A4 00                    6064 	.db #0x00	;  0
      0017A5 00                    6065 	.db #0x00	;  0
      0017A6 00                    6066 	.db #0x00	;  0
      0017A7 00                    6067 	.db #0x00	;  0
      0017A8 00                    6068 	.db #0x00	;  0
      0017A9 00                    6069 	.db #0x00	;  0
      0017AA 00                    6070 	.db #0x00	;  0
      0017AB 00                    6071 	.db #0x00	;  0
      0017AC 00                    6072 	.db #0x00	;  0
      0017AD 00                    6073 	.db #0x00	;  0
      0017AE 00                    6074 	.db #0x00	;  0
      0017AF 00                    6075 	.db #0x00	;  0
      0017B0 00                    6076 	.db #0x00	;  0
      0017B1 00                    6077 	.db #0x00	;  0
      0017B2 00                    6078 	.db #0x00	;  0
      0017B3 00                    6079 	.db #0x00	;  0
      0017B4 00                    6080 	.db #0x00	;  0
      0017B5 00                    6081 	.db #0x00	;  0
      0017B6 00                    6082 	.db #0x00	;  0
      0017B7 00                    6083 	.db #0x00	;  0
      0017B8 00                    6084 	.db #0x00	;  0
      0017B9 00                    6085 	.db #0x00	;  0
      0017BA 00                    6086 	.db #0x00	;  0
      0017BB 00                    6087 	.db #0x00	;  0
      0017BC 00                    6088 	.db #0x00	;  0
      0017BD 00                    6089 	.db #0x00	;  0
      0017BE 00                    6090 	.db #0x00	;  0
      0017BF 00                    6091 	.db #0x00	;  0
      0017C0 00                    6092 	.db #0x00	;  0
      0017C1 00                    6093 	.db #0x00	;  0
      0017C2 00                    6094 	.db #0x00	;  0
      0017C3 00                    6095 	.db #0x00	;  0
      0017C4 00                    6096 	.db #0x00	;  0
      0017C5 00                    6097 	.db #0x00	;  0
      0017C6 00                    6098 	.db #0x00	;  0
      0017C7 00                    6099 	.db #0x00	;  0
      0017C8 00                    6100 	.db #0x00	;  0
      0017C9 00                    6101 	.db #0x00	;  0
      0017CA 00                    6102 	.db #0x00	;  0
      0017CB 00                    6103 	.db #0x00	;  0
      0017CC 00                    6104 	.db #0x00	;  0
      0017CD 00                    6105 	.db #0x00	;  0
      0017CE 00                    6106 	.db #0x00	;  0
      0017CF 00                    6107 	.db #0x00	;  0
      0017D0 00                    6108 	.db #0x00	;  0
      0017D1 00                    6109 	.db #0x00	;  0
      0017D2 00                    6110 	.db #0x00	;  0
      0017D3 00                    6111 	.db #0x00	;  0
      0017D4 00                    6112 	.db #0x00	;  0
      0017D5 00                    6113 	.db #0x00	;  0
      0017D6 00                    6114 	.db #0x00	;  0
      0017D7 00                    6115 	.db #0x00	;  0
      0017D8 00                    6116 	.db #0x00	;  0
      0017D9 00                    6117 	.db #0x00	;  0
      0017DA 00                    6118 	.db #0x00	;  0
      0017DB 01                    6119 	.db #0x01	;  1
      0017DC FF                    6120 	.db #0xff	; -1
      0017DD 00                    6121 	.db #0x00	;  0
      0017DE 01                    6122 	.db #0x01	;  1
      0017DF 05                    6123 	.db #0x05	;  5
      0017E0 03                    6124 	.db #0x03	;  3
      0017E1 00                    6125 	.db #0x00	;  0
      0017E2 FE                    6126 	.db #0xfe	; -2
      0017E3 00                    6127 	.db #0x00	;  0
      0017E4 04                    6128 	.db #0x04	;  4
      0017E5 00                    6129 	.db #0x00	;  0
      0017E6 F9                    6130 	.db #0xf9	; -7
      0017E7 00                    6131 	.db #0x00	;  0
      0017E8 02                    6132 	.db #0x02	;  2
      0017E9 FF                    6133 	.db #0xff	; -1
      0017EA FF                    6134 	.db #0xff	; -1
      0017EB 00                    6135 	.db #0x00	;  0
      0017EC 02                    6136 	.db #0x02	;  2
      0017ED 03                    6137 	.db #0x03	;  3
      0017EE 03                    6138 	.db #0x03	;  3
      0017EF 00                    6139 	.db #0x00	;  0
      0017F0 00                    6140 	.db #0x00	;  0
      0017F1 00                    6141 	.db #0x00	;  0
      0017F2 03                    6142 	.db #0x03	;  3
      0017F3 00                    6143 	.db #0x00	;  0
      0017F4 FE                    6144 	.db #0xfe	; -2
      0017F5 04                    6145 	.db #0x04	;  4
      0017F6 FD                    6146 	.db #0xfd	; -3
      0017F7 08                    6147 	.db #0x08	;  8
      0017F8 FC                    6148 	.db #0xfc	; -4
      0017F9 01                    6149 	.db #0x01	;  1
      0017FA 01                    6150 	.db #0x01	;  1
      0017FB FD                    6151 	.db #0xfd	; -3
      0017FC F1                    6152 	.db #0xf1	; -15
      0017FD 1F                    6153 	.db #0x1f	;  31
      0017FE 1D                    6154 	.db #0x1d	;  29
      0017FF FE                    6155 	.db #0xfe	; -2
      001800 0C                    6156 	.db #0x0c	;  12
      001801 00                    6157 	.db #0x00	;  0
      001802 0D                    6158 	.db #0x0d	;  13
      001803 0D                    6159 	.db #0x0d	;  13
      001804 05                    6160 	.db #0x05	;  5
      001805 ED                    6161 	.db #0xed	; -19
      001806 F2                    6162 	.db #0xf2	; -14
      001807 00                    6163 	.db #0x00	;  0
      001808 09                    6164 	.db #0x09	;  9
      001809 EC                    6165 	.db #0xec	; -20
      00180A 09                    6166 	.db #0x09	;  9
      00180B FC                    6167 	.db #0xfc	; -4
      00180C FE                    6168 	.db #0xfe	; -2
      00180D 08                    6169 	.db #0x08	;  8
      00180E 0D                    6170 	.db #0x0d	;  13
      00180F FB                    6171 	.db #0xfb	; -5
      001810 FC                    6172 	.db #0xfc	; -4
      001811 00                    6173 	.db #0x00	;  0
      001812 15                    6174 	.db #0x15	;  21
      001813 00                    6175 	.db #0x00	;  0
      001814 F5                    6176 	.db #0xf5	; -11
      001815 F8                    6177 	.db #0xf8	; -8
      001816 0A                    6178 	.db #0x0a	;  10
      001817 00                    6179 	.db #0x00	;  0
      001818 05                    6180 	.db #0x05	;  5
      001819 03                    6181 	.db #0x03	;  3
      00181A F7                    6182 	.db #0xf7	; -9
      00181B 0D                    6183 	.db #0x0d	;  13
      00181C F8                    6184 	.db #0xf8	; -8
      00181D 12                    6185 	.db #0x12	;  18
      00181E 2E                    6186 	.db #0x2e	;  46
      00181F 0E                    6187 	.db #0x0e	;  14
      001820 00                    6188 	.db #0x00	;  0
      001821 00                    6189 	.db #0x00	;  0
      001822 0A                    6190 	.db #0x0a	;  10
      001823 FB                    6191 	.db #0xfb	; -5
      001824 04                    6192 	.db #0x04	;  4
      001825 E9                    6193 	.db #0xe9	; -23
      001826 16                    6194 	.db #0x16	;  22
      001827 00                    6195 	.db #0x00	;  0
      001828 12                    6196 	.db #0x12	;  18
      001829 E7                    6197 	.db #0xe7	; -25
      00182A 0B                    6198 	.db #0x0b	;  11
      00182B F2                    6199 	.db #0xf2	; -14
      00182C 08                    6200 	.db #0x08	;  8
      00182D 1B                    6201 	.db #0x1b	;  27
      00182E 1C                    6202 	.db #0x1c	;  28
      00182F F7                    6203 	.db #0xf7	; -9
      001830 FB                    6204 	.db #0xfb	; -5
      001831 F9                    6205 	.db #0xf9	; -7
      001832 F8                    6206 	.db #0xf8	; -8
      001833 00                    6207 	.db #0x00	;  0
      001834 FC                    6208 	.db #0xfc	; -4
      001835 F4                    6209 	.db #0xf4	; -12
      001836 FC                    6210 	.db #0xfc	; -4
      001837 18                    6211 	.db #0x18	;  24
      001838 07                    6212 	.db #0x07	;  7
      001839 03                    6213 	.db #0x03	;  3
      00183A E8                    6214 	.db #0xe8	; -24
      00183B 01                    6215 	.db #0x01	;  1
      00183C E7                    6216 	.db #0xe7	; -25
      00183D 06                    6217 	.db #0x06	;  6
      00183E 0F                    6218 	.db #0x0f	;  15
      00183F F5                    6219 	.db #0xf5	; -11
      001840 04                    6220 	.db #0x04	;  4
      001841 00                    6221 	.db #0x00	;  0
      001842 13                    6222 	.db #0x13	;  19
      001843 CB                    6223 	.db #0xcb	; -53
      001844 FD                    6224 	.db #0xfd	; -3
      001845 FF                    6225 	.db #0xff	; -1
      001846 07                    6226 	.db #0x07	;  7
      001847 00                    6227 	.db #0x00	;  0
      001848 1D                    6228 	.db #0x1d	;  29
      001849 EC                    6229 	.db #0xec	; -20
      00184A 0E                    6230 	.db #0x0e	;  14
      00184B FA                    6231 	.db #0xfa	; -6
      00184C 08                    6232 	.db #0x08	;  8
      00184D FA                    6233 	.db #0xfa	; -6
      00184E 24                    6234 	.db #0x24	;  36
      00184F 01                    6235 	.db #0x01	;  1
      001850 11                    6236 	.db #0x11	;  17
      001851 07                    6237 	.db #0x07	;  7
      001852 02                    6238 	.db #0x02	;  2
      001853 00                    6239 	.db #0x00	;  0
      001854 FB                    6240 	.db #0xfb	; -5
      001855 F0                    6241 	.db #0xf0	; -16
      001856 FC                    6242 	.db #0xfc	; -4
      001857 1C                    6243 	.db #0x1c	;  28
      001858 12                    6244 	.db #0x12	;  18
      001859 E4                    6245 	.db #0xe4	; -28
      00185A EE                    6246 	.db #0xee	; -18
      00185B 05                    6247 	.db #0x05	;  5
      00185C E8                    6248 	.db #0xe8	; -24
      00185D 0B                    6249 	.db #0x0b	;  11
      00185E F9                    6250 	.db #0xf9	; -7
      00185F F9                    6251 	.db #0xf9	; -7
      001860 04                    6252 	.db #0x04	;  4
      001861 00                    6253 	.db #0x00	;  0
      001862 07                    6254 	.db #0x07	;  7
      001863 DE                    6255 	.db #0xde	; -34
      001864 12                    6256 	.db #0x12	;  18
      001865 08                    6257 	.db #0x08	;  8
      001866 13                    6258 	.db #0x13	;  19
      001867 00                    6259 	.db #0x00	;  0
      001868 24                    6260 	.db #0x24	;  36
      001869 FF                    6261 	.db #0xff	; -1
      00186A 0C                    6262 	.db #0x0c	;  12
      00186B ED                    6263 	.db #0xed	; -19
      00186C 20                    6264 	.db #0x20	;  32
      00186D F9                    6265 	.db #0xf9	; -7
      00186E 30                    6266 	.db #0x30	;  48	'0'
      00186F 02                    6267 	.db #0x02	;  2
      001870 03                    6268 	.db #0x03	;  3
      001871 08                    6269 	.db #0x08	;  8
      001872 0A                    6270 	.db #0x0a	;  10
      001873 00                    6271 	.db #0x00	;  0
      001874 F6                    6272 	.db #0xf6	; -10
      001875 FE                    6273 	.db #0xfe	; -2
      001876 04                    6274 	.db #0x04	;  4
      001877 0A                    6275 	.db #0x0a	;  10
      001878 FB                    6276 	.db #0xfb	; -5
      001879 FB                    6277 	.db #0xfb	; -5
      00187A FF                    6278 	.db #0xff	; -1
      00187B 0F                    6279 	.db #0x0f	;  15
      00187C FB                    6280 	.db #0xfb	; -5
      00187D 36                    6281 	.db #0x36	;  54	'6'
      00187E 0A                    6282 	.db #0x0a	;  10
      00187F 08                    6283 	.db #0x08	;  8
      001880 FC                    6284 	.db #0xfc	; -4
      001881 00                    6285 	.db #0x00	;  0
      001882 07                    6286 	.db #0x07	;  7
      001883 E6                    6287 	.db #0xe6	; -26
      001884 14                    6288 	.db #0x14	;  20
      001885 04                    6289 	.db #0x04	;  4
      001886 22                    6290 	.db #0x22	;  34
      001887 00                    6291 	.db #0x00	;  0
      001888 09                    6292 	.db #0x09	;  9
      001889 FD                    6293 	.db #0xfd	; -3
      00188A 14                    6294 	.db #0x14	;  20
      00188B FA                    6295 	.db #0xfa	; -6
      00188C 07                    6296 	.db #0x07	;  7
      00188D 0C                    6297 	.db #0x0c	;  12
      00188E FB                    6298 	.db #0xfb	; -5
      00188F FD                    6299 	.db #0xfd	; -3
      001890 07                    6300 	.db #0x07	;  7
      001891 0D                    6301 	.db #0x0d	;  13
      001892 0E                    6302 	.db #0x0e	;  14
      001893 00                    6303 	.db #0x00	;  0
      001894 00                    6304 	.db #0x00	;  0
      001895 EE                    6305 	.db #0xee	; -18
      001896 0D                    6306 	.db #0x0d	;  13
      001897 0F                    6307 	.db #0x0f	;  15
      001898 16                    6308 	.db #0x16	;  22
      001899 E6                    6309 	.db #0xe6	; -26
      00189A 09                    6310 	.db #0x09	;  9
      00189B 0D                    6311 	.db #0x0d	;  13
      00189C 1D                    6312 	.db #0x1d	;  29
      00189D 43                    6313 	.db #0x43	;  67	'C'
      00189E 03                    6314 	.db #0x03	;  3
      00189F 00                    6315 	.db #0x00	;  0
      0018A0 ED                    6316 	.db #0xed	; -19
      0018A1 00                    6317 	.db #0x00	;  0
      0018A2 FE                    6318 	.db #0xfe	; -2
      0018A3 EE                    6319 	.db #0xee	; -18
      0018A4 1C                    6320 	.db #0x1c	;  28
      0018A5 F3                    6321 	.db #0xf3	; -13
      0018A6 FA                    6322 	.db #0xfa	; -6
      0018A7 00                    6323 	.db #0x00	;  0
      0018A8 00                    6324 	.db #0x00	;  0
      0018A9 19                    6325 	.db #0x19	;  25
      0018AA 0B                    6326 	.db #0x0b	;  11
      0018AB F5                    6327 	.db #0xf5	; -11
      0018AC F2                    6328 	.db #0xf2	; -14
      0018AD FA                    6329 	.db #0xfa	; -6
      0018AE D2                    6330 	.db #0xd2	; -46
      0018AF F6                    6331 	.db #0xf6	; -10
      0018B0 0D                    6332 	.db #0x0d	;  13
      0018B1 07                    6333 	.db #0x07	;  7
      0018B2 0A                    6334 	.db #0x0a	;  10
      0018B3 00                    6335 	.db #0x00	;  0
      0018B4 FF                    6336 	.db #0xff	; -1
      0018B5 D8                    6337 	.db #0xd8	; -40
      0018B6 FB                    6338 	.db #0xfb	; -5
      0018B7 FB                    6339 	.db #0xfb	; -5
      0018B8 F4                    6340 	.db #0xf4	; -12
      0018B9 E1                    6341 	.db #0xe1	; -31
      0018BA 0C                    6342 	.db #0x0c	;  12
      0018BB F6                    6343 	.db #0xf6	; -10
      0018BC 28                    6344 	.db #0x28	;  40
      0018BD 25                    6345 	.db #0x25	;  37
      0018BE F6                    6346 	.db #0xf6	; -10
      0018BF 00                    6347 	.db #0x00	;  0
      0018C0 E8                    6348 	.db #0xe8	; -24
      0018C1 00                    6349 	.db #0x00	;  0
      0018C2 F6                    6350 	.db #0xf6	; -10
      0018C3 FA                    6351 	.db #0xfa	; -6
      0018C4 00                    6352 	.db #0x00	;  0
      0018C5 F8                    6353 	.db #0xf8	; -8
      0018C6 DD                    6354 	.db #0xdd	; -35
      0018C7 00                    6355 	.db #0x00	;  0
      0018C8 EE                    6356 	.db #0xee	; -18
      0018C9 F9                    6357 	.db #0xf9	; -7
      0018CA 03                    6358 	.db #0x03	;  3
      0018CB F5                    6359 	.db #0xf5	; -11
      0018CC B5                    6360 	.db #0xb5	; -75
      0018CD F5                    6361 	.db #0xf5	; -11
      0018CE E2                    6362 	.db #0xe2	; -30
      0018CF 01                    6363 	.db #0x01	;  1
      0018D0 05                    6364 	.db #0x05	;  5
      0018D1 E8                    6365 	.db #0xe8	; -24
      0018D2 F9                    6366 	.db #0xf9	; -7
      0018D3 00                    6367 	.db #0x00	;  0
      0018D4 0E                    6368 	.db #0x0e	;  14
      0018D5 D3                    6369 	.db #0xd3	; -45
      0018D6 09                    6370 	.db #0x09	;  9
      0018D7 10                    6371 	.db #0x10	;  16
      0018D8 E9                    6372 	.db #0xe9	; -23
      0018D9 E3                    6373 	.db #0xe3	; -29
      0018DA 13                    6374 	.db #0x13	;  19
      0018DB ED                    6375 	.db #0xed	; -19
      0018DC FF                    6376 	.db #0xff	; -1
      0018DD 10                    6377 	.db #0x10	;  16
      0018DE F6                    6378 	.db #0xf6	; -10
      0018DF F9                    6379 	.db #0xf9	; -7
      0018E0 0C                    6380 	.db #0x0c	;  12
      0018E1 00                    6381 	.db #0x00	;  0
      0018E2 06                    6382 	.db #0x06	;  6
      0018E3 F0                    6383 	.db #0xf0	; -16
      0018E4 00                    6384 	.db #0x00	;  0
      0018E5 00                    6385 	.db #0x00	;  0
      0018E6 DB                    6386 	.db #0xdb	; -37
      0018E7 00                    6387 	.db #0x00	;  0
      0018E8 F3                    6388 	.db #0xf3	; -13
      0018E9 E6                    6389 	.db #0xe6	; -26
      0018EA 05                    6390 	.db #0x05	;  5
      0018EB EB                    6391 	.db #0xeb	; -21
      0018EC ED                    6392 	.db #0xed	; -19
      0018ED 03                    6393 	.db #0x03	;  3
      0018EE FC                    6394 	.db #0xfc	; -4
      0018EF 06                    6395 	.db #0x06	;  6
      0018F0 FF                    6396 	.db #0xff	; -1
      0018F1 FE                    6397 	.db #0xfe	; -2
      0018F2 13                    6398 	.db #0x13	;  19
      0018F3 00                    6399 	.db #0x00	;  0
      0018F4 06                    6400 	.db #0x06	;  6
      0018F5 DF                    6401 	.db #0xdf	; -33
      0018F6 00                    6402 	.db #0x00	;  0
      0018F7 1D                    6403 	.db #0x1d	;  29
      0018F8 E7                    6404 	.db #0xe7	; -25
      0018F9 EF                    6405 	.db #0xef	; -17
      0018FA 15                    6406 	.db #0x15	;  21
      0018FB ED                    6407 	.db #0xed	; -19
      0018FC 01                    6408 	.db #0x01	;  1
      0018FD 17                    6409 	.db #0x17	;  23
      0018FE F8                    6410 	.db #0xf8	; -8
      0018FF F3                    6411 	.db #0xf3	; -13
      001900 1A                    6412 	.db #0x1a	;  26
      001901 00                    6413 	.db #0x00	;  0
      001902 FE                    6414 	.db #0xfe	; -2
      001903 08                    6415 	.db #0x08	;  8
      001904 FF                    6416 	.db #0xff	; -1
      001905 04                    6417 	.db #0x04	;  4
      001906 E2                    6418 	.db #0xe2	; -30
      001907 00                    6419 	.db #0x00	;  0
      001908 E7                    6420 	.db #0xe7	; -25
      001909 F7                    6421 	.db #0xf7	; -9
      00190A 08                    6422 	.db #0x08	;  8
      00190B F5                    6423 	.db #0xf5	; -11
      00190C F5                    6424 	.db #0xf5	; -11
      00190D FC                    6425 	.db #0xfc	; -4
      00190E F2                    6426 	.db #0xf2	; -14
      00190F 01                    6427 	.db #0x01	;  1
      001910 01                    6428 	.db #0x01	;  1
      001911 0B                    6429 	.db #0x0b	;  11
      001912 F8                    6430 	.db #0xf8	; -8
      001913 00                    6431 	.db #0x00	;  0
      001914 13                    6432 	.db #0x13	;  19
      001915 F8                    6433 	.db #0xf8	; -8
      001916 F8                    6434 	.db #0xf8	; -8
      001917 03                    6435 	.db #0x03	;  3
      001918 EB                    6436 	.db #0xeb	; -21
      001919 E8                    6437 	.db #0xe8	; -24
      00191A F7                    6438 	.db #0xf7	; -9
      00191B 02                    6439 	.db #0x02	;  2
      00191C F9                    6440 	.db #0xf9	; -7
      00191D 16                    6441 	.db #0x16	;  22
      00191E 04                    6442 	.db #0x04	;  4
      00191F F0                    6443 	.db #0xf0	; -16
      001920 14                    6444 	.db #0x14	;  20
      001921 00                    6445 	.db #0x00	;  0
      001922 F6                    6446 	.db #0xf6	; -10
      001923 08                    6447 	.db #0x08	;  8
      001924 0C                    6448 	.db #0x0c	;  12
      001925 04                    6449 	.db #0x04	;  4
      001926 F2                    6450 	.db #0xf2	; -14
      001927 00                    6451 	.db #0x00	;  0
      001928 FE                    6452 	.db #0xfe	; -2
      001929 F7                    6453 	.db #0xf7	; -9
      00192A 10                    6454 	.db #0x10	;  16
      00192B F6                    6455 	.db #0xf6	; -10
      00192C F8                    6456 	.db #0xf8	; -8
      00192D FE                    6457 	.db #0xfe	; -2
      00192E ED                    6458 	.db #0xed	; -19
      00192F E8                    6459 	.db #0xe8	; -24
      001930 0A                    6460 	.db #0x0a	;  10
      001931 09                    6461 	.db #0x09	;  9
      001932 F4                    6462 	.db #0xf4	; -12
      001933 00                    6463 	.db #0x00	;  0
      001934 1D                    6464 	.db #0x1d	;  29
      001935 F6                    6465 	.db #0xf6	; -10
      001936 02                    6466 	.db #0x02	;  2
      001937 1E                    6467 	.db #0x1e	;  30
      001938 FB                    6468 	.db #0xfb	; -5
      001939 DA                    6469 	.db #0xda	; -38
      00193A 04                    6470 	.db #0x04	;  4
      00193B 0A                    6471 	.db #0x0a	;  10
      00193C FD                    6472 	.db #0xfd	; -3
      00193D FD                    6473 	.db #0xfd	; -3
      00193E FD                    6474 	.db #0xfd	; -3
      00193F 00                    6475 	.db #0x00	;  0
      001940 01                    6476 	.db #0x01	;  1
      001941 00                    6477 	.db #0x00	;  0
      001942 F2                    6478 	.db #0xf2	; -14
      001943 09                    6479 	.db #0x09	;  9
      001944 04                    6480 	.db #0x04	;  4
      001945 FF                    6481 	.db #0xff	; -1
      001946 FB                    6482 	.db #0xfb	; -5
      001947 00                    6483 	.db #0x00	;  0
      001948 01                    6484 	.db #0x01	;  1
      001949 00                    6485 	.db #0x00	;  0
      00194A 06                    6486 	.db #0x06	;  6
      00194B 01                    6487 	.db #0x01	;  1
      00194C 00                    6488 	.db #0x00	;  0
      00194D 01                    6489 	.db #0x01	;  1
      00194E F5                    6490 	.db #0xf5	; -11
      00194F 02                    6491 	.db #0x02	;  2
      001950 06                    6492 	.db #0x06	;  6
      001951 00                    6493 	.db #0x00	;  0
      001952 FD                    6494 	.db #0xfd	; -3
      001953 00                    6495 	.db #0x00	;  0
      001954 01                    6496 	.db #0x01	;  1
      001955 F8                    6497 	.db #0xf8	; -8
      001956 07                    6498 	.db #0x07	;  7
      001957 09                    6499 	.db #0x09	;  9
      001958 00                    6500 	.db #0x00	;  0
      001959 ED                    6501 	.db #0xed	; -19
      00195A FE                    6502 	.db #0xfe	; -2
      00195B 00                    6503 	.db #0x00	;  0
      00195C 00                    6504 	.db #0x00	;  0
      00195D 00                    6505 	.db #0x00	;  0
      00195E 00                    6506 	.db #0x00	;  0
      00195F 00                    6507 	.db #0x00	;  0
      001960 00                    6508 	.db #0x00	;  0
      001961 00                    6509 	.db #0x00	;  0
      001962 00                    6510 	.db #0x00	;  0
      001963 00                    6511 	.db #0x00	;  0
      001964 00                    6512 	.db #0x00	;  0
      001965 00                    6513 	.db #0x00	;  0
      001966 00                    6514 	.db #0x00	;  0
      001967 00                    6515 	.db #0x00	;  0
      001968 00                    6516 	.db #0x00	;  0
      001969 00                    6517 	.db #0x00	;  0
      00196A 00                    6518 	.db #0x00	;  0
      00196B 00                    6519 	.db #0x00	;  0
      00196C 00                    6520 	.db #0x00	;  0
      00196D 00                    6521 	.db #0x00	;  0
      00196E 00                    6522 	.db #0x00	;  0
      00196F 00                    6523 	.db #0x00	;  0
      001970 00                    6524 	.db #0x00	;  0
      001971 00                    6525 	.db #0x00	;  0
      001972 00                    6526 	.db #0x00	;  0
      001973 00                    6527 	.db #0x00	;  0
      001974 00                    6528 	.db #0x00	;  0
      001975 00                    6529 	.db #0x00	;  0
      001976 00                    6530 	.db #0x00	;  0
      001977 00                    6531 	.db #0x00	;  0
      001978 00                    6532 	.db #0x00	;  0
      001979 00                    6533 	.db #0x00	;  0
      00197A 00                    6534 	.db #0x00	;  0
      00197B 00                    6535 	.db #0x00	;  0
      00197C 00                    6536 	.db #0x00	;  0
      00197D 00                    6537 	.db #0x00	;  0
      00197E 00                    6538 	.db #0x00	;  0
      00197F 00                    6539 	.db #0x00	;  0
      001980 00                    6540 	.db #0x00	;  0
      001981 00                    6541 	.db #0x00	;  0
      001982 00                    6542 	.db #0x00	;  0
      001983 00                    6543 	.db #0x00	;  0
      001984 00                    6544 	.db #0x00	;  0
      001985 00                    6545 	.db #0x00	;  0
      001986 00                    6546 	.db #0x00	;  0
      001987 00                    6547 	.db #0x00	;  0
      001988 00                    6548 	.db #0x00	;  0
      001989 00                    6549 	.db #0x00	;  0
      00198A 00                    6550 	.db #0x00	;  0
      00198B 00                    6551 	.db #0x00	;  0
      00198C 00                    6552 	.db #0x00	;  0
      00198D 00                    6553 	.db #0x00	;  0
      00198E 00                    6554 	.db #0x00	;  0
      00198F 00                    6555 	.db #0x00	;  0
      001990 00                    6556 	.db #0x00	;  0
      001991 00                    6557 	.db #0x00	;  0
      001992 00                    6558 	.db #0x00	;  0
      001993 00                    6559 	.db #0x00	;  0
      001994 00                    6560 	.db #0x00	;  0
      001995 00                    6561 	.db #0x00	;  0
      001996 00                    6562 	.db #0x00	;  0
      001997 00                    6563 	.db #0x00	;  0
      001998 00                    6564 	.db #0x00	;  0
      001999 00                    6565 	.db #0x00	;  0
      00199A 00                    6566 	.db #0x00	;  0
      00199B 00                    6567 	.db #0x00	;  0
      00199C 00                    6568 	.db #0x00	;  0
      00199D 01                    6569 	.db #0x01	;  1
      00199E 00                    6570 	.db #0x00	;  0
      00199F 00                    6571 	.db #0x00	;  0
      0019A0 00                    6572 	.db #0x00	;  0
      0019A1 00                    6573 	.db #0x00	;  0
      0019A2 01                    6574 	.db #0x01	;  1
      0019A3 01                    6575 	.db #0x01	;  1
      0019A4 00                    6576 	.db #0x00	;  0
      0019A5 00                    6577 	.db #0x00	;  0
      0019A6 00                    6578 	.db #0x00	;  0
      0019A7 00                    6579 	.db #0x00	;  0
      0019A8 01                    6580 	.db #0x01	;  1
      0019A9 00                    6581 	.db #0x00	;  0
      0019AA 00                    6582 	.db #0x00	;  0
      0019AB 00                    6583 	.db #0x00	;  0
      0019AC 00                    6584 	.db #0x00	;  0
      0019AD 00                    6585 	.db #0x00	;  0
      0019AE 00                    6586 	.db #0x00	;  0
      0019AF 00                    6587 	.db #0x00	;  0
      0019B0 FF                    6588 	.db #0xff	; -1
      0019B1 00                    6589 	.db #0x00	;  0
      0019B2 00                    6590 	.db #0x00	;  0
      0019B3 00                    6591 	.db #0x00	;  0
      0019B4 00                    6592 	.db #0x00	;  0
      0019B5 00                    6593 	.db #0x00	;  0
      0019B6 01                    6594 	.db #0x01	;  1
      0019B7 00                    6595 	.db #0x00	;  0
      0019B8 00                    6596 	.db #0x00	;  0
      0019B9 00                    6597 	.db #0x00	;  0
      0019BA 00                    6598 	.db #0x00	;  0
      0019BB FF                    6599 	.db #0xff	; -1
      0019BC FE                    6600 	.db #0xfe	; -2
      0019BD FB                    6601 	.db #0xfb	; -5
      0019BE FD                    6602 	.db #0xfd	; -3
      0019BF 05                    6603 	.db #0x05	;  5
      0019C0 0D                    6604 	.db #0x0d	;  13
      0019C1 00                    6605 	.db #0x00	;  0
      0019C2 0D                    6606 	.db #0x0d	;  13
      0019C3 0E                    6607 	.db #0x0e	;  14
      0019C4 09                    6608 	.db #0x09	;  9
      0019C5 01                    6609 	.db #0x01	;  1
      0019C6 12                    6610 	.db #0x12	;  18
      0019C7 00                    6611 	.db #0x00	;  0
      0019C8 15                    6612 	.db #0x15	;  21
      0019C9 FC                    6613 	.db #0xfc	; -4
      0019CA FD                    6614 	.db #0xfd	; -3
      0019CB 02                    6615 	.db #0x02	;  2
      0019CC EC                    6616 	.db #0xec	; -20
      0019CD 04                    6617 	.db #0x04	;  4
      0019CE EC                    6618 	.db #0xec	; -20
      0019CF FD                    6619 	.db #0xfd	; -3
      0019D0 F5                    6620 	.db #0xf5	; -11
      0019D1 FD                    6621 	.db #0xfd	; -3
      0019D2 FA                    6622 	.db #0xfa	; -6
      0019D3 00                    6623 	.db #0x00	;  0
      0019D4 00                    6624 	.db #0x00	;  0
      0019D5 FE                    6625 	.db #0xfe	; -2
      0019D6 FE                    6626 	.db #0xfe	; -2
      0019D7 0E                    6627 	.db #0x0e	;  14
      0019D8 FD                    6628 	.db #0xfd	; -3
      0019D9 FF                    6629 	.db #0xff	; -1
      0019DA E7                    6630 	.db #0xe7	; -25
      0019DB F8                    6631 	.db #0xf8	; -8
      0019DC FB                    6632 	.db #0xfb	; -5
      0019DD 13                    6633 	.db #0x13	;  19
      0019DE F6                    6634 	.db #0xf6	; -10
      0019DF 0A                    6635 	.db #0x0a	;  10
      0019E0 07                    6636 	.db #0x07	;  7
      0019E1 00                    6637 	.db #0x00	;  0
      0019E2 09                    6638 	.db #0x09	;  9
      0019E3 08                    6639 	.db #0x08	;  8
      0019E4 EE                    6640 	.db #0xee	; -18
      0019E5 03                    6641 	.db #0x03	;  3
      0019E6 1E                    6642 	.db #0x1e	;  30
      0019E7 00                    6643 	.db #0x00	;  0
      0019E8 27                    6644 	.db #0x27	;  39
      0019E9 E1                    6645 	.db #0xe1	; -31
      0019EA FF                    6646 	.db #0xff	; -1
      0019EB EA                    6647 	.db #0xea	; -22
      0019EC EE                    6648 	.db #0xee	; -18
      0019ED 0B                    6649 	.db #0x0b	;  11
      0019EE FB                    6650 	.db #0xfb	; -5
      0019EF 0B                    6651 	.db #0x0b	;  11
      0019F0 F6                    6652 	.db #0xf6	; -10
      0019F1 E2                    6653 	.db #0xe2	; -30
      0019F2 F3                    6654 	.db #0xf3	; -13
      0019F3 00                    6655 	.db #0x00	;  0
      0019F4 05                    6656 	.db #0x05	;  5
      0019F5 EC                    6657 	.db #0xec	; -20
      0019F6 FB                    6658 	.db #0xfb	; -5
      0019F7 13                    6659 	.db #0x13	;  19
      0019F8 F2                    6660 	.db #0xf2	; -14
      0019F9 EE                    6661 	.db #0xee	; -18
      0019FA EC                    6662 	.db #0xec	; -20
      0019FB F5                    6663 	.db #0xf5	; -11
      0019FC 01                    6664 	.db #0x01	;  1
      0019FD 30                    6665 	.db #0x30	;  48	'0'
      0019FE 04                    6666 	.db #0x04	;  4
      0019FF 27                    6667 	.db #0x27	;  39
      001A00 F5                    6668 	.db #0xf5	; -11
      001A01 00                    6669 	.db #0x00	;  0
      001A02 FE                    6670 	.db #0xfe	; -2
      001A03 16                    6671 	.db #0x16	;  22
      001A04 F3                    6672 	.db #0xf3	; -13
      001A05 06                    6673 	.db #0x06	;  6
      001A06 1B                    6674 	.db #0x1b	;  27
      001A07 00                    6675 	.db #0x00	;  0
      001A08 1B                    6676 	.db #0x1b	;  27
      001A09 F4                    6677 	.db #0xf4	; -12
      001A0A 0A                    6678 	.db #0x0a	;  10
      001A0B F9                    6679 	.db #0xf9	; -7
      001A0C FD                    6680 	.db #0xfd	; -3
      001A0D FB                    6681 	.db #0xfb	; -5
      001A0E 13                    6682 	.db #0x13	;  19
      001A0F 0B                    6683 	.db #0x0b	;  11
      001A10 FF                    6684 	.db #0xff	; -1
      001A11 05                    6685 	.db #0x05	;  5
      001A12 E2                    6686 	.db #0xe2	; -30
      001A13 00                    6687 	.db #0x00	;  0
      001A14 EA                    6688 	.db #0xea	; -22
      001A15 D7                    6689 	.db #0xd7	; -41
      001A16 FF                    6690 	.db #0xff	; -1
      001A17 0E                    6691 	.db #0x0e	;  14
      001A18 03                    6692 	.db #0x03	;  3
      001A19 DE                    6693 	.db #0xde	; -34
      001A1A FD                    6694 	.db #0xfd	; -3
      001A1B F2                    6695 	.db #0xf2	; -14
      001A1C 0D                    6696 	.db #0x0d	;  13
      001A1D 2B                    6697 	.db #0x2b	;  43
      001A1E F4                    6698 	.db #0xf4	; -12
      001A1F 03                    6699 	.db #0x03	;  3
      001A20 0F                    6700 	.db #0x0f	;  15
      001A21 00                    6701 	.db #0x00	;  0
      001A22 01                    6702 	.db #0x01	;  1
      001A23 29                    6703 	.db #0x29	;  41
      001A24 FC                    6704 	.db #0xfc	; -4
      001A25 01                    6705 	.db #0x01	;  1
      001A26 0F                    6706 	.db #0x0f	;  15
      001A27 00                    6707 	.db #0x00	;  0
      001A28 07                    6708 	.db #0x07	;  7
      001A29 EF                    6709 	.db #0xef	; -17
      001A2A FE                    6710 	.db #0xfe	; -2
      001A2B 0C                    6711 	.db #0x0c	;  12
      001A2C E9                    6712 	.db #0xe9	; -23
      001A2D 05                    6713 	.db #0x05	;  5
      001A2E 13                    6714 	.db #0x13	;  19
      001A2F 17                    6715 	.db #0x17	;  23
      001A30 03                    6716 	.db #0x03	;  3
      001A31 FE                    6717 	.db #0xfe	; -2
      001A32 F2                    6718 	.db #0xf2	; -14
      001A33 00                    6719 	.db #0x00	;  0
      001A34 0F                    6720 	.db #0x0f	;  15
      001A35 D5                    6721 	.db #0xd5	; -43
      001A36 FB                    6722 	.db #0xfb	; -5
      001A37 07                    6723 	.db #0x07	;  7
      001A38 09                    6724 	.db #0x09	;  9
      001A39 F5                    6725 	.db #0xf5	; -11
      001A3A F6                    6726 	.db #0xf6	; -10
      001A3B FA                    6727 	.db #0xfa	; -6
      001A3C FC                    6728 	.db #0xfc	; -4
      001A3D 30                    6729 	.db #0x30	;  48	'0'
      001A3E 05                    6730 	.db #0x05	;  5
      001A3F 07                    6731 	.db #0x07	;  7
      001A40 06                    6732 	.db #0x06	;  6
      001A41 00                    6733 	.db #0x00	;  0
      001A42 F7                    6734 	.db #0xf7	; -9
      001A43 0E                    6735 	.db #0x0e	;  14
      001A44 FC                    6736 	.db #0xfc	; -4
      001A45 03                    6737 	.db #0x03	;  3
      001A46 29                    6738 	.db #0x29	;  41
      001A47 00                    6739 	.db #0x00	;  0
      001A48 0C                    6740 	.db #0x0c	;  12
      001A49 03                    6741 	.db #0x03	;  3
      001A4A 09                    6742 	.db #0x09	;  9
      001A4B FF                    6743 	.db #0xff	; -1
      001A4C E4                    6744 	.db #0xe4	; -28
      001A4D 07                    6745 	.db #0x07	;  7
      001A4E 0A                    6746 	.db #0x0a	;  10
      001A4F 0B                    6747 	.db #0x0b	;  11
      001A50 0D                    6748 	.db #0x0d	;  13
      001A51 F7                    6749 	.db #0xf7	; -9
      001A52 E2                    6750 	.db #0xe2	; -30
      001A53 00                    6751 	.db #0x00	;  0
      001A54 FB                    6752 	.db #0xfb	; -5
      001A55 C4                    6753 	.db #0xc4	; -60
      001A56 02                    6754 	.db #0x02	;  2
      001A57 F5                    6755 	.db #0xf5	; -11
      001A58 04                    6756 	.db #0x04	;  4
      001A59 F0                    6757 	.db #0xf0	; -16
      001A5A 04                    6758 	.db #0x04	;  4
      001A5B 0D                    6759 	.db #0x0d	;  13
      001A5C 18                    6760 	.db #0x18	;  24
      001A5D 15                    6761 	.db #0x15	;  21
      001A5E FA                    6762 	.db #0xfa	; -6
      001A5F EF                    6763 	.db #0xef	; -17
      001A60 EC                    6764 	.db #0xec	; -20
      001A61 00                    6765 	.db #0x00	;  0
      001A62 FB                    6766 	.db #0xfb	; -5
      001A63 02                    6767 	.db #0x02	;  2
      001A64 1E                    6768 	.db #0x1e	;  30
      001A65 03                    6769 	.db #0x03	;  3
      001A66 ED                    6770 	.db #0xed	; -19
      001A67 00                    6771 	.db #0x00	;  0
      001A68 05                    6772 	.db #0x05	;  5
      001A69 0F                    6773 	.db #0x0f	;  15
      001A6A F6                    6774 	.db #0xf6	; -10
      001A6B 06                    6775 	.db #0x06	;  6
      001A6C C5                    6776 	.db #0xc5	; -59
      001A6D 05                    6777 	.db #0x05	;  5
      001A6E FF                    6778 	.db #0xff	; -1
      001A6F F6                    6779 	.db #0xf6	; -10
      001A70 0D                    6780 	.db #0x0d	;  13
      001A71 F7                    6781 	.db #0xf7	; -9
      001A72 E8                    6782 	.db #0xe8	; -24
      001A73 00                    6783 	.db #0x00	;  0
      001A74 03                    6784 	.db #0x03	;  3
      001A75 D2                    6785 	.db #0xd2	; -46
      001A76 FD                    6786 	.db #0xfd	; -3
      001A77 F9                    6787 	.db #0xf9	; -7
      001A78 07                    6788 	.db #0x07	;  7
      001A79 ED                    6789 	.db #0xed	; -19
      001A7A FF                    6790 	.db #0xff	; -1
      001A7B FB                    6791 	.db #0xfb	; -5
      001A7C 16                    6792 	.db #0x16	;  22
      001A7D 0E                    6793 	.db #0x0e	;  14
      001A7E FC                    6794 	.db #0xfc	; -4
      001A7F 04                    6795 	.db #0x04	;  4
      001A80 EB                    6796 	.db #0xeb	; -21
      001A81 00                    6797 	.db #0x00	;  0
      001A82 F8                    6798 	.db #0xf8	; -8
      001A83 1F                    6799 	.db #0x1f	;  31
      001A84 0E                    6800 	.db #0x0e	;  14
      001A85 00                    6801 	.db #0x00	;  0
      001A86 D5                    6802 	.db #0xd5	; -43
      001A87 00                    6803 	.db #0x00	;  0
      001A88 ED                    6804 	.db #0xed	; -19
      001A89 22                    6805 	.db #0x22	;  34
      001A8A F0                    6806 	.db #0xf0	; -16
      001A8B 10                    6807 	.db #0x10	;  16
      001A8C FC                    6808 	.db #0xfc	; -4
      001A8D F5                    6809 	.db #0xf5	; -11
      001A8E F0                    6810 	.db #0xf0	; -16
      001A8F F0                    6811 	.db #0xf0	; -16
      001A90 0C                    6812 	.db #0x0c	;  12
      001A91 06                    6813 	.db #0x06	;  6
      001A92 F7                    6814 	.db #0xf7	; -9
      001A93 00                    6815 	.db #0x00	;  0
      001A94 F3                    6816 	.db #0xf3	; -13
      001A95 D7                    6817 	.db #0xd7	; -41
      001A96 16                    6818 	.db #0x16	;  22
      001A97 F7                    6819 	.db #0xf7	; -9
      001A98 D4                    6820 	.db #0xd4	; -44
      001A99 FA                    6821 	.db #0xfa	; -6
      001A9A 19                    6822 	.db #0x19	;  25
      001A9B 08                    6823 	.db #0x08	;  8
      001A9C 07                    6824 	.db #0x07	;  7
      001A9D F7                    6825 	.db #0xf7	; -9
      001A9E ED                    6826 	.db #0xed	; -19
      001A9F FC                    6827 	.db #0xfc	; -4
      001AA0 E7                    6828 	.db #0xe7	; -25
      001AA1 00                    6829 	.db #0x00	;  0
      001AA2 EC                    6830 	.db #0xec	; -20
      001AA3 1B                    6831 	.db #0x1b	;  27
      001AA4 FC                    6832 	.db #0xfc	; -4
      001AA5 F3                    6833 	.db #0xf3	; -13
      001AA6 DD                    6834 	.db #0xdd	; -35
      001AA7 00                    6835 	.db #0x00	;  0
      001AA8 E8                    6836 	.db #0xe8	; -24
      001AA9 F3                    6837 	.db #0xf3	; -13
      001AAA 01                    6838 	.db #0x01	;  1
      001AAB 09                    6839 	.db #0x09	;  9
      001AAC 09                    6840 	.db #0x09	;  9
      001AAD F6                    6841 	.db #0xf6	; -10
      001AAE F6                    6842 	.db #0xf6	; -10
      001AAF 0E                    6843 	.db #0x0e	;  14
      001AB0 09                    6844 	.db #0x09	;  9
      001AB1 04                    6845 	.db #0x04	;  4
      001AB2 E3                    6846 	.db #0xe3	; -29
      001AB3 00                    6847 	.db #0x00	;  0
      001AB4 1B                    6848 	.db #0x1b	;  27
      001AB5 E0                    6849 	.db #0xe0	; -32
      001AB6 16                    6850 	.db #0x16	;  22
      001AB7 03                    6851 	.db #0x03	;  3
      001AB8 F5                    6852 	.db #0xf5	; -11
      001AB9 EF                    6853 	.db #0xef	; -17
      001ABA 06                    6854 	.db #0x06	;  6
      001ABB 1C                    6855 	.db #0x1c	;  28
      001ABC 03                    6856 	.db #0x03	;  3
      001ABD FC                    6857 	.db #0xfc	; -4
      001ABE F2                    6858 	.db #0xf2	; -14
      001ABF F5                    6859 	.db #0xf5	; -11
      001AC0 F7                    6860 	.db #0xf7	; -9
      001AC1 00                    6861 	.db #0x00	;  0
      001AC2 09                    6862 	.db #0x09	;  9
      001AC3 12                    6863 	.db #0x12	;  18
      001AC4 07                    6864 	.db #0x07	;  7
      001AC5 FC                    6865 	.db #0xfc	; -4
      001AC6 F4                    6866 	.db #0xf4	; -12
      001AC7 00                    6867 	.db #0x00	;  0
      001AC8 05                    6868 	.db #0x05	;  5
      001AC9 F0                    6869 	.db #0xf0	; -16
      001ACA F1                    6870 	.db #0xf1	; -15
      001ACB FE                    6871 	.db #0xfe	; -2
      001ACC 00                    6872 	.db #0x00	;  0
      001ACD FA                    6873 	.db #0xfa	; -6
      001ACE ED                    6874 	.db #0xed	; -19
      001ACF FB                    6875 	.db #0xfb	; -5
      001AD0 01                    6876 	.db #0x01	;  1
      001AD1 03                    6877 	.db #0x03	;  3
      001AD2 F7                    6878 	.db #0xf7	; -9
      001AD3 00                    6879 	.db #0x00	;  0
      001AD4 04                    6880 	.db #0x04	;  4
      001AD5 EB                    6881 	.db #0xeb	; -21
      001AD6 08                    6882 	.db #0x08	;  8
      001AD7 0E                    6883 	.db #0x0e	;  14
      001AD8 ED                    6884 	.db #0xed	; -19
      001AD9 02                    6885 	.db #0x02	;  2
      001ADA 0E                    6886 	.db #0x0e	;  14
      001ADB 0A                    6887 	.db #0x0a	;  10
      001ADC 01                    6888 	.db #0x01	;  1
      001ADD 00                    6889 	.db #0x00	;  0
      001ADE FE                    6890 	.db #0xfe	; -2
      001ADF F6                    6891 	.db #0xf6	; -10
      001AE0 0A                    6892 	.db #0x0a	;  10
      001AE1 00                    6893 	.db #0x00	;  0
      001AE2 0C                    6894 	.db #0x0c	;  12
      001AE3 06                    6895 	.db #0x06	;  6
      001AE4 F3                    6896 	.db #0xf3	; -13
      001AE5 FF                    6897 	.db #0xff	; -1
      001AE6 FE                    6898 	.db #0xfe	; -2
      001AE7 00                    6899 	.db #0x00	;  0
      001AE8 02                    6900 	.db #0x02	;  2
      001AE9 02                    6901 	.db #0x02	;  2
      001AEA 03                    6902 	.db #0x03	;  3
      001AEB FC                    6903 	.db #0xfc	; -4
      001AEC 00                    6904 	.db #0x00	;  0
      001AED F5                    6905 	.db #0xf5	; -11
      001AEE F9                    6906 	.db #0xf9	; -7
      001AEF F9                    6907 	.db #0xf9	; -7
      001AF0 F8                    6908 	.db #0xf8	; -8
      001AF1 03                    6909 	.db #0x03	;  3
      001AF2 F7                    6910 	.db #0xf7	; -9
      001AF3 00                    6911 	.db #0x00	;  0
      001AF4 0F                    6912 	.db #0x0f	;  15
      001AF5 EE                    6913 	.db #0xee	; -18
      001AF6 FF                    6914 	.db #0xff	; -1
      001AF7 05                    6915 	.db #0x05	;  5
      001AF8 00                    6916 	.db #0x00	;  0
      001AF9 FA                    6917 	.db #0xfa	; -6
      001AFA 04                    6918 	.db #0x04	;  4
      001AFB 01                    6919 	.db #0x01	;  1
      001AFC 00                    6920 	.db #0x00	;  0
      001AFD 00                    6921 	.db #0x00	;  0
      001AFE FF                    6922 	.db #0xff	; -1
      001AFF FF                    6923 	.db #0xff	; -1
      001B00 00                    6924 	.db #0x00	;  0
      001B01 00                    6925 	.db #0x00	;  0
      001B02 00                    6926 	.db #0x00	;  0
      001B03 00                    6927 	.db #0x00	;  0
      001B04 00                    6928 	.db #0x00	;  0
      001B05 00                    6929 	.db #0x00	;  0
      001B06 00                    6930 	.db #0x00	;  0
      001B07 00                    6931 	.db #0x00	;  0
      001B08 01                    6932 	.db #0x01	;  1
      001B09 00                    6933 	.db #0x00	;  0
      001B0A 00                    6934 	.db #0x00	;  0
      001B0B 01                    6935 	.db #0x01	;  1
      001B0C 00                    6936 	.db #0x00	;  0
      001B0D 00                    6937 	.db #0x00	;  0
      001B0E FF                    6938 	.db #0xff	; -1
      001B0F 00                    6939 	.db #0x00	;  0
      001B10 00                    6940 	.db #0x00	;  0
      001B11 00                    6941 	.db #0x00	;  0
      001B12 00                    6942 	.db #0x00	;  0
      001B13 00                    6943 	.db #0x00	;  0
      001B14 00                    6944 	.db #0x00	;  0
      001B15 00                    6945 	.db #0x00	;  0
      001B16 01                    6946 	.db #0x01	;  1
      001B17 00                    6947 	.db #0x00	;  0
      001B18 00                    6948 	.db #0x00	;  0
      001B19 00                    6949 	.db #0x00	;  0
      001B1A 00                    6950 	.db #0x00	;  0
      001B1B 00                    6951 	.db #0x00	;  0
      001B1C 00                    6952 	.db #0x00	;  0
      001B1D 00                    6953 	.db #0x00	;  0
      001B1E 00                    6954 	.db #0x00	;  0
      001B1F 00                    6955 	.db #0x00	;  0
      001B20 00                    6956 	.db #0x00	;  0
      001B21 00                    6957 	.db #0x00	;  0
      001B22 00                    6958 	.db #0x00	;  0
      001B23 00                    6959 	.db #0x00	;  0
      001B24 00                    6960 	.db #0x00	;  0
      001B25 00                    6961 	.db #0x00	;  0
      001B26 00                    6962 	.db #0x00	;  0
      001B27 00                    6963 	.db #0x00	;  0
      001B28 00                    6964 	.db #0x00	;  0
      001B29 00                    6965 	.db #0x00	;  0
      001B2A 00                    6966 	.db #0x00	;  0
      001B2B 00                    6967 	.db #0x00	;  0
      001B2C 00                    6968 	.db #0x00	;  0
      001B2D 00                    6969 	.db #0x00	;  0
      001B2E 00                    6970 	.db #0x00	;  0
      001B2F 00                    6971 	.db #0x00	;  0
      001B30 00                    6972 	.db #0x00	;  0
      001B31 00                    6973 	.db #0x00	;  0
      001B32 00                    6974 	.db #0x00	;  0
      001B33 00                    6975 	.db #0x00	;  0
      001B34 00                    6976 	.db #0x00	;  0
      001B35 00                    6977 	.db #0x00	;  0
      001B36 00                    6978 	.db #0x00	;  0
      001B37 00                    6979 	.db #0x00	;  0
      001B38 00                    6980 	.db #0x00	;  0
      001B39 00                    6981 	.db #0x00	;  0
      001B3A 00                    6982 	.db #0x00	;  0
      001B3B 00                    6983 	.db #0x00	;  0
      001B3C 00                    6984 	.db #0x00	;  0
      001B3D 00                    6985 	.db #0x00	;  0
      001B3E 00                    6986 	.db #0x00	;  0
      001B3F 00                    6987 	.db #0x00	;  0
      001B40 00                    6988 	.db #0x00	;  0
      001B41 00                    6989 	.db #0x00	;  0
      001B42 00                    6990 	.db #0x00	;  0
      001B43 00                    6991 	.db #0x00	;  0
      001B44 00                    6992 	.db #0x00	;  0
      001B45 00                    6993 	.db #0x00	;  0
      001B46 00                    6994 	.db #0x00	;  0
      001B47 00                    6995 	.db #0x00	;  0
      001B48 00                    6996 	.db #0x00	;  0
      001B49 00                    6997 	.db #0x00	;  0
      001B4A 00                    6998 	.db #0x00	;  0
      001B4B 00                    6999 	.db #0x00	;  0
      001B4C 00                    7000 	.db #0x00	;  0
      001B4D 00                    7001 	.db #0x00	;  0
      001B4E 00                    7002 	.db #0x00	;  0
      001B4F 00                    7003 	.db #0x00	;  0
      001B50 00                    7004 	.db #0x00	;  0
      001B51 00                    7005 	.db #0x00	;  0
      001B52 00                    7006 	.db #0x00	;  0
      001B53 00                    7007 	.db #0x00	;  0
      001B54 00                    7008 	.db #0x00	;  0
      001B55 00                    7009 	.db #0x00	;  0
      001B56 00                    7010 	.db #0x00	;  0
      001B57 00                    7011 	.db #0x00	;  0
      001B58 00                    7012 	.db #0x00	;  0
      001B59 00                    7013 	.db #0x00	;  0
      001B5A 00                    7014 	.db #0x00	;  0
      001B5B 00                    7015 	.db #0x00	;  0
      001B5C 00                    7016 	.db #0x00	;  0
      001B5D 00                    7017 	.db #0x00	;  0
      001B5E 00                    7018 	.db #0x00	;  0
      001B5F 00                    7019 	.db #0x00	;  0
      001B60 00                    7020 	.db #0x00	;  0
      001B61 00                    7021 	.db #0x00	;  0
      001B62 00                    7022 	.db #0x00	;  0
      001B63 00                    7023 	.db #0x00	;  0
      001B64 00                    7024 	.db #0x00	;  0
      001B65 00                    7025 	.db #0x00	;  0
      001B66 00                    7026 	.db #0x00	;  0
      001B67 00                    7027 	.db #0x00	;  0
      001B68 00                    7028 	.db #0x00	;  0
      001B69 00                    7029 	.db #0x00	;  0
      001B6A 00                    7030 	.db #0x00	;  0
      001B6B 00                    7031 	.db #0x00	;  0
      001B6C 00                    7032 	.db #0x00	;  0
      001B6D 00                    7033 	.db #0x00	;  0
      001B6E 00                    7034 	.db #0x00	;  0
      001B6F 00                    7035 	.db #0x00	;  0
      001B70 00                    7036 	.db #0x00	;  0
      001B71 00                    7037 	.db #0x00	;  0
      001B72 00                    7038 	.db #0x00	;  0
      001B73 00                    7039 	.db #0x00	;  0
      001B74 00                    7040 	.db #0x00	;  0
      001B75 00                    7041 	.db #0x00	;  0
      001B76 00                    7042 	.db #0x00	;  0
      001B77 00                    7043 	.db #0x00	;  0
      001B78 00                    7044 	.db #0x00	;  0
      001B79 00                    7045 	.db #0x00	;  0
      001B7A 00                    7046 	.db #0x00	;  0
      001B7B 00                    7047 	.db #0x00	;  0
      001B7C 00                    7048 	.db #0x00	;  0
      001B7D 02                    7049 	.db #0x02	;  2
      001B7E FB                    7050 	.db #0xfb	; -5
      001B7F 00                    7051 	.db #0x00	;  0
      001B80 FF                    7052 	.db #0xff	; -1
      001B81 00                    7053 	.db #0x00	;  0
      001B82 05                    7054 	.db #0x05	;  5
      001B83 01                    7055 	.db #0x01	;  1
      001B84 FA                    7056 	.db #0xfa	; -6
      001B85 01                    7057 	.db #0x01	;  1
      001B86 FF                    7058 	.db #0xff	; -1
      001B87 00                    7059 	.db #0x00	;  0
      001B88 01                    7060 	.db #0x01	;  1
      001B89 00                    7061 	.db #0x00	;  0
      001B8A 00                    7062 	.db #0x00	;  0
      001B8B 00                    7063 	.db #0x00	;  0
      001B8C 00                    7064 	.db #0x00	;  0
      001B8D 00                    7065 	.db #0x00	;  0
      001B8E 00                    7066 	.db #0x00	;  0
      001B8F 00                    7067 	.db #0x00	;  0
      001B90 F8                    7068 	.db #0xf8	; -8
      001B91 FF                    7069 	.db #0xff	; -1
      001B92 FD                    7070 	.db #0xfd	; -3
      001B93 00                    7071 	.db #0x00	;  0
      001B94 02                    7072 	.db #0x02	;  2
      001B95 00                    7073 	.db #0x00	;  0
      001B96 00                    7074 	.db #0x00	;  0
      001B97 00                    7075 	.db #0x00	;  0
      001B98 02                    7076 	.db #0x02	;  2
      001B99 00                    7077 	.db #0x00	;  0
      001B9A 05                    7078 	.db #0x05	;  5
      001B9B 00                    7079 	.db #0x00	;  0
      001B9C 00                    7080 	.db #0x00	;  0
      001B9D FC                    7081 	.db #0xfc	; -4
      001B9E F9                    7082 	.db #0xf9	; -7
      001B9F 00                    7083 	.db #0x00	;  0
      001BA0 03                    7084 	.db #0x03	;  3
      001BA1 00                    7085 	.db #0x00	;  0
      001BA2 FF                    7086 	.db #0xff	; -1
      001BA3 04                    7087 	.db #0x04	;  4
      001BA4 04                    7088 	.db #0x04	;  4
      001BA5 00                    7089 	.db #0x00	;  0
      001BA6 08                    7090 	.db #0x08	;  8
      001BA7 00                    7091 	.db #0x00	;  0
      001BA8 04                    7092 	.db #0x04	;  4
      001BA9 01                    7093 	.db #0x01	;  1
      001BAA 00                    7094 	.db #0x00	;  0
      001BAB FF                    7095 	.db #0xff	; -1
      001BAC FA                    7096 	.db #0xfa	; -6
      001BAD 03                    7097 	.db #0x03	;  3
      001BAE FF                    7098 	.db #0xff	; -1
      001BAF 00                    7099 	.db #0x00	;  0
      001BB0 00                    7100 	.db #0x00	;  0
      001BB1 FD                    7101 	.db #0xfd	; -3
      001BB2 F5                    7102 	.db #0xf5	; -11
      001BB3 00                    7103 	.db #0x00	;  0
      001BB4 02                    7104 	.db #0x02	;  2
      001BB5 FC                    7105 	.db #0xfc	; -4
      001BB6 00                    7106 	.db #0x00	;  0
      001BB7 07                    7107 	.db #0x07	;  7
      001BB8 FF                    7108 	.db #0xff	; -1
      001BB9 00                    7109 	.db #0x00	;  0
      001BBA 00                    7110 	.db #0x00	;  0
      001BBB 02                    7111 	.db #0x02	;  2
      001BBC 03                    7112 	.db #0x03	;  3
      001BBD F8                    7113 	.db #0xf8	; -8
      001BBE FE                    7114 	.db #0xfe	; -2
      001BBF 01                    7115 	.db #0x01	;  1
      001BC0 00                    7116 	.db #0x00	;  0
      001BC1 00                    7117 	.db #0x00	;  0
      001BC2 F9                    7118 	.db #0xf9	; -7
      001BC3 05                    7119 	.db #0x05	;  5
      001BC4 F8                    7120 	.db #0xf8	; -8
      001BC5 FF                    7121 	.db #0xff	; -1
      001BC6 0A                    7122 	.db #0x0a	;  10
      001BC7 00                    7123 	.db #0x00	;  0
      001BC8 07                    7124 	.db #0x07	;  7
      001BC9 05                    7125 	.db #0x05	;  5
      001BCA 03                    7126 	.db #0x03	;  3
      001BCB 06                    7127 	.db #0x06	;  6
      001BCC F4                    7128 	.db #0xf4	; -12
      001BCD 01                    7129 	.db #0x01	;  1
      001BCE FA                    7130 	.db #0xfa	; -6
      001BCF 04                    7131 	.db #0x04	;  4
      001BD0 08                    7132 	.db #0x08	;  8
      001BD1 FC                    7133 	.db #0xfc	; -4
      001BD2 FB                    7134 	.db #0xfb	; -5
      001BD3 00                    7135 	.db #0x00	;  0
      001BD4 01                    7136 	.db #0x01	;  1
      001BD5 FE                    7137 	.db #0xfe	; -2
      001BD6 00                    7138 	.db #0x00	;  0
      001BD7 04                    7139 	.db #0x04	;  4
      001BD8 FE                    7140 	.db #0xfe	; -2
      001BD9 FB                    7141 	.db #0xfb	; -5
      001BDA F4                    7142 	.db #0xf4	; -12
      001BDB FA                    7143 	.db #0xfa	; -6
      001BDC FA                    7144 	.db #0xfa	; -6
      001BDD 04                    7145 	.db #0x04	;  4
      001BDE F4                    7146 	.db #0xf4	; -12
      001BDF F8                    7147 	.db #0xf8	; -8
      001BE0 FD                    7148 	.db #0xfd	; -3
      001BE1 00                    7149 	.db #0x00	;  0
      001BE2 FF                    7150 	.db #0xff	; -1
      001BE3 0F                    7151 	.db #0x0f	;  15
      001BE4 01                    7152 	.db #0x01	;  1
      001BE5 00                    7153 	.db #0x00	;  0
      001BE6 01                    7154 	.db #0x01	;  1
      001BE7 00                    7155 	.db #0x00	;  0
      001BE8 04                    7156 	.db #0x04	;  4
      001BE9 02                    7157 	.db #0x02	;  2
      001BEA FE                    7158 	.db #0xfe	; -2
      001BEB 01                    7159 	.db #0x01	;  1
      001BEC F5                    7160 	.db #0xf5	; -11
      001BED 08                    7161 	.db #0x08	;  8
      001BEE FF                    7162 	.db #0xff	; -1
      001BEF 0E                    7163 	.db #0x0e	;  14
      001BF0 FD                    7164 	.db #0xfd	; -3
      001BF1 F6                    7165 	.db #0xf6	; -10
      001BF2 F1                    7166 	.db #0xf1	; -15
      001BF3 00                    7167 	.db #0x00	;  0
      001BF4 01                    7168 	.db #0x01	;  1
      001BF5 FA                    7169 	.db #0xfa	; -6
      001BF6 00                    7170 	.db #0x00	;  0
      001BF7 08                    7171 	.db #0x08	;  8
      001BF8 FE                    7172 	.db #0xfe	; -2
      001BF9 00                    7173 	.db #0x00	;  0
      001BFA FC                    7174 	.db #0xfc	; -4
      001BFB 09                    7175 	.db #0x09	;  9
      001BFC FD                    7176 	.db #0xfd	; -3
      001BFD 09                    7177 	.db #0x09	;  9
      001BFE EE                    7178 	.db #0xee	; -18
      001BFF FC                    7179 	.db #0xfc	; -4
      001C00 08                    7180 	.db #0x08	;  8
      001C01 00                    7181 	.db #0x00	;  0
      001C02 00                    7182 	.db #0x00	;  0
      001C03 05                    7183 	.db #0x05	;  5
      001C04 03                    7184 	.db #0x03	;  3
      001C05 FC                    7185 	.db #0xfc	; -4
      001C06 0E                    7186 	.db #0x0e	;  14
      001C07 00                    7187 	.db #0x00	;  0
      001C08 FE                    7188 	.db #0xfe	; -2
      001C09 01                    7189 	.db #0x01	;  1
      001C0A 04                    7190 	.db #0x04	;  4
      001C0B 13                    7191 	.db #0x13	;  19
      001C0C FC                    7192 	.db #0xfc	; -4
      001C0D 0B                    7193 	.db #0x0b	;  11
      001C0E FE                    7194 	.db #0xfe	; -2
      001C0F F8                    7195 	.db #0xf8	; -8
      001C10 06                    7196 	.db #0x06	;  6
      001C11 04                    7197 	.db #0x04	;  4
      001C12 F6                    7198 	.db #0xf6	; -10
      001C13 00                    7199 	.db #0x00	;  0
      001C14 00                    7200 	.db #0x00	;  0
      001C15 FA                    7201 	.db #0xfa	; -6
      001C16 02                    7202 	.db #0x02	;  2
      001C17 02                    7203 	.db #0x02	;  2
      001C18 0B                    7204 	.db #0x0b	;  11
      001C19 FF                    7205 	.db #0xff	; -1
      001C1A 04                    7206 	.db #0x04	;  4
      001C1B FB                    7207 	.db #0xfb	; -5
      001C1C 00                    7208 	.db #0x00	;  0
      001C1D F4                    7209 	.db #0xf4	; -12
      001C1E F8                    7210 	.db #0xf8	; -8
      001C1F FD                    7211 	.db #0xfd	; -3
      001C20 FE                    7212 	.db #0xfe	; -2
      001C21 00                    7213 	.db #0x00	;  0
      001C22 0C                    7214 	.db #0x0c	;  12
      001C23 17                    7215 	.db #0x17	;  23
      001C24 09                    7216 	.db #0x09	;  9
      001C25 F8                    7217 	.db #0xf8	; -8
      001C26 0B                    7218 	.db #0x0b	;  11
      001C27 00                    7219 	.db #0x00	;  0
      001C28 03                    7220 	.db #0x03	;  3
      001C29 08                    7221 	.db #0x08	;  8
      001C2A 0D                    7222 	.db #0x0d	;  13
      001C2B 12                    7223 	.db #0x12	;  18
      001C2C FC                    7224 	.db #0xfc	; -4
      001C2D 0A                    7225 	.db #0x0a	;  10
      001C2E 01                    7226 	.db #0x01	;  1
      001C2F FD                    7227 	.db #0xfd	; -3
      001C30 1A                    7228 	.db #0x1a	;  26
      001C31 01                    7229 	.db #0x01	;  1
      001C32 EF                    7230 	.db #0xef	; -17
      001C33 00                    7231 	.db #0x00	;  0
      001C34 F2                    7232 	.db #0xf2	; -14
      001C35 FA                    7233 	.db #0xfa	; -6
      001C36 F8                    7234 	.db #0xf8	; -8
      001C37 02                    7235 	.db #0x02	;  2
      001C38 04                    7236 	.db #0x04	;  4
      001C39 FA                    7237 	.db #0xfa	; -6
      001C3A F5                    7238 	.db #0xf5	; -11
      001C3B 05                    7239 	.db #0x05	;  5
      001C3C 06                    7240 	.db #0x06	;  6
      001C3D FC                    7241 	.db #0xfc	; -4
      001C3E F4                    7242 	.db #0xf4	; -12
      001C3F FE                    7243 	.db #0xfe	; -2
      001C40 FA                    7244 	.db #0xfa	; -6
      001C41 00                    7245 	.db #0x00	;  0
      001C42 02                    7246 	.db #0x02	;  2
      001C43 0A                    7247 	.db #0x0a	;  10
      001C44 F3                    7248 	.db #0xf3	; -13
      001C45 F6                    7249 	.db #0xf6	; -10
      001C46 01                    7250 	.db #0x01	;  1
      001C47 00                    7251 	.db #0x00	;  0
      001C48 03                    7252 	.db #0x03	;  3
      001C49 01                    7253 	.db #0x01	;  1
      001C4A 06                    7254 	.db #0x06	;  6
      001C4B 11                    7255 	.db #0x11	;  17
      001C4C 01                    7256 	.db #0x01	;  1
      001C4D 0A                    7257 	.db #0x0a	;  10
      001C4E 02                    7258 	.db #0x02	;  2
      001C4F 00                    7259 	.db #0x00	;  0
      001C50 05                    7260 	.db #0x05	;  5
      001C51 FE                    7261 	.db #0xfe	; -2
      001C52 FD                    7262 	.db #0xfd	; -3
      001C53 00                    7263 	.db #0x00	;  0
      001C54 FF                    7264 	.db #0xff	; -1
      001C55 F6                    7265 	.db #0xf6	; -10
      001C56 0D                    7266 	.db #0x0d	;  13
      001C57 FF                    7267 	.db #0xff	; -1
      001C58 03                    7268 	.db #0x03	;  3
      001C59 04                    7269 	.db #0x04	;  4
      001C5A 07                    7270 	.db #0x07	;  7
      001C5B 0A                    7271 	.db #0x0a	;  10
      001C5C 02                    7272 	.db #0x02	;  2
      001C5D FF                    7273 	.db #0xff	; -1
      001C5E EF                    7274 	.db #0xef	; -17
      001C5F 02                    7275 	.db #0x02	;  2
      001C60 FF                    7276 	.db #0xff	; -1
      001C61 00                    7277 	.db #0x00	;  0
      001C62 FD                    7278 	.db #0xfd	; -3
      001C63 09                    7279 	.db #0x09	;  9
      001C64 09                    7280 	.db #0x09	;  9
      001C65 FB                    7281 	.db #0xfb	; -5
      001C66 00                    7282 	.db #0x00	;  0
      001C67 00                    7283 	.db #0x00	;  0
      001C68 05                    7284 	.db #0x05	;  5
      001C69 FF                    7285 	.db #0xff	; -1
      001C6A 04                    7286 	.db #0x04	;  4
      001C6B 11                    7287 	.db #0x11	;  17
      001C6C 02                    7288 	.db #0x02	;  2
      001C6D FF                    7289 	.db #0xff	; -1
      001C6E 03                    7290 	.db #0x03	;  3
      001C6F 06                    7291 	.db #0x06	;  6
      001C70 05                    7292 	.db #0x05	;  5
      001C71 FC                    7293 	.db #0xfc	; -4
      001C72 FE                    7294 	.db #0xfe	; -2
      001C73 00                    7295 	.db #0x00	;  0
      001C74 F9                    7296 	.db #0xf9	; -7
      001C75 FE                    7297 	.db #0xfe	; -2
      001C76 FE                    7298 	.db #0xfe	; -2
      001C77 FF                    7299 	.db #0xff	; -1
      001C78 01                    7300 	.db #0x01	;  1
      001C79 FB                    7301 	.db #0xfb	; -5
      001C7A 02                    7302 	.db #0x02	;  2
      001C7B 0D                    7303 	.db #0x0d	;  13
      001C7C FF                    7304 	.db #0xff	; -1
      001C7D 04                    7305 	.db #0x04	;  4
      001C7E FA                    7306 	.db #0xfa	; -6
      001C7F F9                    7307 	.db #0xf9	; -7
      001C80 05                    7308 	.db #0x05	;  5
      001C81 00                    7309 	.db #0x00	;  0
      001C82 01                    7310 	.db #0x01	;  1
      001C83 02                    7311 	.db #0x02	;  2
      001C84 FA                    7312 	.db #0xfa	; -6
      001C85 FC                    7313 	.db #0xfc	; -4
      001C86 FF                    7314 	.db #0xff	; -1
      001C87 00                    7315 	.db #0x00	;  0
      001C88 01                    7316 	.db #0x01	;  1
      001C89 FE                    7317 	.db #0xfe	; -2
      001C8A 05                    7318 	.db #0x05	;  5
      001C8B 08                    7319 	.db #0x08	;  8
      001C8C 00                    7320 	.db #0x00	;  0
      001C8D 01                    7321 	.db #0x01	;  1
      001C8E 02                    7322 	.db #0x02	;  2
      001C8F F3                    7323 	.db #0xf3	; -13
      001C90 01                    7324 	.db #0x01	;  1
      001C91 F9                    7325 	.db #0xf9	; -7
      001C92 FD                    7326 	.db #0xfd	; -3
      001C93 00                    7327 	.db #0x00	;  0
      001C94 00                    7328 	.db #0x00	;  0
      001C95 FF                    7329 	.db #0xff	; -1
      001C96 09                    7330 	.db #0x09	;  9
      001C97 01                    7331 	.db #0x01	;  1
      001C98 00                    7332 	.db #0x00	;  0
      001C99 00                    7333 	.db #0x00	;  0
      001C9A 01                    7334 	.db #0x01	;  1
      001C9B 01                    7335 	.db #0x01	;  1
      001C9C 01                    7336 	.db #0x01	;  1
      001C9D 00                    7337 	.db #0x00	;  0
      001C9E FF                    7338 	.db #0xff	; -1
      001C9F 00                    7339 	.db #0x00	;  0
      001CA0 00                    7340 	.db #0x00	;  0
      001CA1 00                    7341 	.db #0x00	;  0
      001CA2 00                    7342 	.db #0x00	;  0
      001CA3 03                    7343 	.db #0x03	;  3
      001CA4 00                    7344 	.db #0x00	;  0
      001CA5 00                    7345 	.db #0x00	;  0
      001CA6 00                    7346 	.db #0x00	;  0
      001CA7 00                    7347 	.db #0x00	;  0
      001CA8 00                    7348 	.db #0x00	;  0
      001CA9 00                    7349 	.db #0x00	;  0
      001CAA FF                    7350 	.db #0xff	; -1
      001CAB 02                    7351 	.db #0x02	;  2
      001CAC 00                    7352 	.db #0x00	;  0
      001CAD 00                    7353 	.db #0x00	;  0
      001CAE FD                    7354 	.db #0xfd	; -3
      001CAF 00                    7355 	.db #0x00	;  0
      001CB0 03                    7356 	.db #0x03	;  3
      001CB1 00                    7357 	.db #0x00	;  0
      001CB2 FD                    7358 	.db #0xfd	; -3
      001CB3 00                    7359 	.db #0x00	;  0
      001CB4 FE                    7360 	.db #0xfe	; -2
      001CB5 FE                    7361 	.db #0xfe	; -2
      001CB6 00                    7362 	.db #0x00	;  0
      001CB7 00                    7363 	.db #0x00	;  0
      001CB8 00                    7364 	.db #0x00	;  0
      001CB9 00                    7365 	.db #0x00	;  0
      001CBA 02                    7366 	.db #0x02	;  2
      001CBB 00                    7367 	.db #0x00	;  0
      001CBC 00                    7368 	.db #0x00	;  0
      001CBD 00                    7369 	.db #0x00	;  0
      001CBE 00                    7370 	.db #0x00	;  0
      001CBF 00                    7371 	.db #0x00	;  0
      001CC0 00                    7372 	.db #0x00	;  0
      001CC1 00                    7373 	.db #0x00	;  0
      001CC2 00                    7374 	.db #0x00	;  0
      001CC3 00                    7375 	.db #0x00	;  0
      001CC4 00                    7376 	.db #0x00	;  0
      001CC5 00                    7377 	.db #0x00	;  0
      001CC6 00                    7378 	.db #0x00	;  0
      001CC7 00                    7379 	.db #0x00	;  0
      001CC8 00                    7380 	.db #0x00	;  0
      001CC9 00                    7381 	.db #0x00	;  0
      001CCA 00                    7382 	.db #0x00	;  0
      001CCB 00                    7383 	.db #0x00	;  0
      001CCC 00                    7384 	.db #0x00	;  0
      001CCD 00                    7385 	.db #0x00	;  0
      001CCE 00                    7386 	.db #0x00	;  0
      001CCF 00                    7387 	.db #0x00	;  0
      001CD0 00                    7388 	.db #0x00	;  0
      001CD1 00                    7389 	.db #0x00	;  0
      001CD2 00                    7390 	.db #0x00	;  0
      001CD3 00                    7391 	.db #0x00	;  0
      001CD4 00                    7392 	.db #0x00	;  0
      001CD5 00                    7393 	.db #0x00	;  0
      001CD6 00                    7394 	.db #0x00	;  0
      001CD7 00                    7395 	.db #0x00	;  0
      001CD8 00                    7396 	.db #0x00	;  0
      001CD9 00                    7397 	.db #0x00	;  0
      001CDA 00                    7398 	.db #0x00	;  0
      001CDB 00                    7399 	.db #0x00	;  0
      001CDC 00                    7400 	.db #0x00	;  0
      001CDD 00                    7401 	.db #0x00	;  0
      001CDE 00                    7402 	.db #0x00	;  0
      001CDF 00                    7403 	.db #0x00	;  0
      001CE0 00                    7404 	.db #0x00	;  0
      001CE1 00                    7405 	.db #0x00	;  0
      001CE2 00                    7406 	.db #0x00	;  0
      001CE3 00                    7407 	.db #0x00	;  0
      001CE4 00                    7408 	.db #0x00	;  0
      001CE5 00                    7409 	.db #0x00	;  0
      001CE6 00                    7410 	.db #0x00	;  0
      001CE7 00                    7411 	.db #0x00	;  0
      001CE8 00                    7412 	.db #0x00	;  0
      001CE9 00                    7413 	.db #0x00	;  0
      001CEA 00                    7414 	.db #0x00	;  0
      001CEB 00                    7415 	.db #0x00	;  0
      001CEC 00                    7416 	.db #0x00	;  0
      001CED 00                    7417 	.db #0x00	;  0
      001CEE 00                    7418 	.db #0x00	;  0
      001CEF 00                    7419 	.db #0x00	;  0
      001CF0 00                    7420 	.db #0x00	;  0
      001CF1 00                    7421 	.db #0x00	;  0
      001CF2 00                    7422 	.db #0x00	;  0
      001CF3 00                    7423 	.db #0x00	;  0
      001CF4 00                    7424 	.db #0x00	;  0
      001CF5 00                    7425 	.db #0x00	;  0
      001CF6 00                    7426 	.db #0x00	;  0
      001CF7 00                    7427 	.db #0x00	;  0
      001CF8 00                    7428 	.db #0x00	;  0
      001CF9 00                    7429 	.db #0x00	;  0
      001CFA 00                    7430 	.db #0x00	;  0
                                   7431 	.area CSEG    (CODE)
                                   7432 	.area CONST   (CODE)
      001CFB                       7433 _B2:
      001CFB 1F F8 FF FF           7434 	.byte #0x1f, #0xf8, #0xff, #0xff	; -2017
      001CFF 56 FD FF FF           7435 	.byte #0x56, #0xfd, #0xff, #0xff	; -682
      001D03 4E FC FF FF           7436 	.byte #0x4e, #0xfc, #0xff, #0xff	; -946
      001D07 F2 FC FF FF           7437 	.byte #0xf2, #0xfc, #0xff, #0xff	; -782
      001D0B 27 00 00 00           7438 	.byte #0x27, #0x00, #0x00, #0x00	;  39
      001D0F 72 FD FF FF           7439 	.byte #0x72, #0xfd, #0xff, #0xff	; -654
      001D13 99 FB FF FF           7440 	.byte #0x99, #0xfb, #0xff, #0xff	; -1127
      001D17 1C F9 FF FF           7441 	.byte #0x1c, #0xf9, #0xff, #0xff	; -1764
      001D1B 27 11 00 00           7442 	.byte #0x27, #0x11, #0x00, #0x00	;  4391
      001D1F F7 04 00 00           7443 	.byte #0xf7, #0x04, #0x00, #0x00	;  1271
                                   7444 	.area CSEG    (CODE)
                                   7445 	.area CONST   (CODE)
      001D23                       7446 _W2:
      001D23 2B                    7447 	.db #0x2b	;  43
      001D24 31                    7448 	.db #0x31	;  49	'1'
      001D25 22                    7449 	.db #0x22	;  34
      001D26 E9                    7450 	.db #0xe9	; -23
      001D27 DF                    7451 	.db #0xdf	; -33
      001D28 DD                    7452 	.db #0xdd	; -35
      001D29 00                    7453 	.db #0x00	;  0
      001D2A C1                    7454 	.db #0xc1	; -63
      001D2B B4                    7455 	.db #0xb4	; -76
      001D2C EA                    7456 	.db #0xea	; -22
      001D2D AE                    7457 	.db #0xae	; -82
      001D2E 47                    7458 	.db #0x47	;  71	'G'
      001D2F 00                    7459 	.db #0x00	;  0
      001D30 93                    7460 	.db #0x93	; -109
      001D31 2C                    7461 	.db #0x2c	;  44
      001D32 FB                    7462 	.db #0xfb	; -5
      001D33 20                    7463 	.db #0x20	;  32
      001D34 30                    7464 	.db #0x30	;  48	'0'
      001D35 CF                    7465 	.db #0xcf	; -49
      001D36 34                    7466 	.db #0x34	;  52	'4'
      001D37 EE                    7467 	.db #0xee	; -18
      001D38 B9                    7468 	.db #0xb9	; -71
      001D39 02                    7469 	.db #0x02	;  2
      001D3A 15                    7470 	.db #0x15	;  21
      001D3B 00                    7471 	.db #0x00	;  0
      001D3C 02                    7472 	.db #0x02	;  2
      001D3D 10                    7473 	.db #0x10	;  16
      001D3E CE                    7474 	.db #0xce	; -50
      001D3F 1A                    7475 	.db #0x1a	;  26
      001D40 A1                    7476 	.db #0xa1	; -95
      001D41 EB                    7477 	.db #0xeb	; -21
      001D42 FB                    7478 	.db #0xfb	; -5
      001D43 BC                    7479 	.db #0xbc	; -68
      001D44 DE                    7480 	.db #0xde	; -34
      001D45 EE                    7481 	.db #0xee	; -18
      001D46 50                    7482 	.db #0x50	;  80	'P'
      001D47 3F                    7483 	.db #0x3f	;  63
      001D48 41                    7484 	.db #0x41	;  65	'A'
      001D49 00                    7485 	.db #0x00	;  0
      001D4A EF                    7486 	.db #0xef	; -17
      001D4B E4                    7487 	.db #0xe4	; -28
      001D4C FD                    7488 	.db #0xfd	; -3
      001D4D D3                    7489 	.db #0xd3	; -45
      001D4E CB                    7490 	.db #0xcb	; -53
      001D4F 00                    7491 	.db #0x00	;  0
      001D50 CC                    7492 	.db #0xcc	; -52
      001D51 01                    7493 	.db #0x01	;  1
      001D52 3A                    7494 	.db #0x3a	;  58
      001D53 A8                    7495 	.db #0xa8	; -88
      001D54 EC                    7496 	.db #0xec	; -20
      001D55 0F                    7497 	.db #0x0f	;  15
      001D56 FF                    7498 	.db #0xff	; -1
      001D57 51                    7499 	.db #0x51	;  81	'Q'
      001D58 35                    7500 	.db #0x35	;  53	'5'
      001D59 44                    7501 	.db #0x44	;  68	'D'
      001D5A 09                    7502 	.db #0x09	;  9
      001D5B 00                    7503 	.db #0x00	;  0
      001D5C 92                    7504 	.db #0x92	; -110
      001D5D E5                    7505 	.db #0xe5	; -27
      001D5E C8                    7506 	.db #0xc8	; -56
      001D5F FA                    7507 	.db #0xfa	; -6
      001D60 0D                    7508 	.db #0x0d	;  13
      001D61 FD                    7509 	.db #0xfd	; -3
      001D62 F9                    7510 	.db #0xf9	; -7
      001D63 0A                    7511 	.db #0x0a	;  10
      001D64 C9                    7512 	.db #0xc9	; -55
      001D65 00                    7513 	.db #0x00	;  0
      001D66 E2                    7514 	.db #0xe2	; -30
      001D67 07                    7515 	.db #0x07	;  7
      001D68 4C                    7516 	.db #0x4c	;  76	'L'
      001D69 00                    7517 	.db #0x00	;  0
      001D6A AD                    7518 	.db #0xad	; -83
      001D6B 08                    7519 	.db #0x08	;  8
      001D6C 3A                    7520 	.db #0x3a	;  58
      001D6D DE                    7521 	.db #0xde	; -34
      001D6E D3                    7522 	.db #0xd3	; -45
      001D6F 00                    7523 	.db #0x00	;  0
      001D70 EB                    7524 	.db #0xeb	; -21
      001D71 DB                    7525 	.db #0xdb	; -37
      001D72 1E                    7526 	.db #0x1e	;  30
      001D73 13                    7527 	.db #0x13	;  19
      001D74 DC                    7528 	.db #0xdc	; -36
      001D75 0F                    7529 	.db #0x0f	;  15
      001D76 2B                    7530 	.db #0x2b	;  43
      001D77 1F                    7531 	.db #0x1f	;  31
      001D78 49                    7532 	.db #0x49	;  73	'I'
      001D79 AB                    7533 	.db #0xab	; -85
      001D7A F3                    7534 	.db #0xf3	; -13
      001D7B 00                    7535 	.db #0x00	;  0
      001D7C ED                    7536 	.db #0xed	; -19
      001D7D 56                    7537 	.db #0x56	;  86	'V'
      001D7E CC                    7538 	.db #0xcc	; -52
      001D7F 46                    7539 	.db #0x46	;  70	'F'
      001D80 A1                    7540 	.db #0xa1	; -95
      001D81 21                    7541 	.db #0x21	;  33
      001D82 FB                    7542 	.db #0xfb	; -5
      001D83 FF                    7543 	.db #0xff	; -1
      001D84 D7                    7544 	.db #0xd7	; -41
      001D85 24                    7545 	.db #0x24	;  36
      001D86 E0                    7546 	.db #0xe0	; -32
      001D87 28                    7547 	.db #0x28	;  40
      001D88 CA                    7548 	.db #0xca	; -54
      001D89 00                    7549 	.db #0x00	;  0
      001D8A 1D                    7550 	.db #0x1d	;  29
      001D8B 41                    7551 	.db #0x41	;  65	'A'
      001D8C 24                    7552 	.db #0x24	;  36
      001D8D 45                    7553 	.db #0x45	;  69	'E'
      001D8E F0                    7554 	.db #0xf0	; -16
      001D8F 00                    7555 	.db #0x00	;  0
      001D90 35                    7556 	.db #0x35	;  53	'5'
      001D91 C0                    7557 	.db #0xc0	; -64
      001D92 FB                    7558 	.db #0xfb	; -5
      001D93 1B                    7559 	.db #0x1b	;  27
      001D94 3A                    7560 	.db #0x3a	;  58
      001D95 29                    7561 	.db #0x29	;  41
      001D96 C7                    7562 	.db #0xc7	; -57
      001D97 20                    7563 	.db #0x20	;  32
      001D98 07                    7564 	.db #0x07	;  7
      001D99 B9                    7565 	.db #0xb9	; -71
      001D9A F9                    7566 	.db #0xf9	; -7
      001D9B 00                    7567 	.db #0x00	;  0
      001D9C C2                    7568 	.db #0xc2	; -62
      001D9D E2                    7569 	.db #0xe2	; -30
      001D9E 0C                    7570 	.db #0x0c	;  12
      001D9F 1E                    7571 	.db #0x1e	;  30
      001DA0 E7                    7572 	.db #0xe7	; -25
      001DA1 F5                    7573 	.db #0xf5	; -11
      001DA2 D1                    7574 	.db #0xd1	; -47
      001DA3 C9                    7575 	.db #0xc9	; -55
      001DA4 30                    7576 	.db #0x30	;  48	'0'
      001DA5 A4                    7577 	.db #0xa4	; -92
      001DA6 54                    7578 	.db #0x54	;  84	'T'
      001DA7 3A                    7579 	.db #0x3a	;  58
      001DA8 01                    7580 	.db #0x01	;  1
      001DA9 00                    7581 	.db #0x00	;  0
      001DAA 45                    7582 	.db #0x45	;  69	'E'
      001DAB F6                    7583 	.db #0xf6	; -10
      001DAC EC                    7584 	.db #0xec	; -20
      001DAD FD                    7585 	.db #0xfd	; -3
      001DAE 14                    7586 	.db #0x14	;  20
      001DAF 00                    7587 	.db #0x00	;  0
      001DB0 18                    7588 	.db #0x18	;  24
      001DB1 16                    7589 	.db #0x16	;  22
      001DB2 9E                    7590 	.db #0x9e	; -98
      001DB3 9E                    7591 	.db #0x9e	; -98
      001DB4 9D                    7592 	.db #0x9d	; -99
      001DB5 02                    7593 	.db #0x02	;  2
      001DB6 DE                    7594 	.db #0xde	; -34
      001DB7 24                    7595 	.db #0x24	;  36
      001DB8 EF                    7596 	.db #0xef	; -17
      001DB9 2B                    7597 	.db #0x2b	;  43
      001DBA 41                    7598 	.db #0x41	;  65	'A'
      001DBB 00                    7599 	.db #0x00	;  0
      001DBC 39                    7600 	.db #0x39	;  57	'9'
      001DBD 26                    7601 	.db #0x26	;  38
      001DBE D2                    7602 	.db #0xd2	; -46
      001DBF B2                    7603 	.db #0xb2	; -78
      001DC0 FE                    7604 	.db #0xfe	; -2
      001DC1 B4                    7605 	.db #0xb4	; -76
      001DC2 0B                    7606 	.db #0x0b	;  11
      001DC3 E3                    7607 	.db #0xe3	; -29
      001DC4 EF                    7608 	.db #0xef	; -17
      001DC5 33                    7609 	.db #0x33	;  51	'3'
      001DC6 D8                    7610 	.db #0xd8	; -40
      001DC7 A0                    7611 	.db #0xa0	; -96
      001DC8 D2                    7612 	.db #0xd2	; -46
      001DC9 00                    7613 	.db #0x00	;  0
      001DCA 1D                    7614 	.db #0x1d	;  29
      001DCB 1A                    7615 	.db #0x1a	;  26
      001DCC E7                    7616 	.db #0xe7	; -25
      001DCD 3E                    7617 	.db #0x3e	;  62
      001DCE 09                    7618 	.db #0x09	;  9
      001DCF 00                    7619 	.db #0x00	;  0
      001DD0 24                    7620 	.db #0x24	;  36
      001DD1 CD                    7621 	.db #0xcd	; -51
      001DD2 23                    7622 	.db #0x23	;  35
      001DD3 2E                    7623 	.db #0x2e	;  46
      001DD4 43                    7624 	.db #0x43	;  67	'C'
      001DD5 B1                    7625 	.db #0xb1	; -79
      001DD6 E4                    7626 	.db #0xe4	; -28
      001DD7 81                    7627 	.db #0x81	; -127
      001DD8 FB                    7628 	.db #0xfb	; -5
      001DD9 18                    7629 	.db #0x18	;  24
      001DDA F9                    7630 	.db #0xf9	; -7
      001DDB 00                    7631 	.db #0x00	;  0
      001DDC 04                    7632 	.db #0x04	;  4
      001DDD 02                    7633 	.db #0x02	;  2
      001DDE 60                    7634 	.db #0x60	;  96
      001DDF E3                    7635 	.db #0xe3	; -29
      001DE0 49                    7636 	.db #0x49	;  73	'I'
      001DE1 22                    7637 	.db #0x22	;  34
      001DE2 FB                    7638 	.db #0xfb	; -5
      001DE3 02                    7639 	.db #0x02	;  2
      001DE4 22                    7640 	.db #0x22	;  34
      001DE5 19                    7641 	.db #0x19	;  25
      001DE6 4A                    7642 	.db #0x4a	;  74	'J'
      001DE7 C9                    7643 	.db #0xc9	; -55
      001DE8 DD                    7644 	.db #0xdd	; -35
      001DE9 00                    7645 	.db #0x00	;  0
      001DEA 99                    7646 	.db #0x99	; -103
      001DEB B9                    7647 	.db #0xb9	; -71
      001DEC D6                    7648 	.db #0xd6	; -42
      001DED D5                    7649 	.db #0xd5	; -43
      001DEE E7                    7650 	.db #0xe7	; -25
      001DEF 00                    7651 	.db #0x00	;  0
      001DF0 A9                    7652 	.db #0xa9	; -87
      001DF1 19                    7653 	.db #0x19	;  25
      001DF2 ED                    7654 	.db #0xed	; -19
      001DF3 C5                    7655 	.db #0xc5	; -59
      001DF4 1C                    7656 	.db #0x1c	;  28
      001DF5 D6                    7657 	.db #0xd6	; -42
      001DF6 16                    7658 	.db #0x16	;  22
      001DF7 CB                    7659 	.db #0xcb	; -53
      001DF8 DA                    7660 	.db #0xda	; -38
      001DF9 60                    7661 	.db #0x60	;  96
      001DFA 2B                    7662 	.db #0x2b	;  43
      001DFB 00                    7663 	.db #0x00	;  0
      001DFC 07                    7664 	.db #0x07	;  7
      001DFD 0A                    7665 	.db #0x0a	;  10
      001DFE 5C                    7666 	.db #0x5c	;  92
      001DFF DE                    7667 	.db #0xde	; -34
      001E00 E1                    7668 	.db #0xe1	; -31
      001E01 56                    7669 	.db #0x56	;  86	'V'
      001E02 13                    7670 	.db #0x13	;  19
      001E03 F2                    7671 	.db #0xf2	; -14
      001E04 26                    7672 	.db #0x26	;  38
      001E05 B9                    7673 	.db #0xb9	; -71
      001E06 F0                    7674 	.db #0xf0	; -16
      001E07 2B                    7675 	.db #0x2b	;  43
      001E08 29                    7676 	.db #0x29	;  41
      001E09 00                    7677 	.db #0x00	;  0
      001E0A EC                    7678 	.db #0xec	; -20
      001E0B 24                    7679 	.db #0x24	;  36
      001E0C 3F                    7680 	.db #0x3f	;  63
      001E0D C2                    7681 	.db #0xc2	; -62
      001E0E 31                    7682 	.db #0x31	;  49	'1'
      001E0F 00                    7683 	.db #0x00	;  0
      001E10 21                    7684 	.db #0x21	;  33
      001E11 19                    7685 	.db #0x19	;  25
      001E12 1F                    7686 	.db #0x1f	;  31
      001E13 27                    7687 	.db #0x27	;  39
      001E14 9F                    7688 	.db #0x9f	; -97
      001E15 20                    7689 	.db #0x20	;  32
      001E16 E4                    7690 	.db #0xe4	; -28
      001E17 15                    7691 	.db #0x15	;  21
      001E18 52                    7692 	.db #0x52	;  82	'R'
      001E19 CA                    7693 	.db #0xca	; -54
      001E1A C3                    7694 	.db #0xc3	; -61
      001E1B 00                    7695 	.db #0x00	;  0
      001E1C F1                    7696 	.db #0xf1	; -15
      001E1D E1                    7697 	.db #0xe1	; -31
      001E1E F8                    7698 	.db #0xf8	; -8
      001E1F 14                    7699 	.db #0x14	;  20
      001E20 10                    7700 	.db #0x10	;  16
      001E21 0E                    7701 	.db #0x0e	;  14
      001E22 BD                    7702 	.db #0xbd	; -67
      001E23 02                    7703 	.db #0x02	;  2
      001E24 B3                    7704 	.db #0xb3	; -77
      001E25 29                    7705 	.db #0x29	;  41
      001E26 CA                    7706 	.db #0xca	; -54
      001E27 F6                    7707 	.db #0xf6	; -10
      001E28 CE                    7708 	.db #0xce	; -50
      001E29 00                    7709 	.db #0x00	;  0
      001E2A D4                    7710 	.db #0xd4	; -44
      001E2B E1                    7711 	.db #0xe1	; -31
      001E2C 1D                    7712 	.db #0x1d	;  29
      001E2D 17                    7713 	.db #0x17	;  23
      001E2E 01                    7714 	.db #0x01	;  1
      001E2F 00                    7715 	.db #0x00	;  0
      001E30 C9                    7716 	.db #0xc9	; -55
      001E31 C0                    7717 	.db #0xc0	; -64
      001E32 E0                    7718 	.db #0xe0	; -32
      001E33 01                    7719 	.db #0x01	;  1
      001E34 25                    7720 	.db #0x25	;  37
      001E35 28                    7721 	.db #0x28	;  40
      001E36 37                    7722 	.db #0x37	;  55	'7'
      001E37 E7                    7723 	.db #0xe7	; -25
      001E38 DE                    7724 	.db #0xde	; -34
      001E39 EC                    7725 	.db #0xec	; -20
      001E3A E6                    7726 	.db #0xe6	; -26
      001E3B 00                    7727 	.db #0x00	;  0
      001E3C 34                    7728 	.db #0x34	;  52	'4'
      001E3D C9                    7729 	.db #0xc9	; -55
      001E3E ED                    7730 	.db #0xed	; -19
      001E3F E6                    7731 	.db #0xe6	; -26
      001E40 0C                    7732 	.db #0x0c	;  12
      001E41 FA                    7733 	.db #0xfa	; -6
      001E42 2C                    7734 	.db #0x2c	;  44
      001E43 3D                    7735 	.db #0x3d	;  61
      001E44 0F                    7736 	.db #0x0f	;  15
      001E45 D0                    7737 	.db #0xd0	; -48
      001E46 BE                    7738 	.db #0xbe	; -66
      001E47 E8                    7739 	.db #0xe8	; -24
      001E48 15                    7740 	.db #0x15	;  21
      001E49 00                    7741 	.db #0x00	;  0
      001E4A 41                    7742 	.db #0x41	;  65	'A'
      001E4B 25                    7743 	.db #0x25	;  37
      001E4C AB                    7744 	.db #0xab	; -85
      001E4D 2D                    7745 	.db #0x2d	;  45
      001E4E 23                    7746 	.db #0x23	;  35
      001E4F 00                    7747 	.db #0x00	;  0
      001E50 24                    7748 	.db #0x24	;  36
      001E51 23                    7749 	.db #0x23	;  35
      001E52 F3                    7750 	.db #0xf3	; -13
      001E53 0C                    7751 	.db #0x0c	;  12
      001E54 DF                    7752 	.db #0xdf	; -33
      001E55 1C                    7753 	.db #0x1c	;  28
      001E56 D0                    7754 	.db #0xd0	; -48
      001E57 E7                    7755 	.db #0xe7	; -25
      001E58 C5                    7756 	.db #0xc5	; -59
      001E59 EB                    7757 	.db #0xeb	; -21
      001E5A B7                    7758 	.db #0xb7	; -73
      001E5B 00                    7759 	.db #0x00	;  0
      001E5C 1E                    7760 	.db #0x1e	;  30
      001E5D D5                    7761 	.db #0xd5	; -43
      001E5E 04                    7762 	.db #0x04	;  4
      001E5F 01                    7763 	.db #0x01	;  1
      001E60 21                    7764 	.db #0x21	;  33
      001E61 AB                    7765 	.db #0xab	; -85
      001E62 1A                    7766 	.db #0x1a	;  26
                                   7767 	.area CSEG    (CODE)
                                   7768 	.area CONST   (CODE)
      001E63                       7769 _dsel:
      001E63 F7                    7770 	.db #0xf7	; 247
      001E64 EF                    7771 	.db #0xef	; 239
      001E65 DF                    7772 	.db #0xdf	; 223
      001E66 BF                    7773 	.db #0xbf	; 191
                                   7774 	.area CSEG    (CODE)
                                   7775 	.area CONST   (CODE)
      001E67                       7776 _segs:
      001E67 C0                    7777 	.db #0xc0	; 192
      001E68 F9                    7778 	.db #0xf9	; 249
      001E69 A4                    7779 	.db #0xa4	; 164
      001E6A B0                    7780 	.db #0xb0	; 176
      001E6B 99                    7781 	.db #0x99	; 153
      001E6C 92                    7782 	.db #0x92	; 146
      001E6D 82                    7783 	.db #0x82	; 130
      001E6E F8                    7784 	.db #0xf8	; 248
      001E6F 80                    7785 	.db #0x80	; 128
      001E70 90                    7786 	.db #0x90	; 144
                                   7787 	.area CSEG    (CODE)
                                   7788 	.area CONST   (CODE)
      001E71                       7789 _hexd:
      001E71 30 31 32 33 34 35 36  7790 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      001E81 00                    7791 	.db 0x00
                                   7792 	.area CSEG    (CODE)
                                   7793 	.area CONST   (CODE)
      001E82                       7794 ___str_0:
      001E82 4E 4E 20 52 45 41 44  7795 	.ascii "NN READY"
             59
      001E8A 0D                    7796 	.db 0x0d
      001E8B 0A                    7797 	.db 0x0a
      001E8C 00                    7798 	.db 0x00
                                   7799 	.area CSEG    (CODE)
                                   7800 	.area XINIT   (CODE)
                                   7801 	.area CABS    (ABS,CODE)
