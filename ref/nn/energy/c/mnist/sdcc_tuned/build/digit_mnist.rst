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
      00001D                        299 _main_w_10000_12:
      00001D                        300 	.ds 2
      00001F                        301 _main_mask_10000_12:
      00001F                        302 	.ds 1
      000020                        303 _main___800000000_80000_25:
      000020                        304 	.ds 1
      000021                        305 _main_sloc0_1_0:
      000021                        306 	.ds 2
      000023                        307 _main_sloc1_1_0:
      000023                        308 	.ds 4
                                    309 ;--------------------------------------------------------
                                    310 ; overlayable items in internal ram
                                    311 ;--------------------------------------------------------
                                    312 	.area	OSEG    (OVR,DATA)
                                    313 ;--------------------------------------------------------
                                    314 ; Stack segment in internal ram
                                    315 ;--------------------------------------------------------
                                    316 	.area SSEG
      0000C8                        317 __start__stack:
      0000C8                        318 	.ds	1
                                    319 
                                    320 ;--------------------------------------------------------
                                    321 ; indirectly addressable internal ram data
                                    322 ;--------------------------------------------------------
                                    323 	.area ISEG    (DATA)
      000027                        324 _pix::
      000027                        325 	.ds 25
      000040                        326 _acc::
      000040                        327 	.ds 64
      000080                        328 _hid::
      000080                        329 	.ds 32
      0000A0                        330 _score::
      0000A0                        331 	.ds 40
                                    332 ;--------------------------------------------------------
                                    333 ; absolute internal ram data
                                    334 ;--------------------------------------------------------
                                    335 	.area IABS    (ABS,DATA)
                                    336 	.area IABS    (ABS,DATA)
                                    337 ;--------------------------------------------------------
                                    338 ; bit data
                                    339 ;--------------------------------------------------------
                                    340 	.area BSEG    (BIT)
                                    341 ;--------------------------------------------------------
                                    342 ; paged external ram data
                                    343 ;--------------------------------------------------------
                                    344 	.area PSEG    (PAG,XDATA)
                                    345 ;--------------------------------------------------------
                                    346 ; uninitialized external ram data
                                    347 ;--------------------------------------------------------
                                    348 	.area XSEG    (XDATA)
                                    349 ;--------------------------------------------------------
                                    350 ; absolute external ram data
                                    351 ;--------------------------------------------------------
                                    352 	.area XABS    (ABS,XDATA)
                                    353 ;--------------------------------------------------------
                                    354 ; initialized external ram data
                                    355 ;--------------------------------------------------------
                                    356 	.area XISEG   (XDATA)
                                    357 	.area HOME    (CODE)
                                    358 	.area GSINIT0 (CODE)
                                    359 	.area GSINIT1 (CODE)
                                    360 	.area GSINIT2 (CODE)
                                    361 	.area GSINIT3 (CODE)
                                    362 	.area GSINIT4 (CODE)
                                    363 	.area GSINIT5 (CODE)
                                    364 	.area GSINIT  (CODE)
                                    365 	.area GSFINAL (CODE)
                                    366 	.area CSEG    (CODE)
                                    367 ;--------------------------------------------------------
                                    368 ; interrupt vector
                                    369 ;--------------------------------------------------------
                                    370 	.area HOME    (CODE)
      000000                        371 __interrupt_vect:
      000000 02 00 56         [24]  372 	ljmp	__sdcc_gsinit_startup
      000003 32               [24]  373 	reti
      000004                        374 	.ds	7
      00000B 02 00 B2         [24]  375 	ljmp	_t0_isr
                                    376 ; restartable atomic support routines
      00000E                        377 	.ds	2
      000010                        378 sdcc_atomic_exchange_rollback_start::
      000010 00               [12]  379 	nop
      000011 00               [12]  380 	nop
      000012                        381 sdcc_atomic_exchange_pdata_impl:
      000012 E2               [24]  382 	movx	a, @r0
      000013 FB               [12]  383 	mov	r3, a
      000014 EA               [12]  384 	mov	a, r2
      000015 F2               [24]  385 	movx	@r0, a
      000016 80 2C            [24]  386 	sjmp	sdcc_atomic_exchange_exit
      000018 00               [12]  387 	nop
      000019 00               [12]  388 	nop
      00001A                        389 sdcc_atomic_exchange_xdata_impl:
      00001A E0               [24]  390 	movx	a, @dptr
      00001B FB               [12]  391 	mov	r3, a
      00001C EA               [12]  392 	mov	a, r2
      00001D F0               [24]  393 	movx	@dptr, a
      00001E 80 24            [24]  394 	sjmp	sdcc_atomic_exchange_exit
      000020                        395 sdcc_atomic_compare_exchange_idata_impl:
      000020 E6               [12]  396 	mov	a, @r0
      000021 B5 02 02         [24]  397 	cjne	a, ar2, .+#5
      000024 EB               [12]  398 	mov	a, r3
      000025 F6               [12]  399 	mov	@r0, a
      000026 22               [24]  400 	ret
      000027 00               [12]  401 	nop
      000028                        402 sdcc_atomic_compare_exchange_pdata_impl:
      000028 E2               [24]  403 	movx	a, @r0
      000029 B5 02 02         [24]  404 	cjne	a, ar2, .+#5
      00002C EB               [12]  405 	mov	a, r3
      00002D F2               [24]  406 	movx	@r0, a
      00002E 22               [24]  407 	ret
      00002F 00               [12]  408 	nop
      000030                        409 sdcc_atomic_compare_exchange_xdata_impl:
      000030 E0               [24]  410 	movx	a, @dptr
      000031 B5 02 02         [24]  411 	cjne	a, ar2, .+#5
      000034 EB               [12]  412 	mov	a, r3
      000035 F0               [24]  413 	movx	@dptr, a
      000036 22               [24]  414 	ret
      000037                        415 sdcc_atomic_exchange_rollback_end::
                                    416 
      000037                        417 sdcc_atomic_exchange_gptr_impl::
      000037 30 F6 E0         [24]  418 	jnb	b.6, sdcc_atomic_exchange_xdata_impl
      00003A A8 82            [24]  419 	mov	r0, dpl
      00003C 20 F5 D3         [24]  420 	jb	b.5, sdcc_atomic_exchange_pdata_impl
      00003F                        421 sdcc_atomic_exchange_idata_impl:
      00003F EA               [12]  422 	mov	a, r2
      000040 C6               [12]  423 	xch	a, @r0
      000041 F5 82            [12]  424 	mov	dpl, a
      000043 22               [24]  425 	ret
      000044                        426 sdcc_atomic_exchange_exit:
      000044 8B 82            [24]  427 	mov	dpl, r3
      000046 22               [24]  428 	ret
      000047                        429 sdcc_atomic_compare_exchange_gptr_impl::
      000047 30 F6 E6         [24]  430 	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
      00004A A8 82            [24]  431 	mov	r0, dpl
      00004C 20 F5 D9         [24]  432 	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
      00004F 80 CF            [24]  433 	sjmp	sdcc_atomic_compare_exchange_idata_impl
                                    434 ;--------------------------------------------------------
                                    435 ; global & static initialisations
                                    436 ;--------------------------------------------------------
                                    437 	.area HOME    (CODE)
                                    438 	.area GSINIT  (CODE)
                                    439 	.area GSFINAL (CODE)
                                    440 	.area GSINIT  (CODE)
                                    441 	.globl __sdcc_gsinit_startup
                                    442 	.globl __sdcc_program_startup
                                    443 	.globl __start__stack
                                    444 	.globl __mcs51_genXINIT
                                    445 	.globl __mcs51_genXRAMCLEAR
                                    446 	.globl __mcs51_genRAMCLEAR
                                    447 	.area GSFINAL (CODE)
      0000AF 02 00 51         [24]  448 	ljmp	__sdcc_program_startup
                                    449 ;--------------------------------------------------------
                                    450 ; Home
                                    451 ;--------------------------------------------------------
                                    452 	.area HOME    (CODE)
                                    453 	.area HOME    (CODE)
      000051                        454 __sdcc_program_startup:
      000051 12 01 31         [24]  455 	lcall	_main
      000054                        456 __sdcc_program_exit:
      000054 80 FE            [24]  457 	sjmp	.
                                    458 ;	return from main will return to caller
                                    459 ;--------------------------------------------------------
                                    460 ; code
                                    461 ;--------------------------------------------------------
                                    462 	.area CSEG    (CODE)
                                    463 ;------------------------------------------------------------
                                    464 ;Allocation info for local variables in function 't0_isr'
                                    465 ;------------------------------------------------------------
                                    466 ;	digit_mnist.c:26: void t0_isr(void) T0_ISR
                                    467 ;	-----------------------------------------
                                    468 ;	 function t0_isr
                                    469 ;	-----------------------------------------
      0000B2                        470 _t0_isr:
                           00000F   471 	ar7 = 0x0f
                           00000E   472 	ar6 = 0x0e
                           00000D   473 	ar5 = 0x0d
                           00000C   474 	ar4 = 0x0c
                           00000B   475 	ar3 = 0x0b
                           00000A   476 	ar2 = 0x0a
                           000009   477 	ar1 = 0x09
                           000008   478 	ar0 = 0x08
      0000B2 C0 E0            [24]  479 	push	acc
      0000B4 C0 82            [24]  480 	push	dpl
      0000B6 C0 83            [24]  481 	push	dph
      0000B8 C0 D0            [24]  482 	push	psw
      0000BA 75 D0 08         [24]  483 	mov	psw,#0x08
                                    484 ;	digit_mnist.c:28: P1 = 0xFF;
      0000BD 75 90 FF         [24]  485 	mov	_P1,#0xff
                                    486 ;	digit_mnist.c:29: digi = (digi + 1) & 3;
      0000C0 AF 14            [24]  487 	mov	r7,_digi
      0000C2 0F               [12]  488 	inc	r7
      0000C3 74 03            [12]  489 	mov	a,#0x03
      0000C5 5F               [12]  490 	anl	a,r7
                                    491 ;	digit_mnist.c:30: P0 = dbuf[digi];
      0000C6 F5 14            [12]  492 	mov	_digi,a
      0000C8 24 10            [12]  493 	add	a, #_dbuf
      0000CA F9               [12]  494 	mov	r1,a
      0000CB 87 80            [24]  495 	mov	_P0,@r1
                                    496 ;	digit_mnist.c:31: P1 = dsel[digi];
      0000CD E5 14            [12]  497 	mov	a,_digi
      0000CF 90 1E 45         [24]  498 	mov	dptr,#_dsel
      0000D2 93               [24]  499 	movc	a,@a+dptr
      0000D3 F5 90            [12]  500 	mov	_P1,a
                                    501 ;	digit_mnist.c:32: }
      0000D5 D0 D0            [24]  502 	pop	psw
      0000D7 D0 83            [24]  503 	pop	dph
      0000D9 D0 82            [24]  504 	pop	dpl
      0000DB D0 E0            [24]  505 	pop	acc
      0000DD 32               [24]  506 	reti
                                    507 ;	eliminated unneeded push/pop b
                                    508 ;------------------------------------------------------------
                                    509 ;Allocation info for local variables in function 'getc_'
                                    510 ;------------------------------------------------------------
                                    511 ;	digit_mnist.c:34: static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
                                    512 ;	-----------------------------------------
                                    513 ;	 function getc_
                                    514 ;	-----------------------------------------
      0000DE                        515 _getc_:
                           000007   516 	ar7 = 0x07
                           000006   517 	ar6 = 0x06
                           000005   518 	ar5 = 0x05
                           000004   519 	ar4 = 0x04
                           000003   520 	ar3 = 0x03
                           000002   521 	ar2 = 0x02
                           000001   522 	ar1 = 0x01
                           000000   523 	ar0 = 0x00
      0000DE                        524 00101$:
                                    525 ;	assignBit
      0000DE 10 98 02         [24]  526 	jbc	_RI,00120$
      0000E1 80 FB            [24]  527 	sjmp	00101$
      0000E3                        528 00120$:
      0000E3 85 99 82         [24]  529 	mov	dpl, _SBUF
      0000E6 22               [24]  530 	ret
                                    531 ;------------------------------------------------------------
                                    532 ;Allocation info for local variables in function 'putc_'
                                    533 ;------------------------------------------------------------
                                    534 ;c             Allocated to registers 
                                    535 ;------------------------------------------------------------
                                    536 ;	digit_mnist.c:35: static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
                                    537 ;	-----------------------------------------
                                    538 ;	 function putc_
                                    539 ;	-----------------------------------------
      0000E7                        540 _putc_:
      0000E7 85 82 99         [24]  541 	mov	_SBUF,dpl
      0000EA                        542 00101$:
                                    543 ;	assignBit
      0000EA 10 99 02         [24]  544 	jbc	_TI,00120$
      0000ED 80 FB            [24]  545 	sjmp	00101$
      0000EF                        546 00120$:
      0000EF 22               [24]  547 	ret
                                    548 ;------------------------------------------------------------
                                    549 ;Allocation info for local variables in function 'puthex'
                                    550 ;------------------------------------------------------------
                                    551 ;v             Allocated to registers r7 
                                    552 ;------------------------------------------------------------
                                    553 ;	digit_mnist.c:36: static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
                                    554 ;	-----------------------------------------
                                    555 ;	 function puthex
                                    556 ;	-----------------------------------------
      0000F0                        557 _puthex:
      0000F0 E5 82            [12]  558 	mov	a,dpl
      0000F2 FF               [12]  559 	mov	r7,a
      0000F3 C4               [12]  560 	swap	a
      0000F4 54 0F            [12]  561 	anl	a,#0x0f
      0000F6 90 1E 53         [24]  562 	mov	dptr,#_hexd
      0000F9 93               [24]  563 	movc	a,@a+dptr
      0000FA F5 82            [12]  564 	mov	dpl,a
      0000FC C0 07            [24]  565 	push	ar7
      0000FE 12 00 E7         [24]  566 	lcall	_putc_
      000101 D0 07            [24]  567 	pop	ar7
      000103 74 0F            [12]  568 	mov	a,#0x0f
      000105 5F               [12]  569 	anl	a,r7
      000106 90 1E 53         [24]  570 	mov	dptr,#_hexd
      000109 93               [24]  571 	movc	a,@a+dptr
      00010A F5 82            [12]  572 	mov	dpl,a
      00010C 02 00 E7         [24]  573 	ljmp	_putc_
                                    574 ;------------------------------------------------------------
                                    575 ;Allocation info for local variables in function 'puts_'
                                    576 ;------------------------------------------------------------
                                    577 ;s             Allocated to registers 
                                    578 ;------------------------------------------------------------
                                    579 ;	digit_mnist.c:37: static void puts_(char code *s) { while (*s) putc_(*s++); }
                                    580 ;	-----------------------------------------
                                    581 ;	 function puts_
                                    582 ;	-----------------------------------------
      00010F                        583 _puts_:
      00010F AE 82            [24]  584 	mov	r6, dpl
      000111 AF 83            [24]  585 	mov	r7, dph
      000113                        586 00101$:
      000113 8E 82            [24]  587 	mov	dpl,r6
      000115 8F 83            [24]  588 	mov	dph,r7
      000117 E4               [12]  589 	clr	a
      000118 93               [24]  590 	movc	a,@a+dptr
      000119 FD               [12]  591 	mov	r5,a
      00011A 60 14            [24]  592 	jz	00104$
      00011C 8D 82            [24]  593 	mov	dpl,r5
      00011E 0E               [12]  594 	inc	r6
      00011F BE 00 01         [24]  595 	cjne	r6,#0x00,00122$
      000122 0F               [12]  596 	inc	r7
      000123                        597 00122$:
      000123 C0 07            [24]  598 	push	ar7
      000125 C0 06            [24]  599 	push	ar6
      000127 12 00 E7         [24]  600 	lcall	_putc_
      00012A D0 06            [24]  601 	pop	ar6
      00012C D0 07            [24]  602 	pop	ar7
      00012E 80 E3            [24]  603 	sjmp	00101$
      000130                        604 00104$:
      000130 22               [24]  605 	ret
                                    606 ;------------------------------------------------------------
                                    607 ;Allocation info for local variables in function 'main'
                                    608 ;------------------------------------------------------------
                                    609 ;i             Allocated with name '_main_i_10000_12'
                                    610 ;j             Allocated with name '_main_j_10000_12'
                                    611 ;k             Allocated with name '_main_k_10000_12'
                                    612 ;best          Allocated with name '_main_best_10000_12'
                                    613 ;b             Allocated to registers r7 
                                    614 ;a             Allocated to registers r5 r6 
                                    615 ;s             Allocated with name '_main_s_10000_12'
                                    616 ;u             Allocated to registers r3 r4 r5 r6 
                                    617 ;w             Allocated with name '_main_w_10000_12'
                                    618 ;p             Allocated to registers 
                                    619 ;q             Allocated to registers 
                                    620 ;wv            Allocated to registers r6 
                                    621 ;hv            Allocated to registers r5 
                                    622 ;m             Allocated to registers r6 
                                    623 ;mask          Allocated with name '_main_mask_10000_12'
                                    624 ;byte          Allocated to registers r5 
                                    625 ;__800000000   Allocated with name '_main___800000000_80000_25'
                                    626 ;sloc0         Allocated with name '_main_sloc0_1_0'
                                    627 ;sloc1         Allocated with name '_main_sloc1_1_0'
                                    628 ;------------------------------------------------------------
                                    629 ;	digit_mnist.c:39: void main(void)
                                    630 ;	-----------------------------------------
                                    631 ;	 function main
                                    632 ;	-----------------------------------------
      000131                        633 _main:
                                    634 ;	digit_mnist.c:53: dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
      000131 75 11 AB         [24]  635 	mov	(_dbuf + 0x0001),#0xab
      000134 75 10 AB         [24]  636 	mov	_dbuf,#0xab
                                    637 ;	digit_mnist.c:54: dbuf[2] = dbuf[3] = 0xBF;
      000137 75 13 BF         [24]  638 	mov	(_dbuf + 0x0003),#0xbf
      00013A 75 12 BF         [24]  639 	mov	(_dbuf + 0x0002),#0xbf
                                    640 ;	digit_mnist.c:55: digi = 0;
      00013D 75 14 00         [24]  641 	mov	_digi,#0x00
                                    642 ;	digit_mnist.c:56: TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
      000140 75 89 22         [24]  643 	mov	_TMOD,#0x22
                                    644 ;	digit_mnist.c:57: TH1 = TL1 = 0xFD;
      000143 75 8B FD         [24]  645 	mov	_TL1,#0xfd
      000146 75 8D FD         [24]  646 	mov	_TH1,#0xfd
                                    647 ;	digit_mnist.c:58: PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
      000149 43 87 80         [24]  648 	orl	_PCON,#0x80
                                    649 ;	digit_mnist.c:59: SCON = 0x50;
      00014C 75 98 50         [24]  650 	mov	_SCON,#0x50
                                    651 ;	digit_mnist.c:60: TH0 = TL0 = 0;
      00014F 75 8A 00         [24]  652 	mov	_TL0,#0x00
      000152 75 8C 00         [24]  653 	mov	_TH0,#0x00
                                    654 ;	digit_mnist.c:61: TR1 = 1; TR0 = 1; ET0 = 0;   /* DISPLAY OFF BUILD (nn/energy_build.py) */ EA = 1;
                                    655 ;	assignBit
      000155 D2 8E            [12]  656 	setb	_TR1
                                    657 ;	assignBit
      000157 D2 8C            [12]  658 	setb	_TR0
                                    659 ;	assignBit
      000159 C2 A9            [12]  660 	clr	_ET0
                                    661 ;	assignBit
      00015B D2 AF            [12]  662 	setb	_EA
                                    663 ;	digit_mnist.c:62: puts_("NN READY\r\n");
      00015D 90 1E 64         [24]  664 	mov	dptr,#___str_0
      000160 12 01 0F         [24]  665 	lcall	_puts_
                                    666 ;	digit_mnist.c:65: while (getc_() != 'D') ;
      000163                        667 00101$:
      000163 12 00 DE         [24]  668 	lcall	_getc_
      000166 AF 82            [24]  669 	mov	r7, dpl
      000168 BF 44 F8         [24]  670 	cjne	r7,#0x44,00101$
                                    671 ;	digit_mnist.c:66: b = 0;
      00016B 7F 00            [12]  672 	mov	r7,#0x00
                                    673 ;	digit_mnist.c:67: for (i = 0; i < NIN; i++) {
      00016D 7E 00            [12]  674 	mov	r6,#0x00
      00016F                        675 00130$:
                                    676 ;	digit_mnist.c:68: b = (b << 1) | (getc_() == '1');
      00016F EF               [12]  677 	mov	a,r7
      000170 2F               [12]  678 	add	a,r7
      000171 FD               [12]  679 	mov	r5,a
      000172 C0 06            [24]  680 	push	ar6
      000174 C0 05            [24]  681 	push	ar5
      000176 12 00 DE         [24]  682 	lcall	_getc_
      000179 AC 82            [24]  683 	mov	r4, dpl
      00017B D0 05            [24]  684 	pop	ar5
      00017D D0 06            [24]  685 	pop	ar6
      00017F E4               [12]  686 	clr	a
      000180 BC 31 01         [24]  687 	cjne	r4,#0x31,00373$
      000183 04               [12]  688 	inc	a
      000184                        689 00373$:
      000184 4D               [12]  690 	orl	a,r5
      000185 FF               [12]  691 	mov	r7,a
                                    692 ;	digit_mnist.c:69: if ((i & 7) == 7) { pix[i >> 3] = b; b = 0; }
      000186 8E 05            [24]  693 	mov	ar5,r6
      000188 53 05 07         [24]  694 	anl	ar5,#0x07
      00018B BD 07 0C         [24]  695 	cjne	r5,#0x07,00131$
      00018E EE               [12]  696 	mov	a,r6
      00018F C4               [12]  697 	swap	a
      000190 23               [12]  698 	rl	a
      000191 54 1F            [12]  699 	anl	a,#0x1f
      000193 24 27            [12]  700 	add	a, #_pix
      000195 F8               [12]  701 	mov	r0,a
      000196 A6 07            [24]  702 	mov	@r0,ar7
      000198 7F 00            [12]  703 	mov	r7,#0x00
      00019A                        704 00131$:
                                    705 ;	digit_mnist.c:67: for (i = 0; i < NIN; i++) {
      00019A 0E               [12]  706 	inc	r6
      00019B BE C4 00         [24]  707 	cjne	r6,#0xc4,00377$
      00019E                        708 00377$:
      00019E 40 CF            [24]  709 	jc	00130$
                                    710 ;	digit_mnist.c:71: if (NIN & 7) pix[NIN >> 3] = b << (8 - (NIN & 7));
      0001A0 EF               [12]  711 	mov	a,r7
      0001A1 C4               [12]  712 	swap	a
      0001A2 54 F0            [12]  713 	anl	a,#0xf0
      0001A4 FF               [12]  714 	mov	r7,a
      0001A5 78 3F            [12]  715 	mov	r0,#(_pix + 0x0018)
      0001A7 A6 07            [24]  716 	mov	@r0,ar7
                                    717 ;	digit_mnist.c:74: for (j = 0; j < NH; j++) acc[j] = B1[j];
      0001A9 7F 00            [12]  718 	mov	r7,#0x00
      0001AB                        719 00132$:
      0001AB EF               [12]  720 	mov	a,r7
      0001AC 2F               [12]  721 	add	a,r7
      0001AD 24 40            [12]  722 	add	a, #_acc
      0001AF F9               [12]  723 	mov	r1,a
      0001B0 EF               [12]  724 	mov	a,r7
      0001B1 75 F0 02         [24]  725 	mov	b,#0x02
      0001B4 A4               [48]  726 	mul	ab
      0001B5 24 1D            [12]  727 	add	a, #_B1
      0001B7 F5 82            [12]  728 	mov	dpl,a
      0001B9 74 04            [12]  729 	mov	a,#(_B1 >> 8)
      0001BB 35 F0            [12]  730 	addc	a, b
      0001BD F5 83            [12]  731 	mov	dph,a
      0001BF E4               [12]  732 	clr	a
      0001C0 93               [24]  733 	movc	a,@a+dptr
      0001C1 FD               [12]  734 	mov	r5,a
      0001C2 A3               [24]  735 	inc	dptr
      0001C3 E4               [12]  736 	clr	a
      0001C4 93               [24]  737 	movc	a,@a+dptr
      0001C5 FE               [12]  738 	mov	r6,a
      0001C6 A7 05            [24]  739 	mov	@r1,ar5
      0001C8 09               [12]  740 	inc	r1
      0001C9 A7 06            [24]  741 	mov	@r1,ar6
      0001CB 19               [12]  742 	dec	r1
      0001CC 0F               [12]  743 	inc	r7
      0001CD BF 20 00         [24]  744 	cjne	r7,#0x20,00379$
      0001D0                        745 00379$:
      0001D0 40 D9            [24]  746 	jc	00132$
                                    747 ;	digit_mnist.c:77: w = &W1[0][0];
      0001D2 7E 5D            [12]  748 	mov	r6,#_W1
      0001D4 7F 04            [12]  749 	mov	r7,#(_W1 >> 8)
                                    750 ;	digit_mnist.c:78: q = pix; byte = *q; mask = 0x80;
      0001D6 78 27            [12]  751 	mov	r0,#_pix
      0001D8 86 05            [24]  752 	mov	ar5,@r0
      0001DA 75 1F 80         [24]  753 	mov	_main_mask_10000_12,#0x80
                                    754 ;	digit_mnist.c:79: for (i = 0; i < NIN; i++, w += NH) {
      0001DD 79 27            [12]  755 	mov	r1,#_pix
      0001DF 75 15 00         [24]  756 	mov	_main_i_10000_12,#0x00
      0001E2                        757 00136$:
                                    758 ;	digit_mnist.c:80: if (byte & mask) {
      0001E2 E5 1F            [12]  759 	mov	a,_main_mask_10000_12
      0001E4 5D               [12]  760 	anl	a,r5
      0001E5 60 3C            [24]  761 	jz	00112$
                                    762 ;	digit_mnist.c:81: p = acc;
      0001E7 7A 40            [12]  763 	mov	r2,#_acc
                                    764 ;	digit_mnist.c:82: for (j = 0; j < NH; j++) *p++ += w[j];
      0001E9 75 16 00         [24]  765 	mov	_main_j_10000_12,#0x00
      0001EC                        766 00134$:
      0001EC C0 05            [24]  767 	push	ar5
      0001EE 8A 20            [24]  768 	mov	_main___800000000_80000_25,r2
      0001F0 0A               [12]  769 	inc	r2
      0001F1 0A               [12]  770 	inc	r2
      0001F2 A8 20            [24]  771 	mov	r0,_main___800000000_80000_25
      0001F4 86 21            [24]  772 	mov	_main_sloc0_1_0,@r0
      0001F6 08               [12]  773 	inc	r0
      0001F7 86 22            [24]  774 	mov	(_main_sloc0_1_0 + 1),@r0
      0001F9 E5 16            [12]  775 	mov	a,_main_j_10000_12
      0001FB 2E               [12]  776 	add	a, r6
      0001FC F5 82            [12]  777 	mov	dpl,a
      0001FE E4               [12]  778 	clr	a
      0001FF 3F               [12]  779 	addc	a, r7
      000200 F5 83            [12]  780 	mov	dph,a
      000202 E4               [12]  781 	clr	a
      000203 93               [24]  782 	movc	a,@a+dptr
      000204 FC               [12]  783 	mov	r4,a
      000205 33               [12]  784 	rlc	a
      000206 95 E0            [12]  785 	subb	a,acc
      000208 FD               [12]  786 	mov	r5,a
      000209 EC               [12]  787 	mov	a,r4
      00020A 25 21            [12]  788 	add	a, _main_sloc0_1_0
      00020C FC               [12]  789 	mov	r4,a
      00020D ED               [12]  790 	mov	a,r5
      00020E 35 22            [12]  791 	addc	a, (_main_sloc0_1_0 + 1)
      000210 FD               [12]  792 	mov	r5,a
      000211 A8 20            [24]  793 	mov	r0,_main___800000000_80000_25
      000213 A6 04            [24]  794 	mov	@r0,ar4
      000215 08               [12]  795 	inc	r0
      000216 A6 05            [24]  796 	mov	@r0,ar5
      000218 05 16            [12]  797 	inc	_main_j_10000_12
      00021A C3               [12]  798 	clr	c
      00021B E5 16            [12]  799 	mov	a,_main_j_10000_12
      00021D 94 20            [12]  800 	subb	a,#0x20
      00021F D0 05            [24]  801 	pop	ar5
      000221 40 C9            [24]  802 	jc	00134$
      000223                        803 00112$:
                                    804 ;	digit_mnist.c:84: mask >>= 1;
      000223 E5 1F            [12]  805 	mov	a,_main_mask_10000_12
      000225 C3               [12]  806 	clr	c
      000226 13               [12]  807 	rrc	a
                                    808 ;	digit_mnist.c:85: if (!mask) { mask = 0x80; byte = *++q; }
      000227 F5 1F            [12]  809 	mov	_main_mask_10000_12,a
      000229 70 06            [24]  810 	jnz	00137$
      00022B 75 1F 80         [24]  811 	mov	_main_mask_10000_12,#0x80
      00022E 09               [12]  812 	inc	r1
      00022F 87 05            [24]  813 	mov	ar5,@r1
      000231                        814 00137$:
                                    815 ;	digit_mnist.c:79: for (i = 0; i < NIN; i++, w += NH) {
      000231 05 15            [12]  816 	inc	_main_i_10000_12
      000233 74 20            [12]  817 	mov	a,#0x20
      000235 2E               [12]  818 	add	a, r6
      000236 FE               [12]  819 	mov	r6,a
      000237 E4               [12]  820 	clr	a
      000238 3F               [12]  821 	addc	a, r7
      000239 FF               [12]  822 	mov	r7,a
      00023A 74 3C            [12]  823 	mov	a,#0x100 - 0xc4
      00023C 25 15            [12]  824 	add	a,_main_i_10000_12
      00023E 50 A2            [24]  825 	jnc	00136$
                                    826 ;	digit_mnist.c:93: for (j = 0; j < NH; j++) {
      000240 7F 00            [12]  827 	mov	r7,#0x00
      000242                        828 00138$:
                                    829 ;	digit_mnist.c:94: a = acc[j];
      000242 EF               [12]  830 	mov	a,r7
      000243 2F               [12]  831 	add	a,r7
      000244 24 40            [12]  832 	add	a, #_acc
      000246 F9               [12]  833 	mov	r1,a
      000247 87 05            [24]  834 	mov	ar5,@r1
      000249 09               [12]  835 	inc	r1
      00024A 87 06            [24]  836 	mov	ar6,@r1
      00024C 19               [12]  837 	dec	r1
                                    838 ;	digit_mnist.c:95: if (a < 0) hid[j] = 0;
      00024D EE               [12]  839 	mov	a,r6
      00024E 30 E7 08         [24]  840 	jnb	acc.7,00117$
      000251 EF               [12]  841 	mov	a,r7
      000252 24 80            [12]  842 	add	a, #_hid
      000254 F8               [12]  843 	mov	r0,a
      000255 76 00            [12]  844 	mov	@r0,#0x00
      000257 80 23            [24]  845 	sjmp	00139$
      000259                        846 00117$:
                                    847 ;	digit_mnist.c:96: else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
      000259 EE               [12]  848 	mov	a,r6
      00025A A2 E7            [12]  849 	mov	c,acc.7
      00025C 13               [12]  850 	rrc	a
      00025D CD               [12]  851 	xch	a,r5
      00025E 13               [12]  852 	rrc	a
      00025F CD               [12]  853 	xch	a,r5
      000260 FE               [12]  854 	mov	r6,a
      000261 EF               [12]  855 	mov	a,r7
      000262 24 80            [12]  856 	add	a, #_hid
      000264 F9               [12]  857 	mov	r1,a
      000265 C3               [12]  858 	clr	c
      000266 74 FF            [12]  859 	mov	a,#0xff
      000268 9D               [12]  860 	subb	a,r5
      000269 74 80            [12]  861 	mov	a,#(0x00 ^ 0x80)
      00026B 8E F0            [24]  862 	mov	b,r6
      00026D 63 F0 80         [24]  863 	xrl	b,#0x80
      000270 95 F0            [12]  864 	subb	a,b
      000272 50 04            [24]  865 	jnc	00152$
                                    866 ;	free result
      000274 7C FF            [12]  867 	mov	r4,#0xff
      000276 80 02            [24]  868 	sjmp	00153$
      000278                        869 00152$:
      000278 8D 04            [24]  870 	mov	ar4,r5
      00027A                        871 00153$:
      00027A A7 04            [24]  872 	mov	@r1,ar4
      00027C                        873 00139$:
                                    874 ;	digit_mnist.c:93: for (j = 0; j < NH; j++) {
      00027C 0F               [12]  875 	inc	r7
      00027D BF 20 00         [24]  876 	cjne	r7,#0x20,00387$
      000280                        877 00387$:
      000280 40 C0            [24]  878 	jc	00138$
                                    879 ;	digit_mnist.c:100: for (k = 0; k < 10; k++) {
      000282 75 17 00         [24]  880 	mov	_main_k_10000_12,#0x00
      000285                        881 00142$:
                                    882 ;	digit_mnist.c:101: s = B2[k];
      000285 E5 17            [12]  883 	mov	a,_main_k_10000_12
      000287 75 F0 04         [24]  884 	mov	b,#0x04
      00028A A4               [48]  885 	mul	ab
      00028B 24 DD            [12]  886 	add	a, #_B2
      00028D F5 82            [12]  887 	mov	dpl,a
      00028F 74 1C            [12]  888 	mov	a,#(_B2 >> 8)
      000291 35 F0            [12]  889 	addc	a, b
      000293 F5 83            [12]  890 	mov	dph,a
      000295 E4               [12]  891 	clr	a
      000296 93               [24]  892 	movc	a,@a+dptr
      000297 F5 19            [12]  893 	mov	_main_s_10000_12,a
      000299 A3               [24]  894 	inc	dptr
      00029A E4               [12]  895 	clr	a
      00029B 93               [24]  896 	movc	a,@a+dptr
      00029C F5 1A            [12]  897 	mov	(_main_s_10000_12 + 1),a
      00029E A3               [24]  898 	inc	dptr
      00029F E4               [12]  899 	clr	a
      0002A0 93               [24]  900 	movc	a,@a+dptr
      0002A1 F5 1B            [12]  901 	mov	(_main_s_10000_12 + 2),a
      0002A3 A3               [24]  902 	inc	dptr
      0002A4 E4               [12]  903 	clr	a
      0002A5 93               [24]  904 	movc	a,@a+dptr
      0002A6 F5 1C            [12]  905 	mov	(_main_s_10000_12 + 3),a
                                    906 ;	digit_mnist.c:103: w = W2[k];
      0002A8 E5 17            [12]  907 	mov	a,_main_k_10000_12
      0002AA 75 F0 20         [24]  908 	mov	b,#0x20
      0002AD A4               [48]  909 	mul	ab
      0002AE 24 05            [12]  910 	add	a, #_W2
      0002B0 F5 1D            [12]  911 	mov	_main_w_10000_12,a
      0002B2 74 1D            [12]  912 	mov	a,#(_W2 >> 8)
      0002B4 35 F0            [12]  913 	addc	a, b
      0002B6 F5 1E            [12]  914 	mov	(_main_w_10000_12 + 1),a
                                    915 ;	digit_mnist.c:104: for (j = 0; j < NH; j++) {
      0002B8 75 16 00         [24]  916 	mov	_main_j_10000_12,#0x00
      0002BB                        917 00140$:
                                    918 ;	digit_mnist.c:105: wv = w[j];
      0002BB E5 16            [12]  919 	mov	a,_main_j_10000_12
      0002BD 25 1D            [12]  920 	add	a, _main_w_10000_12
      0002BF F5 82            [12]  921 	mov	dpl,a
      0002C1 E4               [12]  922 	clr	a
      0002C2 35 1E            [12]  923 	addc	a, (_main_w_10000_12 + 1)
      0002C4 F5 83            [12]  924 	mov	dph,a
      0002C6 E4               [12]  925 	clr	a
      0002C7 93               [24]  926 	movc	a,@a+dptr
      0002C8 FE               [12]  927 	mov	r6,a
                                    928 ;	digit_mnist.c:106: hv = hid[j];
      0002C9 E5 16            [12]  929 	mov	a,_main_j_10000_12
      0002CB 24 80            [12]  930 	add	a, #_hid
      0002CD F9               [12]  931 	mov	r1,a
      0002CE 87 05            [24]  932 	mov	ar5,@r1
                                    933 ;	digit_mnist.c:107: if (wv < 0) { m = -wv; s -= (unsigned int)(hv * m); }
      0002D0 EE               [12]  934 	mov	a,r6
      0002D1 30 E7 23         [24]  935 	jnb	acc.7,00121$
      0002D4 C3               [12]  936 	clr	c
      0002D5 E4               [12]  937 	clr	a
      0002D6 9E               [12]  938 	subb	a,r6
      0002D7 8D F0            [24]  939 	mov	b,r5
      0002D9 A4               [48]  940 	mul	ab
      0002DA FB               [12]  941 	mov	r3,a
      0002DB AC F0            [24]  942 	mov	r4,b
      0002DD E4               [12]  943 	clr	a
      0002DE FA               [12]  944 	mov	r2,a
      0002DF FF               [12]  945 	mov	r7,a
      0002E0 E5 19            [12]  946 	mov	a,_main_s_10000_12
      0002E2 C3               [12]  947 	clr	c
      0002E3 9B               [12]  948 	subb	a,r3
      0002E4 F5 19            [12]  949 	mov	_main_s_10000_12,a
      0002E6 E5 1A            [12]  950 	mov	a,(_main_s_10000_12 + 1)
      0002E8 9C               [12]  951 	subb	a,r4
      0002E9 F5 1A            [12]  952 	mov	(_main_s_10000_12 + 1),a
      0002EB E5 1B            [12]  953 	mov	a,(_main_s_10000_12 + 2)
      0002ED 9A               [12]  954 	subb	a,r2
      0002EE F5 1B            [12]  955 	mov	(_main_s_10000_12 + 2),a
      0002F0 E5 1C            [12]  956 	mov	a,(_main_s_10000_12 + 3)
      0002F2 9F               [12]  957 	subb	a,r7
      0002F3 F5 1C            [12]  958 	mov	(_main_s_10000_12 + 3),a
      0002F5 80 20            [24]  959 	sjmp	00141$
      0002F7                        960 00121$:
                                    961 ;	digit_mnist.c:108: else { m = wv; s += (unsigned int)(hv * m); }
      0002F7 8D F0            [24]  962 	mov	b,r5
      0002F9 EE               [12]  963 	mov	a,r6
      0002FA A4               [48]  964 	mul	ab
      0002FB FF               [12]  965 	mov	r7,a
      0002FC AD F0            [24]  966 	mov	r5,b
      0002FE 8D 04            [24]  967 	mov	ar4,r5
      000300 E4               [12]  968 	clr	a
      000301 FD               [12]  969 	mov	r5,a
      000302 FE               [12]  970 	mov	r6,a
      000303 EF               [12]  971 	mov	a,r7
      000304 25 19            [12]  972 	add	a, _main_s_10000_12
      000306 F5 19            [12]  973 	mov	_main_s_10000_12,a
      000308 EC               [12]  974 	mov	a,r4
      000309 35 1A            [12]  975 	addc	a, (_main_s_10000_12 + 1)
      00030B F5 1A            [12]  976 	mov	(_main_s_10000_12 + 1),a
      00030D ED               [12]  977 	mov	a,r5
      00030E 35 1B            [12]  978 	addc	a, (_main_s_10000_12 + 2)
      000310 F5 1B            [12]  979 	mov	(_main_s_10000_12 + 2),a
      000312 EE               [12]  980 	mov	a,r6
      000313 35 1C            [12]  981 	addc	a, (_main_s_10000_12 + 3)
      000315 F5 1C            [12]  982 	mov	(_main_s_10000_12 + 3),a
      000317                        983 00141$:
                                    984 ;	digit_mnist.c:104: for (j = 0; j < NH; j++) {
      000317 05 16            [12]  985 	inc	_main_j_10000_12
      000319 74 E0            [12]  986 	mov	a,#0x100 - 0x20
      00031B 25 16            [12]  987 	add	a,_main_j_10000_12
      00031D 50 9C            [24]  988 	jnc	00140$
                                    989 ;	digit_mnist.c:114: score[k] = s;
      00031F E5 17            [12]  990 	mov	a,_main_k_10000_12
      000321 25 17            [12]  991 	add	a,_main_k_10000_12
      000323 25 E0            [12]  992 	add	a,acc
      000325 24 A0            [12]  993 	add	a, #_score
      000327 F8               [12]  994 	mov	r0,a
      000328 A6 19            [24]  995 	mov	@r0,_main_s_10000_12
      00032A 08               [12]  996 	inc	r0
      00032B A6 1A            [24]  997 	mov	@r0,(_main_s_10000_12 + 1)
      00032D 08               [12]  998 	inc	r0
      00032E A6 1B            [24]  999 	mov	@r0,(_main_s_10000_12 + 2)
      000330 08               [12] 1000 	inc	r0
      000331 A6 1C            [24] 1001 	mov	@r0,(_main_s_10000_12 + 3)
                                   1002 ;	digit_mnist.c:100: for (k = 0; k < 10; k++) {
      000333 05 17            [12] 1003 	inc	_main_k_10000_12
      000335 74 F6            [12] 1004 	mov	a,#0x100 - 0x0a
      000337 25 17            [12] 1005 	add	a,_main_k_10000_12
      000339 40 03            [24] 1006 	jc	00391$
      00033B 02 02 85         [24] 1007 	ljmp	00142$
      00033E                       1008 00391$:
                                   1009 ;	digit_mnist.c:118: best = 0;
      00033E 7F 00            [12] 1010 	mov	r7,#0x00
                                   1011 ;	digit_mnist.c:119: for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;
      000340 75 18 01         [24] 1012 	mov	_main_best_10000_12,#0x01
      000343                       1013 00144$:
      000343 E5 18            [12] 1014 	mov	a,_main_best_10000_12
      000345 25 18            [12] 1015 	add	a,_main_best_10000_12
      000347 25 E0            [12] 1016 	add	a,acc
      000349 24 A0            [12] 1017 	add	a, #_score
      00034B F9               [12] 1018 	mov	r1,a
      00034C 87 23            [24] 1019 	mov	_main_sloc1_1_0,@r1
      00034E 09               [12] 1020 	inc	r1
      00034F 87 24            [24] 1021 	mov	(_main_sloc1_1_0 + 1),@r1
      000351 09               [12] 1022 	inc	r1
      000352 87 25            [24] 1023 	mov	(_main_sloc1_1_0 + 2),@r1
      000354 09               [12] 1024 	inc	r1
      000355 87 26            [24] 1025 	mov	(_main_sloc1_1_0 + 3),@r1
      000357 19               [12] 1026 	dec	r1
      000358 19               [12] 1027 	dec	r1
      000359 19               [12] 1028 	dec	r1
      00035A EF               [12] 1029 	mov	a,r7
      00035B 2F               [12] 1030 	add	a,r7
      00035C 25 E0            [12] 1031 	add	a,acc
      00035E 24 A0            [12] 1032 	add	a, #_score
      000360 F9               [12] 1033 	mov	r1,a
      000361 C0 07            [24] 1034 	push	ar7
      000363 87 04            [24] 1035 	mov	ar4,@r1
      000365 09               [12] 1036 	inc	r1
      000366 87 05            [24] 1037 	mov	ar5,@r1
      000368 09               [12] 1038 	inc	r1
      000369 87 06            [24] 1039 	mov	ar6,@r1
      00036B 09               [12] 1040 	inc	r1
      00036C 87 07            [24] 1041 	mov	ar7,@r1
      00036E 19               [12] 1042 	dec	r1
      00036F 19               [12] 1043 	dec	r1
      000370 19               [12] 1044 	dec	r1
      000371 C3               [12] 1045 	clr	c
      000372 EC               [12] 1046 	mov	a,r4
      000373 95 23            [12] 1047 	subb	a,_main_sloc1_1_0
      000375 ED               [12] 1048 	mov	a,r5
      000376 95 24            [12] 1049 	subb	a,(_main_sloc1_1_0 + 1)
      000378 EE               [12] 1050 	mov	a,r6
      000379 95 25            [12] 1051 	subb	a,(_main_sloc1_1_0 + 2)
      00037B EF               [12] 1052 	mov	a,r7
      00037C 64 80            [12] 1053 	xrl	a,#0x80
      00037E 85 26 F0         [24] 1054 	mov	b,(_main_sloc1_1_0 + 3)
      000381 63 F0 80         [24] 1055 	xrl	b,#0x80
      000384 95 F0            [12] 1056 	subb	a,b
      000386 D0 07            [24] 1057 	pop	ar7
      000388 50 02            [24] 1058 	jnc	00145$
                                   1059 ;	free result
      00038A AF 18            [24] 1060 	mov	r7,_main_best_10000_12
      00038C                       1061 00145$:
      00038C 05 18            [12] 1062 	inc	_main_best_10000_12
      00038E 74 F6            [12] 1063 	mov	a,#0x100 - 0x0a
      000390 25 18            [12] 1064 	add	a,_main_best_10000_12
      000392 50 AF            [24] 1065 	jnc	00144$
                                   1066 ;	digit_mnist.c:121: dbuf[2] = 0xFF;
      000394 75 12 FF         [24] 1067 	mov	(_dbuf + 0x0002),#0xff
                                   1068 ;	digit_mnist.c:122: dbuf[3] = segs[best];
      000397 EF               [12] 1069 	mov	a,r7
      000398 90 1E 49         [24] 1070 	mov	dptr,#_segs
      00039B 93               [24] 1071 	movc	a,@a+dptr
      00039C F5 13            [12] 1072 	mov	(_dbuf + 0x0003), a
                                   1073 ;	digit_mnist.c:123: putc_('=');
      00039E 75 82 3D         [24] 1074 	mov	dpl, #0x3d
      0003A1 C0 07            [24] 1075 	push	ar7
      0003A3 12 00 E7         [24] 1076 	lcall	_putc_
      0003A6 D0 07            [24] 1077 	pop	ar7
                                   1078 ;	digit_mnist.c:124: putc_('0' + best);
      0003A8 74 30            [12] 1079 	mov	a,#0x30
      0003AA 2F               [12] 1080 	add	a, r7
      0003AB F5 82            [12] 1081 	mov	dpl,a
      0003AD 12 00 E7         [24] 1082 	lcall	_putc_
                                   1083 ;	digit_mnist.c:125: for (k = 0; k < 10; k++) {
      0003B0 7F 00            [12] 1084 	mov	r7,#0x00
      0003B2                       1085 00146$:
                                   1086 ;	digit_mnist.c:126: u = (unsigned long)score[k];
      0003B2 EF               [12] 1087 	mov	a,r7
      0003B3 2F               [12] 1088 	add	a,r7
      0003B4 25 E0            [12] 1089 	add	a,acc
      0003B6 24 A0            [12] 1090 	add	a, #_score
      0003B8 F9               [12] 1091 	mov	r1,a
      0003B9 87 03            [24] 1092 	mov	ar3,@r1
      0003BB 09               [12] 1093 	inc	r1
      0003BC 87 04            [24] 1094 	mov	ar4,@r1
      0003BE 09               [12] 1095 	inc	r1
      0003BF 87 05            [24] 1096 	mov	ar5,@r1
      0003C1 09               [12] 1097 	inc	r1
      0003C2 87 06            [24] 1098 	mov	ar6,@r1
      0003C4 19               [12] 1099 	dec	r1
      0003C5 19               [12] 1100 	dec	r1
      0003C6 19               [12] 1101 	dec	r1
                                   1102 ;	digit_mnist.c:127: putc_(' ');
      0003C7 75 82 20         [24] 1103 	mov	dpl, #0x20
      0003CA C0 07            [24] 1104 	push	ar7
      0003CC C0 06            [24] 1105 	push	ar6
      0003CE C0 05            [24] 1106 	push	ar5
      0003D0 C0 04            [24] 1107 	push	ar4
      0003D2 C0 03            [24] 1108 	push	ar3
      0003D4 12 00 E7         [24] 1109 	lcall	_putc_
      0003D7 D0 03            [24] 1110 	pop	ar3
      0003D9 D0 04            [24] 1111 	pop	ar4
      0003DB D0 05            [24] 1112 	pop	ar5
                                   1113 ;	digit_mnist.c:128: puthex((unsigned char)(u >> 16));
      0003DD 8D 82            [24] 1114 	mov	dpl,r5
      0003DF C0 05            [24] 1115 	push	ar5
      0003E1 C0 04            [24] 1116 	push	ar4
      0003E3 C0 03            [24] 1117 	push	ar3
      0003E5 12 00 F0         [24] 1118 	lcall	_puthex
      0003E8 D0 03            [24] 1119 	pop	ar3
      0003EA D0 04            [24] 1120 	pop	ar4
                                   1121 ;	digit_mnist.c:129: puthex((unsigned char)(u >> 8));
      0003EC 8C 82            [24] 1122 	mov	dpl,r4
      0003EE C0 04            [24] 1123 	push	ar4
      0003F0 C0 03            [24] 1124 	push	ar3
      0003F2 12 00 F0         [24] 1125 	lcall	_puthex
      0003F5 D0 03            [24] 1126 	pop	ar3
      0003F7 D0 04            [24] 1127 	pop	ar4
      0003F9 D0 05            [24] 1128 	pop	ar5
      0003FB D0 06            [24] 1129 	pop	ar6
                                   1130 ;	digit_mnist.c:130: puthex((unsigned char)u);
      0003FD 8B 82            [24] 1131 	mov	dpl,r3
      0003FF 12 00 F0         [24] 1132 	lcall	_puthex
      000402 D0 07            [24] 1133 	pop	ar7
                                   1134 ;	digit_mnist.c:125: for (k = 0; k < 10; k++) {
      000404 0F               [12] 1135 	inc	r7
      000405 BF 0A 00         [24] 1136 	cjne	r7,#0x0a,00394$
      000408                       1137 00394$:
      000408 40 A8            [24] 1138 	jc	00146$
                                   1139 ;	digit_mnist.c:132: putc_('\r');
      00040A 75 82 0D         [24] 1140 	mov	dpl, #0x0d
      00040D 12 00 E7         [24] 1141 	lcall	_putc_
                                   1142 ;	digit_mnist.c:133: putc_('\n');
      000410 75 82 0A         [24] 1143 	mov	dpl, #0x0a
      000413 12 00 E7         [24] 1144 	lcall	_putc_
                                   1145 ;	digit_mnist.c:135: }
      000416 02 01 63         [24] 1146 	ljmp	00101$
                                   1147 	.area CSEG    (CODE)
                                   1148 	.area CONST   (CODE)
                                   1149 	.area CONST   (CODE)
      00041D                       1150 _B1:
      00041D F1 FF                 1151 	.byte #0xf1, #0xff	; -15
      00041F 19 00                 1152 	.byte #0x19, #0x00	;  25
      000421 E9 FF                 1153 	.byte #0xe9, #0xff	; -23
      000423 1E 00                 1154 	.byte #0x1e, #0x00	;  30
      000425 B7 FF                 1155 	.byte #0xb7, #0xff	; -73
      000427 FA FF                 1156 	.byte #0xfa, #0xff	; -6
      000429 FC FF                 1157 	.byte #0xfc, #0xff	; -4
      00042B 14 00                 1158 	.byte #0x14, #0x00	;  20
      00042D 2C 00                 1159 	.byte #0x2c, #0x00	;  44
      00042F DA FF                 1160 	.byte #0xda, #0xff	; -38
      000431 CC FF                 1161 	.byte #0xcc, #0xff	; -52
      000433 22 00                 1162 	.byte #0x22, #0x00	;  34
      000435 FA FF                 1163 	.byte #0xfa, #0xff	; -6
      000437 FD FF                 1164 	.byte #0xfd, #0xff	; -3
      000439 E1 FF                 1165 	.byte #0xe1, #0xff	; -31
      00043B 30 00                 1166 	.byte #0x30, #0x00	;  48
      00043D 1D 00                 1167 	.byte #0x1d, #0x00	;  29
      00043F E0 FF                 1168 	.byte #0xe0, #0xff	; -32
      000441 CA FF                 1169 	.byte #0xca, #0xff	; -54
      000443 01 00                 1170 	.byte #0x01, #0x00	;  1
      000445 00 00                 1171 	.byte #0x00, #0x00	;  0
      000447 2B 00                 1172 	.byte #0x2b, #0x00	;  43
      000449 0E 00                 1173 	.byte #0x0e, #0x00	;  14
      00044B EB FF                 1174 	.byte #0xeb, #0xff	; -21
      00044D FD FF                 1175 	.byte #0xfd, #0xff	; -3
      00044F F7 FF                 1176 	.byte #0xf7, #0xff	; -9
      000451 35 00                 1177 	.byte #0x35, #0x00	;  53
      000453 02 00                 1178 	.byte #0x02, #0x00	;  2
      000455 26 00                 1179 	.byte #0x26, #0x00	;  38
      000457 33 00                 1180 	.byte #0x33, #0x00	;  51
      000459 1F 00                 1181 	.byte #0x1f, #0x00	;  31
      00045B EC FF                 1182 	.byte #0xec, #0xff	; -20
                                   1183 	.area CSEG    (CODE)
                                   1184 	.area CONST   (CODE)
      00045D                       1185 _W1:
      00045D 00                    1186 	.db #0x00	;  0
      00045E 00                    1187 	.db #0x00	;  0
      00045F 00                    1188 	.db #0x00	;  0
      000460 00                    1189 	.db #0x00	;  0
      000461 00                    1190 	.db #0x00	;  0
      000462 00                    1191 	.db #0x00	;  0
      000463 00                    1192 	.db #0x00	;  0
      000464 00                    1193 	.db #0x00	;  0
      000465 00                    1194 	.db #0x00	;  0
      000466 00                    1195 	.db #0x00	;  0
      000467 00                    1196 	.db #0x00	;  0
      000468 00                    1197 	.db #0x00	;  0
      000469 00                    1198 	.db #0x00	;  0
      00046A 00                    1199 	.db #0x00	;  0
      00046B 00                    1200 	.db #0x00	;  0
      00046C 00                    1201 	.db #0x00	;  0
      00046D 00                    1202 	.db #0x00	;  0
      00046E 00                    1203 	.db #0x00	;  0
      00046F 00                    1204 	.db #0x00	;  0
      000470 00                    1205 	.db #0x00	;  0
      000471 00                    1206 	.db #0x00	;  0
      000472 00                    1207 	.db #0x00	;  0
      000473 00                    1208 	.db #0x00	;  0
      000474 00                    1209 	.db #0x00	;  0
      000475 00                    1210 	.db #0x00	;  0
      000476 00                    1211 	.db #0x00	;  0
      000477 00                    1212 	.db #0x00	;  0
      000478 00                    1213 	.db #0x00	;  0
      000479 00                    1214 	.db #0x00	;  0
      00047A 00                    1215 	.db #0x00	;  0
      00047B 00                    1216 	.db #0x00	;  0
      00047C 00                    1217 	.db #0x00	;  0
      00047D 00                    1218 	.db #0x00	;  0
      00047E 00                    1219 	.db #0x00	;  0
      00047F 00                    1220 	.db #0x00	;  0
      000480 00                    1221 	.db #0x00	;  0
      000481 00                    1222 	.db #0x00	;  0
      000482 00                    1223 	.db #0x00	;  0
      000483 00                    1224 	.db #0x00	;  0
      000484 00                    1225 	.db #0x00	;  0
      000485 00                    1226 	.db #0x00	;  0
      000486 00                    1227 	.db #0x00	;  0
      000487 00                    1228 	.db #0x00	;  0
      000488 00                    1229 	.db #0x00	;  0
      000489 00                    1230 	.db #0x00	;  0
      00048A 00                    1231 	.db #0x00	;  0
      00048B 00                    1232 	.db #0x00	;  0
      00048C 00                    1233 	.db #0x00	;  0
      00048D 00                    1234 	.db #0x00	;  0
      00048E 00                    1235 	.db #0x00	;  0
      00048F 00                    1236 	.db #0x00	;  0
      000490 00                    1237 	.db #0x00	;  0
      000491 00                    1238 	.db #0x00	;  0
      000492 00                    1239 	.db #0x00	;  0
      000493 00                    1240 	.db #0x00	;  0
      000494 00                    1241 	.db #0x00	;  0
      000495 00                    1242 	.db #0x00	;  0
      000496 00                    1243 	.db #0x00	;  0
      000497 00                    1244 	.db #0x00	;  0
      000498 00                    1245 	.db #0x00	;  0
      000499 00                    1246 	.db #0x00	;  0
      00049A 00                    1247 	.db #0x00	;  0
      00049B 00                    1248 	.db #0x00	;  0
      00049C 00                    1249 	.db #0x00	;  0
      00049D 00                    1250 	.db #0x00	;  0
      00049E 00                    1251 	.db #0x00	;  0
      00049F 00                    1252 	.db #0x00	;  0
      0004A0 00                    1253 	.db #0x00	;  0
      0004A1 00                    1254 	.db #0x00	;  0
      0004A2 00                    1255 	.db #0x00	;  0
      0004A3 00                    1256 	.db #0x00	;  0
      0004A4 00                    1257 	.db #0x00	;  0
      0004A5 00                    1258 	.db #0x00	;  0
      0004A6 00                    1259 	.db #0x00	;  0
      0004A7 00                    1260 	.db #0x00	;  0
      0004A8 00                    1261 	.db #0x00	;  0
      0004A9 00                    1262 	.db #0x00	;  0
      0004AA 00                    1263 	.db #0x00	;  0
      0004AB 00                    1264 	.db #0x00	;  0
      0004AC 00                    1265 	.db #0x00	;  0
      0004AD 00                    1266 	.db #0x00	;  0
      0004AE 00                    1267 	.db #0x00	;  0
      0004AF 00                    1268 	.db #0x00	;  0
      0004B0 00                    1269 	.db #0x00	;  0
      0004B1 00                    1270 	.db #0x00	;  0
      0004B2 00                    1271 	.db #0x00	;  0
      0004B3 00                    1272 	.db #0x00	;  0
      0004B4 00                    1273 	.db #0x00	;  0
      0004B5 00                    1274 	.db #0x00	;  0
      0004B6 00                    1275 	.db #0x00	;  0
      0004B7 00                    1276 	.db #0x00	;  0
      0004B8 00                    1277 	.db #0x00	;  0
      0004B9 00                    1278 	.db #0x00	;  0
      0004BA 00                    1279 	.db #0x00	;  0
      0004BB 00                    1280 	.db #0x00	;  0
      0004BC 00                    1281 	.db #0x00	;  0
      0004BD 00                    1282 	.db #0x00	;  0
      0004BE 00                    1283 	.db #0x00	;  0
      0004BF 00                    1284 	.db #0x00	;  0
      0004C0 00                    1285 	.db #0x00	;  0
      0004C1 00                    1286 	.db #0x00	;  0
      0004C2 00                    1287 	.db #0x00	;  0
      0004C3 00                    1288 	.db #0x00	;  0
      0004C4 00                    1289 	.db #0x00	;  0
      0004C5 00                    1290 	.db #0x00	;  0
      0004C6 00                    1291 	.db #0x00	;  0
      0004C7 00                    1292 	.db #0x00	;  0
      0004C8 00                    1293 	.db #0x00	;  0
      0004C9 00                    1294 	.db #0x00	;  0
      0004CA 00                    1295 	.db #0x00	;  0
      0004CB 00                    1296 	.db #0x00	;  0
      0004CC 00                    1297 	.db #0x00	;  0
      0004CD 00                    1298 	.db #0x00	;  0
      0004CE 00                    1299 	.db #0x00	;  0
      0004CF 00                    1300 	.db #0x00	;  0
      0004D0 00                    1301 	.db #0x00	;  0
      0004D1 00                    1302 	.db #0x00	;  0
      0004D2 00                    1303 	.db #0x00	;  0
      0004D3 00                    1304 	.db #0x00	;  0
      0004D4 00                    1305 	.db #0x00	;  0
      0004D5 00                    1306 	.db #0x00	;  0
      0004D6 00                    1307 	.db #0x00	;  0
      0004D7 00                    1308 	.db #0x00	;  0
      0004D8 00                    1309 	.db #0x00	;  0
      0004D9 00                    1310 	.db #0x00	;  0
      0004DA 00                    1311 	.db #0x00	;  0
      0004DB 00                    1312 	.db #0x00	;  0
      0004DC 00                    1313 	.db #0x00	;  0
      0004DD 00                    1314 	.db #0x00	;  0
      0004DE 00                    1315 	.db #0x00	;  0
      0004DF 00                    1316 	.db #0x00	;  0
      0004E0 00                    1317 	.db #0x00	;  0
      0004E1 00                    1318 	.db #0x00	;  0
      0004E2 00                    1319 	.db #0x00	;  0
      0004E3 00                    1320 	.db #0x00	;  0
      0004E4 00                    1321 	.db #0x00	;  0
      0004E5 00                    1322 	.db #0x00	;  0
      0004E6 00                    1323 	.db #0x00	;  0
      0004E7 00                    1324 	.db #0x00	;  0
      0004E8 00                    1325 	.db #0x00	;  0
      0004E9 00                    1326 	.db #0x00	;  0
      0004EA 00                    1327 	.db #0x00	;  0
      0004EB 00                    1328 	.db #0x00	;  0
      0004EC 00                    1329 	.db #0x00	;  0
      0004ED 00                    1330 	.db #0x00	;  0
      0004EE 00                    1331 	.db #0x00	;  0
      0004EF 00                    1332 	.db #0x00	;  0
      0004F0 00                    1333 	.db #0x00	;  0
      0004F1 00                    1334 	.db #0x00	;  0
      0004F2 00                    1335 	.db #0x00	;  0
      0004F3 00                    1336 	.db #0x00	;  0
      0004F4 00                    1337 	.db #0x00	;  0
      0004F5 00                    1338 	.db #0x00	;  0
      0004F6 00                    1339 	.db #0x00	;  0
      0004F7 00                    1340 	.db #0x00	;  0
      0004F8 00                    1341 	.db #0x00	;  0
      0004F9 00                    1342 	.db #0x00	;  0
      0004FA 00                    1343 	.db #0x00	;  0
      0004FB 00                    1344 	.db #0x00	;  0
      0004FC 00                    1345 	.db #0x00	;  0
      0004FD 00                    1346 	.db #0x00	;  0
      0004FE 00                    1347 	.db #0x00	;  0
      0004FF 00                    1348 	.db #0x00	;  0
      000500 00                    1349 	.db #0x00	;  0
      000501 00                    1350 	.db #0x00	;  0
      000502 00                    1351 	.db #0x00	;  0
      000503 00                    1352 	.db #0x00	;  0
      000504 00                    1353 	.db #0x00	;  0
      000505 00                    1354 	.db #0x00	;  0
      000506 00                    1355 	.db #0x00	;  0
      000507 00                    1356 	.db #0x00	;  0
      000508 00                    1357 	.db #0x00	;  0
      000509 00                    1358 	.db #0x00	;  0
      00050A 00                    1359 	.db #0x00	;  0
      00050B 00                    1360 	.db #0x00	;  0
      00050C 00                    1361 	.db #0x00	;  0
      00050D 00                    1362 	.db #0x00	;  0
      00050E 00                    1363 	.db #0x00	;  0
      00050F 00                    1364 	.db #0x00	;  0
      000510 00                    1365 	.db #0x00	;  0
      000511 00                    1366 	.db #0x00	;  0
      000512 00                    1367 	.db #0x00	;  0
      000513 00                    1368 	.db #0x00	;  0
      000514 00                    1369 	.db #0x00	;  0
      000515 00                    1370 	.db #0x00	;  0
      000516 00                    1371 	.db #0x00	;  0
      000517 00                    1372 	.db #0x00	;  0
      000518 00                    1373 	.db #0x00	;  0
      000519 00                    1374 	.db #0x00	;  0
      00051A 00                    1375 	.db #0x00	;  0
      00051B 00                    1376 	.db #0x00	;  0
      00051C 00                    1377 	.db #0x00	;  0
      00051D 00                    1378 	.db #0x00	;  0
      00051E 00                    1379 	.db #0x00	;  0
      00051F 00                    1380 	.db #0x00	;  0
      000520 00                    1381 	.db #0x00	;  0
      000521 00                    1382 	.db #0x00	;  0
      000522 00                    1383 	.db #0x00	;  0
      000523 00                    1384 	.db #0x00	;  0
      000524 00                    1385 	.db #0x00	;  0
      000525 00                    1386 	.db #0x00	;  0
      000526 00                    1387 	.db #0x00	;  0
      000527 00                    1388 	.db #0x00	;  0
      000528 00                    1389 	.db #0x00	;  0
      000529 00                    1390 	.db #0x00	;  0
      00052A 00                    1391 	.db #0x00	;  0
      00052B 00                    1392 	.db #0x00	;  0
      00052C 00                    1393 	.db #0x00	;  0
      00052D 00                    1394 	.db #0x00	;  0
      00052E 00                    1395 	.db #0x00	;  0
      00052F 00                    1396 	.db #0x00	;  0
      000530 00                    1397 	.db #0x00	;  0
      000531 00                    1398 	.db #0x00	;  0
      000532 00                    1399 	.db #0x00	;  0
      000533 00                    1400 	.db #0x00	;  0
      000534 00                    1401 	.db #0x00	;  0
      000535 00                    1402 	.db #0x00	;  0
      000536 00                    1403 	.db #0x00	;  0
      000537 00                    1404 	.db #0x00	;  0
      000538 00                    1405 	.db #0x00	;  0
      000539 00                    1406 	.db #0x00	;  0
      00053A 00                    1407 	.db #0x00	;  0
      00053B 00                    1408 	.db #0x00	;  0
      00053C 00                    1409 	.db #0x00	;  0
      00053D 00                    1410 	.db #0x00	;  0
      00053E 00                    1411 	.db #0x00	;  0
      00053F 00                    1412 	.db #0x00	;  0
      000540 FF                    1413 	.db #0xff	; -1
      000541 05                    1414 	.db #0x05	;  5
      000542 00                    1415 	.db #0x00	;  0
      000543 00                    1416 	.db #0x00	;  0
      000544 00                    1417 	.db #0x00	;  0
      000545 00                    1418 	.db #0x00	;  0
      000546 00                    1419 	.db #0x00	;  0
      000547 FA                    1420 	.db #0xfa	; -6
      000548 00                    1421 	.db #0x00	;  0
      000549 00                    1422 	.db #0x00	;  0
      00054A 00                    1423 	.db #0x00	;  0
      00054B 00                    1424 	.db #0x00	;  0
      00054C 05                    1425 	.db #0x05	;  5
      00054D 00                    1426 	.db #0x00	;  0
      00054E FB                    1427 	.db #0xfb	; -5
      00054F 00                    1428 	.db #0x00	;  0
      000550 01                    1429 	.db #0x01	;  1
      000551 08                    1430 	.db #0x08	;  8
      000552 00                    1431 	.db #0x00	;  0
      000553 FF                    1432 	.db #0xff	; -1
      000554 00                    1433 	.db #0x00	;  0
      000555 00                    1434 	.db #0x00	;  0
      000556 00                    1435 	.db #0x00	;  0
      000557 FF                    1436 	.db #0xff	; -1
      000558 F8                    1437 	.db #0xf8	; -8
      000559 00                    1438 	.db #0x00	;  0
      00055A 03                    1439 	.db #0x03	;  3
      00055B FF                    1440 	.db #0xff	; -1
      00055C 01                    1441 	.db #0x01	;  1
      00055D 00                    1442 	.db #0x00	;  0
      00055E 00                    1443 	.db #0x00	;  0
      00055F 00                    1444 	.db #0x00	;  0
      000560 00                    1445 	.db #0x00	;  0
      000561 00                    1446 	.db #0x00	;  0
      000562 00                    1447 	.db #0x00	;  0
      000563 00                    1448 	.db #0x00	;  0
      000564 00                    1449 	.db #0x00	;  0
      000565 00                    1450 	.db #0x00	;  0
      000566 00                    1451 	.db #0x00	;  0
      000567 00                    1452 	.db #0x00	;  0
      000568 00                    1453 	.db #0x00	;  0
      000569 00                    1454 	.db #0x00	;  0
      00056A 00                    1455 	.db #0x00	;  0
      00056B 00                    1456 	.db #0x00	;  0
      00056C 00                    1457 	.db #0x00	;  0
      00056D 00                    1458 	.db #0x00	;  0
      00056E 00                    1459 	.db #0x00	;  0
      00056F 00                    1460 	.db #0x00	;  0
      000570 00                    1461 	.db #0x00	;  0
      000571 00                    1462 	.db #0x00	;  0
      000572 00                    1463 	.db #0x00	;  0
      000573 00                    1464 	.db #0x00	;  0
      000574 00                    1465 	.db #0x00	;  0
      000575 00                    1466 	.db #0x00	;  0
      000576 00                    1467 	.db #0x00	;  0
      000577 00                    1468 	.db #0x00	;  0
      000578 00                    1469 	.db #0x00	;  0
      000579 00                    1470 	.db #0x00	;  0
      00057A 00                    1471 	.db #0x00	;  0
      00057B 00                    1472 	.db #0x00	;  0
      00057C 00                    1473 	.db #0x00	;  0
      00057D 00                    1474 	.db #0x00	;  0
      00057E 00                    1475 	.db #0x00	;  0
      00057F 00                    1476 	.db #0x00	;  0
      000580 00                    1477 	.db #0x00	;  0
      000581 00                    1478 	.db #0x00	;  0
      000582 00                    1479 	.db #0x00	;  0
      000583 00                    1480 	.db #0x00	;  0
      000584 00                    1481 	.db #0x00	;  0
      000585 00                    1482 	.db #0x00	;  0
      000586 00                    1483 	.db #0x00	;  0
      000587 00                    1484 	.db #0x00	;  0
      000588 00                    1485 	.db #0x00	;  0
      000589 00                    1486 	.db #0x00	;  0
      00058A 00                    1487 	.db #0x00	;  0
      00058B 00                    1488 	.db #0x00	;  0
      00058C 00                    1489 	.db #0x00	;  0
      00058D 00                    1490 	.db #0x00	;  0
      00058E 00                    1491 	.db #0x00	;  0
      00058F 00                    1492 	.db #0x00	;  0
      000590 00                    1493 	.db #0x00	;  0
      000591 00                    1494 	.db #0x00	;  0
      000592 00                    1495 	.db #0x00	;  0
      000593 00                    1496 	.db #0x00	;  0
      000594 00                    1497 	.db #0x00	;  0
      000595 00                    1498 	.db #0x00	;  0
      000596 00                    1499 	.db #0x00	;  0
      000597 00                    1500 	.db #0x00	;  0
      000598 00                    1501 	.db #0x00	;  0
      000599 00                    1502 	.db #0x00	;  0
      00059A 00                    1503 	.db #0x00	;  0
      00059B 00                    1504 	.db #0x00	;  0
      00059C 00                    1505 	.db #0x00	;  0
      00059D 00                    1506 	.db #0x00	;  0
      00059E 00                    1507 	.db #0x00	;  0
      00059F 00                    1508 	.db #0x00	;  0
      0005A0 00                    1509 	.db #0x00	;  0
      0005A1 00                    1510 	.db #0x00	;  0
      0005A2 00                    1511 	.db #0x00	;  0
      0005A3 00                    1512 	.db #0x00	;  0
      0005A4 00                    1513 	.db #0x00	;  0
      0005A5 00                    1514 	.db #0x00	;  0
      0005A6 00                    1515 	.db #0x00	;  0
      0005A7 00                    1516 	.db #0x00	;  0
      0005A8 00                    1517 	.db #0x00	;  0
      0005A9 00                    1518 	.db #0x00	;  0
      0005AA 00                    1519 	.db #0x00	;  0
      0005AB 00                    1520 	.db #0x00	;  0
      0005AC 00                    1521 	.db #0x00	;  0
      0005AD 00                    1522 	.db #0x00	;  0
      0005AE 00                    1523 	.db #0x00	;  0
      0005AF 00                    1524 	.db #0x00	;  0
      0005B0 00                    1525 	.db #0x00	;  0
      0005B1 00                    1526 	.db #0x00	;  0
      0005B2 00                    1527 	.db #0x00	;  0
      0005B3 00                    1528 	.db #0x00	;  0
      0005B4 00                    1529 	.db #0x00	;  0
      0005B5 00                    1530 	.db #0x00	;  0
      0005B6 00                    1531 	.db #0x00	;  0
      0005B7 00                    1532 	.db #0x00	;  0
      0005B8 00                    1533 	.db #0x00	;  0
      0005B9 00                    1534 	.db #0x00	;  0
      0005BA 00                    1535 	.db #0x00	;  0
      0005BB 00                    1536 	.db #0x00	;  0
      0005BC 00                    1537 	.db #0x00	;  0
      0005BD 00                    1538 	.db #0x00	;  0
      0005BE 00                    1539 	.db #0x00	;  0
      0005BF 00                    1540 	.db #0x00	;  0
      0005C0 00                    1541 	.db #0x00	;  0
      0005C1 00                    1542 	.db #0x00	;  0
      0005C2 00                    1543 	.db #0x00	;  0
      0005C3 00                    1544 	.db #0x00	;  0
      0005C4 00                    1545 	.db #0x00	;  0
      0005C5 00                    1546 	.db #0x00	;  0
      0005C6 00                    1547 	.db #0x00	;  0
      0005C7 00                    1548 	.db #0x00	;  0
      0005C8 00                    1549 	.db #0x00	;  0
      0005C9 00                    1550 	.db #0x00	;  0
      0005CA 00                    1551 	.db #0x00	;  0
      0005CB 00                    1552 	.db #0x00	;  0
      0005CC 00                    1553 	.db #0x00	;  0
      0005CD 00                    1554 	.db #0x00	;  0
      0005CE 00                    1555 	.db #0x00	;  0
      0005CF 00                    1556 	.db #0x00	;  0
      0005D0 00                    1557 	.db #0x00	;  0
      0005D1 00                    1558 	.db #0x00	;  0
      0005D2 00                    1559 	.db #0x00	;  0
      0005D3 00                    1560 	.db #0x00	;  0
      0005D4 00                    1561 	.db #0x00	;  0
      0005D5 00                    1562 	.db #0x00	;  0
      0005D6 00                    1563 	.db #0x00	;  0
      0005D7 00                    1564 	.db #0x00	;  0
      0005D8 00                    1565 	.db #0x00	;  0
      0005D9 00                    1566 	.db #0x00	;  0
      0005DA 00                    1567 	.db #0x00	;  0
      0005DB 00                    1568 	.db #0x00	;  0
      0005DC 00                    1569 	.db #0x00	;  0
      0005DD 00                    1570 	.db #0x00	;  0
      0005DE 00                    1571 	.db #0x00	;  0
      0005DF 00                    1572 	.db #0x00	;  0
      0005E0 00                    1573 	.db #0x00	;  0
      0005E1 00                    1574 	.db #0x00	;  0
      0005E2 00                    1575 	.db #0x00	;  0
      0005E3 00                    1576 	.db #0x00	;  0
      0005E4 00                    1577 	.db #0x00	;  0
      0005E5 00                    1578 	.db #0x00	;  0
      0005E6 00                    1579 	.db #0x00	;  0
      0005E7 00                    1580 	.db #0x00	;  0
      0005E8 00                    1581 	.db #0x00	;  0
      0005E9 00                    1582 	.db #0x00	;  0
      0005EA 00                    1583 	.db #0x00	;  0
      0005EB 00                    1584 	.db #0x00	;  0
      0005EC 00                    1585 	.db #0x00	;  0
      0005ED 00                    1586 	.db #0x00	;  0
      0005EE 00                    1587 	.db #0x00	;  0
      0005EF 00                    1588 	.db #0x00	;  0
      0005F0 00                    1589 	.db #0x00	;  0
      0005F1 00                    1590 	.db #0x00	;  0
      0005F2 00                    1591 	.db #0x00	;  0
      0005F3 00                    1592 	.db #0x00	;  0
      0005F4 00                    1593 	.db #0x00	;  0
      0005F5 00                    1594 	.db #0x00	;  0
      0005F6 00                    1595 	.db #0x00	;  0
      0005F7 00                    1596 	.db #0x00	;  0
      0005F8 00                    1597 	.db #0x00	;  0
      0005F9 00                    1598 	.db #0x00	;  0
      0005FA 00                    1599 	.db #0x00	;  0
      0005FB 00                    1600 	.db #0x00	;  0
      0005FC 00                    1601 	.db #0x00	;  0
      0005FD 00                    1602 	.db #0x00	;  0
      0005FE 00                    1603 	.db #0x00	;  0
      0005FF 00                    1604 	.db #0x00	;  0
      000600 00                    1605 	.db #0x00	;  0
      000601 00                    1606 	.db #0x00	;  0
      000602 00                    1607 	.db #0x00	;  0
      000603 00                    1608 	.db #0x00	;  0
      000604 00                    1609 	.db #0x00	;  0
      000605 00                    1610 	.db #0x00	;  0
      000606 00                    1611 	.db #0x00	;  0
      000607 00                    1612 	.db #0x00	;  0
      000608 00                    1613 	.db #0x00	;  0
      000609 00                    1614 	.db #0x00	;  0
      00060A 00                    1615 	.db #0x00	;  0
      00060B 00                    1616 	.db #0x00	;  0
      00060C 00                    1617 	.db #0x00	;  0
      00060D 00                    1618 	.db #0x00	;  0
      00060E 00                    1619 	.db #0x00	;  0
      00060F 00                    1620 	.db #0x00	;  0
      000610 00                    1621 	.db #0x00	;  0
      000611 00                    1622 	.db #0x00	;  0
      000612 00                    1623 	.db #0x00	;  0
      000613 00                    1624 	.db #0x00	;  0
      000614 00                    1625 	.db #0x00	;  0
      000615 00                    1626 	.db #0x00	;  0
      000616 00                    1627 	.db #0x00	;  0
      000617 00                    1628 	.db #0x00	;  0
      000618 00                    1629 	.db #0x00	;  0
      000619 00                    1630 	.db #0x00	;  0
      00061A 00                    1631 	.db #0x00	;  0
      00061B 00                    1632 	.db #0x00	;  0
      00061C 00                    1633 	.db #0x00	;  0
      00061D 00                    1634 	.db #0x00	;  0
      00061E 00                    1635 	.db #0x00	;  0
      00061F 00                    1636 	.db #0x00	;  0
      000620 00                    1637 	.db #0x00	;  0
      000621 00                    1638 	.db #0x00	;  0
      000622 00                    1639 	.db #0x00	;  0
      000623 00                    1640 	.db #0x00	;  0
      000624 00                    1641 	.db #0x00	;  0
      000625 00                    1642 	.db #0x00	;  0
      000626 00                    1643 	.db #0x00	;  0
      000627 00                    1644 	.db #0x00	;  0
      000628 00                    1645 	.db #0x00	;  0
      000629 00                    1646 	.db #0x00	;  0
      00062A 00                    1647 	.db #0x00	;  0
      00062B 00                    1648 	.db #0x00	;  0
      00062C 00                    1649 	.db #0x00	;  0
      00062D 00                    1650 	.db #0x00	;  0
      00062E 00                    1651 	.db #0x00	;  0
      00062F 00                    1652 	.db #0x00	;  0
      000630 00                    1653 	.db #0x00	;  0
      000631 00                    1654 	.db #0x00	;  0
      000632 00                    1655 	.db #0x00	;  0
      000633 00                    1656 	.db #0x00	;  0
      000634 00                    1657 	.db #0x00	;  0
      000635 00                    1658 	.db #0x00	;  0
      000636 00                    1659 	.db #0x00	;  0
      000637 00                    1660 	.db #0x00	;  0
      000638 00                    1661 	.db #0x00	;  0
      000639 00                    1662 	.db #0x00	;  0
      00063A 00                    1663 	.db #0x00	;  0
      00063B 00                    1664 	.db #0x00	;  0
      00063C 00                    1665 	.db #0x00	;  0
      00063D 00                    1666 	.db #0x00	;  0
      00063E 00                    1667 	.db #0x00	;  0
      00063F 00                    1668 	.db #0x00	;  0
      000640 00                    1669 	.db #0x00	;  0
      000641 00                    1670 	.db #0x00	;  0
      000642 00                    1671 	.db #0x00	;  0
      000643 00                    1672 	.db #0x00	;  0
      000644 00                    1673 	.db #0x00	;  0
      000645 00                    1674 	.db #0x00	;  0
      000646 00                    1675 	.db #0x00	;  0
      000647 00                    1676 	.db #0x00	;  0
      000648 00                    1677 	.db #0x00	;  0
      000649 00                    1678 	.db #0x00	;  0
      00064A 00                    1679 	.db #0x00	;  0
      00064B 00                    1680 	.db #0x00	;  0
      00064C 00                    1681 	.db #0x00	;  0
      00064D 00                    1682 	.db #0x00	;  0
      00064E 00                    1683 	.db #0x00	;  0
      00064F 00                    1684 	.db #0x00	;  0
      000650 00                    1685 	.db #0x00	;  0
      000651 00                    1686 	.db #0x00	;  0
      000652 00                    1687 	.db #0x00	;  0
      000653 00                    1688 	.db #0x00	;  0
      000654 00                    1689 	.db #0x00	;  0
      000655 00                    1690 	.db #0x00	;  0
      000656 00                    1691 	.db #0x00	;  0
      000657 00                    1692 	.db #0x00	;  0
      000658 00                    1693 	.db #0x00	;  0
      000659 00                    1694 	.db #0x00	;  0
      00065A 00                    1695 	.db #0x00	;  0
      00065B 00                    1696 	.db #0x00	;  0
      00065C 00                    1697 	.db #0x00	;  0
      00065D 00                    1698 	.db #0x00	;  0
      00065E 00                    1699 	.db #0x00	;  0
      00065F 00                    1700 	.db #0x00	;  0
      000660 00                    1701 	.db #0x00	;  0
      000661 00                    1702 	.db #0x00	;  0
      000662 00                    1703 	.db #0x00	;  0
      000663 00                    1704 	.db #0x00	;  0
      000664 00                    1705 	.db #0x00	;  0
      000665 00                    1706 	.db #0x00	;  0
      000666 00                    1707 	.db #0x00	;  0
      000667 00                    1708 	.db #0x00	;  0
      000668 00                    1709 	.db #0x00	;  0
      000669 00                    1710 	.db #0x00	;  0
      00066A 00                    1711 	.db #0x00	;  0
      00066B 00                    1712 	.db #0x00	;  0
      00066C 00                    1713 	.db #0x00	;  0
      00066D 00                    1714 	.db #0x00	;  0
      00066E 00                    1715 	.db #0x00	;  0
      00066F 00                    1716 	.db #0x00	;  0
      000670 00                    1717 	.db #0x00	;  0
      000671 00                    1718 	.db #0x00	;  0
      000672 00                    1719 	.db #0x00	;  0
      000673 00                    1720 	.db #0x00	;  0
      000674 00                    1721 	.db #0x00	;  0
      000675 00                    1722 	.db #0x00	;  0
      000676 00                    1723 	.db #0x00	;  0
      000677 00                    1724 	.db #0x00	;  0
      000678 00                    1725 	.db #0x00	;  0
      000679 00                    1726 	.db #0x00	;  0
      00067A 00                    1727 	.db #0x00	;  0
      00067B 00                    1728 	.db #0x00	;  0
      00067C 00                    1729 	.db #0x00	;  0
      00067D 02                    1730 	.db #0x02	;  2
      00067E 01                    1731 	.db #0x01	;  1
      00067F 08                    1732 	.db #0x08	;  8
      000680 00                    1733 	.db #0x00	;  0
      000681 FC                    1734 	.db #0xfc	; -4
      000682 FC                    1735 	.db #0xfc	; -4
      000683 00                    1736 	.db #0x00	;  0
      000684 03                    1737 	.db #0x03	;  3
      000685 FF                    1738 	.db #0xff	; -1
      000686 00                    1739 	.db #0x00	;  0
      000687 03                    1740 	.db #0x03	;  3
      000688 02                    1741 	.db #0x02	;  2
      000689 00                    1742 	.db #0x00	;  0
      00068A F9                    1743 	.db #0xf9	; -7
      00068B 00                    1744 	.db #0x00	;  0
      00068C 00                    1745 	.db #0x00	;  0
      00068D 00                    1746 	.db #0x00	;  0
      00068E 00                    1747 	.db #0x00	;  0
      00068F FF                    1748 	.db #0xff	; -1
      000690 00                    1749 	.db #0x00	;  0
      000691 FD                    1750 	.db #0xfd	; -3
      000692 FE                    1751 	.db #0xfe	; -2
      000693 06                    1752 	.db #0x06	;  6
      000694 02                    1753 	.db #0x02	;  2
      000695 00                    1754 	.db #0x00	;  0
      000696 FB                    1755 	.db #0xfb	; -5
      000697 FF                    1756 	.db #0xff	; -1
      000698 00                    1757 	.db #0x00	;  0
      000699 FE                    1758 	.db #0xfe	; -2
      00069A 00                    1759 	.db #0x00	;  0
      00069B 0E                    1760 	.db #0x0e	;  14
      00069C FE                    1761 	.db #0xfe	; -2
      00069D 0C                    1762 	.db #0x0c	;  12
      00069E FB                    1763 	.db #0xfb	; -5
      00069F 02                    1764 	.db #0x02	;  2
      0006A0 FF                    1765 	.db #0xff	; -1
      0006A1 02                    1766 	.db #0x02	;  2
      0006A2 05                    1767 	.db #0x05	;  5
      0006A3 00                    1768 	.db #0x00	;  0
      0006A4 00                    1769 	.db #0x00	;  0
      0006A5 F7                    1770 	.db #0xf7	; -9
      0006A6 02                    1771 	.db #0x02	;  2
      0006A7 01                    1772 	.db #0x01	;  1
      0006A8 FF                    1773 	.db #0xff	; -1
      0006A9 00                    1774 	.db #0x00	;  0
      0006AA EB                    1775 	.db #0xeb	; -21
      0006AB 00                    1776 	.db #0x00	;  0
      0006AC 05                    1777 	.db #0x05	;  5
      0006AD FE                    1778 	.db #0xfe	; -2
      0006AE 00                    1779 	.db #0x00	;  0
      0006AF F7                    1780 	.db #0xf7	; -9
      0006B0 00                    1781 	.db #0x00	;  0
      0006B1 06                    1782 	.db #0x06	;  6
      0006B2 FD                    1783 	.db #0xfd	; -3
      0006B3 0F                    1784 	.db #0x0f	;  15
      0006B4 FD                    1785 	.db #0xfd	; -3
      0006B5 00                    1786 	.db #0x00	;  0
      0006B6 F8                    1787 	.db #0xf8	; -8
      0006B7 02                    1788 	.db #0x02	;  2
      0006B8 F9                    1789 	.db #0xf9	; -7
      0006B9 0A                    1790 	.db #0x0a	;  10
      0006BA FD                    1791 	.db #0xfd	; -3
      0006BB 22                    1792 	.db #0x22	;  34
      0006BC FE                    1793 	.db #0xfe	; -2
      0006BD 17                    1794 	.db #0x17	;  23
      0006BE FF                    1795 	.db #0xff	; -1
      0006BF 05                    1796 	.db #0x05	;  5
      0006C0 FF                    1797 	.db #0xff	; -1
      0006C1 06                    1798 	.db #0x06	;  6
      0006C2 07                    1799 	.db #0x07	;  7
      0006C3 00                    1800 	.db #0x00	;  0
      0006C4 FD                    1801 	.db #0xfd	; -3
      0006C5 F5                    1802 	.db #0xf5	; -11
      0006C6 08                    1803 	.db #0x08	;  8
      0006C7 13                    1804 	.db #0x13	;  19
      0006C8 F6                    1805 	.db #0xf6	; -10
      0006C9 00                    1806 	.db #0x00	;  0
      0006CA FC                    1807 	.db #0xfc	; -4
      0006CB F5                    1808 	.db #0xf5	; -11
      0006CC 05                    1809 	.db #0x05	;  5
      0006CD F9                    1810 	.db #0xf9	; -7
      0006CE F8                    1811 	.db #0xf8	; -8
      0006CF FA                    1812 	.db #0xfa	; -6
      0006D0 00                    1813 	.db #0x00	;  0
      0006D1 06                    1814 	.db #0x06	;  6
      0006D2 F8                    1815 	.db #0xf8	; -8
      0006D3 05                    1816 	.db #0x05	;  5
      0006D4 EE                    1817 	.db #0xee	; -18
      0006D5 00                    1818 	.db #0x00	;  0
      0006D6 02                    1819 	.db #0x02	;  2
      0006D7 0B                    1820 	.db #0x0b	;  11
      0006D8 E6                    1821 	.db #0xe6	; -26
      0006D9 18                    1822 	.db #0x18	;  24
      0006DA EB                    1823 	.db #0xeb	; -21
      0006DB 11                    1824 	.db #0x11	;  17
      0006DC F5                    1825 	.db #0xf5	; -11
      0006DD 04                    1826 	.db #0x04	;  4
      0006DE FC                    1827 	.db #0xfc	; -4
      0006DF 09                    1828 	.db #0x09	;  9
      0006E0 0B                    1829 	.db #0x0b	;  11
      0006E1 0A                    1830 	.db #0x0a	;  10
      0006E2 FF                    1831 	.db #0xff	; -1
      0006E3 00                    1832 	.db #0x00	;  0
      0006E4 F9                    1833 	.db #0xf9	; -7
      0006E5 E9                    1834 	.db #0xe9	; -23
      0006E6 05                    1835 	.db #0x05	;  5
      0006E7 02                    1836 	.db #0x02	;  2
      0006E8 06                    1837 	.db #0x06	;  6
      0006E9 00                    1838 	.db #0x00	;  0
      0006EA EF                    1839 	.db #0xef	; -17
      0006EB F8                    1840 	.db #0xf8	; -8
      0006EC F4                    1841 	.db #0xf4	; -12
      0006ED 03                    1842 	.db #0x03	;  3
      0006EE F9                    1843 	.db #0xf9	; -7
      0006EF E8                    1844 	.db #0xe8	; -24
      0006F0 05                    1845 	.db #0x05	;  5
      0006F1 04                    1846 	.db #0x04	;  4
      0006F2 F0                    1847 	.db #0xf0	; -16
      0006F3 F0                    1848 	.db #0xf0	; -16
      0006F4 F9                    1849 	.db #0xf9	; -7
      0006F5 00                    1850 	.db #0x00	;  0
      0006F6 FA                    1851 	.db #0xfa	; -6
      0006F7 FC                    1852 	.db #0xfc	; -4
      0006F8 FA                    1853 	.db #0xfa	; -6
      0006F9 23                    1854 	.db #0x23	;  35
      0006FA ED                    1855 	.db #0xed	; -19
      0006FB 16                    1856 	.db #0x16	;  22
      0006FC FD                    1857 	.db #0xfd	; -3
      0006FD F6                    1858 	.db #0xf6	; -10
      0006FE 08                    1859 	.db #0x08	;  8
      0006FF FE                    1860 	.db #0xfe	; -2
      000700 04                    1861 	.db #0x04	;  4
      000701 0B                    1862 	.db #0x0b	;  11
      000702 FE                    1863 	.db #0xfe	; -2
      000703 00                    1864 	.db #0x00	;  0
      000704 FE                    1865 	.db #0xfe	; -2
      000705 FA                    1866 	.db #0xfa	; -6
      000706 EC                    1867 	.db #0xec	; -20
      000707 11                    1868 	.db #0x11	;  17
      000708 FC                    1869 	.db #0xfc	; -4
      000709 00                    1870 	.db #0x00	;  0
      00070A F2                    1871 	.db #0xf2	; -14
      00070B F5                    1872 	.db #0xf5	; -11
      00070C 00                    1873 	.db #0x00	;  0
      00070D FB                    1874 	.db #0xfb	; -5
      00070E 07                    1875 	.db #0x07	;  7
      00070F FA                    1876 	.db #0xfa	; -6
      000710 F9                    1877 	.db #0xf9	; -7
      000711 F2                    1878 	.db #0xf2	; -14
      000712 F9                    1879 	.db #0xf9	; -7
      000713 D5                    1880 	.db #0xd5	; -43
      000714 1D                    1881 	.db #0x1d	;  29
      000715 00                    1882 	.db #0x00	;  0
      000716 02                    1883 	.db #0x02	;  2
      000717 EE                    1884 	.db #0xee	; -18
      000718 FD                    1885 	.db #0xfd	; -3
      000719 18                    1886 	.db #0x18	;  24
      00071A F0                    1887 	.db #0xf0	; -16
      00071B 25                    1888 	.db #0x25	;  37
      00071C FD                    1889 	.db #0xfd	; -3
      00071D F0                    1890 	.db #0xf0	; -16
      00071E 06                    1891 	.db #0x06	;  6
      00071F F7                    1892 	.db #0xf7	; -9
      000720 E6                    1893 	.db #0xe6	; -26
      000721 09                    1894 	.db #0x09	;  9
      000722 00                    1895 	.db #0x00	;  0
      000723 00                    1896 	.db #0x00	;  0
      000724 07                    1897 	.db #0x07	;  7
      000725 FF                    1898 	.db #0xff	; -1
      000726 F7                    1899 	.db #0xf7	; -9
      000727 08                    1900 	.db #0x08	;  8
      000728 00                    1901 	.db #0x00	;  0
      000729 00                    1902 	.db #0x00	;  0
      00072A F8                    1903 	.db #0xf8	; -8
      00072B FD                    1904 	.db #0xfd	; -3
      00072C FB                    1905 	.db #0xfb	; -5
      00072D 03                    1906 	.db #0x03	;  3
      00072E 04                    1907 	.db #0x04	;  4
      00072F 0D                    1908 	.db #0x0d	;  13
      000730 FE                    1909 	.db #0xfe	; -2
      000731 F4                    1910 	.db #0xf4	; -12
      000732 F8                    1911 	.db #0xf8	; -8
      000733 E3                    1912 	.db #0xe3	; -29
      000734 12                    1913 	.db #0x12	;  18
      000735 00                    1914 	.db #0x00	;  0
      000736 F5                    1915 	.db #0xf5	; -11
      000737 FB                    1916 	.db #0xfb	; -5
      000738 10                    1917 	.db #0x10	;  16
      000739 17                    1918 	.db #0x17	;  23
      00073A F3                    1919 	.db #0xf3	; -13
      00073B 0E                    1920 	.db #0x0e	;  14
      00073C FF                    1921 	.db #0xff	; -1
      00073D FB                    1922 	.db #0xfb	; -5
      00073E FF                    1923 	.db #0xff	; -1
      00073F EF                    1924 	.db #0xef	; -17
      000740 ED                    1925 	.db #0xed	; -19
      000741 DD                    1926 	.db #0xdd	; -35
      000742 01                    1927 	.db #0x01	;  1
      000743 00                    1928 	.db #0x00	;  0
      000744 FF                    1929 	.db #0xff	; -1
      000745 03                    1930 	.db #0x03	;  3
      000746 03                    1931 	.db #0x03	;  3
      000747 08                    1932 	.db #0x08	;  8
      000748 F5                    1933 	.db #0xf5	; -11
      000749 00                    1934 	.db #0x00	;  0
      00074A F8                    1935 	.db #0xf8	; -8
      00074B 07                    1936 	.db #0x07	;  7
      00074C FA                    1937 	.db #0xfa	; -6
      00074D FC                    1938 	.db #0xfc	; -4
      00074E 19                    1939 	.db #0x19	;  25
      00074F 01                    1940 	.db #0x01	;  1
      000750 FE                    1941 	.db #0xfe	; -2
      000751 F5                    1942 	.db #0xf5	; -11
      000752 04                    1943 	.db #0x04	;  4
      000753 01                    1944 	.db #0x01	;  1
      000754 0D                    1945 	.db #0x0d	;  13
      000755 00                    1946 	.db #0x00	;  0
      000756 01                    1947 	.db #0x01	;  1
      000757 F3                    1948 	.db #0xf3	; -13
      000758 0E                    1949 	.db #0x0e	;  14
      000759 0B                    1950 	.db #0x0b	;  11
      00075A F6                    1951 	.db #0xf6	; -10
      00075B 22                    1952 	.db #0x22	;  34
      00075C FA                    1953 	.db #0xfa	; -6
      00075D FC                    1954 	.db #0xfc	; -4
      00075E FD                    1955 	.db #0xfd	; -3
      00075F 02                    1956 	.db #0x02	;  2
      000760 FD                    1957 	.db #0xfd	; -3
      000761 E7                    1958 	.db #0xe7	; -25
      000762 F6                    1959 	.db #0xf6	; -10
      000763 00                    1960 	.db #0x00	;  0
      000764 F9                    1961 	.db #0xf9	; -7
      000765 FB                    1962 	.db #0xfb	; -5
      000766 06                    1963 	.db #0x06	;  6
      000767 FF                    1964 	.db #0xff	; -1
      000768 F9                    1965 	.db #0xf9	; -7
      000769 00                    1966 	.db #0x00	;  0
      00076A 0A                    1967 	.db #0x0a	;  10
      00076B 08                    1968 	.db #0x08	;  8
      00076C F8                    1969 	.db #0xf8	; -8
      00076D 00                    1970 	.db #0x00	;  0
      00076E 06                    1971 	.db #0x06	;  6
      00076F F6                    1972 	.db #0xf6	; -10
      000770 02                    1973 	.db #0x02	;  2
      000771 01                    1974 	.db #0x01	;  1
      000772 00                    1975 	.db #0x00	;  0
      000773 1D                    1976 	.db #0x1d	;  29
      000774 05                    1977 	.db #0x05	;  5
      000775 00                    1978 	.db #0x00	;  0
      000776 09                    1979 	.db #0x09	;  9
      000777 01                    1980 	.db #0x01	;  1
      000778 0C                    1981 	.db #0x0c	;  12
      000779 FA                    1982 	.db #0xfa	; -6
      00077A F8                    1983 	.db #0xf8	; -8
      00077B 14                    1984 	.db #0x14	;  20
      00077C 08                    1985 	.db #0x08	;  8
      00077D 00                    1986 	.db #0x00	;  0
      00077E 01                    1987 	.db #0x01	;  1
      00077F FF                    1988 	.db #0xff	; -1
      000780 05                    1989 	.db #0x05	;  5
      000781 01                    1990 	.db #0x01	;  1
      000782 FC                    1991 	.db #0xfc	; -4
      000783 00                    1992 	.db #0x00	;  0
      000784 FF                    1993 	.db #0xff	; -1
      000785 F8                    1994 	.db #0xf8	; -8
      000786 FE                    1995 	.db #0xfe	; -2
      000787 01                    1996 	.db #0x01	;  1
      000788 FE                    1997 	.db #0xfe	; -2
      000789 00                    1998 	.db #0x00	;  0
      00078A FF                    1999 	.db #0xff	; -1
      00078B 07                    2000 	.db #0x07	;  7
      00078C FE                    2001 	.db #0xfe	; -2
      00078D FE                    2002 	.db #0xfe	; -2
      00078E 00                    2003 	.db #0x00	;  0
      00078F 00                    2004 	.db #0x00	;  0
      000790 02                    2005 	.db #0x02	;  2
      000791 FB                    2006 	.db #0xfb	; -5
      000792 00                    2007 	.db #0x00	;  0
      000793 0C                    2008 	.db #0x0c	;  12
      000794 08                    2009 	.db #0x08	;  8
      000795 00                    2010 	.db #0x00	;  0
      000796 01                    2011 	.db #0x01	;  1
      000797 FC                    2012 	.db #0xfc	; -4
      000798 07                    2013 	.db #0x07	;  7
      000799 FD                    2014 	.db #0xfd	; -3
      00079A F6                    2015 	.db #0xf6	; -10
      00079B 09                    2016 	.db #0x09	;  9
      00079C 06                    2017 	.db #0x06	;  6
      00079D 00                    2018 	.db #0x00	;  0
      00079E 00                    2019 	.db #0x00	;  0
      00079F 00                    2020 	.db #0x00	;  0
      0007A0 02                    2021 	.db #0x02	;  2
      0007A1 01                    2022 	.db #0x01	;  1
      0007A2 00                    2023 	.db #0x00	;  0
      0007A3 00                    2024 	.db #0x00	;  0
      0007A4 00                    2025 	.db #0x00	;  0
      0007A5 00                    2026 	.db #0x00	;  0
      0007A6 FF                    2027 	.db #0xff	; -1
      0007A7 00                    2028 	.db #0x00	;  0
      0007A8 00                    2029 	.db #0x00	;  0
      0007A9 00                    2030 	.db #0x00	;  0
      0007AA 00                    2031 	.db #0x00	;  0
      0007AB 02                    2032 	.db #0x02	;  2
      0007AC 00                    2033 	.db #0x00	;  0
      0007AD 00                    2034 	.db #0x00	;  0
      0007AE FF                    2035 	.db #0xff	; -1
      0007AF 00                    2036 	.db #0x00	;  0
      0007B0 01                    2037 	.db #0x01	;  1
      0007B1 00                    2038 	.db #0x00	;  0
      0007B2 00                    2039 	.db #0x00	;  0
      0007B3 03                    2040 	.db #0x03	;  3
      0007B4 02                    2041 	.db #0x02	;  2
      0007B5 00                    2042 	.db #0x00	;  0
      0007B6 00                    2043 	.db #0x00	;  0
      0007B7 00                    2044 	.db #0x00	;  0
      0007B8 01                    2045 	.db #0x01	;  1
      0007B9 00                    2046 	.db #0x00	;  0
      0007BA FD                    2047 	.db #0xfd	; -3
      0007BB 00                    2048 	.db #0x00	;  0
      0007BC 01                    2049 	.db #0x01	;  1
      0007BD 00                    2050 	.db #0x00	;  0
      0007BE 00                    2051 	.db #0x00	;  0
      0007BF 00                    2052 	.db #0x00	;  0
      0007C0 00                    2053 	.db #0x00	;  0
      0007C1 00                    2054 	.db #0x00	;  0
      0007C2 00                    2055 	.db #0x00	;  0
      0007C3 00                    2056 	.db #0x00	;  0
      0007C4 00                    2057 	.db #0x00	;  0
      0007C5 00                    2058 	.db #0x00	;  0
      0007C6 00                    2059 	.db #0x00	;  0
      0007C7 00                    2060 	.db #0x00	;  0
      0007C8 00                    2061 	.db #0x00	;  0
      0007C9 00                    2062 	.db #0x00	;  0
      0007CA 00                    2063 	.db #0x00	;  0
      0007CB 00                    2064 	.db #0x00	;  0
      0007CC 00                    2065 	.db #0x00	;  0
      0007CD 00                    2066 	.db #0x00	;  0
      0007CE 00                    2067 	.db #0x00	;  0
      0007CF 00                    2068 	.db #0x00	;  0
      0007D0 00                    2069 	.db #0x00	;  0
      0007D1 00                    2070 	.db #0x00	;  0
      0007D2 00                    2071 	.db #0x00	;  0
      0007D3 00                    2072 	.db #0x00	;  0
      0007D4 00                    2073 	.db #0x00	;  0
      0007D5 00                    2074 	.db #0x00	;  0
      0007D6 00                    2075 	.db #0x00	;  0
      0007D7 00                    2076 	.db #0x00	;  0
      0007D8 00                    2077 	.db #0x00	;  0
      0007D9 00                    2078 	.db #0x00	;  0
      0007DA 00                    2079 	.db #0x00	;  0
      0007DB 00                    2080 	.db #0x00	;  0
      0007DC 00                    2081 	.db #0x00	;  0
      0007DD 00                    2082 	.db #0x00	;  0
      0007DE 00                    2083 	.db #0x00	;  0
      0007DF 00                    2084 	.db #0x00	;  0
      0007E0 00                    2085 	.db #0x00	;  0
      0007E1 00                    2086 	.db #0x00	;  0
      0007E2 00                    2087 	.db #0x00	;  0
      0007E3 00                    2088 	.db #0x00	;  0
      0007E4 00                    2089 	.db #0x00	;  0
      0007E5 00                    2090 	.db #0x00	;  0
      0007E6 00                    2091 	.db #0x00	;  0
      0007E7 00                    2092 	.db #0x00	;  0
      0007E8 00                    2093 	.db #0x00	;  0
      0007E9 00                    2094 	.db #0x00	;  0
      0007EA 00                    2095 	.db #0x00	;  0
      0007EB 00                    2096 	.db #0x00	;  0
      0007EC 00                    2097 	.db #0x00	;  0
      0007ED 00                    2098 	.db #0x00	;  0
      0007EE 00                    2099 	.db #0x00	;  0
      0007EF 00                    2100 	.db #0x00	;  0
      0007F0 00                    2101 	.db #0x00	;  0
      0007F1 00                    2102 	.db #0x00	;  0
      0007F2 00                    2103 	.db #0x00	;  0
      0007F3 00                    2104 	.db #0x00	;  0
      0007F4 00                    2105 	.db #0x00	;  0
      0007F5 00                    2106 	.db #0x00	;  0
      0007F6 00                    2107 	.db #0x00	;  0
      0007F7 00                    2108 	.db #0x00	;  0
      0007F8 00                    2109 	.db #0x00	;  0
      0007F9 00                    2110 	.db #0x00	;  0
      0007FA 00                    2111 	.db #0x00	;  0
      0007FB 00                    2112 	.db #0x00	;  0
      0007FC 00                    2113 	.db #0x00	;  0
      0007FD 00                    2114 	.db #0x00	;  0
      0007FE 00                    2115 	.db #0x00	;  0
      0007FF 00                    2116 	.db #0x00	;  0
      000800 00                    2117 	.db #0x00	;  0
      000801 00                    2118 	.db #0x00	;  0
      000802 00                    2119 	.db #0x00	;  0
      000803 00                    2120 	.db #0x00	;  0
      000804 00                    2121 	.db #0x00	;  0
      000805 00                    2122 	.db #0x00	;  0
      000806 00                    2123 	.db #0x00	;  0
      000807 00                    2124 	.db #0x00	;  0
      000808 00                    2125 	.db #0x00	;  0
      000809 00                    2126 	.db #0x00	;  0
      00080A 00                    2127 	.db #0x00	;  0
      00080B 00                    2128 	.db #0x00	;  0
      00080C 00                    2129 	.db #0x00	;  0
      00080D 00                    2130 	.db #0x00	;  0
      00080E 00                    2131 	.db #0x00	;  0
      00080F 00                    2132 	.db #0x00	;  0
      000810 00                    2133 	.db #0x00	;  0
      000811 00                    2134 	.db #0x00	;  0
      000812 00                    2135 	.db #0x00	;  0
      000813 00                    2136 	.db #0x00	;  0
      000814 00                    2137 	.db #0x00	;  0
      000815 00                    2138 	.db #0x00	;  0
      000816 00                    2139 	.db #0x00	;  0
      000817 00                    2140 	.db #0x00	;  0
      000818 00                    2141 	.db #0x00	;  0
      000819 00                    2142 	.db #0x00	;  0
      00081A 00                    2143 	.db #0x00	;  0
      00081B 00                    2144 	.db #0x00	;  0
      00081C 00                    2145 	.db #0x00	;  0
      00081D 04                    2146 	.db #0x04	;  4
      00081E FD                    2147 	.db #0xfd	; -3
      00081F 04                    2148 	.db #0x04	;  4
      000820 03                    2149 	.db #0x03	;  3
      000821 07                    2150 	.db #0x07	;  7
      000822 F8                    2151 	.db #0xf8	; -8
      000823 00                    2152 	.db #0x00	;  0
      000824 07                    2153 	.db #0x07	;  7
      000825 02                    2154 	.db #0x02	;  2
      000826 02                    2155 	.db #0x02	;  2
      000827 09                    2156 	.db #0x09	;  9
      000828 04                    2157 	.db #0x04	;  4
      000829 00                    2158 	.db #0x00	;  0
      00082A 04                    2159 	.db #0x04	;  4
      00082B FF                    2160 	.db #0xff	; -1
      00082C FC                    2161 	.db #0xfc	; -4
      00082D 01                    2162 	.db #0x01	;  1
      00082E 00                    2163 	.db #0x00	;  0
      00082F 00                    2164 	.db #0x00	;  0
      000830 FB                    2165 	.db #0xfb	; -5
      000831 0A                    2166 	.db #0x0a	;  10
      000832 FC                    2167 	.db #0xfc	; -4
      000833 03                    2168 	.db #0x03	;  3
      000834 01                    2169 	.db #0x01	;  1
      000835 00                    2170 	.db #0x00	;  0
      000836 FB                    2171 	.db #0xfb	; -5
      000837 FD                    2172 	.db #0xfd	; -3
      000838 03                    2173 	.db #0x03	;  3
      000839 02                    2174 	.db #0x02	;  2
      00083A 00                    2175 	.db #0x00	;  0
      00083B FB                    2176 	.db #0xfb	; -5
      00083C F9                    2177 	.db #0xf9	; -7
      00083D 00                    2178 	.db #0x00	;  0
      00083E F8                    2179 	.db #0xf8	; -8
      00083F 02                    2180 	.db #0x02	;  2
      000840 11                    2181 	.db #0x11	;  17
      000841 03                    2182 	.db #0x03	;  3
      000842 05                    2183 	.db #0x05	;  5
      000843 00                    2184 	.db #0x00	;  0
      000844 0B                    2185 	.db #0x0b	;  11
      000845 F8                    2186 	.db #0xf8	; -8
      000846 0B                    2187 	.db #0x0b	;  11
      000847 0B                    2188 	.db #0x0b	;  11
      000848 FE                    2189 	.db #0xfe	; -2
      000849 00                    2190 	.db #0x00	;  0
      00084A 08                    2191 	.db #0x08	;  8
      00084B FE                    2192 	.db #0xfe	; -2
      00084C 08                    2193 	.db #0x08	;  8
      00084D FD                    2194 	.db #0xfd	; -3
      00084E F8                    2195 	.db #0xf8	; -8
      00084F 01                    2196 	.db #0x01	;  1
      000850 F3                    2197 	.db #0xf3	; -13
      000851 1B                    2198 	.db #0x1b	;  27
      000852 FD                    2199 	.db #0xfd	; -3
      000853 07                    2200 	.db #0x07	;  7
      000854 F9                    2201 	.db #0xf9	; -7
      000855 00                    2202 	.db #0x00	;  0
      000856 E9                    2203 	.db #0xe9	; -23
      000857 0B                    2204 	.db #0x0b	;  11
      000858 E7                    2205 	.db #0xe7	; -25
      000859 F8                    2206 	.db #0xf8	; -8
      00085A FA                    2207 	.db #0xfa	; -6
      00085B 0F                    2208 	.db #0x0f	;  15
      00085C EA                    2209 	.db #0xea	; -22
      00085D 01                    2210 	.db #0x01	;  1
      00085E FB                    2211 	.db #0xfb	; -5
      00085F 00                    2212 	.db #0x00	;  0
      000860 03                    2213 	.db #0x03	;  3
      000861 FE                    2214 	.db #0xfe	; -2
      000862 F3                    2215 	.db #0xf3	; -13
      000863 00                    2216 	.db #0x00	;  0
      000864 03                    2217 	.db #0x03	;  3
      000865 E6                    2218 	.db #0xe6	; -26
      000866 1B                    2219 	.db #0x1b	;  27
      000867 1C                    2220 	.db #0x1c	;  28
      000868 E8                    2221 	.db #0xe8	; -24
      000869 00                    2222 	.db #0x00	;  0
      00086A 07                    2223 	.db #0x07	;  7
      00086B 08                    2224 	.db #0x08	;  8
      00086C 0B                    2225 	.db #0x0b	;  11
      00086D E1                    2226 	.db #0xe1	; -31
      00086E F7                    2227 	.db #0xf7	; -9
      00086F F7                    2228 	.db #0xf7	; -9
      000870 EE                    2229 	.db #0xee	; -18
      000871 04                    2230 	.db #0x04	;  4
      000872 FA                    2231 	.db #0xfa	; -6
      000873 1B                    2232 	.db #0x1b	;  27
      000874 EC                    2233 	.db #0xec	; -20
      000875 00                    2234 	.db #0x00	;  0
      000876 09                    2235 	.db #0x09	;  9
      000877 0A                    2236 	.db #0x0a	;  10
      000878 F5                    2237 	.db #0xf5	; -11
      000879 10                    2238 	.db #0x10	;  16
      00087A F2                    2239 	.db #0xf2	; -14
      00087B 0E                    2240 	.db #0x0e	;  14
      00087C F2                    2241 	.db #0xf2	; -14
      00087D 13                    2242 	.db #0x13	;  19
      00087E 03                    2243 	.db #0x03	;  3
      00087F 20                    2244 	.db #0x20	;  32
      000880 14                    2245 	.db #0x14	;  20
      000881 F5                    2246 	.db #0xf5	; -11
      000882 EB                    2247 	.db #0xeb	; -21
      000883 00                    2248 	.db #0x00	;  0
      000884 02                    2249 	.db #0x02	;  2
      000885 EE                    2250 	.db #0xee	; -18
      000886 EC                    2251 	.db #0xec	; -20
      000887 0D                    2252 	.db #0x0d	;  13
      000888 E9                    2253 	.db #0xe9	; -23
      000889 00                    2254 	.db #0x00	;  0
      00088A 0F                    2255 	.db #0x0f	;  15
      00088B E7                    2256 	.db #0xe7	; -25
      00088C 0B                    2257 	.db #0x0b	;  11
      00088D DD                    2258 	.db #0xdd	; -35
      00088E E9                    2259 	.db #0xe9	; -23
      00088F EC                    2260 	.db #0xec	; -20
      000890 08                    2261 	.db #0x08	;  8
      000891 12                    2262 	.db #0x12	;  18
      000892 F4                    2263 	.db #0xf4	; -12
      000893 E1                    2264 	.db #0xe1	; -31
      000894 D9                    2265 	.db #0xd9	; -39
      000895 00                    2266 	.db #0x00	;  0
      000896 1C                    2267 	.db #0x1c	;  28
      000897 03                    2268 	.db #0x03	;  3
      000898 F6                    2269 	.db #0xf6	; -10
      000899 29                    2270 	.db #0x29	;  41
      00089A ED                    2271 	.db #0xed	; -19
      00089B 1F                    2272 	.db #0x1f	;  31
      00089C DF                    2273 	.db #0xdf	; -33
      00089D FB                    2274 	.db #0xfb	; -5
      00089E F5                    2275 	.db #0xf5	; -11
      00089F 12                    2276 	.db #0x12	;  18
      0008A0 04                    2277 	.db #0x04	;  4
      0008A1 01                    2278 	.db #0x01	;  1
      0008A2 14                    2279 	.db #0x14	;  20
      0008A3 00                    2280 	.db #0x00	;  0
      0008A4 04                    2281 	.db #0x04	;  4
      0008A5 E6                    2282 	.db #0xe6	; -26
      0008A6 F8                    2283 	.db #0xf8	; -8
      0008A7 12                    2284 	.db #0x12	;  18
      0008A8 0B                    2285 	.db #0x0b	;  11
      0008A9 00                    2286 	.db #0x00	;  0
      0008AA F6                    2287 	.db #0xf6	; -10
      0008AB D8                    2288 	.db #0xd8	; -40
      0008AC 02                    2289 	.db #0x02	;  2
      0008AD DE                    2290 	.db #0xde	; -34
      0008AE F0                    2291 	.db #0xf0	; -16
      0008AF 06                    2292 	.db #0x06	;  6
      0008B0 09                    2293 	.db #0x09	;  9
      0008B1 19                    2294 	.db #0x19	;  25
      0008B2 E9                    2295 	.db #0xe9	; -23
      0008B3 BA                    2296 	.db #0xba	; -70
      0008B4 03                    2297 	.db #0x03	;  3
      0008B5 00                    2298 	.db #0x00	;  0
      0008B6 11                    2299 	.db #0x11	;  17
      0008B7 F9                    2300 	.db #0xf9	; -7
      0008B8 06                    2301 	.db #0x06	;  6
      0008B9 21                    2302 	.db #0x21	;  33
      0008BA F8                    2303 	.db #0xf8	; -8
      0008BB 05                    2304 	.db #0x05	;  5
      0008BC FA                    2305 	.db #0xfa	; -6
      0008BD FE                    2306 	.db #0xfe	; -2
      0008BE FE                    2307 	.db #0xfe	; -2
      0008BF 02                    2308 	.db #0x02	;  2
      0008C0 AC                    2309 	.db #0xac	; -84
      0008C1 17                    2310 	.db #0x17	;  23
      0008C2 0C                    2311 	.db #0x0c	;  12
      0008C3 00                    2312 	.db #0x00	;  0
      0008C4 03                    2313 	.db #0x03	;  3
      0008C5 E0                    2314 	.db #0xe0	; -32
      0008C6 E7                    2315 	.db #0xe7	; -25
      0008C7 10                    2316 	.db #0x10	;  16
      0008C8 EA                    2317 	.db #0xea	; -22
      0008C9 00                    2318 	.db #0x00	;  0
      0008CA E9                    2319 	.db #0xe9	; -23
      0008CB F2                    2320 	.db #0xf2	; -14
      0008CC 09                    2321 	.db #0x09	;  9
      0008CD DE                    2322 	.db #0xde	; -34
      0008CE FA                    2323 	.db #0xfa	; -6
      0008CF FF                    2324 	.db #0xff	; -1
      0008D0 0C                    2325 	.db #0x0c	;  12
      0008D1 07                    2326 	.db #0x07	;  7
      0008D2 EC                    2327 	.db #0xec	; -20
      0008D3 C4                    2328 	.db #0xc4	; -60
      0008D4 20                    2329 	.db #0x20	;  32
      0008D5 00                    2330 	.db #0x00	;  0
      0008D6 F9                    2331 	.db #0xf9	; -7
      0008D7 FA                    2332 	.db #0xfa	; -6
      0008D8 FA                    2333 	.db #0xfa	; -6
      0008D9 11                    2334 	.db #0x11	;  17
      0008DA 01                    2335 	.db #0x01	;  1
      0008DB 0C                    2336 	.db #0x0c	;  12
      0008DC 05                    2337 	.db #0x05	;  5
      0008DD C4                    2338 	.db #0xc4	; -60
      0008DE 10                    2339 	.db #0x10	;  16
      0008DF 0E                    2340 	.db #0x0e	;  14
      0008E0 C2                    2341 	.db #0xc2	; -62
      0008E1 16                    2342 	.db #0x16	;  22
      0008E2 0A                    2343 	.db #0x0a	;  10
      0008E3 00                    2344 	.db #0x00	;  0
      0008E4 F0                    2345 	.db #0xf0	; -16
      0008E5 E4                    2346 	.db #0xe4	; -28
      0008E6 F5                    2347 	.db #0xf5	; -11
      0008E7 0D                    2348 	.db #0x0d	;  13
      0008E8 E3                    2349 	.db #0xe3	; -29
      0008E9 00                    2350 	.db #0x00	;  0
      0008EA FA                    2351 	.db #0xfa	; -6
      0008EB 02                    2352 	.db #0x02	;  2
      0008EC F1                    2353 	.db #0xf1	; -15
      0008ED E0                    2354 	.db #0xe0	; -32
      0008EE 04                    2355 	.db #0x04	;  4
      0008EF F9                    2356 	.db #0xf9	; -7
      0008F0 F8                    2357 	.db #0xf8	; -8
      0008F1 CC                    2358 	.db #0xcc	; -52
      0008F2 F9                    2359 	.db #0xf9	; -7
      0008F3 F6                    2360 	.db #0xf6	; -10
      0008F4 E4                    2361 	.db #0xe4	; -28
      0008F5 00                    2362 	.db #0x00	;  0
      0008F6 F5                    2363 	.db #0xf5	; -11
      0008F7 FA                    2364 	.db #0xfa	; -6
      0008F8 0A                    2365 	.db #0x0a	;  10
      0008F9 20                    2366 	.db #0x20	;  32
      0008FA E5                    2367 	.db #0xe5	; -27
      0008FB 06                    2368 	.db #0x06	;  6
      0008FC 10                    2369 	.db #0x10	;  16
      0008FD E2                    2370 	.db #0xe2	; -30
      0008FE 28                    2371 	.db #0x28	;  40
      0008FF 04                    2372 	.db #0x04	;  4
      000900 F3                    2373 	.db #0xf3	; -13
      000901 FF                    2374 	.db #0xff	; -1
      000902 00                    2375 	.db #0x00	;  0
      000903 00                    2376 	.db #0x00	;  0
      000904 E8                    2377 	.db #0xe8	; -24
      000905 EB                    2378 	.db #0xeb	; -21
      000906 F9                    2379 	.db #0xf9	; -7
      000907 0F                    2380 	.db #0x0f	;  15
      000908 E7                    2381 	.db #0xe7	; -25
      000909 00                    2382 	.db #0x00	;  0
      00090A 03                    2383 	.db #0x03	;  3
      00090B F6                    2384 	.db #0xf6	; -10
      00090C 0D                    2385 	.db #0x0d	;  13
      00090D ED                    2386 	.db #0xed	; -19
      00090E 10                    2387 	.db #0x10	;  16
      00090F 11                    2388 	.db #0x11	;  17
      000910 F4                    2389 	.db #0xf4	; -12
      000911 D4                    2390 	.db #0xd4	; -44
      000912 07                    2391 	.db #0x07	;  7
      000913 18                    2392 	.db #0x18	;  24
      000914 E9                    2393 	.db #0xe9	; -23
      000915 00                    2394 	.db #0x00	;  0
      000916 F6                    2395 	.db #0xf6	; -10
      000917 09                    2396 	.db #0x09	;  9
      000918 FE                    2397 	.db #0xfe	; -2
      000919 01                    2398 	.db #0x01	;  1
      00091A E3                    2399 	.db #0xe3	; -29
      00091B FD                    2400 	.db #0xfd	; -3
      00091C 1B                    2401 	.db #0x1b	;  27
      00091D EB                    2402 	.db #0xeb	; -21
      00091E FE                    2403 	.db #0xfe	; -2
      00091F FE                    2404 	.db #0xfe	; -2
      000920 1F                    2405 	.db #0x1f	;  31
      000921 CD                    2406 	.db #0xcd	; -51
      000922 F9                    2407 	.db #0xf9	; -7
      000923 00                    2408 	.db #0x00	;  0
      000924 F0                    2409 	.db #0xf0	; -16
      000925 FE                    2410 	.db #0xfe	; -2
      000926 06                    2411 	.db #0x06	;  6
      000927 0B                    2412 	.db #0x0b	;  11
      000928 EA                    2413 	.db #0xea	; -22
      000929 00                    2414 	.db #0x00	;  0
      00092A F8                    2415 	.db #0xf8	; -8
      00092B FB                    2416 	.db #0xfb	; -5
      00092C 16                    2417 	.db #0x16	;  22
      00092D F4                    2418 	.db #0xf4	; -12
      00092E FD                    2419 	.db #0xfd	; -3
      00092F 0B                    2420 	.db #0x0b	;  11
      000930 0E                    2421 	.db #0x0e	;  14
      000931 ED                    2422 	.db #0xed	; -19
      000932 F7                    2423 	.db #0xf7	; -9
      000933 02                    2424 	.db #0x02	;  2
      000934 FF                    2425 	.db #0xff	; -1
      000935 00                    2426 	.db #0x00	;  0
      000936 05                    2427 	.db #0x05	;  5
      000937 F8                    2428 	.db #0xf8	; -8
      000938 0F                    2429 	.db #0x0f	;  15
      000939 00                    2430 	.db #0x00	;  0
      00093A DA                    2431 	.db #0xda	; -38
      00093B F8                    2432 	.db #0xf8	; -8
      00093C 11                    2433 	.db #0x11	;  17
      00093D FB                    2434 	.db #0xfb	; -5
      00093E FA                    2435 	.db #0xfa	; -6
      00093F 08                    2436 	.db #0x08	;  8
      000940 01                    2437 	.db #0x01	;  1
      000941 E0                    2438 	.db #0xe0	; -32
      000942 00                    2439 	.db #0x00	;  0
      000943 00                    2440 	.db #0x00	;  0
      000944 FB                    2441 	.db #0xfb	; -5
      000945 FF                    2442 	.db #0xff	; -1
      000946 04                    2443 	.db #0x04	;  4
      000947 0C                    2444 	.db #0x0c	;  12
      000948 F7                    2445 	.db #0xf7	; -9
      000949 00                    2446 	.db #0x00	;  0
      00094A 05                    2447 	.db #0x05	;  5
      00094B FE                    2448 	.db #0xfe	; -2
      00094C 0D                    2449 	.db #0x0d	;  13
      00094D F7                    2450 	.db #0xf7	; -9
      00094E 10                    2451 	.db #0x10	;  16
      00094F F4                    2452 	.db #0xf4	; -12
      000950 F9                    2453 	.db #0xf9	; -7
      000951 F8                    2454 	.db #0xf8	; -8
      000952 01                    2455 	.db #0x01	;  1
      000953 01                    2456 	.db #0x01	;  1
      000954 16                    2457 	.db #0x16	;  22
      000955 00                    2458 	.db #0x00	;  0
      000956 FF                    2459 	.db #0xff	; -1
      000957 F8                    2460 	.db #0xf8	; -8
      000958 10                    2461 	.db #0x10	;  16
      000959 F0                    2462 	.db #0xf0	; -16
      00095A F9                    2463 	.db #0xf9	; -7
      00095B F6                    2464 	.db #0xf6	; -10
      00095C 0D                    2465 	.db #0x0d	;  13
      00095D 00                    2466 	.db #0x00	;  0
      00095E EE                    2467 	.db #0xee	; -18
      00095F 0B                    2468 	.db #0x0b	;  11
      000960 03                    2469 	.db #0x03	;  3
      000961 F9                    2470 	.db #0xf9	; -7
      000962 F3                    2471 	.db #0xf3	; -13
      000963 00                    2472 	.db #0x00	;  0
      000964 FF                    2473 	.db #0xff	; -1
      000965 02                    2474 	.db #0x02	;  2
      000966 03                    2475 	.db #0x03	;  3
      000967 0D                    2476 	.db #0x0d	;  13
      000968 03                    2477 	.db #0x03	;  3
      000969 00                    2478 	.db #0x00	;  0
      00096A 12                    2479 	.db #0x12	;  18
      00096B F4                    2480 	.db #0xf4	; -12
      00096C 06                    2481 	.db #0x06	;  6
      00096D F3                    2482 	.db #0xf3	; -13
      00096E FC                    2483 	.db #0xfc	; -4
      00096F 01                    2484 	.db #0x01	;  1
      000970 F1                    2485 	.db #0xf1	; -15
      000971 FA                    2486 	.db #0xfa	; -6
      000972 00                    2487 	.db #0x00	;  0
      000973 03                    2488 	.db #0x03	;  3
      000974 02                    2489 	.db #0x02	;  2
      000975 00                    2490 	.db #0x00	;  0
      000976 07                    2491 	.db #0x07	;  7
      000977 0A                    2492 	.db #0x0a	;  10
      000978 F9                    2493 	.db #0xf9	; -7
      000979 EE                    2494 	.db #0xee	; -18
      00097A F8                    2495 	.db #0xf8	; -8
      00097B F5                    2496 	.db #0xf5	; -11
      00097C 0C                    2497 	.db #0x0c	;  12
      00097D 00                    2498 	.db #0x00	;  0
      00097E 00                    2499 	.db #0x00	;  0
      00097F 03                    2500 	.db #0x03	;  3
      000980 03                    2501 	.db #0x03	;  3
      000981 00                    2502 	.db #0x00	;  0
      000982 FC                    2503 	.db #0xfc	; -4
      000983 00                    2504 	.db #0x00	;  0
      000984 00                    2505 	.db #0x00	;  0
      000985 00                    2506 	.db #0x00	;  0
      000986 FD                    2507 	.db #0xfd	; -3
      000987 00                    2508 	.db #0x00	;  0
      000988 00                    2509 	.db #0x00	;  0
      000989 00                    2510 	.db #0x00	;  0
      00098A FD                    2511 	.db #0xfd	; -3
      00098B 00                    2512 	.db #0x00	;  0
      00098C 00                    2513 	.db #0x00	;  0
      00098D FE                    2514 	.db #0xfe	; -2
      00098E 03                    2515 	.db #0x03	;  3
      00098F FD                    2516 	.db #0xfd	; -3
      000990 02                    2517 	.db #0x02	;  2
      000991 00                    2518 	.db #0x00	;  0
      000992 00                    2519 	.db #0x00	;  0
      000993 04                    2520 	.db #0x04	;  4
      000994 03                    2521 	.db #0x03	;  3
      000995 00                    2522 	.db #0x00	;  0
      000996 00                    2523 	.db #0x00	;  0
      000997 03                    2524 	.db #0x03	;  3
      000998 00                    2525 	.db #0x00	;  0
      000999 FD                    2526 	.db #0xfd	; -3
      00099A FC                    2527 	.db #0xfc	; -4
      00099B 00                    2528 	.db #0x00	;  0
      00099C 02                    2529 	.db #0x02	;  2
      00099D 00                    2530 	.db #0x00	;  0
      00099E 00                    2531 	.db #0x00	;  0
      00099F 00                    2532 	.db #0x00	;  0
      0009A0 00                    2533 	.db #0x00	;  0
      0009A1 00                    2534 	.db #0x00	;  0
      0009A2 00                    2535 	.db #0x00	;  0
      0009A3 00                    2536 	.db #0x00	;  0
      0009A4 00                    2537 	.db #0x00	;  0
      0009A5 00                    2538 	.db #0x00	;  0
      0009A6 00                    2539 	.db #0x00	;  0
      0009A7 00                    2540 	.db #0x00	;  0
      0009A8 00                    2541 	.db #0x00	;  0
      0009A9 00                    2542 	.db #0x00	;  0
      0009AA 00                    2543 	.db #0x00	;  0
      0009AB 00                    2544 	.db #0x00	;  0
      0009AC 00                    2545 	.db #0x00	;  0
      0009AD 00                    2546 	.db #0x00	;  0
      0009AE 00                    2547 	.db #0x00	;  0
      0009AF 00                    2548 	.db #0x00	;  0
      0009B0 00                    2549 	.db #0x00	;  0
      0009B1 00                    2550 	.db #0x00	;  0
      0009B2 00                    2551 	.db #0x00	;  0
      0009B3 00                    2552 	.db #0x00	;  0
      0009B4 00                    2553 	.db #0x00	;  0
      0009B5 00                    2554 	.db #0x00	;  0
      0009B6 00                    2555 	.db #0x00	;  0
      0009B7 00                    2556 	.db #0x00	;  0
      0009B8 00                    2557 	.db #0x00	;  0
      0009B9 00                    2558 	.db #0x00	;  0
      0009BA 00                    2559 	.db #0x00	;  0
      0009BB 00                    2560 	.db #0x00	;  0
      0009BC 00                    2561 	.db #0x00	;  0
      0009BD 01                    2562 	.db #0x01	;  1
      0009BE 02                    2563 	.db #0x02	;  2
      0009BF FD                    2564 	.db #0xfd	; -3
      0009C0 FC                    2565 	.db #0xfc	; -4
      0009C1 01                    2566 	.db #0x01	;  1
      0009C2 FB                    2567 	.db #0xfb	; -5
      0009C3 00                    2568 	.db #0x00	;  0
      0009C4 FD                    2569 	.db #0xfd	; -3
      0009C5 05                    2570 	.db #0x05	;  5
      0009C6 02                    2571 	.db #0x02	;  2
      0009C7 00                    2572 	.db #0x00	;  0
      0009C8 08                    2573 	.db #0x08	;  8
      0009C9 00                    2574 	.db #0x00	;  0
      0009CA 02                    2575 	.db #0x02	;  2
      0009CB 02                    2576 	.db #0x02	;  2
      0009CC 00                    2577 	.db #0x00	;  0
      0009CD 09                    2578 	.db #0x09	;  9
      0009CE 00                    2579 	.db #0x00	;  0
      0009CF 04                    2580 	.db #0x04	;  4
      0009D0 00                    2581 	.db #0x00	;  0
      0009D1 03                    2582 	.db #0x03	;  3
      0009D2 09                    2583 	.db #0x09	;  9
      0009D3 FD                    2584 	.db #0xfd	; -3
      0009D4 FC                    2585 	.db #0xfc	; -4
      0009D5 00                    2586 	.db #0x00	;  0
      0009D6 FC                    2587 	.db #0xfc	; -4
      0009D7 FF                    2588 	.db #0xff	; -1
      0009D8 FF                    2589 	.db #0xff	; -1
      0009D9 00                    2590 	.db #0x00	;  0
      0009DA 08                    2591 	.db #0x08	;  8
      0009DB 03                    2592 	.db #0x03	;  3
      0009DC FA                    2593 	.db #0xfa	; -6
      0009DD F7                    2594 	.db #0xf7	; -9
      0009DE 07                    2595 	.db #0x07	;  7
      0009DF F7                    2596 	.db #0xf7	; -9
      0009E0 04                    2597 	.db #0x04	;  4
      0009E1 0E                    2598 	.db #0x0e	;  14
      0009E2 F2                    2599 	.db #0xf2	; -14
      0009E3 00                    2600 	.db #0x00	;  0
      0009E4 0A                    2601 	.db #0x0a	;  10
      0009E5 00                    2602 	.db #0x00	;  0
      0009E6 20                    2603 	.db #0x20	;  32
      0009E7 FF                    2604 	.db #0xff	; -1
      0009E8 FB                    2605 	.db #0xfb	; -5
      0009E9 00                    2606 	.db #0x00	;  0
      0009EA 10                    2607 	.db #0x10	;  16
      0009EB F8                    2608 	.db #0xf8	; -8
      0009EC FA                    2609 	.db #0xfa	; -6
      0009ED 08                    2610 	.db #0x08	;  8
      0009EE 01                    2611 	.db #0x01	;  1
      0009EF FB                    2612 	.db #0xfb	; -5
      0009F0 F4                    2613 	.db #0xf4	; -12
      0009F1 0D                    2614 	.db #0x0d	;  13
      0009F2 1B                    2615 	.db #0x1b	;  27
      0009F3 1C                    2616 	.db #0x1c	;  28
      0009F4 FD                    2617 	.db #0xfd	; -3
      0009F5 00                    2618 	.db #0x00	;  0
      0009F6 EF                    2619 	.db #0xef	; -17
      0009F7 05                    2620 	.db #0x05	;  5
      0009F8 F9                    2621 	.db #0xf9	; -7
      0009F9 07                    2622 	.db #0x07	;  7
      0009FA 03                    2623 	.db #0x03	;  3
      0009FB 08                    2624 	.db #0x08	;  8
      0009FC EB                    2625 	.db #0xeb	; -21
      0009FD FE                    2626 	.db #0xfe	; -2
      0009FE F8                    2627 	.db #0xf8	; -8
      0009FF FE                    2628 	.db #0xfe	; -2
      000A00 12                    2629 	.db #0x12	;  18
      000A01 F8                    2630 	.db #0xf8	; -8
      000A02 E7                    2631 	.db #0xe7	; -25
      000A03 00                    2632 	.db #0x00	;  0
      000A04 0D                    2633 	.db #0x0d	;  13
      000A05 05                    2634 	.db #0x05	;  5
      000A06 2F                    2635 	.db #0x2f	;  47
      000A07 FD                    2636 	.db #0xfd	; -3
      000A08 F3                    2637 	.db #0xf3	; -13
      000A09 00                    2638 	.db #0x00	;  0
      000A0A 08                    2639 	.db #0x08	;  8
      000A0B 0E                    2640 	.db #0x0e	;  14
      000A0C 00                    2641 	.db #0x00	;  0
      000A0D FE                    2642 	.db #0xfe	; -2
      000A0E DF                    2643 	.db #0xdf	; -33
      000A0F EC                    2644 	.db #0xec	; -20
      000A10 E2                    2645 	.db #0xe2	; -30
      000A11 0C                    2646 	.db #0x0c	;  12
      000A12 F4                    2647 	.db #0xf4	; -12
      000A13 1F                    2648 	.db #0x1f	;  31
      000A14 FA                    2649 	.db #0xfa	; -6
      000A15 00                    2650 	.db #0x00	;  0
      000A16 F1                    2651 	.db #0xf1	; -15
      000A17 02                    2652 	.db #0x02	;  2
      000A18 E9                    2653 	.db #0xe9	; -23
      000A19 F9                    2654 	.db #0xf9	; -7
      000A1A EA                    2655 	.db #0xea	; -22
      000A1B 08                    2656 	.db #0x08	;  8
      000A1C E2                    2657 	.db #0xe2	; -30
      000A1D 06                    2658 	.db #0x06	;  6
      000A1E FB                    2659 	.db #0xfb	; -5
      000A1F 18                    2660 	.db #0x18	;  24
      000A20 0C                    2661 	.db #0x0c	;  12
      000A21 06                    2662 	.db #0x06	;  6
      000A22 FA                    2663 	.db #0xfa	; -6
      000A23 00                    2664 	.db #0x00	;  0
      000A24 01                    2665 	.db #0x01	;  1
      000A25 FD                    2666 	.db #0xfd	; -3
      000A26 24                    2667 	.db #0x24	;  36
      000A27 FF                    2668 	.db #0xff	; -1
      000A28 F4                    2669 	.db #0xf4	; -12
      000A29 00                    2670 	.db #0x00	;  0
      000A2A 18                    2671 	.db #0x18	;  24
      000A2B FB                    2672 	.db #0xfb	; -5
      000A2C 19                    2673 	.db #0x19	;  25
      000A2D F4                    2674 	.db #0xf4	; -12
      000A2E EE                    2675 	.db #0xee	; -18
      000A2F F7                    2676 	.db #0xf7	; -9
      000A30 F1                    2677 	.db #0xf1	; -15
      000A31 F9                    2678 	.db #0xf9	; -7
      000A32 E5                    2679 	.db #0xe5	; -27
      000A33 07                    2680 	.db #0x07	;  7
      000A34 C1                    2681 	.db #0xc1	; -63
      000A35 00                    2682 	.db #0x00	;  0
      000A36 0F                    2683 	.db #0x0f	;  15
      000A37 E7                    2684 	.db #0xe7	; -25
      000A38 EF                    2685 	.db #0xef	; -17
      000A39 02                    2686 	.db #0x02	;  2
      000A3A DA                    2687 	.db #0xda	; -38
      000A3B FA                    2688 	.db #0xfa	; -6
      000A3C E1                    2689 	.db #0xe1	; -31
      000A3D 16                    2690 	.db #0x16	;  22
      000A3E FC                    2691 	.db #0xfc	; -4
      000A3F 0A                    2692 	.db #0x0a	;  10
      000A40 17                    2693 	.db #0x17	;  23
      000A41 F9                    2694 	.db #0xf9	; -7
      000A42 F2                    2695 	.db #0xf2	; -14
      000A43 00                    2696 	.db #0x00	;  0
      000A44 03                    2697 	.db #0x03	;  3
      000A45 FA                    2698 	.db #0xfa	; -6
      000A46 15                    2699 	.db #0x15	;  21
      000A47 07                    2700 	.db #0x07	;  7
      000A48 17                    2701 	.db #0x17	;  23
      000A49 00                    2702 	.db #0x00	;  0
      000A4A 11                    2703 	.db #0x11	;  17
      000A4B E2                    2704 	.db #0xe2	; -30
      000A4C 23                    2705 	.db #0x23	;  35
      000A4D EA                    2706 	.db #0xea	; -22
      000A4E F3                    2707 	.db #0xf3	; -13
      000A4F FD                    2708 	.db #0xfd	; -3
      000A50 08                    2709 	.db #0x08	;  8
      000A51 05                    2710 	.db #0x05	;  5
      000A52 F7                    2711 	.db #0xf7	; -9
      000A53 CD                    2712 	.db #0xcd	; -51
      000A54 EA                    2713 	.db #0xea	; -22
      000A55 00                    2714 	.db #0x00	;  0
      000A56 1C                    2715 	.db #0x1c	;  28
      000A57 EA                    2716 	.db #0xea	; -22
      000A58 FF                    2717 	.db #0xff	; -1
      000A59 0D                    2718 	.db #0x0d	;  13
      000A5A FA                    2719 	.db #0xfa	; -6
      000A5B FD                    2720 	.db #0xfd	; -3
      000A5C E3                    2721 	.db #0xe3	; -29
      000A5D 4D                    2722 	.db #0x4d	;  77	'M'
      000A5E FB                    2723 	.db #0xfb	; -5
      000A5F 0F                    2724 	.db #0x0f	;  15
      000A60 08                    2725 	.db #0x08	;  8
      000A61 FC                    2726 	.db #0xfc	; -4
      000A62 03                    2727 	.db #0x03	;  3
      000A63 00                    2728 	.db #0x00	;  0
      000A64 FB                    2729 	.db #0xfb	; -5
      000A65 06                    2730 	.db #0x06	;  6
      000A66 06                    2731 	.db #0x06	;  6
      000A67 12                    2732 	.db #0x12	;  18
      000A68 28                    2733 	.db #0x28	;  40
      000A69 00                    2734 	.db #0x00	;  0
      000A6A 13                    2735 	.db #0x13	;  19
      000A6B DF                    2736 	.db #0xdf	; -33
      000A6C 34                    2737 	.db #0x34	;  52	'4'
      000A6D CF                    2738 	.db #0xcf	; -49
      000A6E E4                    2739 	.db #0xe4	; -28
      000A6F 0F                    2740 	.db #0x0f	;  15
      000A70 0C                    2741 	.db #0x0c	;  12
      000A71 04                    2742 	.db #0x04	;  4
      000A72 00                    2743 	.db #0x00	;  0
      000A73 B8                    2744 	.db #0xb8	; -72
      000A74 2A                    2745 	.db #0x2a	;  42
      000A75 00                    2746 	.db #0x00	;  0
      000A76 FA                    2747 	.db #0xfa	; -6
      000A77 E4                    2748 	.db #0xe4	; -28
      000A78 00                    2749 	.db #0x00	;  0
      000A79 15                    2750 	.db #0x15	;  21
      000A7A 0C                    2751 	.db #0x0c	;  12
      000A7B F9                    2752 	.db #0xf9	; -7
      000A7C 06                    2753 	.db #0x06	;  6
      000A7D 0E                    2754 	.db #0x0e	;  14
      000A7E FD                    2755 	.db #0xfd	; -3
      000A7F 17                    2756 	.db #0x17	;  23
      000A80 8D                    2757 	.db #0x8d	; -115
      000A81 F5                    2758 	.db #0xf5	; -11
      000A82 11                    2759 	.db #0x11	;  17
      000A83 00                    2760 	.db #0x00	;  0
      000A84 04                    2761 	.db #0x04	;  4
      000A85 09                    2762 	.db #0x09	;  9
      000A86 FF                    2763 	.db #0xff	; -1
      000A87 14                    2764 	.db #0x14	;  20
      000A88 F8                    2765 	.db #0xf8	; -8
      000A89 00                    2766 	.db #0x00	;  0
      000A8A 00                    2767 	.db #0x00	;  0
      000A8B 18                    2768 	.db #0x18	;  24
      000A8C 27                    2769 	.db #0x27	;  39
      000A8D DC                    2770 	.db #0xdc	; -36
      000A8E 03                    2771 	.db #0x03	;  3
      000A8F F8                    2772 	.db #0xf8	; -8
      000A90 12                    2773 	.db #0x12	;  18
      000A91 19                    2774 	.db #0x19	;  25
      000A92 EE                    2775 	.db #0xee	; -18
      000A93 E7                    2776 	.db #0xe7	; -25
      000A94 20                    2777 	.db #0x20	;  32
      000A95 00                    2778 	.db #0x00	;  0
      000A96 FA                    2779 	.db #0xfa	; -6
      000A97 E4                    2780 	.db #0xe4	; -28
      000A98 0B                    2781 	.db #0x0b	;  11
      000A99 17                    2782 	.db #0x17	;  23
      000A9A 02                    2783 	.db #0x02	;  2
      000A9B F2                    2784 	.db #0xf2	; -14
      000A9C 05                    2785 	.db #0x05	;  5
      000A9D E5                    2786 	.db #0xe5	; -27
      000A9E 05                    2787 	.db #0x05	;  5
      000A9F 18                    2788 	.db #0x18	;  24
      000AA0 CF                    2789 	.db #0xcf	; -49
      000AA1 45                    2790 	.db #0x45	;  69	'E'
      000AA2 0D                    2791 	.db #0x0d	;  13
      000AA3 00                    2792 	.db #0x00	;  0
      000AA4 00                    2793 	.db #0x00	;  0
      000AA5 14                    2794 	.db #0x14	;  20
      000AA6 F4                    2795 	.db #0xf4	; -12
      000AA7 0D                    2796 	.db #0x0d	;  13
      000AA8 18                    2797 	.db #0x18	;  24
      000AA9 00                    2798 	.db #0x00	;  0
      000AAA F6                    2799 	.db #0xf6	; -10
      000AAB 0A                    2800 	.db #0x0a	;  10
      000AAC 10                    2801 	.db #0x10	;  16
      000AAD C9                    2802 	.db #0xc9	; -55
      000AAE 09                    2803 	.db #0x09	;  9
      000AAF 00                    2804 	.db #0x00	;  0
      000AB0 08                    2805 	.db #0x08	;  8
      000AB1 E2                    2806 	.db #0xe2	; -30
      000AB2 F2                    2807 	.db #0xf2	; -14
      000AB3 17                    2808 	.db #0x17	;  23
      000AB4 BB                    2809 	.db #0xbb	; -69
      000AB5 00                    2810 	.db #0x00	;  0
      000AB6 FA                    2811 	.db #0xfa	; -6
      000AB7 0E                    2812 	.db #0x0e	;  14
      000AB8 1A                    2813 	.db #0x1a	;  26
      000AB9 29                    2814 	.db #0x29	;  41
      000ABA EB                    2815 	.db #0xeb	; -21
      000ABB E3                    2816 	.db #0xe3	; -29
      000ABC 13                    2817 	.db #0x13	;  19
      000ABD D5                    2818 	.db #0xd5	; -43
      000ABE 00                    2819 	.db #0x00	;  0
      000ABF 0F                    2820 	.db #0x0f	;  15
      000AC0 1A                    2821 	.db #0x1a	;  26
      000AC1 06                    2822 	.db #0x06	;  6
      000AC2 01                    2823 	.db #0x01	;  1
      000AC3 00                    2824 	.db #0x00	;  0
      000AC4 FD                    2825 	.db #0xfd	; -3
      000AC5 13                    2826 	.db #0x13	;  19
      000AC6 02                    2827 	.db #0x02	;  2
      000AC7 07                    2828 	.db #0x07	;  7
      000AC8 18                    2829 	.db #0x18	;  24
      000AC9 00                    2830 	.db #0x00	;  0
      000ACA F5                    2831 	.db #0xf5	; -11
      000ACB EB                    2832 	.db #0xeb	; -21
      000ACC 05                    2833 	.db #0x05	;  5
      000ACD CC                    2834 	.db #0xcc	; -52
      000ACE FF                    2835 	.db #0xff	; -1
      000ACF 18                    2836 	.db #0x18	;  24
      000AD0 10                    2837 	.db #0x10	;  16
      000AD1 A8                    2838 	.db #0xa8	; -88
      000AD2 F3                    2839 	.db #0xf3	; -13
      000AD3 0D                    2840 	.db #0x0d	;  13
      000AD4 E8                    2841 	.db #0xe8	; -24
      000AD5 00                    2842 	.db #0x00	;  0
      000AD6 07                    2843 	.db #0x07	;  7
      000AD7 F7                    2844 	.db #0xf7	; -9
      000AD8 13                    2845 	.db #0x13	;  19
      000AD9 29                    2846 	.db #0x29	;  41
      000ADA 04                    2847 	.db #0x04	;  4
      000ADB D5                    2848 	.db #0xd5	; -43
      000ADC FA                    2849 	.db #0xfa	; -6
      000ADD D7                    2850 	.db #0xd7	; -41
      000ADE E3                    2851 	.db #0xe3	; -29
      000ADF 04                    2852 	.db #0x04	;  4
      000AE0 13                    2853 	.db #0x13	;  19
      000AE1 CB                    2854 	.db #0xcb	; -53
      000AE2 06                    2855 	.db #0x06	;  6
      000AE3 00                    2856 	.db #0x00	;  0
      000AE4 F1                    2857 	.db #0xf1	; -15
      000AE5 15                    2858 	.db #0x15	;  21
      000AE6 11                    2859 	.db #0x11	;  17
      000AE7 10                    2860 	.db #0x10	;  16
      000AE8 19                    2861 	.db #0x19	;  25
      000AE9 00                    2862 	.db #0x00	;  0
      000AEA F7                    2863 	.db #0xf7	; -9
      000AEB EB                    2864 	.db #0xeb	; -21
      000AEC 06                    2865 	.db #0x06	;  6
      000AED E8                    2866 	.db #0xe8	; -24
      000AEE 03                    2867 	.db #0x03	;  3
      000AEF 09                    2868 	.db #0x09	;  9
      000AF0 F2                    2869 	.db #0xf2	; -14
      000AF1 E0                    2870 	.db #0xe0	; -32
      000AF2 FF                    2871 	.db #0xff	; -1
      000AF3 10                    2872 	.db #0x10	;  16
      000AF4 FB                    2873 	.db #0xfb	; -5
      000AF5 00                    2874 	.db #0x00	;  0
      000AF6 F4                    2875 	.db #0xf4	; -12
      000AF7 F0                    2876 	.db #0xf0	; -16
      000AF8 1F                    2877 	.db #0x1f	;  31
      000AF9 0B                    2878 	.db #0x0b	;  11
      000AFA EC                    2879 	.db #0xec	; -20
      000AFB B2                    2880 	.db #0xb2	; -78
      000AFC 01                    2881 	.db #0x01	;  1
      000AFD E6                    2882 	.db #0xe6	; -26
      000AFE F2                    2883 	.db #0xf2	; -14
      000AFF 07                    2884 	.db #0x07	;  7
      000B00 10                    2885 	.db #0x10	;  16
      000B01 D1                    2886 	.db #0xd1	; -47
      000B02 FF                    2887 	.db #0xff	; -1
      000B03 00                    2888 	.db #0x00	;  0
      000B04 F8                    2889 	.db #0xf8	; -8
      000B05 08                    2890 	.db #0x08	;  8
      000B06 05                    2891 	.db #0x05	;  5
      000B07 09                    2892 	.db #0x09	;  9
      000B08 16                    2893 	.db #0x16	;  22
      000B09 00                    2894 	.db #0x00	;  0
      000B0A FC                    2895 	.db #0xfc	; -4
      000B0B FB                    2896 	.db #0xfb	; -5
      000B0C 09                    2897 	.db #0x09	;  9
      000B0D 08                    2898 	.db #0x08	;  8
      000B0E F9                    2899 	.db #0xf9	; -7
      000B0F FA                    2900 	.db #0xfa	; -6
      000B10 09                    2901 	.db #0x09	;  9
      000B11 1B                    2902 	.db #0x1b	;  27
      000B12 F5                    2903 	.db #0xf5	; -11
      000B13 02                    2904 	.db #0x02	;  2
      000B14 12                    2905 	.db #0x12	;  18
      000B15 00                    2906 	.db #0x00	;  0
      000B16 01                    2907 	.db #0x01	;  1
      000B17 FC                    2908 	.db #0xfc	; -4
      000B18 18                    2909 	.db #0x18	;  24
      000B19 04                    2910 	.db #0x04	;  4
      000B1A 1A                    2911 	.db #0x1a	;  26
      000B1B C3                    2912 	.db #0xc3	; -61
      000B1C 15                    2913 	.db #0x15	;  21
      000B1D 01                    2914 	.db #0x01	;  1
      000B1E F8                    2915 	.db #0xf8	; -8
      000B1F 12                    2916 	.db #0x12	;  18
      000B20 06                    2917 	.db #0x06	;  6
      000B21 F5                    2918 	.db #0xf5	; -11
      000B22 E7                    2919 	.db #0xe7	; -25
      000B23 00                    2920 	.db #0x00	;  0
      000B24 0B                    2921 	.db #0x0b	;  11
      000B25 03                    2922 	.db #0x03	;  3
      000B26 FB                    2923 	.db #0xfb	; -5
      000B27 0B                    2924 	.db #0x0b	;  11
      000B28 09                    2925 	.db #0x09	;  9
      000B29 00                    2926 	.db #0x00	;  0
      000B2A FE                    2927 	.db #0xfe	; -2
      000B2B F2                    2928 	.db #0xf2	; -14
      000B2C 08                    2929 	.db #0x08	;  8
      000B2D EB                    2930 	.db #0xeb	; -21
      000B2E 04                    2931 	.db #0x04	;  4
      000B2F 0A                    2932 	.db #0x0a	;  10
      000B30 FE                    2933 	.db #0xfe	; -2
      000B31 13                    2934 	.db #0x13	;  19
      000B32 01                    2935 	.db #0x01	;  1
      000B33 02                    2936 	.db #0x02	;  2
      000B34 0A                    2937 	.db #0x0a	;  10
      000B35 00                    2938 	.db #0x00	;  0
      000B36 04                    2939 	.db #0x04	;  4
      000B37 04                    2940 	.db #0x04	;  4
      000B38 12                    2941 	.db #0x12	;  18
      000B39 EF                    2942 	.db #0xef	; -17
      000B3A 0B                    2943 	.db #0x0b	;  11
      000B3B EE                    2944 	.db #0xee	; -18
      000B3C 02                    2945 	.db #0x02	;  2
      000B3D 00                    2946 	.db #0x00	;  0
      000B3E 00                    2947 	.db #0x00	;  0
      000B3F 04                    2948 	.db #0x04	;  4
      000B40 02                    2949 	.db #0x02	;  2
      000B41 FF                    2950 	.db #0xff	; -1
      000B42 FC                    2951 	.db #0xfc	; -4
      000B43 00                    2952 	.db #0x00	;  0
      000B44 FE                    2953 	.db #0xfe	; -2
      000B45 00                    2954 	.db #0x00	;  0
      000B46 01                    2955 	.db #0x01	;  1
      000B47 00                    2956 	.db #0x00	;  0
      000B48 00                    2957 	.db #0x00	;  0
      000B49 00                    2958 	.db #0x00	;  0
      000B4A FD                    2959 	.db #0xfd	; -3
      000B4B FD                    2960 	.db #0xfd	; -3
      000B4C 00                    2961 	.db #0x00	;  0
      000B4D 01                    2962 	.db #0x01	;  1
      000B4E 05                    2963 	.db #0x05	;  5
      000B4F FC                    2964 	.db #0xfc	; -4
      000B50 03                    2965 	.db #0x03	;  3
      000B51 FE                    2966 	.db #0xfe	; -2
      000B52 01                    2967 	.db #0x01	;  1
      000B53 03                    2968 	.db #0x03	;  3
      000B54 03                    2969 	.db #0x03	;  3
      000B55 00                    2970 	.db #0x00	;  0
      000B56 00                    2971 	.db #0x00	;  0
      000B57 02                    2972 	.db #0x02	;  2
      000B58 00                    2973 	.db #0x00	;  0
      000B59 FD                    2974 	.db #0xfd	; -3
      000B5A FD                    2975 	.db #0xfd	; -3
      000B5B 00                    2976 	.db #0x00	;  0
      000B5C 01                    2977 	.db #0x01	;  1
      000B5D 00                    2978 	.db #0x00	;  0
      000B5E 00                    2979 	.db #0x00	;  0
      000B5F 00                    2980 	.db #0x00	;  0
      000B60 00                    2981 	.db #0x00	;  0
      000B61 00                    2982 	.db #0x00	;  0
      000B62 00                    2983 	.db #0x00	;  0
      000B63 00                    2984 	.db #0x00	;  0
      000B64 00                    2985 	.db #0x00	;  0
      000B65 00                    2986 	.db #0x00	;  0
      000B66 00                    2987 	.db #0x00	;  0
      000B67 00                    2988 	.db #0x00	;  0
      000B68 00                    2989 	.db #0x00	;  0
      000B69 00                    2990 	.db #0x00	;  0
      000B6A 00                    2991 	.db #0x00	;  0
      000B6B 00                    2992 	.db #0x00	;  0
      000B6C 00                    2993 	.db #0x00	;  0
      000B6D 00                    2994 	.db #0x00	;  0
      000B6E 00                    2995 	.db #0x00	;  0
      000B6F 00                    2996 	.db #0x00	;  0
      000B70 00                    2997 	.db #0x00	;  0
      000B71 00                    2998 	.db #0x00	;  0
      000B72 00                    2999 	.db #0x00	;  0
      000B73 00                    3000 	.db #0x00	;  0
      000B74 00                    3001 	.db #0x00	;  0
      000B75 00                    3002 	.db #0x00	;  0
      000B76 00                    3003 	.db #0x00	;  0
      000B77 00                    3004 	.db #0x00	;  0
      000B78 00                    3005 	.db #0x00	;  0
      000B79 00                    3006 	.db #0x00	;  0
      000B7A 00                    3007 	.db #0x00	;  0
      000B7B 00                    3008 	.db #0x00	;  0
      000B7C 00                    3009 	.db #0x00	;  0
      000B7D FE                    3010 	.db #0xfe	; -2
      000B7E 02                    3011 	.db #0x02	;  2
      000B7F F9                    3012 	.db #0xf9	; -7
      000B80 05                    3013 	.db #0x05	;  5
      000B81 00                    3014 	.db #0x00	;  0
      000B82 04                    3015 	.db #0x04	;  4
      000B83 00                    3016 	.db #0x00	;  0
      000B84 03                    3017 	.db #0x03	;  3
      000B85 FD                    3018 	.db #0xfd	; -3
      000B86 03                    3019 	.db #0x03	;  3
      000B87 F7                    3020 	.db #0xf7	; -9
      000B88 02                    3021 	.db #0x02	;  2
      000B89 00                    3022 	.db #0x00	;  0
      000B8A 04                    3023 	.db #0x04	;  4
      000B8B 01                    3024 	.db #0x01	;  1
      000B8C FF                    3025 	.db #0xff	; -1
      000B8D 03                    3026 	.db #0x03	;  3
      000B8E 00                    3027 	.db #0x00	;  0
      000B8F 02                    3028 	.db #0x02	;  2
      000B90 00                    3029 	.db #0x00	;  0
      000B91 04                    3030 	.db #0x04	;  4
      000B92 05                    3031 	.db #0x05	;  5
      000B93 06                    3032 	.db #0x06	;  6
      000B94 FB                    3033 	.db #0xfb	; -5
      000B95 00                    3034 	.db #0x00	;  0
      000B96 08                    3035 	.db #0x08	;  8
      000B97 FE                    3036 	.db #0xfe	; -2
      000B98 00                    3037 	.db #0x00	;  0
      000B99 FC                    3038 	.db #0xfc	; -4
      000B9A 01                    3039 	.db #0x01	;  1
      000B9B 01                    3040 	.db #0x01	;  1
      000B9C F9                    3041 	.db #0xf9	; -7
      000B9D 03                    3042 	.db #0x03	;  3
      000B9E 1E                    3043 	.db #0x1e	;  30
      000B9F FA                    3044 	.db #0xfa	; -6
      000BA0 03                    3045 	.db #0x03	;  3
      000BA1 15                    3046 	.db #0x15	;  21
      000BA2 F8                    3047 	.db #0xf8	; -8
      000BA3 00                    3048 	.db #0x00	;  0
      000BA4 FF                    3049 	.db #0xff	; -1
      000BA5 F9                    3050 	.db #0xf9	; -7
      000BA6 25                    3051 	.db #0x25	;  37
      000BA7 F6                    3052 	.db #0xf6	; -10
      000BA8 F5                    3053 	.db #0xf5	; -11
      000BA9 00                    3054 	.db #0x00	;  0
      000BAA 04                    3055 	.db #0x04	;  4
      000BAB EA                    3056 	.db #0xea	; -22
      000BAC EB                    3057 	.db #0xeb	; -21
      000BAD 0C                    3058 	.db #0x0c	;  12
      000BAE F9                    3059 	.db #0xf9	; -7
      000BAF 03                    3060 	.db #0x03	;  3
      000BB0 F2                    3061 	.db #0xf2	; -14
      000BB1 17                    3062 	.db #0x17	;  23
      000BB2 12                    3063 	.db #0x12	;  18
      000BB3 15                    3064 	.db #0x15	;  21
      000BB4 FE                    3065 	.db #0xfe	; -2
      000BB5 00                    3066 	.db #0x00	;  0
      000BB6 05                    3067 	.db #0x05	;  5
      000BB7 EB                    3068 	.db #0xeb	; -21
      000BB8 03                    3069 	.db #0x03	;  3
      000BB9 F6                    3070 	.db #0xf6	; -10
      000BBA FB                    3071 	.db #0xfb	; -5
      000BBB 06                    3072 	.db #0x06	;  6
      000BBC E3                    3073 	.db #0xe3	; -29
      000BBD FB                    3074 	.db #0xfb	; -5
      000BBE 09                    3075 	.db #0x09	;  9
      000BBF 04                    3076 	.db #0x04	;  4
      000BC0 F3                    3077 	.db #0xf3	; -13
      000BC1 18                    3078 	.db #0x18	;  24
      000BC2 0B                    3079 	.db #0x0b	;  11
      000BC3 00                    3080 	.db #0x00	;  0
      000BC4 FF                    3081 	.db #0xff	; -1
      000BC5 E8                    3082 	.db #0xe8	; -24
      000BC6 0F                    3083 	.db #0x0f	;  15
      000BC7 FB                    3084 	.db #0xfb	; -5
      000BC8 E5                    3085 	.db #0xe5	; -27
      000BC9 00                    3086 	.db #0x00	;  0
      000BCA 01                    3087 	.db #0x01	;  1
      000BCB F6                    3088 	.db #0xf6	; -10
      000BCC 0B                    3089 	.db #0x0b	;  11
      000BCD 1B                    3090 	.db #0x1b	;  27
      000BCE FD                    3091 	.db #0xfd	; -3
      000BCF 07                    3092 	.db #0x07	;  7
      000BD0 F5                    3093 	.db #0xf5	; -11
      000BD1 F6                    3094 	.db #0xf6	; -10
      000BD2 12                    3095 	.db #0x12	;  18
      000BD3 03                    3096 	.db #0x03	;  3
      000BD4 F9                    3097 	.db #0xf9	; -7
      000BD5 00                    3098 	.db #0x00	;  0
      000BD6 15                    3099 	.db #0x15	;  21
      000BD7 E9                    3100 	.db #0xe9	; -23
      000BD8 E4                    3101 	.db #0xe4	; -28
      000BD9 F2                    3102 	.db #0xf2	; -14
      000BDA FB                    3103 	.db #0xfb	; -5
      000BDB F7                    3104 	.db #0xf7	; -9
      000BDC DA                    3105 	.db #0xda	; -38
      000BDD 14                    3106 	.db #0x14	;  20
      000BDE 18                    3107 	.db #0x18	;  24
      000BDF 0B                    3108 	.db #0x0b	;  11
      000BE0 0D                    3109 	.db #0x0d	;  13
      000BE1 00                    3110 	.db #0x00	;  0
      000BE2 07                    3111 	.db #0x07	;  7
      000BE3 00                    3112 	.db #0x00	;  0
      000BE4 02                    3113 	.db #0x02	;  2
      000BE5 0C                    3114 	.db #0x0c	;  12
      000BE6 12                    3115 	.db #0x12	;  18
      000BE7 0B                    3116 	.db #0x0b	;  11
      000BE8 EC                    3117 	.db #0xec	; -20
      000BE9 00                    3118 	.db #0x00	;  0
      000BEA 01                    3119 	.db #0x01	;  1
      000BEB 09                    3120 	.db #0x09	;  9
      000BEC 15                    3121 	.db #0x15	;  21
      000BED 07                    3122 	.db #0x07	;  7
      000BEE F5                    3123 	.db #0xf5	; -11
      000BEF 02                    3124 	.db #0x02	;  2
      000BF0 FB                    3125 	.db #0xfb	; -5
      000BF1 EC                    3126 	.db #0xec	; -20
      000BF2 08                    3127 	.db #0x08	;  8
      000BF3 04                    3128 	.db #0x04	;  4
      000BF4 E8                    3129 	.db #0xe8	; -24
      000BF5 00                    3130 	.db #0x00	;  0
      000BF6 29                    3131 	.db #0x29	;  41
      000BF7 F5                    3132 	.db #0xf5	; -11
      000BF8 F3                    3133 	.db #0xf3	; -13
      000BF9 D6                    3134 	.db #0xd6	; -42
      000BFA F7                    3135 	.db #0xf7	; -9
      000BFB 04                    3136 	.db #0x04	;  4
      000BFC EC                    3137 	.db #0xec	; -20
      000BFD 1E                    3138 	.db #0x1e	;  30
      000BFE 0A                    3139 	.db #0x0a	;  10
      000BFF 0F                    3140 	.db #0x0f	;  15
      000C00 23                    3141 	.db #0x23	;  35
      000C01 F4                    3142 	.db #0xf4	; -12
      000C02 FC                    3143 	.db #0xfc	; -4
      000C03 00                    3144 	.db #0x00	;  0
      000C04 04                    3145 	.db #0x04	;  4
      000C05 22                    3146 	.db #0x22	;  34
      000C06 25                    3147 	.db #0x25	;  37
      000C07 FB                    3148 	.db #0xfb	; -5
      000C08 16                    3149 	.db #0x16	;  22
      000C09 00                    3150 	.db #0x00	;  0
      000C0A FB                    3151 	.db #0xfb	; -5
      000C0B F6                    3152 	.db #0xf6	; -10
      000C0C 23                    3153 	.db #0x23	;  35
      000C0D 1A                    3154 	.db #0x1a	;  26
      000C0E E0                    3155 	.db #0xe0	; -32
      000C0F 04                    3156 	.db #0x04	;  4
      000C10 0E                    3157 	.db #0x0e	;  14
      000C11 F3                    3158 	.db #0xf3	; -13
      000C12 F9                    3159 	.db #0xf9	; -7
      000C13 C1                    3160 	.db #0xc1	; -63
      000C14 EC                    3161 	.db #0xec	; -20
      000C15 00                    3162 	.db #0x00	;  0
      000C16 EA                    3163 	.db #0xea	; -22
      000C17 F2                    3164 	.db #0xf2	; -14
      000C18 0A                    3165 	.db #0x0a	;  10
      000C19 EB                    3166 	.db #0xeb	; -21
      000C1A F7                    3167 	.db #0xf7	; -9
      000C1B EB                    3168 	.db #0xeb	; -21
      000C1C 29                    3169 	.db #0x29	;  41
      000C1D F7                    3170 	.db #0xf7	; -9
      000C1E F6                    3171 	.db #0xf6	; -10
      000C1F 0B                    3172 	.db #0x0b	;  11
      000C20 13                    3173 	.db #0x13	;  19
      000C21 CE                    3174 	.db #0xce	; -50
      000C22 08                    3175 	.db #0x08	;  8
      000C23 00                    3176 	.db #0x00	;  0
      000C24 08                    3177 	.db #0x08	;  8
      000C25 2F                    3178 	.db #0x2f	;  47
      000C26 29                    3179 	.db #0x29	;  41
      000C27 08                    3180 	.db #0x08	;  8
      000C28 04                    3181 	.db #0x04	;  4
      000C29 00                    3182 	.db #0x00	;  0
      000C2A F5                    3183 	.db #0xf5	; -11
      000C2B 1D                    3184 	.db #0x1d	;  29
      000C2C 26                    3185 	.db #0x26	;  38
      000C2D 3C                    3186 	.db #0x3c	;  60
      000C2E F7                    3187 	.db #0xf7	; -9
      000C2F 02                    3188 	.db #0x02	;  2
      000C30 0A                    3189 	.db #0x0a	;  10
      000C31 15                    3190 	.db #0x15	;  21
      000C32 F1                    3191 	.db #0xf1	; -15
      000C33 CC                    3192 	.db #0xcc	; -52
      000C34 41                    3193 	.db #0x41	;  65	'A'
      000C35 00                    3194 	.db #0x00	;  0
      000C36 C8                    3195 	.db #0xc8	; -56
      000C37 EC                    3196 	.db #0xec	; -20
      000C38 F9                    3197 	.db #0xf9	; -7
      000C39 E1                    3198 	.db #0xe1	; -31
      000C3A 1D                    3199 	.db #0x1d	;  29
      000C3B E3                    3200 	.db #0xe3	; -29
      000C3C 1A                    3201 	.db #0x1a	;  26
      000C3D F9                    3202 	.db #0xf9	; -7
      000C3E FA                    3203 	.db #0xfa	; -6
      000C3F F6                    3204 	.db #0xf6	; -10
      000C40 81                    3205 	.db #0x81	; -127
      000C41 0C                    3206 	.db #0x0c	;  12
      000C42 0D                    3207 	.db #0x0d	;  13
      000C43 00                    3208 	.db #0x00	;  0
      000C44 06                    3209 	.db #0x06	;  6
      000C45 06                    3210 	.db #0x06	;  6
      000C46 04                    3211 	.db #0x04	;  4
      000C47 F7                    3212 	.db #0xf7	; -9
      000C48 0D                    3213 	.db #0x0d	;  13
      000C49 00                    3214 	.db #0x00	;  0
      000C4A 02                    3215 	.db #0x02	;  2
      000C4B 07                    3216 	.db #0x07	;  7
      000C4C 2B                    3217 	.db #0x2b	;  43
      000C4D 06                    3218 	.db #0x06	;  6
      000C4E 0B                    3219 	.db #0x0b	;  11
      000C4F F7                    3220 	.db #0xf7	; -9
      000C50 05                    3221 	.db #0x05	;  5
      000C51 53                    3222 	.db #0x53	;  83	'S'
      000C52 00                    3223 	.db #0x00	;  0
      000C53 2A                    3224 	.db #0x2a	;  42
      000C54 12                    3225 	.db #0x12	;  18
      000C55 00                    3226 	.db #0x00	;  0
      000C56 13                    3227 	.db #0x13	;  19
      000C57 FC                    3228 	.db #0xfc	; -4
      000C58 0C                    3229 	.db #0x0c	;  12
      000C59 02                    3230 	.db #0x02	;  2
      000C5A 01                    3231 	.db #0x01	;  1
      000C5B E7                    3232 	.db #0xe7	; -25
      000C5C E8                    3233 	.db #0xe8	; -24
      000C5D 17                    3234 	.db #0x17	;  23
      000C5E F9                    3235 	.db #0xf9	; -7
      000C5F 06                    3236 	.db #0x06	;  6
      000C60 07                    3237 	.db #0x07	;  7
      000C61 69                    3238 	.db #0x69	;  105	'i'
      000C62 15                    3239 	.db #0x15	;  21
      000C63 00                    3240 	.db #0x00	;  0
      000C64 FE                    3241 	.db #0xfe	; -2
      000C65 0E                    3242 	.db #0x0e	;  14
      000C66 11                    3243 	.db #0x11	;  17
      000C67 EB                    3244 	.db #0xeb	; -21
      000C68 23                    3245 	.db #0x23	;  35
      000C69 00                    3246 	.db #0x00	;  0
      000C6A FB                    3247 	.db #0xfb	; -5
      000C6B FF                    3248 	.db #0xff	; -1
      000C6C E7                    3249 	.db #0xe7	; -25
      000C6D 21                    3250 	.db #0x21	;  33
      000C6E 0C                    3251 	.db #0x0c	;  12
      000C6F DA                    3252 	.db #0xda	; -38
      000C70 10                    3253 	.db #0x10	;  16
      000C71 C1                    3254 	.db #0xc1	; -63
      000C72 FA                    3255 	.db #0xfa	; -6
      000C73 31                    3256 	.db #0x31	;  49	'1'
      000C74 CC                    3257 	.db #0xcc	; -52
      000C75 00                    3258 	.db #0x00	;  0
      000C76 FA                    3259 	.db #0xfa	; -6
      000C77 F9                    3260 	.db #0xf9	; -7
      000C78 0E                    3261 	.db #0x0e	;  14
      000C79 2B                    3262 	.db #0x2b	;  43
      000C7A 09                    3263 	.db #0x09	;  9
      000C7B DC                    3264 	.db #0xdc	; -36
      000C7C F1                    3265 	.db #0xf1	; -15
      000C7D FF                    3266 	.db #0xff	; -1
      000C7E EA                    3267 	.db #0xea	; -22
      000C7F FE                    3268 	.db #0xfe	; -2
      000C80 23                    3269 	.db #0x23	;  35
      000C81 04                    3270 	.db #0x04	;  4
      000C82 0B                    3271 	.db #0x0b	;  11
      000C83 00                    3272 	.db #0x00	;  0
      000C84 ED                    3273 	.db #0xed	; -19
      000C85 13                    3274 	.db #0x13	;  19
      000C86 03                    3275 	.db #0x03	;  3
      000C87 F9                    3276 	.db #0xf9	; -7
      000C88 22                    3277 	.db #0x22	;  34
      000C89 00                    3278 	.db #0x00	;  0
      000C8A F5                    3279 	.db #0xf5	; -11
      000C8B ED                    3280 	.db #0xed	; -19
      000C8C D8                    3281 	.db #0xd8	; -40
      000C8D 1C                    3282 	.db #0x1c	;  28
      000C8E 05                    3283 	.db #0x05	;  5
      000C8F 24                    3284 	.db #0x24	;  36
      000C90 F7                    3285 	.db #0xf7	; -9
      000C91 AC                    3286 	.db #0xac	; -84
      000C92 FF                    3287 	.db #0xff	; -1
      000C93 04                    3288 	.db #0x04	;  4
      000C94 0C                    3289 	.db #0x0c	;  12
      000C95 00                    3290 	.db #0x00	;  0
      000C96 FF                    3291 	.db #0xff	; -1
      000C97 FF                    3292 	.db #0xff	; -1
      000C98 0C                    3293 	.db #0x0c	;  12
      000C99 48                    3294 	.db #0x48	;  72	'H'
      000C9A 1E                    3295 	.db #0x1e	;  30
      000C9B CB                    3296 	.db #0xcb	; -53
      000C9C 01                    3297 	.db #0x01	;  1
      000C9D DD                    3298 	.db #0xdd	; -35
      000C9E FF                    3299 	.db #0xff	; -1
      000C9F FB                    3300 	.db #0xfb	; -5
      000CA0 0C                    3301 	.db #0x0c	;  12
      000CA1 BA                    3302 	.db #0xba	; -70
      000CA2 E5                    3303 	.db #0xe5	; -27
      000CA3 00                    3304 	.db #0x00	;  0
      000CA4 FE                    3305 	.db #0xfe	; -2
      000CA5 10                    3306 	.db #0x10	;  16
      000CA6 09                    3307 	.db #0x09	;  9
      000CA7 F1                    3308 	.db #0xf1	; -15
      000CA8 17                    3309 	.db #0x17	;  23
      000CA9 00                    3310 	.db #0x00	;  0
      000CAA FB                    3311 	.db #0xfb	; -5
      000CAB E4                    3312 	.db #0xe4	; -28
      000CAC D8                    3313 	.db #0xd8	; -40
      000CAD 0F                    3314 	.db #0x0f	;  15
      000CAE 00                    3315 	.db #0x00	;  0
      000CAF 23                    3316 	.db #0x23	;  35
      000CB0 06                    3317 	.db #0x06	;  6
      000CB1 F4                    3318 	.db #0xf4	; -12
      000CB2 FE                    3319 	.db #0xfe	; -2
      000CB3 FF                    3320 	.db #0xff	; -1
      000CB4 1B                    3321 	.db #0x1b	;  27
      000CB5 00                    3322 	.db #0x00	;  0
      000CB6 01                    3323 	.db #0x01	;  1
      000CB7 FB                    3324 	.db #0xfb	; -5
      000CB8 0D                    3325 	.db #0x0d	;  13
      000CB9 28                    3326 	.db #0x28	;  40
      000CBA 1C                    3327 	.db #0x1c	;  28
      000CBB D9                    3328 	.db #0xd9	; -39
      000CBC FA                    3329 	.db #0xfa	; -6
      000CBD DE                    3330 	.db #0xde	; -34
      000CBE FD                    3331 	.db #0xfd	; -3
      000CBF 19                    3332 	.db #0x19	;  25
      000CC0 09                    3333 	.db #0x09	;  9
      000CC1 D3                    3334 	.db #0xd3	; -45
      000CC2 04                    3335 	.db #0x04	;  4
      000CC3 00                    3336 	.db #0x00	;  0
      000CC4 04                    3337 	.db #0x04	;  4
      000CC5 FC                    3338 	.db #0xfc	; -4
      000CC6 08                    3339 	.db #0x08	;  8
      000CC7 09                    3340 	.db #0x09	;  9
      000CC8 00                    3341 	.db #0x00	;  0
      000CC9 00                    3342 	.db #0x00	;  0
      000CCA 04                    3343 	.db #0x04	;  4
      000CCB EF                    3344 	.db #0xef	; -17
      000CCC DF                    3345 	.db #0xdf	; -33
      000CCD 22                    3346 	.db #0x22	;  34
      000CCE 07                    3347 	.db #0x07	;  7
      000CCF EF                    3348 	.db #0xef	; -17
      000CD0 19                    3349 	.db #0x19	;  25
      000CD1 26                    3350 	.db #0x26	;  38
      000CD2 13                    3351 	.db #0x13	;  19
      000CD3 F3                    3352 	.db #0xf3	; -13
      000CD4 FE                    3353 	.db #0xfe	; -2
      000CD5 00                    3354 	.db #0x00	;  0
      000CD6 01                    3355 	.db #0x01	;  1
      000CD7 EA                    3356 	.db #0xea	; -22
      000CD8 F8                    3357 	.db #0xf8	; -8
      000CD9 18                    3358 	.db #0x18	;  24
      000CDA 2C                    3359 	.db #0x2c	;  44
      000CDB DB                    3360 	.db #0xdb	; -37
      000CDC EF                    3361 	.db #0xef	; -17
      000CDD F9                    3362 	.db #0xf9	; -7
      000CDE FA                    3363 	.db #0xfa	; -6
      000CDF 15                    3364 	.db #0x15	;  21
      000CE0 04                    3365 	.db #0x04	;  4
      000CE1 FA                    3366 	.db #0xfa	; -6
      000CE2 E9                    3367 	.db #0xe9	; -23
      000CE3 00                    3368 	.db #0x00	;  0
      000CE4 0B                    3369 	.db #0x0b	;  11
      000CE5 F0                    3370 	.db #0xf0	; -16
      000CE6 07                    3371 	.db #0x07	;  7
      000CE7 F9                    3372 	.db #0xf9	; -7
      000CE8 0F                    3373 	.db #0x0f	;  15
      000CE9 00                    3374 	.db #0x00	;  0
      000CEA 0D                    3375 	.db #0x0d	;  13
      000CEB EC                    3376 	.db #0xec	; -20
      000CEC FC                    3377 	.db #0xfc	; -4
      000CED FA                    3378 	.db #0xfa	; -6
      000CEE 1F                    3379 	.db #0x1f	;  31
      000CEF E0                    3380 	.db #0xe0	; -32
      000CF0 F8                    3381 	.db #0xf8	; -8
      000CF1 10                    3382 	.db #0x10	;  16
      000CF2 FF                    3383 	.db #0xff	; -1
      000CF3 F1                    3384 	.db #0xf1	; -15
      000CF4 0C                    3385 	.db #0x0c	;  12
      000CF5 00                    3386 	.db #0x00	;  0
      000CF6 11                    3387 	.db #0x11	;  17
      000CF7 FA                    3388 	.db #0xfa	; -6
      000CF8 03                    3389 	.db #0x03	;  3
      000CF9 F5                    3390 	.db #0xf5	; -11
      000CFA 30                    3391 	.db #0x30	;  48	'0'
      000CFB EC                    3392 	.db #0xec	; -20
      000CFC 09                    3393 	.db #0x09	;  9
      000CFD 00                    3394 	.db #0x00	;  0
      000CFE FF                    3395 	.db #0xff	; -1
      000CFF 06                    3396 	.db #0x06	;  6
      000D00 FE                    3397 	.db #0xfe	; -2
      000D01 00                    3398 	.db #0x00	;  0
      000D02 00                    3399 	.db #0x00	;  0
      000D03 00                    3400 	.db #0x00	;  0
      000D04 FC                    3401 	.db #0xfc	; -4
      000D05 01                    3402 	.db #0x01	;  1
      000D06 02                    3403 	.db #0x02	;  2
      000D07 00                    3404 	.db #0x00	;  0
      000D08 FE                    3405 	.db #0xfe	; -2
      000D09 00                    3406 	.db #0x00	;  0
      000D0A FE                    3407 	.db #0xfe	; -2
      000D0B FD                    3408 	.db #0xfd	; -3
      000D0C 00                    3409 	.db #0x00	;  0
      000D0D FF                    3410 	.db #0xff	; -1
      000D0E 02                    3411 	.db #0x02	;  2
      000D0F FE                    3412 	.db #0xfe	; -2
      000D10 00                    3413 	.db #0x00	;  0
      000D11 FF                    3414 	.db #0xff	; -1
      000D12 00                    3415 	.db #0x00	;  0
      000D13 00                    3416 	.db #0x00	;  0
      000D14 03                    3417 	.db #0x03	;  3
      000D15 00                    3418 	.db #0x00	;  0
      000D16 00                    3419 	.db #0x00	;  0
      000D17 00                    3420 	.db #0x00	;  0
      000D18 04                    3421 	.db #0x04	;  4
      000D19 FE                    3422 	.db #0xfe	; -2
      000D1A 01                    3423 	.db #0x01	;  1
      000D1B 01                    3424 	.db #0x01	;  1
      000D1C 01                    3425 	.db #0x01	;  1
      000D1D 00                    3426 	.db #0x00	;  0
      000D1E 00                    3427 	.db #0x00	;  0
      000D1F 00                    3428 	.db #0x00	;  0
      000D20 00                    3429 	.db #0x00	;  0
      000D21 00                    3430 	.db #0x00	;  0
      000D22 00                    3431 	.db #0x00	;  0
      000D23 00                    3432 	.db #0x00	;  0
      000D24 00                    3433 	.db #0x00	;  0
      000D25 00                    3434 	.db #0x00	;  0
      000D26 00                    3435 	.db #0x00	;  0
      000D27 00                    3436 	.db #0x00	;  0
      000D28 00                    3437 	.db #0x00	;  0
      000D29 00                    3438 	.db #0x00	;  0
      000D2A 00                    3439 	.db #0x00	;  0
      000D2B 00                    3440 	.db #0x00	;  0
      000D2C 00                    3441 	.db #0x00	;  0
      000D2D 00                    3442 	.db #0x00	;  0
      000D2E 00                    3443 	.db #0x00	;  0
      000D2F 00                    3444 	.db #0x00	;  0
      000D30 00                    3445 	.db #0x00	;  0
      000D31 00                    3446 	.db #0x00	;  0
      000D32 00                    3447 	.db #0x00	;  0
      000D33 00                    3448 	.db #0x00	;  0
      000D34 00                    3449 	.db #0x00	;  0
      000D35 00                    3450 	.db #0x00	;  0
      000D36 00                    3451 	.db #0x00	;  0
      000D37 00                    3452 	.db #0x00	;  0
      000D38 00                    3453 	.db #0x00	;  0
      000D39 00                    3454 	.db #0x00	;  0
      000D3A 00                    3455 	.db #0x00	;  0
      000D3B 00                    3456 	.db #0x00	;  0
      000D3C 00                    3457 	.db #0x00	;  0
      000D3D 00                    3458 	.db #0x00	;  0
      000D3E 08                    3459 	.db #0x08	;  8
      000D3F FB                    3460 	.db #0xfb	; -5
      000D40 FF                    3461 	.db #0xff	; -1
      000D41 05                    3462 	.db #0x05	;  5
      000D42 00                    3463 	.db #0x00	;  0
      000D43 00                    3464 	.db #0x00	;  0
      000D44 F9                    3465 	.db #0xf9	; -7
      000D45 04                    3466 	.db #0x04	;  4
      000D46 02                    3467 	.db #0x02	;  2
      000D47 FA                    3468 	.db #0xfa	; -6
      000D48 04                    3469 	.db #0x04	;  4
      000D49 00                    3470 	.db #0x00	;  0
      000D4A 07                    3471 	.db #0x07	;  7
      000D4B 04                    3472 	.db #0x04	;  4
      000D4C FD                    3473 	.db #0xfd	; -3
      000D4D 0E                    3474 	.db #0x0e	;  14
      000D4E FD                    3475 	.db #0xfd	; -3
      000D4F 05                    3476 	.db #0x05	;  5
      000D50 00                    3477 	.db #0x00	;  0
      000D51 07                    3478 	.db #0x07	;  7
      000D52 11                    3479 	.db #0x11	;  17
      000D53 FC                    3480 	.db #0xfc	; -4
      000D54 FC                    3481 	.db #0xfc	; -4
      000D55 00                    3482 	.db #0x00	;  0
      000D56 F6                    3483 	.db #0xf6	; -10
      000D57 FC                    3484 	.db #0xfc	; -4
      000D58 FE                    3485 	.db #0xfe	; -2
      000D59 FE                    3486 	.db #0xfe	; -2
      000D5A 01                    3487 	.db #0x01	;  1
      000D5B 01                    3488 	.db #0x01	;  1
      000D5C FC                    3489 	.db #0xfc	; -4
      000D5D 1A                    3490 	.db #0x1a	;  26
      000D5E 03                    3491 	.db #0x03	;  3
      000D5F 08                    3492 	.db #0x08	;  8
      000D60 FC                    3493 	.db #0xfc	; -4
      000D61 FA                    3494 	.db #0xfa	; -6
      000D62 F9                    3495 	.db #0xf9	; -7
      000D63 00                    3496 	.db #0x00	;  0
      000D64 02                    3497 	.db #0x02	;  2
      000D65 F7                    3498 	.db #0xf7	; -9
      000D66 03                    3499 	.db #0x03	;  3
      000D67 F6                    3500 	.db #0xf6	; -10
      000D68 EB                    3501 	.db #0xeb	; -21
      000D69 00                    3502 	.db #0x00	;  0
      000D6A 01                    3503 	.db #0x01	;  1
      000D6B FA                    3504 	.db #0xfa	; -6
      000D6C EF                    3505 	.db #0xef	; -17
      000D6D 09                    3506 	.db #0x09	;  9
      000D6E FC                    3507 	.db #0xfc	; -4
      000D6F 14                    3508 	.db #0x14	;  20
      000D70 0D                    3509 	.db #0x0d	;  13
      000D71 08                    3510 	.db #0x08	;  8
      000D72 26                    3511 	.db #0x26	;  38
      000D73 06                    3512 	.db #0x06	;  6
      000D74 F9                    3513 	.db #0xf9	; -7
      000D75 00                    3514 	.db #0x00	;  0
      000D76 0B                    3515 	.db #0x0b	;  11
      000D77 F3                    3516 	.db #0xf3	; -13
      000D78 F8                    3517 	.db #0xf8	; -8
      000D79 F6                    3518 	.db #0xf6	; -10
      000D7A FB                    3519 	.db #0xfb	; -5
      000D7B E9                    3520 	.db #0xe9	; -23
      000D7C E1                    3521 	.db #0xe1	; -31
      000D7D 11                    3522 	.db #0x11	;  17
      000D7E 0F                    3523 	.db #0x0f	;  15
      000D7F FF                    3524 	.db #0xff	; -1
      000D80 E8                    3525 	.db #0xe8	; -24
      000D81 FE                    3526 	.db #0xfe	; -2
      000D82 F4                    3527 	.db #0xf4	; -12
      000D83 00                    3528 	.db #0x00	;  0
      000D84 0C                    3529 	.db #0x0c	;  12
      000D85 04                    3530 	.db #0x04	;  4
      000D86 0E                    3531 	.db #0x0e	;  14
      000D87 FE                    3532 	.db #0xfe	; -2
      000D88 FA                    3533 	.db #0xfa	; -6
      000D89 00                    3534 	.db #0x00	;  0
      000D8A FC                    3535 	.db #0xfc	; -4
      000D8B EF                    3536 	.db #0xef	; -17
      000D8C FB                    3537 	.db #0xfb	; -5
      000D8D 1E                    3538 	.db #0x1e	;  30
      000D8E F9                    3539 	.db #0xf9	; -7
      000D8F FE                    3540 	.db #0xfe	; -2
      000D90 02                    3541 	.db #0x02	;  2
      000D91 FD                    3542 	.db #0xfd	; -3
      000D92 12                    3543 	.db #0x12	;  18
      000D93 14                    3544 	.db #0x14	;  20
      000D94 0C                    3545 	.db #0x0c	;  12
      000D95 00                    3546 	.db #0x00	;  0
      000D96 29                    3547 	.db #0x29	;  41
      000D97 F5                    3548 	.db #0xf5	; -11
      000D98 F9                    3549 	.db #0xf9	; -7
      000D99 D3                    3550 	.db #0xd3	; -45
      000D9A E0                    3551 	.db #0xe0	; -32
      000D9B F9                    3552 	.db #0xf9	; -7
      000D9C ED                    3553 	.db #0xed	; -19
      000D9D 14                    3554 	.db #0x14	;  20
      000D9E 29                    3555 	.db #0x29	;  41
      000D9F 01                    3556 	.db #0x01	;  1
      000DA0 FC                    3557 	.db #0xfc	; -4
      000DA1 F6                    3558 	.db #0xf6	; -10
      000DA2 08                    3559 	.db #0x08	;  8
      000DA3 00                    3560 	.db #0x00	;  0
      000DA4 19                    3561 	.db #0x19	;  25
      000DA5 0A                    3562 	.db #0x0a	;  10
      000DA6 0C                    3563 	.db #0x0c	;  12
      000DA7 FB                    3564 	.db #0xfb	; -5
      000DA8 F7                    3565 	.db #0xf7	; -9
      000DA9 00                    3566 	.db #0x00	;  0
      000DAA F6                    3567 	.db #0xf6	; -10
      000DAB E2                    3568 	.db #0xe2	; -30
      000DAC FA                    3569 	.db #0xfa	; -6
      000DAD 1D                    3570 	.db #0x1d	;  29
      000DAE E0                    3571 	.db #0xe0	; -32
      000DAF FE                    3572 	.db #0xfe	; -2
      000DB0 0D                    3573 	.db #0x0d	;  13
      000DB1 FD                    3574 	.db #0xfd	; -3
      000DB2 12                    3575 	.db #0x12	;  18
      000DB3 02                    3576 	.db #0x02	;  2
      000DB4 DB                    3577 	.db #0xdb	; -37
      000DB5 00                    3578 	.db #0x00	;  0
      000DB6 4C                    3579 	.db #0x4c	;  76	'L'
      000DB7 F8                    3580 	.db #0xf8	; -8
      000DB8 FF                    3581 	.db #0xff	; -1
      000DB9 E3                    3582 	.db #0xe3	; -29
      000DBA F8                    3583 	.db #0xf8	; -8
      000DBB 03                    3584 	.db #0x03	;  3
      000DBC F6                    3585 	.db #0xf6	; -10
      000DBD D7                    3586 	.db #0xd7	; -41
      000DBE 2E                    3587 	.db #0x2e	;  46
      000DBF FF                    3588 	.db #0xff	; -1
      000DC0 03                    3589 	.db #0x03	;  3
      000DC1 DA                    3590 	.db #0xda	; -38
      000DC2 FE                    3591 	.db #0xfe	; -2
      000DC3 00                    3592 	.db #0x00	;  0
      000DC4 0D                    3593 	.db #0x0d	;  13
      000DC5 0B                    3594 	.db #0x0b	;  11
      000DC6 F7                    3595 	.db #0xf7	; -9
      000DC7 F5                    3596 	.db #0xf5	; -11
      000DC8 0B                    3597 	.db #0x0b	;  11
      000DC9 00                    3598 	.db #0x00	;  0
      000DCA F4                    3599 	.db #0xf4	; -12
      000DCB 08                    3600 	.db #0x08	;  8
      000DCC E5                    3601 	.db #0xe5	; -27
      000DCD 22                    3602 	.db #0x22	;  34
      000DCE F2                    3603 	.db #0xf2	; -14
      000DCF D7                    3604 	.db #0xd7	; -41
      000DD0 F9                    3605 	.db #0xf9	; -7
      000DD1 05                    3606 	.db #0x05	;  5
      000DD2 2D                    3607 	.db #0x2d	;  45
      000DD3 CB                    3608 	.db #0xcb	; -53
      000DD4 E6                    3609 	.db #0xe6	; -26
      000DD5 00                    3610 	.db #0x00	;  0
      000DD6 16                    3611 	.db #0x16	;  22
      000DD7 EC                    3612 	.db #0xec	; -20
      000DD8 FA                    3613 	.db #0xfa	; -6
      000DD9 E5                    3614 	.db #0xe5	; -27
      000DDA F0                    3615 	.db #0xf0	; -16
      000DDB E9                    3616 	.db #0xe9	; -23
      000DDC 37                    3617 	.db #0x37	;  55	'7'
      000DDD EF                    3618 	.db #0xef	; -17
      000DDE DE                    3619 	.db #0xde	; -34
      000DDF 02                    3620 	.db #0x02	;  2
      000DE0 E8                    3621 	.db #0xe8	; -24
      000DE1 F3                    3622 	.db #0xf3	; -13
      000DE2 F2                    3623 	.db #0xf2	; -14
      000DE3 00                    3624 	.db #0x00	;  0
      000DE4 FA                    3625 	.db #0xfa	; -6
      000DE5 EB                    3626 	.db #0xeb	; -21
      000DE6 E4                    3627 	.db #0xe4	; -28
      000DE7 30                    3628 	.db #0x30	;  48	'0'
      000DE8 15                    3629 	.db #0x15	;  21
      000DE9 00                    3630 	.db #0x00	;  0
      000DEA 00                    3631 	.db #0x00	;  0
      000DEB 13                    3632 	.db #0x13	;  19
      000DEC F1                    3633 	.db #0xf1	; -15
      000DED 15                    3634 	.db #0x15	;  21
      000DEE E8                    3635 	.db #0xe8	; -24
      000DEF DC                    3636 	.db #0xdc	; -36
      000DF0 09                    3637 	.db #0x09	;  9
      000DF1 1C                    3638 	.db #0x1c	;  28
      000DF2 1B                    3639 	.db #0x1b	;  27
      000DF3 F0                    3640 	.db #0xf0	; -16
      000DF4 2B                    3641 	.db #0x2b	;  43
      000DF5 00                    3642 	.db #0x00	;  0
      000DF6 A7                    3643 	.db #0xa7	; -89
      000DF7 E7                    3644 	.db #0xe7	; -25
      000DF8 F2                    3645 	.db #0xf2	; -14
      000DF9 D7                    3646 	.db #0xd7	; -41
      000DFA 0D                    3647 	.db #0x0d	;  13
      000DFB EA                    3648 	.db #0xea	; -22
      000DFC 19                    3649 	.db #0x19	;  25
      000DFD 09                    3650 	.db #0x09	;  9
      000DFE FC                    3651 	.db #0xfc	; -4
      000DFF F9                    3652 	.db #0xf9	; -7
      000E00 DE                    3653 	.db #0xde	; -34
      000E01 31                    3654 	.db #0x31	;  49	'1'
      000E02 0B                    3655 	.db #0x0b	;  11
      000E03 00                    3656 	.db #0x00	;  0
      000E04 07                    3657 	.db #0x07	;  7
      000E05 EB                    3658 	.db #0xeb	; -21
      000E06 F1                    3659 	.db #0xf1	; -15
      000E07 28                    3660 	.db #0x28	;  40
      000E08 FD                    3661 	.db #0xfd	; -3
      000E09 00                    3662 	.db #0x00	;  0
      000E0A F7                    3663 	.db #0xf7	; -9
      000E0B F8                    3664 	.db #0xf8	; -8
      000E0C E8                    3665 	.db #0xe8	; -24
      000E0D 33                    3666 	.db #0x33	;  51	'3'
      000E0E 0E                    3667 	.db #0x0e	;  14
      000E0F D6                    3668 	.db #0xd6	; -42
      000E10 01                    3669 	.db #0x01	;  1
      000E11 2A                    3670 	.db #0x2a	;  42
      000E12 00                    3671 	.db #0x00	;  0
      000E13 22                    3672 	.db #0x22	;  34
      000E14 F7                    3673 	.db #0xf7	; -9
      000E15 00                    3674 	.db #0x00	;  0
      000E16 02                    3675 	.db #0x02	;  2
      000E17 EF                    3676 	.db #0xef	; -17
      000E18 DD                    3677 	.db #0xdd	; -35
      000E19 DF                    3678 	.db #0xdf	; -33
      000E1A 03                    3679 	.db #0x03	;  3
      000E1B 00                    3680 	.db #0x00	;  0
      000E1C EF                    3681 	.db #0xef	; -17
      000E1D 39                    3682 	.db #0x39	;  57	'9'
      000E1E 02                    3683 	.db #0x02	;  2
      000E1F F4                    3684 	.db #0xf4	; -12
      000E20 20                    3685 	.db #0x20	;  32
      000E21 27                    3686 	.db #0x27	;  39
      000E22 10                    3687 	.db #0x10	;  16
      000E23 00                    3688 	.db #0x00	;  0
      000E24 00                    3689 	.db #0x00	;  0
      000E25 FD                    3690 	.db #0xfd	; -3
      000E26 01                    3691 	.db #0x01	;  1
      000E27 1C                    3692 	.db #0x1c	;  28
      000E28 0A                    3693 	.db #0x0a	;  10
      000E29 00                    3694 	.db #0x00	;  0
      000E2A FD                    3695 	.db #0xfd	; -3
      000E2B 0E                    3696 	.db #0x0e	;  14
      000E2C 05                    3697 	.db #0x05	;  5
      000E2D 1A                    3698 	.db #0x1a	;  26
      000E2E 0D                    3699 	.db #0x0d	;  13
      000E2F 11                    3700 	.db #0x11	;  17
      000E30 E9                    3701 	.db #0xe9	; -23
      000E31 BB                    3702 	.db #0xbb	; -69
      000E32 0A                    3703 	.db #0x0a	;  10
      000E33 04                    3704 	.db #0x04	;  4
      000E34 01                    3705 	.db #0x01	;  1
      000E35 00                    3706 	.db #0x00	;  0
      000E36 F4                    3707 	.db #0xf4	; -12
      000E37 FF                    3708 	.db #0xff	; -1
      000E38 98                    3709 	.db #0x98	; -104
      000E39 E6                    3710 	.db #0xe6	; -26
      000E3A F6                    3711 	.db #0xf6	; -10
      000E3B 04                    3712 	.db #0x04	;  4
      000E3C DF                    3713 	.db #0xdf	; -33
      000E3D 18                    3714 	.db #0x18	;  24
      000E3E FF                    3715 	.db #0xff	; -1
      000E3F 01                    3716 	.db #0x01	;  1
      000E40 1E                    3717 	.db #0x1e	;  30
      000E41 D8                    3718 	.db #0xd8	; -40
      000E42 FA                    3719 	.db #0xfa	; -6
      000E43 00                    3720 	.db #0x00	;  0
      000E44 15                    3721 	.db #0x15	;  21
      000E45 02                    3722 	.db #0x02	;  2
      000E46 FE                    3723 	.db #0xfe	; -2
      000E47 F2                    3724 	.db #0xf2	; -14
      000E48 07                    3725 	.db #0x07	;  7
      000E49 00                    3726 	.db #0x00	;  0
      000E4A F7                    3727 	.db #0xf7	; -9
      000E4B 01                    3728 	.db #0x01	;  1
      000E4C EB                    3729 	.db #0xeb	; -21
      000E4D 12                    3730 	.db #0x12	;  18
      000E4E 0A                    3731 	.db #0x0a	;  10
      000E4F 43                    3732 	.db #0x43	;  67	'C'
      000E50 EE                    3733 	.db #0xee	; -18
      000E51 D6                    3734 	.db #0xd6	; -42
      000E52 18                    3735 	.db #0x18	;  24
      000E53 FF                    3736 	.db #0xff	; -1
      000E54 11                    3737 	.db #0x11	;  17
      000E55 00                    3738 	.db #0x00	;  0
      000E56 FD                    3739 	.db #0xfd	; -3
      000E57 FA                    3740 	.db #0xfa	; -6
      000E58 86                    3741 	.db #0x86	; -122
      000E59 10                    3742 	.db #0x10	;  16
      000E5A 13                    3743 	.db #0x13	;  19
      000E5B FF                    3744 	.db #0xff	; -1
      000E5C E7                    3745 	.db #0xe7	; -25
      000E5D FE                    3746 	.db #0xfe	; -2
      000E5E FE                    3747 	.db #0xfe	; -2
      000E5F FB                    3748 	.db #0xfb	; -5
      000E60 00                    3749 	.db #0x00	;  0
      000E61 C3                    3750 	.db #0xc3	; -61
      000E62 D7                    3751 	.db #0xd7	; -41
      000E63 00                    3752 	.db #0x00	;  0
      000E64 0D                    3753 	.db #0x0d	;  13
      000E65 01                    3754 	.db #0x01	;  1
      000E66 F6                    3755 	.db #0xf6	; -10
      000E67 D6                    3756 	.db #0xd6	; -42
      000E68 11                    3757 	.db #0x11	;  17
      000E69 00                    3758 	.db #0x00	;  0
      000E6A 02                    3759 	.db #0x02	;  2
      000E6B E8                    3760 	.db #0xe8	; -24
      000E6C D7                    3761 	.db #0xd7	; -41
      000E6D FE                    3762 	.db #0xfe	; -2
      000E6E 01                    3763 	.db #0x01	;  1
      000E6F 1E                    3764 	.db #0x1e	;  30
      000E70 FA                    3765 	.db #0xfa	; -6
      000E71 0F                    3766 	.db #0x0f	;  15
      000E72 0E                    3767 	.db #0x0e	;  14
      000E73 E5                    3768 	.db #0xe5	; -27
      000E74 F7                    3769 	.db #0xf7	; -9
      000E75 00                    3770 	.db #0x00	;  0
      000E76 0A                    3771 	.db #0x0a	;  10
      000E77 FF                    3772 	.db #0xff	; -1
      000E78 9E                    3773 	.db #0x9e	; -98
      000E79 2B                    3774 	.db #0x2b	;  43
      000E7A 1A                    3775 	.db #0x1a	;  26
      000E7B 0C                    3776 	.db #0x0c	;  12
      000E7C 02                    3777 	.db #0x02	;  2
      000E7D EC                    3778 	.db #0xec	; -20
      000E7E FE                    3779 	.db #0xfe	; -2
      000E7F F4                    3780 	.db #0xf4	; -12
      000E80 F3                    3781 	.db #0xf3	; -13
      000E81 F2                    3782 	.db #0xf2	; -14
      000E82 EA                    3783 	.db #0xea	; -22
      000E83 00                    3784 	.db #0x00	;  0
      000E84 08                    3785 	.db #0x08	;  8
      000E85 FA                    3786 	.db #0xfa	; -6
      000E86 05                    3787 	.db #0x05	;  5
      000E87 CD                    3788 	.db #0xcd	; -51
      000E88 0E                    3789 	.db #0x0e	;  14
      000E89 00                    3790 	.db #0x00	;  0
      000E8A FF                    3791 	.db #0xff	; -1
      000E8B ED                    3792 	.db #0xed	; -19
      000E8C E5                    3793 	.db #0xe5	; -27
      000E8D 19                    3794 	.db #0x19	;  25
      000E8E 1C                    3795 	.db #0x1c	;  28
      000E8F FA                    3796 	.db #0xfa	; -6
      000E90 24                    3797 	.db #0x24	;  36
      000E91 10                    3798 	.db #0x10	;  16
      000E92 00                    3799 	.db #0x00	;  0
      000E93 0A                    3800 	.db #0x0a	;  10
      000E94 FE                    3801 	.db #0xfe	; -2
      000E95 00                    3802 	.db #0x00	;  0
      000E96 0C                    3803 	.db #0x0c	;  12
      000E97 EB                    3804 	.db #0xeb	; -21
      000E98 BF                    3805 	.db #0xbf	; -65
      000E99 0C                    3806 	.db #0x0c	;  12
      000E9A 12                    3807 	.db #0x12	;  18
      000E9B 06                    3808 	.db #0x06	;  6
      000E9C 09                    3809 	.db #0x09	;  9
      000E9D FD                    3810 	.db #0xfd	; -3
      000E9E 08                    3811 	.db #0x08	;  8
      000E9F 08                    3812 	.db #0x08	;  8
      000EA0 02                    3813 	.db #0x02	;  2
      000EA1 06                    3814 	.db #0x06	;  6
      000EA2 FD                    3815 	.db #0xfd	; -3
      000EA3 00                    3816 	.db #0x00	;  0
      000EA4 FD                    3817 	.db #0xfd	; -3
      000EA5 F1                    3818 	.db #0xf1	; -15
      000EA6 05                    3819 	.db #0x05	;  5
      000EA7 EA                    3820 	.db #0xea	; -22
      000EA8 13                    3821 	.db #0x13	;  19
      000EA9 00                    3822 	.db #0x00	;  0
      000EAA F7                    3823 	.db #0xf7	; -9
      000EAB E6                    3824 	.db #0xe6	; -26
      000EAC F1                    3825 	.db #0xf1	; -15
      000EAD 0E                    3826 	.db #0x0e	;  14
      000EAE 17                    3827 	.db #0x17	;  23
      000EAF DB                    3828 	.db #0xdb	; -37
      000EB0 0D                    3829 	.db #0x0d	;  13
      000EB1 F8                    3830 	.db #0xf8	; -8
      000EB2 F8                    3831 	.db #0xf8	; -8
      000EB3 FB                    3832 	.db #0xfb	; -5
      000EB4 F4                    3833 	.db #0xf4	; -12
      000EB5 00                    3834 	.db #0x00	;  0
      000EB6 04                    3835 	.db #0x04	;  4
      000EB7 06                    3836 	.db #0x06	;  6
      000EB8 EA                    3837 	.db #0xea	; -22
      000EB9 05                    3838 	.db #0x05	;  5
      000EBA 28                    3839 	.db #0x28	;  40
      000EBB 0A                    3840 	.db #0x0a	;  10
      000EBC 04                    3841 	.db #0x04	;  4
      000EBD 00                    3842 	.db #0x00	;  0
      000EBE 00                    3843 	.db #0x00	;  0
      000EBF 00                    3844 	.db #0x00	;  0
      000EC0 00                    3845 	.db #0x00	;  0
      000EC1 00                    3846 	.db #0x00	;  0
      000EC2 00                    3847 	.db #0x00	;  0
      000EC3 00                    3848 	.db #0x00	;  0
      000EC4 00                    3849 	.db #0x00	;  0
      000EC5 00                    3850 	.db #0x00	;  0
      000EC6 00                    3851 	.db #0x00	;  0
      000EC7 00                    3852 	.db #0x00	;  0
      000EC8 00                    3853 	.db #0x00	;  0
      000EC9 00                    3854 	.db #0x00	;  0
      000ECA 00                    3855 	.db #0x00	;  0
      000ECB 00                    3856 	.db #0x00	;  0
      000ECC 00                    3857 	.db #0x00	;  0
      000ECD 00                    3858 	.db #0x00	;  0
      000ECE 00                    3859 	.db #0x00	;  0
      000ECF 00                    3860 	.db #0x00	;  0
      000ED0 00                    3861 	.db #0x00	;  0
      000ED1 00                    3862 	.db #0x00	;  0
      000ED2 00                    3863 	.db #0x00	;  0
      000ED3 00                    3864 	.db #0x00	;  0
      000ED4 00                    3865 	.db #0x00	;  0
      000ED5 00                    3866 	.db #0x00	;  0
      000ED6 00                    3867 	.db #0x00	;  0
      000ED7 00                    3868 	.db #0x00	;  0
      000ED8 00                    3869 	.db #0x00	;  0
      000ED9 00                    3870 	.db #0x00	;  0
      000EDA 00                    3871 	.db #0x00	;  0
      000EDB 00                    3872 	.db #0x00	;  0
      000EDC 00                    3873 	.db #0x00	;  0
      000EDD 00                    3874 	.db #0x00	;  0
      000EDE 00                    3875 	.db #0x00	;  0
      000EDF 00                    3876 	.db #0x00	;  0
      000EE0 00                    3877 	.db #0x00	;  0
      000EE1 00                    3878 	.db #0x00	;  0
      000EE2 00                    3879 	.db #0x00	;  0
      000EE3 00                    3880 	.db #0x00	;  0
      000EE4 00                    3881 	.db #0x00	;  0
      000EE5 00                    3882 	.db #0x00	;  0
      000EE6 00                    3883 	.db #0x00	;  0
      000EE7 00                    3884 	.db #0x00	;  0
      000EE8 00                    3885 	.db #0x00	;  0
      000EE9 00                    3886 	.db #0x00	;  0
      000EEA 00                    3887 	.db #0x00	;  0
      000EEB 00                    3888 	.db #0x00	;  0
      000EEC 00                    3889 	.db #0x00	;  0
      000EED 00                    3890 	.db #0x00	;  0
      000EEE 00                    3891 	.db #0x00	;  0
      000EEF 00                    3892 	.db #0x00	;  0
      000EF0 00                    3893 	.db #0x00	;  0
      000EF1 00                    3894 	.db #0x00	;  0
      000EF2 00                    3895 	.db #0x00	;  0
      000EF3 00                    3896 	.db #0x00	;  0
      000EF4 00                    3897 	.db #0x00	;  0
      000EF5 00                    3898 	.db #0x00	;  0
      000EF6 00                    3899 	.db #0x00	;  0
      000EF7 00                    3900 	.db #0x00	;  0
      000EF8 00                    3901 	.db #0x00	;  0
      000EF9 00                    3902 	.db #0x00	;  0
      000EFA 00                    3903 	.db #0x00	;  0
      000EFB 00                    3904 	.db #0x00	;  0
      000EFC 00                    3905 	.db #0x00	;  0
      000EFD 03                    3906 	.db #0x03	;  3
      000EFE 00                    3907 	.db #0x00	;  0
      000EFF 0A                    3908 	.db #0x0a	;  10
      000F00 FA                    3909 	.db #0xfa	; -6
      000F01 00                    3910 	.db #0x00	;  0
      000F02 00                    3911 	.db #0x00	;  0
      000F03 00                    3912 	.db #0x00	;  0
      000F04 F2                    3913 	.db #0xf2	; -14
      000F05 FB                    3914 	.db #0xfb	; -5
      000F06 F6                    3915 	.db #0xf6	; -10
      000F07 F2                    3916 	.db #0xf2	; -14
      000F08 07                    3917 	.db #0x07	;  7
      000F09 00                    3918 	.db #0x00	;  0
      000F0A F5                    3919 	.db #0xf5	; -11
      000F0B 06                    3920 	.db #0x06	;  6
      000F0C 00                    3921 	.db #0x00	;  0
      000F0D 0A                    3922 	.db #0x0a	;  10
      000F0E F4                    3923 	.db #0xf4	; -12
      000F0F 08                    3924 	.db #0x08	;  8
      000F10 00                    3925 	.db #0x00	;  0
      000F11 08                    3926 	.db #0x08	;  8
      000F12 1F                    3927 	.db #0x1f	;  31
      000F13 FC                    3928 	.db #0xfc	; -4
      000F14 F5                    3929 	.db #0xf5	; -11
      000F15 00                    3930 	.db #0x00	;  0
      000F16 02                    3931 	.db #0x02	;  2
      000F17 F3                    3932 	.db #0xf3	; -13
      000F18 00                    3933 	.db #0x00	;  0
      000F19 05                    3934 	.db #0x05	;  5
      000F1A FF                    3935 	.db #0xff	; -1
      000F1B FF                    3936 	.db #0xff	; -1
      000F1C 02                    3937 	.db #0x02	;  2
      000F1D 1F                    3938 	.db #0x1f	;  31
      000F1E 0D                    3939 	.db #0x0d	;  13
      000F1F F8                    3940 	.db #0xf8	; -8
      000F20 F0                    3941 	.db #0xf0	; -16
      000F21 FF                    3942 	.db #0xff	; -1
      000F22 F0                    3943 	.db #0xf0	; -16
      000F23 00                    3944 	.db #0x00	;  0
      000F24 00                    3945 	.db #0x00	;  0
      000F25 F3                    3946 	.db #0xf3	; -13
      000F26 D2                    3947 	.db #0xd2	; -46
      000F27 EB                    3948 	.db #0xeb	; -21
      000F28 FF                    3949 	.db #0xff	; -1
      000F29 00                    3950 	.db #0x00	;  0
      000F2A FB                    3951 	.db #0xfb	; -5
      000F2B ED                    3952 	.db #0xed	; -19
      000F2C E9                    3953 	.db #0xe9	; -23
      000F2D EE                    3954 	.db #0xee	; -18
      000F2E F4                    3955 	.db #0xf4	; -12
      000F2F 03                    3956 	.db #0x03	;  3
      000F30 D9                    3957 	.db #0xd9	; -39
      000F31 00                    3958 	.db #0x00	;  0
      000F32 21                    3959 	.db #0x21	;  33
      000F33 0D                    3960 	.db #0x0d	;  13
      000F34 F6                    3961 	.db #0xf6	; -10
      000F35 00                    3962 	.db #0x00	;  0
      000F36 21                    3963 	.db #0x21	;  33
      000F37 E2                    3964 	.db #0xe2	; -30
      000F38 F7                    3965 	.db #0xf7	; -9
      000F39 EE                    3966 	.db #0xee	; -18
      000F3A F4                    3967 	.db #0xf4	; -12
      000F3B F0                    3968 	.db #0xf0	; -16
      000F3C 03                    3969 	.db #0x03	;  3
      000F3D 22                    3970 	.db #0x22	;  34
      000F3E 13                    3971 	.db #0x13	;  19
      000F3F 0E                    3972 	.db #0x0e	;  14
      000F40 FF                    3973 	.db #0xff	; -1
      000F41 EB                    3974 	.db #0xeb	; -21
      000F42 F5                    3975 	.db #0xf5	; -11
      000F43 00                    3976 	.db #0x00	;  0
      000F44 11                    3977 	.db #0x11	;  17
      000F45 EE                    3978 	.db #0xee	; -18
      000F46 D1                    3979 	.db #0xd1	; -47
      000F47 E9                    3980 	.db #0xe9	; -23
      000F48 FE                    3981 	.db #0xfe	; -2
      000F49 00                    3982 	.db #0x00	;  0
      000F4A FC                    3983 	.db #0xfc	; -4
      000F4B 03                    3984 	.db #0x03	;  3
      000F4C 06                    3985 	.db #0x06	;  6
      000F4D FB                    3986 	.db #0xfb	; -5
      000F4E 02                    3987 	.db #0x02	;  2
      000F4F F5                    3988 	.db #0xf5	; -11
      000F50 FE                    3989 	.db #0xfe	; -2
      000F51 F0                    3990 	.db #0xf0	; -16
      000F52 25                    3991 	.db #0x25	;  37
      000F53 10                    3992 	.db #0x10	;  16
      000F54 F7                    3993 	.db #0xf7	; -9
      000F55 00                    3994 	.db #0x00	;  0
      000F56 1C                    3995 	.db #0x1c	;  28
      000F57 F7                    3996 	.db #0xf7	; -9
      000F58 F5                    3997 	.db #0xf5	; -11
      000F59 FF                    3998 	.db #0xff	; -1
      000F5A ED                    3999 	.db #0xed	; -19
      000F5B EC                    4000 	.db #0xec	; -20
      000F5C 14                    4001 	.db #0x14	;  20
      000F5D FC                    4002 	.db #0xfc	; -4
      000F5E 2C                    4003 	.db #0x2c	;  44
      000F5F 13                    4004 	.db #0x13	;  19
      000F60 ED                    4005 	.db #0xed	; -19
      000F61 F3                    4006 	.db #0xf3	; -13
      000F62 F6                    4007 	.db #0xf6	; -10
      000F63 00                    4008 	.db #0x00	;  0
      000F64 0F                    4009 	.db #0x0f	;  15
      000F65 E8                    4010 	.db #0xe8	; -24
      000F66 CF                    4011 	.db #0xcf	; -49
      000F67 F9                    4012 	.db #0xf9	; -7
      000F68 00                    4013 	.db #0x00	;  0
      000F69 00                    4014 	.db #0x00	;  0
      000F6A 02                    4015 	.db #0x02	;  2
      000F6B F9                    4016 	.db #0xf9	; -7
      000F6C F4                    4017 	.db #0xf4	; -12
      000F6D EB                    4018 	.db #0xeb	; -21
      000F6E 08                    4019 	.db #0x08	;  8
      000F6F F4                    4020 	.db #0xf4	; -12
      000F70 F6                    4021 	.db #0xf6	; -10
      000F71 0F                    4022 	.db #0x0f	;  15
      000F72 34                    4023 	.db #0x34	;  52	'4'
      000F73 09                    4024 	.db #0x09	;  9
      000F74 FE                    4025 	.db #0xfe	; -2
      000F75 00                    4026 	.db #0x00	;  0
      000F76 50                    4027 	.db #0x50	;  80	'P'
      000F77 EE                    4028 	.db #0xee	; -18
      000F78 FC                    4029 	.db #0xfc	; -4
      000F79 11                    4030 	.db #0x11	;  17
      000F7A 02                    4031 	.db #0x02	;  2
      000F7B FC                    4032 	.db #0xfc	; -4
      000F7C FA                    4033 	.db #0xfa	; -6
      000F7D F2                    4034 	.db #0xf2	; -14
      000F7E FE                    4035 	.db #0xfe	; -2
      000F7F 14                    4036 	.db #0x14	;  20
      000F80 FD                    4037 	.db #0xfd	; -3
      000F81 0D                    4038 	.db #0x0d	;  13
      000F82 F1                    4039 	.db #0xf1	; -15
      000F83 00                    4040 	.db #0x00	;  0
      000F84 1B                    4041 	.db #0x1b	;  27
      000F85 CB                    4042 	.db #0xcb	; -53
      000F86 CC                    4043 	.db #0xcc	; -52
      000F87 07                    4044 	.db #0x07	;  7
      000F88 1D                    4045 	.db #0x1d	;  29
      000F89 00                    4046 	.db #0x00	;  0
      000F8A 17                    4047 	.db #0x17	;  23
      000F8B 10                    4048 	.db #0x10	;  16
      000F8C E4                    4049 	.db #0xe4	; -28
      000F8D F8                    4050 	.db #0xf8	; -8
      000F8E F2                    4051 	.db #0xf2	; -14
      000F8F F8                    4052 	.db #0xf8	; -8
      000F90 FE                    4053 	.db #0xfe	; -2
      000F91 FE                    4054 	.db #0xfe	; -2
      000F92 37                    4055 	.db #0x37	;  55	'7'
      000F93 EE                    4056 	.db #0xee	; -18
      000F94 1A                    4057 	.db #0x1a	;  26
      000F95 00                    4058 	.db #0x00	;  0
      000F96 31                    4059 	.db #0x31	;  49	'1'
      000F97 08                    4060 	.db #0x08	;  8
      000F98 0E                    4061 	.db #0x0e	;  14
      000F99 0D                    4062 	.db #0x0d	;  13
      000F9A 14                    4063 	.db #0x14	;  20
      000F9B FD                    4064 	.db #0xfd	; -3
      000F9C 0F                    4065 	.db #0x0f	;  15
      000F9D FF                    4066 	.db #0xff	; -1
      000F9E BB                    4067 	.db #0xbb	; -69
      000F9F 16                    4068 	.db #0x16	;  22
      000FA0 F9                    4069 	.db #0xf9	; -7
      000FA1 0A                    4070 	.db #0x0a	;  10
      000FA2 F6                    4071 	.db #0xf6	; -10
      000FA3 00                    4072 	.db #0x00	;  0
      000FA4 1C                    4073 	.db #0x1c	;  28
      000FA5 E5                    4074 	.db #0xe5	; -27
      000FA6 E0                    4075 	.db #0xe0	; -32
      000FA7 31                    4076 	.db #0x31	;  49	'1'
      000FA8 1A                    4077 	.db #0x1a	;  26
      000FA9 00                    4078 	.db #0x00	;  0
      000FAA 05                    4079 	.db #0x05	;  5
      000FAB 04                    4080 	.db #0x04	;  4
      000FAC EA                    4081 	.db #0xea	; -22
      000FAD 07                    4082 	.db #0x07	;  7
      000FAE 0F                    4083 	.db #0x0f	;  15
      000FAF 00                    4084 	.db #0x00	;  0
      000FB0 06                    4085 	.db #0x06	;  6
      000FB1 16                    4086 	.db #0x16	;  22
      000FB2 E1                    4087 	.db #0xe1	; -31
      000FB3 0F                    4088 	.db #0x0f	;  15
      000FB4 10                    4089 	.db #0x10	;  16
      000FB5 00                    4090 	.db #0x00	;  0
      000FB6 E2                    4091 	.db #0xe2	; -30
      000FB7 0D                    4092 	.db #0x0d	;  13
      000FB8 07                    4093 	.db #0x07	;  7
      000FB9 F3                    4094 	.db #0xf3	; -13
      000FBA 04                    4095 	.db #0x04	;  4
      000FBB 0C                    4096 	.db #0x0c	;  12
      000FBC 0F                    4097 	.db #0x0f	;  15
      000FBD FF                    4098 	.db #0xff	; -1
      000FBE CD                    4099 	.db #0xcd	; -51
      000FBF EA                    4100 	.db #0xea	; -22
      000FC0 01                    4101 	.db #0x01	;  1
      000FC1 1D                    4102 	.db #0x1d	;  29
      000FC2 0B                    4103 	.db #0x0b	;  11
      000FC3 00                    4104 	.db #0x00	;  0
      000FC4 1D                    4105 	.db #0x1d	;  29
      000FC5 09                    4106 	.db #0x09	;  9
      000FC6 01                    4107 	.db #0x01	;  1
      000FC7 26                    4108 	.db #0x26	;  38
      000FC8 ED                    4109 	.db #0xed	; -19
      000FC9 00                    4110 	.db #0x00	;  0
      000FCA 16                    4111 	.db #0x16	;  22
      000FCB 04                    4112 	.db #0x04	;  4
      000FCC F5                    4113 	.db #0xf5	; -11
      000FCD EF                    4114 	.db #0xef	; -17
      000FCE 32                    4115 	.db #0x32	;  50	'2'
      000FCF 0A                    4116 	.db #0x0a	;  10
      000FD0 05                    4117 	.db #0x05	;  5
      000FD1 17                    4118 	.db #0x17	;  23
      000FD2 C6                    4119 	.db #0xc6	; -58
      000FD3 03                    4120 	.db #0x03	;  3
      000FD4 DC                    4121 	.db #0xdc	; -36
      000FD5 00                    4122 	.db #0x00	;  0
      000FD6 F5                    4123 	.db #0xf5	; -11
      000FD7 DC                    4124 	.db #0xdc	; -36
      000FD8 00                    4125 	.db #0x00	;  0
      000FD9 D6                    4126 	.db #0xd6	; -42
      000FDA 0F                    4127 	.db #0x0f	;  15
      000FDB 21                    4128 	.db #0x21	;  33
      000FDC 02                    4129 	.db #0x02	;  2
      000FDD 0B                    4130 	.db #0x0b	;  11
      000FDE 10                    4131 	.db #0x10	;  16
      000FDF E2                    4132 	.db #0xe2	; -30
      000FE0 0A                    4133 	.db #0x0a	;  10
      000FE1 FD                    4134 	.db #0xfd	; -3
      000FE2 13                    4135 	.db #0x13	;  19
      000FE3 00                    4136 	.db #0x00	;  0
      000FE4 09                    4137 	.db #0x09	;  9
      000FE5 06                    4138 	.db #0x06	;  6
      000FE6 04                    4139 	.db #0x04	;  4
      000FE7 29                    4140 	.db #0x29	;  41
      000FE8 FF                    4141 	.db #0xff	; -1
      000FE9 00                    4142 	.db #0x00	;  0
      000FEA FE                    4143 	.db #0xfe	; -2
      000FEB 14                    4144 	.db #0x14	;  20
      000FEC F4                    4145 	.db #0xf4	; -12
      000FED E5                    4146 	.db #0xe5	; -27
      000FEE FF                    4147 	.db #0xff	; -1
      000FEF 4B                    4148 	.db #0x4b	;  75	'K'
      000FF0 F1                    4149 	.db #0xf1	; -15
      000FF1 E8                    4150 	.db #0xe8	; -24
      000FF2 0E                    4151 	.db #0x0e	;  14
      000FF3 F4                    4152 	.db #0xf4	; -12
      000FF4 F2                    4153 	.db #0xf2	; -14
      000FF5 00                    4154 	.db #0x00	;  0
      000FF6 F2                    4155 	.db #0xf2	; -14
      000FF7 EC                    4156 	.db #0xec	; -20
      000FF8 FC                    4157 	.db #0xfc	; -4
      000FF9 D8                    4158 	.db #0xd8	; -40
      000FFA EF                    4159 	.db #0xef	; -17
      000FFB 0C                    4160 	.db #0x0c	;  12
      000FFC 04                    4161 	.db #0x04	;  4
      000FFD 04                    4162 	.db #0x04	;  4
      000FFE FA                    4163 	.db #0xfa	; -6
      000FFF FD                    4164 	.db #0xfd	; -3
      001000 0C                    4165 	.db #0x0c	;  12
      001001 DA                    4166 	.db #0xda	; -38
      001002 FE                    4167 	.db #0xfe	; -2
      001003 00                    4168 	.db #0x00	;  0
      001004 07                    4169 	.db #0x07	;  7
      001005 02                    4170 	.db #0x02	;  2
      001006 F0                    4171 	.db #0xf0	; -16
      001007 15                    4172 	.db #0x15	;  21
      001008 0E                    4173 	.db #0x0e	;  14
      001009 00                    4174 	.db #0x00	;  0
      00100A 09                    4175 	.db #0x09	;  9
      00100B 12                    4176 	.db #0x12	;  18
      00100C 01                    4177 	.db #0x01	;  1
      00100D F0                    4178 	.db #0xf0	; -16
      00100E E8                    4179 	.db #0xe8	; -24
      00100F 2E                    4180 	.db #0x2e	;  46
      001010 F4                    4181 	.db #0xf4	; -12
      001011 F1                    4182 	.db #0xf1	; -15
      001012 17                    4183 	.db #0x17	;  23
      001013 FA                    4184 	.db #0xfa	; -6
      001014 07                    4185 	.db #0x07	;  7
      001015 00                    4186 	.db #0x00	;  0
      001016 16                    4187 	.db #0x16	;  22
      001017 EF                    4188 	.db #0xef	; -17
      001018 E2                    4189 	.db #0xe2	; -30
      001019 00                    4190 	.db #0x00	;  0
      00101A D3                    4191 	.db #0xd3	; -45
      00101B 17                    4192 	.db #0x17	;  23
      00101C F5                    4193 	.db #0xf5	; -11
      00101D 07                    4194 	.db #0x07	;  7
      00101E 02                    4195 	.db #0x02	;  2
      00101F F4                    4196 	.db #0xf4	; -12
      001020 0E                    4197 	.db #0x0e	;  14
      001021 FA                    4198 	.db #0xfa	; -6
      001022 D7                    4199 	.db #0xd7	; -41
      001023 00                    4200 	.db #0x00	;  0
      001024 F5                    4201 	.db #0xf5	; -11
      001025 F1                    4202 	.db #0xf1	; -15
      001026 F9                    4203 	.db #0xf9	; -7
      001027 F0                    4204 	.db #0xf0	; -16
      001028 10                    4205 	.db #0x10	;  16
      001029 00                    4206 	.db #0x00	;  0
      00102A 1B                    4207 	.db #0x1b	;  27
      00102B F0                    4208 	.db #0xf0	; -16
      00102C F1                    4209 	.db #0xf1	; -15
      00102D F7                    4210 	.db #0xf7	; -9
      00102E DA                    4211 	.db #0xda	; -38
      00102F F2                    4212 	.db #0xf2	; -14
      001030 F5                    4213 	.db #0xf5	; -11
      001031 0F                    4214 	.db #0x0f	;  15
      001032 01                    4215 	.db #0x01	;  1
      001033 F5                    4216 	.db #0xf5	; -11
      001034 EB                    4217 	.db #0xeb	; -21
      001035 00                    4218 	.db #0x00	;  0
      001036 11                    4219 	.db #0x11	;  17
      001037 DB                    4220 	.db #0xdb	; -37
      001038 C8                    4221 	.db #0xc8	; -56
      001039 06                    4222 	.db #0x06	;  6
      00103A D6                    4223 	.db #0xd6	; -42
      00103B 1D                    4224 	.db #0x1d	;  29
      00103C 2D                    4225 	.db #0x2d	;  45
      00103D 17                    4226 	.db #0x17	;  23
      00103E 26                    4227 	.db #0x26	;  38
      00103F E2                    4228 	.db #0xe2	; -30
      001040 08                    4229 	.db #0x08	;  8
      001041 16                    4230 	.db #0x16	;  22
      001042 E7                    4231 	.db #0xe7	; -25
      001043 00                    4232 	.db #0x00	;  0
      001044 09                    4233 	.db #0x09	;  9
      001045 F2                    4234 	.db #0xf2	; -14
      001046 01                    4235 	.db #0x01	;  1
      001047 EF                    4236 	.db #0xef	; -17
      001048 11                    4237 	.db #0x11	;  17
      001049 00                    4238 	.db #0x00	;  0
      00104A 1C                    4239 	.db #0x1c	;  28
      00104B DF                    4240 	.db #0xdf	; -33
      00104C FE                    4241 	.db #0xfe	; -2
      00104D 0E                    4242 	.db #0x0e	;  14
      00104E ED                    4243 	.db #0xed	; -19
      00104F EB                    4244 	.db #0xeb	; -21
      001050 1D                    4245 	.db #0x1d	;  29
      001051 03                    4246 	.db #0x03	;  3
      001052 EC                    4247 	.db #0xec	; -20
      001053 0D                    4248 	.db #0x0d	;  13
      001054 F4                    4249 	.db #0xf4	; -12
      001055 00                    4250 	.db #0x00	;  0
      001056 19                    4251 	.db #0x19	;  25
      001057 E2                    4252 	.db #0xe2	; -30
      001058 CD                    4253 	.db #0xcd	; -51
      001059 00                    4254 	.db #0x00	;  0
      00105A E8                    4255 	.db #0xe8	; -24
      00105B 2B                    4256 	.db #0x2b	;  43
      00105C 29                    4257 	.db #0x29	;  41
      00105D F7                    4258 	.db #0xf7	; -9
      00105E 10                    4259 	.db #0x10	;  16
      00105F 06                    4260 	.db #0x06	;  6
      001060 0D                    4261 	.db #0x0d	;  13
      001061 0D                    4262 	.db #0x0d	;  13
      001062 01                    4263 	.db #0x01	;  1
      001063 00                    4264 	.db #0x00	;  0
      001064 F4                    4265 	.db #0xf4	; -12
      001065 F2                    4266 	.db #0xf2	; -14
      001066 00                    4267 	.db #0x00	;  0
      001067 F0                    4268 	.db #0xf0	; -16
      001068 03                    4269 	.db #0x03	;  3
      001069 00                    4270 	.db #0x00	;  0
      00106A 18                    4271 	.db #0x18	;  24
      00106B F3                    4272 	.db #0xf3	; -13
      00106C FF                    4273 	.db #0xff	; -1
      00106D 09                    4274 	.db #0x09	;  9
      00106E F1                    4275 	.db #0xf1	; -15
      00106F F5                    4276 	.db #0xf5	; -11
      001070 16                    4277 	.db #0x16	;  22
      001071 0A                    4278 	.db #0x0a	;  10
      001072 F3                    4279 	.db #0xf3	; -13
      001073 FE                    4280 	.db #0xfe	; -2
      001074 F6                    4281 	.db #0xf6	; -10
      001075 00                    4282 	.db #0x00	;  0
      001076 F6                    4283 	.db #0xf6	; -10
      001077 03                    4284 	.db #0x03	;  3
      001078 EA                    4285 	.db #0xea	; -22
      001079 F1                    4286 	.db #0xf1	; -15
      00107A 07                    4287 	.db #0x07	;  7
      00107B 1F                    4288 	.db #0x1f	;  31
      00107C FC                    4289 	.db #0xfc	; -4
      00107D 00                    4290 	.db #0x00	;  0
      00107E FD                    4291 	.db #0xfd	; -3
      00107F 00                    4292 	.db #0x00	;  0
      001080 00                    4293 	.db #0x00	;  0
      001081 00                    4294 	.db #0x00	;  0
      001082 00                    4295 	.db #0x00	;  0
      001083 00                    4296 	.db #0x00	;  0
      001084 00                    4297 	.db #0x00	;  0
      001085 FF                    4298 	.db #0xff	; -1
      001086 00                    4299 	.db #0x00	;  0
      001087 00                    4300 	.db #0x00	;  0
      001088 FD                    4301 	.db #0xfd	; -3
      001089 00                    4302 	.db #0x00	;  0
      00108A 00                    4303 	.db #0x00	;  0
      00108B FE                    4304 	.db #0xfe	; -2
      00108C 00                    4305 	.db #0x00	;  0
      00108D FF                    4306 	.db #0xff	; -1
      00108E 00                    4307 	.db #0x00	;  0
      00108F 00                    4308 	.db #0x00	;  0
      001090 03                    4309 	.db #0x03	;  3
      001091 00                    4310 	.db #0x00	;  0
      001092 00                    4311 	.db #0x00	;  0
      001093 00                    4312 	.db #0x00	;  0
      001094 02                    4313 	.db #0x02	;  2
      001095 00                    4314 	.db #0x00	;  0
      001096 00                    4315 	.db #0x00	;  0
      001097 03                    4316 	.db #0x03	;  3
      001098 FE                    4317 	.db #0xfe	; -2
      001099 00                    4318 	.db #0x00	;  0
      00109A 00                    4319 	.db #0x00	;  0
      00109B 01                    4320 	.db #0x01	;  1
      00109C 02                    4321 	.db #0x02	;  2
      00109D 00                    4322 	.db #0x00	;  0
      00109E 00                    4323 	.db #0x00	;  0
      00109F 00                    4324 	.db #0x00	;  0
      0010A0 00                    4325 	.db #0x00	;  0
      0010A1 00                    4326 	.db #0x00	;  0
      0010A2 00                    4327 	.db #0x00	;  0
      0010A3 00                    4328 	.db #0x00	;  0
      0010A4 00                    4329 	.db #0x00	;  0
      0010A5 00                    4330 	.db #0x00	;  0
      0010A6 00                    4331 	.db #0x00	;  0
      0010A7 00                    4332 	.db #0x00	;  0
      0010A8 00                    4333 	.db #0x00	;  0
      0010A9 00                    4334 	.db #0x00	;  0
      0010AA 00                    4335 	.db #0x00	;  0
      0010AB 00                    4336 	.db #0x00	;  0
      0010AC 00                    4337 	.db #0x00	;  0
      0010AD 00                    4338 	.db #0x00	;  0
      0010AE 00                    4339 	.db #0x00	;  0
      0010AF 00                    4340 	.db #0x00	;  0
      0010B0 00                    4341 	.db #0x00	;  0
      0010B1 00                    4342 	.db #0x00	;  0
      0010B2 00                    4343 	.db #0x00	;  0
      0010B3 00                    4344 	.db #0x00	;  0
      0010B4 00                    4345 	.db #0x00	;  0
      0010B5 00                    4346 	.db #0x00	;  0
      0010B6 00                    4347 	.db #0x00	;  0
      0010B7 00                    4348 	.db #0x00	;  0
      0010B8 00                    4349 	.db #0x00	;  0
      0010B9 00                    4350 	.db #0x00	;  0
      0010BA 00                    4351 	.db #0x00	;  0
      0010BB 00                    4352 	.db #0x00	;  0
      0010BC 00                    4353 	.db #0x00	;  0
      0010BD 0A                    4354 	.db #0x0a	;  10
      0010BE FE                    4355 	.db #0xfe	; -2
      0010BF 00                    4356 	.db #0x00	;  0
      0010C0 08                    4357 	.db #0x08	;  8
      0010C1 01                    4358 	.db #0x01	;  1
      0010C2 00                    4359 	.db #0x00	;  0
      0010C3 00                    4360 	.db #0x00	;  0
      0010C4 FB                    4361 	.db #0xfb	; -5
      0010C5 FF                    4362 	.db #0xff	; -1
      0010C6 EF                    4363 	.db #0xef	; -17
      0010C7 FE                    4364 	.db #0xfe	; -2
      0010C8 FD                    4365 	.db #0xfd	; -3
      0010C9 00                    4366 	.db #0x00	;  0
      0010CA 02                    4367 	.db #0x02	;  2
      0010CB 03                    4368 	.db #0x03	;  3
      0010CC 03                    4369 	.db #0x03	;  3
      0010CD FC                    4370 	.db #0xfc	; -4
      0010CE FF                    4371 	.db #0xff	; -1
      0010CF 00                    4372 	.db #0x00	;  0
      0010D0 FF                    4373 	.db #0xff	; -1
      0010D1 01                    4374 	.db #0x01	;  1
      0010D2 FF                    4375 	.db #0xff	; -1
      0010D3 03                    4376 	.db #0x03	;  3
      0010D4 FC                    4377 	.db #0xfc	; -4
      0010D5 00                    4378 	.db #0x00	;  0
      0010D6 03                    4379 	.db #0x03	;  3
      0010D7 FF                    4380 	.db #0xff	; -1
      0010D8 FF                    4381 	.db #0xff	; -1
      0010D9 FD                    4382 	.db #0xfd	; -3
      0010DA 02                    4383 	.db #0x02	;  2
      0010DB 00                    4384 	.db #0x00	;  0
      0010DC 04                    4385 	.db #0x04	;  4
      0010DD 0C                    4386 	.db #0x0c	;  12
      0010DE 18                    4387 	.db #0x18	;  24
      0010DF FD                    4388 	.db #0xfd	; -3
      0010E0 FC                    4389 	.db #0xfc	; -4
      0010E1 0C                    4390 	.db #0x0c	;  12
      0010E2 E9                    4391 	.db #0xe9	; -23
      0010E3 00                    4392 	.db #0x00	;  0
      0010E4 EB                    4393 	.db #0xeb	; -21
      0010E5 E3                    4394 	.db #0xe3	; -29
      0010E6 D5                    4395 	.db #0xd5	; -43
      0010E7 00                    4396 	.db #0x00	;  0
      0010E8 09                    4397 	.db #0x09	;  9
      0010E9 00                    4398 	.db #0x00	;  0
      0010EA 0A                    4399 	.db #0x0a	;  10
      0010EB F9                    4400 	.db #0xf9	; -7
      0010EC F6                    4401 	.db #0xf6	; -10
      0010ED FF                    4402 	.db #0xff	; -1
      0010EE 0A                    4403 	.db #0x0a	;  10
      0010EF FD                    4404 	.db #0xfd	; -3
      0010F0 08                    4405 	.db #0x08	;  8
      0010F1 F8                    4406 	.db #0xf8	; -8
      0010F2 01                    4407 	.db #0x01	;  1
      0010F3 10                    4408 	.db #0x10	;  16
      0010F4 F7                    4409 	.db #0xf7	; -9
      0010F5 00                    4410 	.db #0x00	;  0
      0010F6 0E                    4411 	.db #0x0e	;  14
      0010F7 03                    4412 	.db #0x03	;  3
      0010F8 FA                    4413 	.db #0xfa	; -6
      0010F9 05                    4414 	.db #0x05	;  5
      0010FA FD                    4415 	.db #0xfd	; -3
      0010FB EC                    4416 	.db #0xec	; -20
      0010FC 02                    4417 	.db #0x02	;  2
      0010FD F3                    4418 	.db #0xf3	; -13
      0010FE 20                    4419 	.db #0x20	;  32
      0010FF F8                    4420 	.db #0xf8	; -8
      001100 02                    4421 	.db #0x02	;  2
      001101 F4                    4422 	.db #0xf4	; -12
      001102 E8                    4423 	.db #0xe8	; -24
      001103 00                    4424 	.db #0x00	;  0
      001104 E7                    4425 	.db #0xe7	; -25
      001105 FA                    4426 	.db #0xfa	; -6
      001106 A2                    4427 	.db #0xa2	; -94
      001107 DC                    4428 	.db #0xdc	; -36
      001108 0E                    4429 	.db #0x0e	;  14
      001109 00                    4430 	.db #0x00	;  0
      00110A 20                    4431 	.db #0x20	;  32
      00110B DD                    4432 	.db #0xdd	; -35
      00110C EE                    4433 	.db #0xee	; -18
      00110D FB                    4434 	.db #0xfb	; -5
      00110E E9                    4435 	.db #0xe9	; -23
      00110F E8                    4436 	.db #0xe8	; -24
      001110 03                    4437 	.db #0x03	;  3
      001111 F1                    4438 	.db #0xf1	; -15
      001112 06                    4439 	.db #0x06	;  6
      001113 F3                    4440 	.db #0xf3	; -13
      001114 0A                    4441 	.db #0x0a	;  10
      001115 00                    4442 	.db #0x00	;  0
      001116 27                    4443 	.db #0x27	;  39
      001117 0C                    4444 	.db #0x0c	;  12
      001118 04                    4445 	.db #0x04	;  4
      001119 0C                    4446 	.db #0x0c	;  12
      00111A E9                    4447 	.db #0xe9	; -23
      00111B 04                    4448 	.db #0x04	;  4
      00111C 07                    4449 	.db #0x07	;  7
      00111D FE                    4450 	.db #0xfe	; -2
      00111E 16                    4451 	.db #0x16	;  22
      00111F FB                    4452 	.db #0xfb	; -5
      001120 FB                    4453 	.db #0xfb	; -5
      001121 11                    4454 	.db #0x11	;  17
      001122 F3                    4455 	.db #0xf3	; -13
      001123 00                    4456 	.db #0x00	;  0
      001124 EE                    4457 	.db #0xee	; -18
      001125 FB                    4458 	.db #0xfb	; -5
      001126 AF                    4459 	.db #0xaf	; -81
      001127 B4                    4460 	.db #0xb4	; -76
      001128 EC                    4461 	.db #0xec	; -20
      001129 00                    4462 	.db #0x00	;  0
      00112A 25                    4463 	.db #0x25	;  37
      00112B 05                    4464 	.db #0x05	;  5
      00112C FD                    4465 	.db #0xfd	; -3
      00112D FE                    4466 	.db #0xfe	; -2
      00112E F7                    4467 	.db #0xf7	; -9
      00112F F5                    4468 	.db #0xf5	; -11
      001130 0C                    4469 	.db #0x0c	;  12
      001131 FA                    4470 	.db #0xfa	; -6
      001132 F2                    4471 	.db #0xf2	; -14
      001133 09                    4472 	.db #0x09	;  9
      001134 07                    4473 	.db #0x07	;  7
      001135 00                    4474 	.db #0x00	;  0
      001136 13                    4475 	.db #0x13	;  19
      001137 10                    4476 	.db #0x10	;  16
      001138 01                    4477 	.db #0x01	;  1
      001139 E6                    4478 	.db #0xe6	; -26
      00113A F2                    4479 	.db #0xf2	; -14
      00113B 08                    4480 	.db #0x08	;  8
      00113C F2                    4481 	.db #0xf2	; -14
      00113D EA                    4482 	.db #0xea	; -22
      00113E E6                    4483 	.db #0xe6	; -26
      00113F 0B                    4484 	.db #0x0b	;  11
      001140 FF                    4485 	.db #0xff	; -1
      001141 0A                    4486 	.db #0x0a	;  10
      001142 EB                    4487 	.db #0xeb	; -21
      001143 00                    4488 	.db #0x00	;  0
      001144 16                    4489 	.db #0x16	;  22
      001145 EE                    4490 	.db #0xee	; -18
      001146 E1                    4491 	.db #0xe1	; -31
      001147 B1                    4492 	.db #0xb1	; -79
      001148 03                    4493 	.db #0x03	;  3
      001149 00                    4494 	.db #0x00	;  0
      00114A 35                    4495 	.db #0x35	;  53	'5'
      00114B 11                    4496 	.db #0x11	;  17
      00114C F4                    4497 	.db #0xf4	; -12
      00114D 17                    4498 	.db #0x17	;  23
      00114E 05                    4499 	.db #0x05	;  5
      00114F 11                    4500 	.db #0x11	;  17
      001150 20                    4501 	.db #0x20	;  32
      001151 F8                    4502 	.db #0xf8	; -8
      001152 DC                    4503 	.db #0xdc	; -36
      001153 F9                    4504 	.db #0xf9	; -7
      001154 16                    4505 	.db #0x16	;  22
      001155 00                    4506 	.db #0x00	;  0
      001156 28                    4507 	.db #0x28	;  40
      001157 1B                    4508 	.db #0x1b	;  27
      001158 06                    4509 	.db #0x06	;  6
      001159 F1                    4510 	.db #0xf1	; -15
      00115A FC                    4511 	.db #0xfc	; -4
      00115B 10                    4512 	.db #0x10	;  16
      00115C F1                    4513 	.db #0xf1	; -15
      00115D F8                    4514 	.db #0xf8	; -8
      00115E CF                    4515 	.db #0xcf	; -49
      00115F 1B                    4516 	.db #0x1b	;  27
      001160 0D                    4517 	.db #0x0d	;  13
      001161 06                    4518 	.db #0x06	;  6
      001162 FB                    4519 	.db #0xfb	; -5
      001163 00                    4520 	.db #0x00	;  0
      001164 35                    4521 	.db #0x35	;  53	'5'
      001165 FE                    4522 	.db #0xfe	; -2
      001166 16                    4523 	.db #0x16	;  22
      001167 CB                    4524 	.db #0xcb	; -53
      001168 FB                    4525 	.db #0xfb	; -5
      001169 00                    4526 	.db #0x00	;  0
      00116A 21                    4527 	.db #0x21	;  33
      00116B F5                    4528 	.db #0xf5	; -11
      00116C E5                    4529 	.db #0xe5	; -27
      00116D EB                    4530 	.db #0xeb	; -21
      00116E 1A                    4531 	.db #0x1a	;  26
      00116F 25                    4532 	.db #0x25	;  37
      001170 0C                    4533 	.db #0x0c	;  12
      001171 13                    4534 	.db #0x13	;  19
      001172 9E                    4535 	.db #0x9e	; -98
      001173 08                    4536 	.db #0x08	;  8
      001174 FE                    4537 	.db #0xfe	; -2
      001175 00                    4538 	.db #0x00	;  0
      001176 0F                    4539 	.db #0x0f	;  15
      001177 20                    4540 	.db #0x20	;  32
      001178 08                    4541 	.db #0x08	;  8
      001179 FA                    4542 	.db #0xfa	; -6
      00117A 0A                    4543 	.db #0x0a	;  10
      00117B 17                    4544 	.db #0x17	;  23
      00117C 10                    4545 	.db #0x10	;  16
      00117D F3                    4546 	.db #0xf3	; -13
      00117E DB                    4547 	.db #0xdb	; -37
      00117F 02                    4548 	.db #0x02	;  2
      001180 14                    4549 	.db #0x14	;  20
      001181 1D                    4550 	.db #0x1d	;  29
      001182 FE                    4551 	.db #0xfe	; -2
      001183 00                    4552 	.db #0x00	;  0
      001184 14                    4553 	.db #0x14	;  20
      001185 05                    4554 	.db #0x05	;  5
      001186 0D                    4555 	.db #0x0d	;  13
      001187 E4                    4556 	.db #0xe4	; -28
      001188 ED                    4557 	.db #0xed	; -19
      001189 00                    4558 	.db #0x00	;  0
      00118A 16                    4559 	.db #0x16	;  22
      00118B F7                    4560 	.db #0xf7	; -9
      00118C EC                    4561 	.db #0xec	; -20
      00118D F0                    4562 	.db #0xf0	; -16
      00118E FD                    4563 	.db #0xfd	; -3
      00118F 2B                    4564 	.db #0x2b	;  43
      001190 F4                    4565 	.db #0xf4	; -12
      001191 18                    4566 	.db #0x18	;  24
      001192 E7                    4567 	.db #0xe7	; -25
      001193 F0                    4568 	.db #0xf0	; -16
      001194 E2                    4569 	.db #0xe2	; -30
      001195 00                    4570 	.db #0x00	;  0
      001196 ED                    4571 	.db #0xed	; -19
      001197 FD                    4572 	.db #0xfd	; -3
      001198 07                    4573 	.db #0x07	;  7
      001199 EC                    4574 	.db #0xec	; -20
      00119A 18                    4575 	.db #0x18	;  24
      00119B 21                    4576 	.db #0x21	;  33
      00119C 27                    4577 	.db #0x27	;  39
      00119D F4                    4578 	.db #0xf4	; -12
      00119E FB                    4579 	.db #0xfb	; -5
      00119F D8                    4580 	.db #0xd8	; -40
      0011A0 05                    4581 	.db #0x05	;  5
      0011A1 04                    4582 	.db #0x04	;  4
      0011A2 05                    4583 	.db #0x05	;  5
      0011A3 00                    4584 	.db #0x00	;  0
      0011A4 07                    4585 	.db #0x07	;  7
      0011A5 13                    4586 	.db #0x13	;  19
      0011A6 09                    4587 	.db #0x09	;  9
      0011A7 0D                    4588 	.db #0x0d	;  13
      0011A8 F1                    4589 	.db #0xf1	; -15
      0011A9 00                    4590 	.db #0x00	;  0
      0011AA 0E                    4591 	.db #0x0e	;  14
      0011AB 1A                    4592 	.db #0x1a	;  26
      0011AC ED                    4593 	.db #0xed	; -19
      0011AD F3                    4594 	.db #0xf3	; -13
      0011AE F4                    4595 	.db #0xf4	; -12
      0011AF 1C                    4596 	.db #0x1c	;  28
      0011B0 FA                    4597 	.db #0xfa	; -6
      0011B1 F8                    4598 	.db #0xf8	; -8
      0011B2 FB                    4599 	.db #0xfb	; -5
      0011B3 FB                    4600 	.db #0xfb	; -5
      0011B4 F3                    4601 	.db #0xf3	; -13
      0011B5 00                    4602 	.db #0x00	;  0
      0011B6 01                    4603 	.db #0x01	;  1
      0011B7 09                    4604 	.db #0x09	;  9
      0011B8 16                    4605 	.db #0x16	;  22
      0011B9 EF                    4606 	.db #0xef	; -17
      0011BA E5                    4607 	.db #0xe5	; -27
      0011BB 01                    4608 	.db #0x01	;  1
      0011BC 28                    4609 	.db #0x28	;  40
      0011BD 02                    4610 	.db #0x02	;  2
      0011BE F7                    4611 	.db #0xf7	; -9
      0011BF CC                    4612 	.db #0xcc	; -52
      0011C0 06                    4613 	.db #0x06	;  6
      0011C1 0B                    4614 	.db #0x0b	;  11
      0011C2 CC                    4615 	.db #0xcc	; -52
      0011C3 00                    4616 	.db #0x00	;  0
      0011C4 F8                    4617 	.db #0xf8	; -8
      0011C5 15                    4618 	.db #0x15	;  21
      0011C6 10                    4619 	.db #0x10	;  16
      0011C7 0D                    4620 	.db #0x0d	;  13
      0011C8 0E                    4621 	.db #0x0e	;  14
      0011C9 00                    4622 	.db #0x00	;  0
      0011CA 17                    4623 	.db #0x17	;  23
      0011CB 11                    4624 	.db #0x11	;  17
      0011CC F9                    4625 	.db #0xf9	; -7
      0011CD FF                    4626 	.db #0xff	; -1
      0011CE E7                    4627 	.db #0xe7	; -25
      0011CF E6                    4628 	.db #0xe6	; -26
      0011D0 03                    4629 	.db #0x03	;  3
      0011D1 00                    4630 	.db #0x00	;  0
      0011D2 FA                    4631 	.db #0xfa	; -6
      0011D3 F8                    4632 	.db #0xf8	; -8
      0011D4 F8                    4633 	.db #0xf8	; -8
      0011D5 00                    4634 	.db #0x00	;  0
      0011D6 1A                    4635 	.db #0x1a	;  26
      0011D7 F7                    4636 	.db #0xf7	; -9
      0011D8 13                    4637 	.db #0x13	;  19
      0011D9 FE                    4638 	.db #0xfe	; -2
      0011DA E1                    4639 	.db #0xe1	; -31
      0011DB 13                    4640 	.db #0x13	;  19
      0011DC F4                    4641 	.db #0xf4	; -12
      0011DD FA                    4642 	.db #0xfa	; -6
      0011DE 1D                    4643 	.db #0x1d	;  29
      0011DF DD                    4644 	.db #0xdd	; -35
      0011E0 0F                    4645 	.db #0x0f	;  15
      0011E1 0C                    4646 	.db #0x0c	;  12
      0011E2 D6                    4647 	.db #0xd6	; -42
      0011E3 00                    4648 	.db #0x00	;  0
      0011E4 E9                    4649 	.db #0xe9	; -23
      0011E5 0B                    4650 	.db #0x0b	;  11
      0011E6 01                    4651 	.db #0x01	;  1
      0011E7 31                    4652 	.db #0x31	;  49	'1'
      0011E8 0C                    4653 	.db #0x0c	;  12
      0011E9 00                    4654 	.db #0x00	;  0
      0011EA 0D                    4655 	.db #0x0d	;  13
      0011EB 0D                    4656 	.db #0x0d	;  13
      0011EC 07                    4657 	.db #0x07	;  7
      0011ED 02                    4658 	.db #0x02	;  2
      0011EE F1                    4659 	.db #0xf1	; -15
      0011EF E3                    4660 	.db #0xe3	; -29
      0011F0 0D                    4661 	.db #0x0d	;  13
      0011F1 13                    4662 	.db #0x13	;  19
      0011F2 EE                    4663 	.db #0xee	; -18
      0011F3 ED                    4664 	.db #0xed	; -19
      0011F4 07                    4665 	.db #0x07	;  7
      0011F5 00                    4666 	.db #0x00	;  0
      0011F6 0C                    4667 	.db #0x0c	;  12
      0011F7 E6                    4668 	.db #0xe6	; -26
      0011F8 05                    4669 	.db #0x05	;  5
      0011F9 10                    4670 	.db #0x10	;  16
      0011FA DE                    4671 	.db #0xde	; -34
      0011FB 28                    4672 	.db #0x28	;  40
      0011FC FB                    4673 	.db #0xfb	; -5
      0011FD 00                    4674 	.db #0x00	;  0
      0011FE 27                    4675 	.db #0x27	;  39
      0011FF F7                    4676 	.db #0xf7	; -9
      001200 05                    4677 	.db #0x05	;  5
      001201 1B                    4678 	.db #0x1b	;  27
      001202 E5                    4679 	.db #0xe5	; -27
      001203 00                    4680 	.db #0x00	;  0
      001204 00                    4681 	.db #0x00	;  0
      001205 E9                    4682 	.db #0xe9	; -23
      001206 F8                    4683 	.db #0xf8	; -8
      001207 09                    4684 	.db #0x09	;  9
      001208 08                    4685 	.db #0x08	;  8
      001209 00                    4686 	.db #0x00	;  0
      00120A 0E                    4687 	.db #0x0e	;  14
      00120B F0                    4688 	.db #0xf0	; -16
      00120C 04                    4689 	.db #0x04	;  4
      00120D 02                    4690 	.db #0x02	;  2
      00120E F6                    4691 	.db #0xf6	; -10
      00120F FF                    4692 	.db #0xff	; -1
      001210 08                    4693 	.db #0x08	;  8
      001211 04                    4694 	.db #0x04	;  4
      001212 F5                    4695 	.db #0xf5	; -11
      001213 FB                    4696 	.db #0xfb	; -5
      001214 17                    4697 	.db #0x17	;  23
      001215 00                    4698 	.db #0x00	;  0
      001216 07                    4699 	.db #0x07	;  7
      001217 08                    4700 	.db #0x08	;  8
      001218 EC                    4701 	.db #0xec	; -20
      001219 E9                    4702 	.db #0xe9	; -23
      00121A E9                    4703 	.db #0xe9	; -23
      00121B 2E                    4704 	.db #0x2e	;  46
      00121C F0                    4705 	.db #0xf0	; -16
      00121D 02                    4706 	.db #0x02	;  2
      00121E 01                    4707 	.db #0x01	;  1
      00121F 20                    4708 	.db #0x20	;  32
      001220 F8                    4709 	.db #0xf8	; -8
      001221 FD                    4710 	.db #0xfd	; -3
      001222 FB                    4711 	.db #0xfb	; -5
      001223 00                    4712 	.db #0x00	;  0
      001224 FD                    4713 	.db #0xfd	; -3
      001225 F4                    4714 	.db #0xf4	; -12
      001226 04                    4715 	.db #0x04	;  4
      001227 11                    4716 	.db #0x11	;  17
      001228 FE                    4717 	.db #0xfe	; -2
      001229 00                    4718 	.db #0x00	;  0
      00122A 10                    4719 	.db #0x10	;  16
      00122B EB                    4720 	.db #0xeb	; -21
      00122C FB                    4721 	.db #0xfb	; -5
      00122D 19                    4722 	.db #0x19	;  25
      00122E FA                    4723 	.db #0xfa	; -6
      00122F F0                    4724 	.db #0xf0	; -16
      001230 0D                    4725 	.db #0x0d	;  13
      001231 0C                    4726 	.db #0x0c	;  12
      001232 EC                    4727 	.db #0xec	; -20
      001233 0B                    4728 	.db #0x0b	;  11
      001234 14                    4729 	.db #0x14	;  20
      001235 00                    4730 	.db #0x00	;  0
      001236 EF                    4731 	.db #0xef	; -17
      001237 1F                    4732 	.db #0x1f	;  31
      001238 EB                    4733 	.db #0xeb	; -21
      001239 F4                    4734 	.db #0xf4	; -12
      00123A FE                    4735 	.db #0xfe	; -2
      00123B 0D                    4736 	.db #0x0d	;  13
      00123C FF                    4737 	.db #0xff	; -1
      00123D 00                    4738 	.db #0x00	;  0
      00123E 00                    4739 	.db #0x00	;  0
      00123F 00                    4740 	.db #0x00	;  0
      001240 00                    4741 	.db #0x00	;  0
      001241 00                    4742 	.db #0x00	;  0
      001242 00                    4743 	.db #0x00	;  0
      001243 00                    4744 	.db #0x00	;  0
      001244 00                    4745 	.db #0x00	;  0
      001245 00                    4746 	.db #0x00	;  0
      001246 00                    4747 	.db #0x00	;  0
      001247 00                    4748 	.db #0x00	;  0
      001248 00                    4749 	.db #0x00	;  0
      001249 00                    4750 	.db #0x00	;  0
      00124A 00                    4751 	.db #0x00	;  0
      00124B 00                    4752 	.db #0x00	;  0
      00124C 00                    4753 	.db #0x00	;  0
      00124D 00                    4754 	.db #0x00	;  0
      00124E 00                    4755 	.db #0x00	;  0
      00124F 00                    4756 	.db #0x00	;  0
      001250 00                    4757 	.db #0x00	;  0
      001251 00                    4758 	.db #0x00	;  0
      001252 00                    4759 	.db #0x00	;  0
      001253 00                    4760 	.db #0x00	;  0
      001254 00                    4761 	.db #0x00	;  0
      001255 00                    4762 	.db #0x00	;  0
      001256 00                    4763 	.db #0x00	;  0
      001257 00                    4764 	.db #0x00	;  0
      001258 00                    4765 	.db #0x00	;  0
      001259 00                    4766 	.db #0x00	;  0
      00125A 00                    4767 	.db #0x00	;  0
      00125B 00                    4768 	.db #0x00	;  0
      00125C 00                    4769 	.db #0x00	;  0
      00125D 00                    4770 	.db #0x00	;  0
      00125E 00                    4771 	.db #0x00	;  0
      00125F 00                    4772 	.db #0x00	;  0
      001260 00                    4773 	.db #0x00	;  0
      001261 00                    4774 	.db #0x00	;  0
      001262 00                    4775 	.db #0x00	;  0
      001263 00                    4776 	.db #0x00	;  0
      001264 00                    4777 	.db #0x00	;  0
      001265 00                    4778 	.db #0x00	;  0
      001266 00                    4779 	.db #0x00	;  0
      001267 00                    4780 	.db #0x00	;  0
      001268 00                    4781 	.db #0x00	;  0
      001269 00                    4782 	.db #0x00	;  0
      00126A 00                    4783 	.db #0x00	;  0
      00126B 00                    4784 	.db #0x00	;  0
      00126C 00                    4785 	.db #0x00	;  0
      00126D 00                    4786 	.db #0x00	;  0
      00126E 00                    4787 	.db #0x00	;  0
      00126F 00                    4788 	.db #0x00	;  0
      001270 00                    4789 	.db #0x00	;  0
      001271 00                    4790 	.db #0x00	;  0
      001272 00                    4791 	.db #0x00	;  0
      001273 00                    4792 	.db #0x00	;  0
      001274 00                    4793 	.db #0x00	;  0
      001275 00                    4794 	.db #0x00	;  0
      001276 00                    4795 	.db #0x00	;  0
      001277 00                    4796 	.db #0x00	;  0
      001278 00                    4797 	.db #0x00	;  0
      001279 00                    4798 	.db #0x00	;  0
      00127A 00                    4799 	.db #0x00	;  0
      00127B 00                    4800 	.db #0x00	;  0
      00127C 00                    4801 	.db #0x00	;  0
      00127D 03                    4802 	.db #0x03	;  3
      00127E FE                    4803 	.db #0xfe	; -2
      00127F 04                    4804 	.db #0x04	;  4
      001280 FB                    4805 	.db #0xfb	; -5
      001281 00                    4806 	.db #0x00	;  0
      001282 FF                    4807 	.db #0xff	; -1
      001283 00                    4808 	.db #0x00	;  0
      001284 02                    4809 	.db #0x02	;  2
      001285 05                    4810 	.db #0x05	;  5
      001286 FA                    4811 	.db #0xfa	; -6
      001287 0D                    4812 	.db #0x0d	;  13
      001288 FC                    4813 	.db #0xfc	; -4
      001289 00                    4814 	.db #0x00	;  0
      00128A 04                    4815 	.db #0x04	;  4
      00128B FD                    4816 	.db #0xfd	; -3
      00128C FE                    4817 	.db #0xfe	; -2
      00128D FE                    4818 	.db #0xfe	; -2
      00128E FC                    4819 	.db #0xfc	; -4
      00128F 06                    4820 	.db #0x06	;  6
      001290 FB                    4821 	.db #0xfb	; -5
      001291 00                    4822 	.db #0x00	;  0
      001292 02                    4823 	.db #0x02	;  2
      001293 FA                    4824 	.db #0xfa	; -6
      001294 04                    4825 	.db #0x04	;  4
      001295 00                    4826 	.db #0x00	;  0
      001296 01                    4827 	.db #0x01	;  1
      001297 05                    4828 	.db #0x05	;  5
      001298 00                    4829 	.db #0x00	;  0
      001299 03                    4830 	.db #0x03	;  3
      00129A FD                    4831 	.db #0xfd	; -3
      00129B FF                    4832 	.db #0xff	; -1
      00129C FB                    4833 	.db #0xfb	; -5
      00129D 0F                    4834 	.db #0x0f	;  15
      00129E 1C                    4835 	.db #0x1c	;  28
      00129F FC                    4836 	.db #0xfc	; -4
      0012A0 EF                    4837 	.db #0xef	; -17
      0012A1 F7                    4838 	.db #0xf7	; -9
      0012A2 EE                    4839 	.db #0xee	; -18
      0012A3 00                    4840 	.db #0x00	;  0
      0012A4 D2                    4841 	.db #0xd2	; -46
      0012A5 14                    4842 	.db #0x14	;  20
      0012A6 E4                    4843 	.db #0xe4	; -28
      0012A7 18                    4844 	.db #0x18	;  24
      0012A8 0D                    4845 	.db #0x0d	;  13
      0012A9 00                    4846 	.db #0x00	;  0
      0012AA FD                    4847 	.db #0xfd	; -3
      0012AB 0A                    4848 	.db #0x0a	;  10
      0012AC EA                    4849 	.db #0xea	; -22
      0012AD 0C                    4850 	.db #0x0c	;  12
      0012AE F9                    4851 	.db #0xf9	; -7
      0012AF 0C                    4852 	.db #0x0c	;  12
      0012B0 06                    4853 	.db #0x06	;  6
      0012B1 F0                    4854 	.db #0xf0	; -16
      0012B2 EC                    4855 	.db #0xec	; -20
      0012B3 0F                    4856 	.db #0x0f	;  15
      0012B4 03                    4857 	.db #0x03	;  3
      0012B5 00                    4858 	.db #0x00	;  0
      0012B6 FB                    4859 	.db #0xfb	; -5
      0012B7 29                    4860 	.db #0x29	;  41
      0012B8 EE                    4861 	.db #0xee	; -18
      0012B9 F1                    4862 	.db #0xf1	; -15
      0012BA F5                    4863 	.db #0xf5	; -11
      0012BB FC                    4864 	.db #0xfc	; -4
      0012BC FC                    4865 	.db #0xfc	; -4
      0012BD FF                    4866 	.db #0xff	; -1
      0012BE 22                    4867 	.db #0x22	;  34
      0012BF EE                    4868 	.db #0xee	; -18
      0012C0 F8                    4869 	.db #0xf8	; -8
      0012C1 0F                    4870 	.db #0x0f	;  15
      0012C2 EA                    4871 	.db #0xea	; -22
      0012C3 00                    4872 	.db #0x00	;  0
      0012C4 A3                    4873 	.db #0xa3	; -93
      0012C5 1C                    4874 	.db #0x1c	;  28
      0012C6 E2                    4875 	.db #0xe2	; -30
      0012C7 FC                    4876 	.db #0xfc	; -4
      0012C8 06                    4877 	.db #0x06	;  6
      0012C9 00                    4878 	.db #0x00	;  0
      0012CA 03                    4879 	.db #0x03	;  3
      0012CB F9                    4880 	.db #0xf9	; -7
      0012CC E9                    4881 	.db #0xe9	; -23
      0012CD 09                    4882 	.db #0x09	;  9
      0012CE 0C                    4883 	.db #0x0c	;  12
      0012CF F0                    4884 	.db #0xf0	; -16
      0012D0 0C                    4885 	.db #0x0c	;  12
      0012D1 0A                    4886 	.db #0x0a	;  10
      0012D2 E4                    4887 	.db #0xe4	; -28
      0012D3 FF                    4888 	.db #0xff	; -1
      0012D4 F9                    4889 	.db #0xf9	; -7
      0012D5 00                    4890 	.db #0x00	;  0
      0012D6 FC                    4891 	.db #0xfc	; -4
      0012D7 36                    4892 	.db #0x36	;  54	'6'
      0012D8 F7                    4893 	.db #0xf7	; -9
      0012D9 E3                    4894 	.db #0xe3	; -29
      0012DA EE                    4895 	.db #0xee	; -18
      0012DB 11                    4896 	.db #0x11	;  17
      0012DC 07                    4897 	.db #0x07	;  7
      0012DD F7                    4898 	.db #0xf7	; -9
      0012DE 15                    4899 	.db #0x15	;  21
      0012DF F5                    4900 	.db #0xf5	; -11
      0012E0 FF                    4901 	.db #0xff	; -1
      0012E1 0F                    4902 	.db #0x0f	;  15
      0012E2 03                    4903 	.db #0x03	;  3
      0012E3 00                    4904 	.db #0x00	;  0
      0012E4 81                    4905 	.db #0x81	; -127
      0012E5 2C                    4906 	.db #0x2c	;  44
      0012E6 FC                    4907 	.db #0xfc	; -4
      0012E7 03                    4908 	.db #0x03	;  3
      0012E8 04                    4909 	.db #0x04	;  4
      0012E9 00                    4910 	.db #0x00	;  0
      0012EA FF                    4911 	.db #0xff	; -1
      0012EB 17                    4912 	.db #0x17	;  23
      0012EC E0                    4913 	.db #0xe0	; -32
      0012ED F4                    4914 	.db #0xf4	; -12
      0012EE FE                    4915 	.db #0xfe	; -2
      0012EF F7                    4916 	.db #0xf7	; -9
      0012F0 38                    4917 	.db #0x38	;  56	'8'
      0012F1 00                    4918 	.db #0x00	;  0
      0012F2 D4                    4919 	.db #0xd4	; -44
      0012F3 FB                    4920 	.db #0xfb	; -5
      0012F4 11                    4921 	.db #0x11	;  17
      0012F5 00                    4922 	.db #0x00	;  0
      0012F6 FB                    4923 	.db #0xfb	; -5
      0012F7 1D                    4924 	.db #0x1d	;  29
      0012F8 03                    4925 	.db #0x03	;  3
      0012F9 F0                    4926 	.db #0xf0	; -16
      0012FA FE                    4927 	.db #0xfe	; -2
      0012FB F2                    4928 	.db #0xf2	; -14
      0012FC F3                    4929 	.db #0xf3	; -13
      0012FD 0A                    4930 	.db #0x0a	;  10
      0012FE 00                    4931 	.db #0x00	;  0
      0012FF 05                    4932 	.db #0x05	;  5
      001300 02                    4933 	.db #0x02	;  2
      001301 EF                    4934 	.db #0xef	; -17
      001302 0E                    4935 	.db #0x0e	;  14
      001303 00                    4936 	.db #0x00	;  0
      001304 90                    4937 	.db #0x90	; -112
      001305 2C                    4938 	.db #0x2c	;  44
      001306 26                    4939 	.db #0x26	;  38
      001307 DF                    4940 	.db #0xdf	; -33
      001308 E7                    4941 	.db #0xe7	; -25
      001309 00                    4942 	.db #0x00	;  0
      00130A 20                    4943 	.db #0x20	;  32
      00130B 30                    4944 	.db #0x30	;  48	'0'
      00130C D5                    4945 	.db #0xd5	; -43
      00130D 08                    4946 	.db #0x08	;  8
      00130E F5                    4947 	.db #0xf5	; -11
      00130F FF                    4948 	.db #0xff	; -1
      001310 22                    4949 	.db #0x22	;  34
      001311 F3                    4950 	.db #0xf3	; -13
      001312 B4                    4951 	.db #0xb4	; -76
      001313 FC                    4952 	.db #0xfc	; -4
      001314 03                    4953 	.db #0x03	;  3
      001315 00                    4954 	.db #0x00	;  0
      001316 01                    4955 	.db #0x01	;  1
      001317 17                    4956 	.db #0x17	;  23
      001318 11                    4957 	.db #0x11	;  17
      001319 F6                    4958 	.db #0xf6	; -10
      00131A 04                    4959 	.db #0x04	;  4
      00131B FD                    4960 	.db #0xfd	; -3
      00131C 22                    4961 	.db #0x22	;  34
      00131D 0C                    4962 	.db #0x0c	;  12
      00131E E8                    4963 	.db #0xe8	; -24
      00131F 1D                    4964 	.db #0x1d	;  29
      001320 05                    4965 	.db #0x05	;  5
      001321 04                    4966 	.db #0x04	;  4
      001322 10                    4967 	.db #0x10	;  16
      001323 00                    4968 	.db #0x00	;  0
      001324 D3                    4969 	.db #0xd3	; -45
      001325 0D                    4970 	.db #0x0d	;  13
      001326 26                    4971 	.db #0x26	;  38
      001327 BC                    4972 	.db #0xbc	; -68
      001328 E7                    4973 	.db #0xe7	; -25
      001329 00                    4974 	.db #0x00	;  0
      00132A 22                    4975 	.db #0x22	;  34
      00132B F6                    4976 	.db #0xf6	; -10
      00132C DD                    4977 	.db #0xdd	; -35
      00132D F4                    4978 	.db #0xf4	; -12
      00132E E7                    4979 	.db #0xe7	; -25
      00132F 0E                    4980 	.db #0x0e	;  14
      001330 D9                    4981 	.db #0xd9	; -39
      001331 08                    4982 	.db #0x08	;  8
      001332 DF                    4983 	.db #0xdf	; -33
      001333 18                    4984 	.db #0x18	;  24
      001334 0A                    4985 	.db #0x0a	;  10
      001335 00                    4986 	.db #0x00	;  0
      001336 18                    4987 	.db #0x18	;  24
      001337 10                    4988 	.db #0x10	;  16
      001338 FA                    4989 	.db #0xfa	; -6
      001339 F5                    4990 	.db #0xf5	; -11
      00133A 19                    4991 	.db #0x19	;  25
      00133B 0E                    4992 	.db #0x0e	;  14
      00133C 26                    4993 	.db #0x26	;  38
      00133D EC                    4994 	.db #0xec	; -20
      00133E DC                    4995 	.db #0xdc	; -36
      00133F EC                    4996 	.db #0xec	; -20
      001340 16                    4997 	.db #0x16	;  22
      001341 16                    4998 	.db #0x16	;  22
      001342 E7                    4999 	.db #0xe7	; -25
      001343 00                    5000 	.db #0x00	;  0
      001344 DF                    5001 	.db #0xdf	; -33
      001345 FD                    5002 	.db #0xfd	; -3
      001346 04                    5003 	.db #0x04	;  4
      001347 CC                    5004 	.db #0xcc	; -52
      001348 F6                    5005 	.db #0xf6	; -10
      001349 00                    5006 	.db #0x00	;  0
      00134A 1B                    5007 	.db #0x1b	;  27
      00134B 1B                    5008 	.db #0x1b	;  27
      00134C FE                    5009 	.db #0xfe	; -2
      00134D EA                    5010 	.db #0xea	; -22
      00134E F3                    5011 	.db #0xf3	; -13
      00134F 1D                    5012 	.db #0x1d	;  29
      001350 03                    5013 	.db #0x03	;  3
      001351 01                    5014 	.db #0x01	;  1
      001352 FD                    5015 	.db #0xfd	; -3
      001353 F7                    5016 	.db #0xf7	; -9
      001354 FB                    5017 	.db #0xfb	; -5
      001355 00                    5018 	.db #0x00	;  0
      001356 FF                    5019 	.db #0xff	; -1
      001357 1D                    5020 	.db #0x1d	;  29
      001358 FD                    5021 	.db #0xfd	; -3
      001359 EC                    5022 	.db #0xec	; -20
      00135A 16                    5023 	.db #0x16	;  22
      00135B 05                    5024 	.db #0x05	;  5
      00135C 06                    5025 	.db #0x06	;  6
      00135D FC                    5026 	.db #0xfc	; -4
      00135E E8                    5027 	.db #0xe8	; -24
      00135F E3                    5028 	.db #0xe3	; -29
      001360 EC                    5029 	.db #0xec	; -20
      001361 06                    5030 	.db #0x06	;  6
      001362 CA                    5031 	.db #0xca	; -54
      001363 00                    5032 	.db #0x00	;  0
      001364 F3                    5033 	.db #0xf3	; -13
      001365 FE                    5034 	.db #0xfe	; -2
      001366 0A                    5035 	.db #0x0a	;  10
      001367 F5                    5036 	.db #0xf5	; -11
      001368 06                    5037 	.db #0x06	;  6
      001369 00                    5038 	.db #0x00	;  0
      00136A 0E                    5039 	.db #0x0e	;  14
      00136B 2C                    5040 	.db #0x2c	;  44
      00136C F3                    5041 	.db #0xf3	; -13
      00136D ED                    5042 	.db #0xed	; -19
      00136E 18                    5043 	.db #0x18	;  24
      00136F FA                    5044 	.db #0xfa	; -6
      001370 EA                    5045 	.db #0xea	; -22
      001371 FC                    5046 	.db #0xfc	; -4
      001372 05                    5047 	.db #0x05	;  5
      001373 FF                    5048 	.db #0xff	; -1
      001374 F4                    5049 	.db #0xf4	; -12
      001375 00                    5050 	.db #0x00	;  0
      001376 13                    5051 	.db #0x13	;  19
      001377 36                    5052 	.db #0x36	;  54	'6'
      001378 0A                    5053 	.db #0x0a	;  10
      001379 E9                    5054 	.db #0xe9	; -23
      00137A F6                    5055 	.db #0xf6	; -10
      00137B F8                    5056 	.db #0xf8	; -8
      00137C FB                    5057 	.db #0xfb	; -5
      00137D 09                    5058 	.db #0x09	;  9
      00137E 11                    5059 	.db #0x11	;  17
      00137F E7                    5060 	.db #0xe7	; -25
      001380 01                    5061 	.db #0x01	;  1
      001381 03                    5062 	.db #0x03	;  3
      001382 B7                    5063 	.db #0xb7	; -73
      001383 00                    5064 	.db #0x00	;  0
      001384 F5                    5065 	.db #0xf5	; -11
      001385 08                    5066 	.db #0x08	;  8
      001386 07                    5067 	.db #0x07	;  7
      001387 10                    5068 	.db #0x10	;  16
      001388 F5                    5069 	.db #0xf5	; -11
      001389 00                    5070 	.db #0x00	;  0
      00138A FB                    5071 	.db #0xfb	; -5
      00138B 18                    5072 	.db #0x18	;  24
      00138C F2                    5073 	.db #0xf2	; -14
      00138D 04                    5074 	.db #0x04	;  4
      00138E 04                    5075 	.db #0x04	;  4
      00138F F4                    5076 	.db #0xf4	; -12
      001390 F4                    5077 	.db #0xf4	; -12
      001391 FB                    5078 	.db #0xfb	; -5
      001392 F6                    5079 	.db #0xf6	; -10
      001393 04                    5080 	.db #0x04	;  4
      001394 11                    5081 	.db #0x11	;  17
      001395 00                    5082 	.db #0x00	;  0
      001396 FD                    5083 	.db #0xfd	; -3
      001397 26                    5084 	.db #0x26	;  38
      001398 0C                    5085 	.db #0x0c	;  12
      001399 F2                    5086 	.db #0xf2	; -14
      00139A EB                    5087 	.db #0xeb	; -21
      00139B 14                    5088 	.db #0x14	;  20
      00139C D8                    5089 	.db #0xd8	; -40
      00139D F8                    5090 	.db #0xf8	; -8
      00139E 1F                    5091 	.db #0x1f	;  31
      00139F F8                    5092 	.db #0xf8	; -8
      0013A0 FB                    5093 	.db #0xfb	; -5
      0013A1 04                    5094 	.db #0x04	;  4
      0013A2 D8                    5095 	.db #0xd8	; -40
      0013A3 00                    5096 	.db #0x00	;  0
      0013A4 EF                    5097 	.db #0xef	; -17
      0013A5 03                    5098 	.db #0x03	;  3
      0013A6 0F                    5099 	.db #0x0f	;  15
      0013A7 15                    5100 	.db #0x15	;  21
      0013A8 F1                    5101 	.db #0xf1	; -15
      0013A9 00                    5102 	.db #0x00	;  0
      0013AA 06                    5103 	.db #0x06	;  6
      0013AB 08                    5104 	.db #0x08	;  8
      0013AC F7                    5105 	.db #0xf7	; -9
      0013AD 0C                    5106 	.db #0x0c	;  12
      0013AE D4                    5107 	.db #0xd4	; -44
      0013AF EF                    5108 	.db #0xef	; -17
      0013B0 0B                    5109 	.db #0x0b	;  11
      0013B1 09                    5110 	.db #0x09	;  9
      0013B2 05                    5111 	.db #0x05	;  5
      0013B3 07                    5112 	.db #0x07	;  7
      0013B4 0A                    5113 	.db #0x0a	;  10
      0013B5 00                    5114 	.db #0x00	;  0
      0013B6 F2                    5115 	.db #0xf2	; -14
      0013B7 13                    5116 	.db #0x13	;  19
      0013B8 09                    5117 	.db #0x09	;  9
      0013B9 F8                    5118 	.db #0xf8	; -8
      0013BA E4                    5119 	.db #0xe4	; -28
      0013BB 0B                    5120 	.db #0x0b	;  11
      0013BC E2                    5121 	.db #0xe2	; -30
      0013BD 0E                    5122 	.db #0x0e	;  14
      0013BE 18                    5123 	.db #0x18	;  24
      0013BF 1B                    5124 	.db #0x1b	;  27
      0013C0 F4                    5125 	.db #0xf4	; -12
      0013C1 16                    5126 	.db #0x16	;  22
      0013C2 EE                    5127 	.db #0xee	; -18
      0013C3 00                    5128 	.db #0x00	;  0
      0013C4 07                    5129 	.db #0x07	;  7
      0013C5 F0                    5130 	.db #0xf0	; -16
      0013C6 FE                    5131 	.db #0xfe	; -2
      0013C7 08                    5132 	.db #0x08	;  8
      0013C8 EF                    5133 	.db #0xef	; -17
      0013C9 00                    5134 	.db #0x00	;  0
      0013CA 03                    5135 	.db #0x03	;  3
      0013CB ED                    5136 	.db #0xed	; -19
      0013CC FC                    5137 	.db #0xfc	; -4
      0013CD 0C                    5138 	.db #0x0c	;  12
      0013CE E7                    5139 	.db #0xe7	; -25
      0013CF F4                    5140 	.db #0xf4	; -12
      0013D0 01                    5141 	.db #0x01	;  1
      0013D1 0C                    5142 	.db #0x0c	;  12
      0013D2 04                    5143 	.db #0x04	;  4
      0013D3 09                    5144 	.db #0x09	;  9
      0013D4 0D                    5145 	.db #0x0d	;  13
      0013D5 00                    5146 	.db #0x00	;  0
      0013D6 ED                    5147 	.db #0xed	; -19
      0013D7 17                    5148 	.db #0x17	;  23
      0013D8 F9                    5149 	.db #0xf9	; -7
      0013D9 F6                    5150 	.db #0xf6	; -10
      0013DA DA                    5151 	.db #0xda	; -38
      0013DB 08                    5152 	.db #0x08	;  8
      0013DC FD                    5153 	.db #0xfd	; -3
      0013DD F8                    5154 	.db #0xf8	; -8
      0013DE 0F                    5155 	.db #0x0f	;  15
      0013DF 0D                    5156 	.db #0x0d	;  13
      0013E0 F9                    5157 	.db #0xf9	; -7
      0013E1 0C                    5158 	.db #0x0c	;  12
      0013E2 04                    5159 	.db #0x04	;  4
      0013E3 00                    5160 	.db #0x00	;  0
      0013E4 F9                    5161 	.db #0xf9	; -7
      0013E5 F0                    5162 	.db #0xf0	; -16
      0013E6 08                    5163 	.db #0x08	;  8
      0013E7 0C                    5164 	.db #0x0c	;  12
      0013E8 F7                    5165 	.db #0xf7	; -9
      0013E9 00                    5166 	.db #0x00	;  0
      0013EA FF                    5167 	.db #0xff	; -1
      0013EB F0                    5168 	.db #0xf0	; -16
      0013EC 09                    5169 	.db #0x09	;  9
      0013ED 0B                    5170 	.db #0x0b	;  11
      0013EE F5                    5171 	.db #0xf5	; -11
      0013EF 00                    5172 	.db #0x00	;  0
      0013F0 0B                    5173 	.db #0x0b	;  11
      0013F1 04                    5174 	.db #0x04	;  4
      0013F2 FC                    5175 	.db #0xfc	; -4
      0013F3 FE                    5176 	.db #0xfe	; -2
      0013F4 FA                    5177 	.db #0xfa	; -6
      0013F5 00                    5178 	.db #0x00	;  0
      0013F6 00                    5179 	.db #0x00	;  0
      0013F7 0D                    5180 	.db #0x0d	;  13
      0013F8 F8                    5181 	.db #0xf8	; -8
      0013F9 07                    5182 	.db #0x07	;  7
      0013FA F8                    5183 	.db #0xf8	; -8
      0013FB 10                    5184 	.db #0x10	;  16
      0013FC FC                    5185 	.db #0xfc	; -4
      0013FD 00                    5186 	.db #0x00	;  0
      0013FE FA                    5187 	.db #0xfa	; -6
      0013FF 00                    5188 	.db #0x00	;  0
      001400 FF                    5189 	.db #0xff	; -1
      001401 00                    5190 	.db #0x00	;  0
      001402 01                    5191 	.db #0x01	;  1
      001403 00                    5192 	.db #0x00	;  0
      001404 00                    5193 	.db #0x00	;  0
      001405 02                    5194 	.db #0x02	;  2
      001406 01                    5195 	.db #0x01	;  1
      001407 00                    5196 	.db #0x00	;  0
      001408 FD                    5197 	.db #0xfd	; -3
      001409 00                    5198 	.db #0x00	;  0
      00140A 00                    5199 	.db #0x00	;  0
      00140B FB                    5200 	.db #0xfb	; -5
      00140C 03                    5201 	.db #0x03	;  3
      00140D 00                    5202 	.db #0x00	;  0
      00140E 00                    5203 	.db #0x00	;  0
      00140F 00                    5204 	.db #0x00	;  0
      001410 02                    5205 	.db #0x02	;  2
      001411 04                    5206 	.db #0x04	;  4
      001412 00                    5207 	.db #0x00	;  0
      001413 00                    5208 	.db #0x00	;  0
      001414 FE                    5209 	.db #0xfe	; -2
      001415 00                    5210 	.db #0x00	;  0
      001416 00                    5211 	.db #0x00	;  0
      001417 06                    5212 	.db #0x06	;  6
      001418 FC                    5213 	.db #0xfc	; -4
      001419 05                    5214 	.db #0x05	;  5
      00141A 00                    5215 	.db #0x00	;  0
      00141B 01                    5216 	.db #0x01	;  1
      00141C 00                    5217 	.db #0x00	;  0
      00141D 00                    5218 	.db #0x00	;  0
      00141E 00                    5219 	.db #0x00	;  0
      00141F 00                    5220 	.db #0x00	;  0
      001420 00                    5221 	.db #0x00	;  0
      001421 00                    5222 	.db #0x00	;  0
      001422 00                    5223 	.db #0x00	;  0
      001423 00                    5224 	.db #0x00	;  0
      001424 00                    5225 	.db #0x00	;  0
      001425 00                    5226 	.db #0x00	;  0
      001426 00                    5227 	.db #0x00	;  0
      001427 00                    5228 	.db #0x00	;  0
      001428 00                    5229 	.db #0x00	;  0
      001429 00                    5230 	.db #0x00	;  0
      00142A 00                    5231 	.db #0x00	;  0
      00142B 00                    5232 	.db #0x00	;  0
      00142C 00                    5233 	.db #0x00	;  0
      00142D 00                    5234 	.db #0x00	;  0
      00142E 00                    5235 	.db #0x00	;  0
      00142F 00                    5236 	.db #0x00	;  0
      001430 00                    5237 	.db #0x00	;  0
      001431 00                    5238 	.db #0x00	;  0
      001432 00                    5239 	.db #0x00	;  0
      001433 00                    5240 	.db #0x00	;  0
      001434 00                    5241 	.db #0x00	;  0
      001435 00                    5242 	.db #0x00	;  0
      001436 00                    5243 	.db #0x00	;  0
      001437 00                    5244 	.db #0x00	;  0
      001438 00                    5245 	.db #0x00	;  0
      001439 00                    5246 	.db #0x00	;  0
      00143A 00                    5247 	.db #0x00	;  0
      00143B 00                    5248 	.db #0x00	;  0
      00143C 00                    5249 	.db #0x00	;  0
      00143D 00                    5250 	.db #0x00	;  0
      00143E 02                    5251 	.db #0x02	;  2
      00143F 03                    5252 	.db #0x03	;  3
      001440 F7                    5253 	.db #0xf7	; -9
      001441 03                    5254 	.db #0x03	;  3
      001442 FD                    5255 	.db #0xfd	; -3
      001443 00                    5256 	.db #0x00	;  0
      001444 01                    5257 	.db #0x01	;  1
      001445 01                    5258 	.db #0x01	;  1
      001446 00                    5259 	.db #0x00	;  0
      001447 0D                    5260 	.db #0x0d	;  13
      001448 00                    5261 	.db #0x00	;  0
      001449 00                    5262 	.db #0x00	;  0
      00144A FD                    5263 	.db #0xfd	; -3
      00144B 01                    5264 	.db #0x01	;  1
      00144C 03                    5265 	.db #0x03	;  3
      00144D 01                    5266 	.db #0x01	;  1
      00144E 03                    5267 	.db #0x03	;  3
      00144F 08                    5268 	.db #0x08	;  8
      001450 00                    5269 	.db #0x00	;  0
      001451 F8                    5270 	.db #0xf8	; -8
      001452 FD                    5271 	.db #0xfd	; -3
      001453 01                    5272 	.db #0x01	;  1
      001454 FE                    5273 	.db #0xfe	; -2
      001455 00                    5274 	.db #0x00	;  0
      001456 F9                    5275 	.db #0xf9	; -7
      001457 0D                    5276 	.db #0x0d	;  13
      001458 F9                    5277 	.db #0xf9	; -7
      001459 01                    5278 	.db #0x01	;  1
      00145A F9                    5279 	.db #0xf9	; -7
      00145B 0B                    5280 	.db #0x0b	;  11
      00145C F9                    5281 	.db #0xf9	; -7
      00145D F8                    5282 	.db #0xf8	; -8
      00145E F8                    5283 	.db #0xf8	; -8
      00145F F4                    5284 	.db #0xf4	; -12
      001460 F1                    5285 	.db #0xf1	; -15
      001461 FD                    5286 	.db #0xfd	; -3
      001462 E9                    5287 	.db #0xe9	; -23
      001463 00                    5288 	.db #0x00	;  0
      001464 FF                    5289 	.db #0xff	; -1
      001465 0E                    5290 	.db #0x0e	;  14
      001466 11                    5291 	.db #0x11	;  17
      001467 1B                    5292 	.db #0x1b	;  27
      001468 FA                    5293 	.db #0xfa	; -6
      001469 00                    5294 	.db #0x00	;  0
      00146A ED                    5295 	.db #0xed	; -19
      00146B FF                    5296 	.db #0xff	; -1
      00146C FC                    5297 	.db #0xfc	; -4
      00146D F6                    5298 	.db #0xf6	; -10
      00146E 07                    5299 	.db #0x07	;  7
      00146F FF                    5300 	.db #0xff	; -1
      001470 19                    5301 	.db #0x19	;  25
      001471 F8                    5302 	.db #0xf8	; -8
      001472 DD                    5303 	.db #0xdd	; -35
      001473 FE                    5304 	.db #0xfe	; -2
      001474 1A                    5305 	.db #0x1a	;  26
      001475 00                    5306 	.db #0x00	;  0
      001476 EB                    5307 	.db #0xeb	; -21
      001477 24                    5308 	.db #0x24	;  36
      001478 FD                    5309 	.db #0xfd	; -3
      001479 01                    5310 	.db #0x01	;  1
      00147A EE                    5311 	.db #0xee	; -18
      00147B FD                    5312 	.db #0xfd	; -3
      00147C E8                    5313 	.db #0xe8	; -24
      00147D EE                    5314 	.db #0xee	; -18
      00147E 0E                    5315 	.db #0x0e	;  14
      00147F EE                    5316 	.db #0xee	; -18
      001480 F1                    5317 	.db #0xf1	; -15
      001481 FA                    5318 	.db #0xfa	; -6
      001482 0D                    5319 	.db #0x0d	;  13
      001483 00                    5320 	.db #0x00	;  0
      001484 0E                    5321 	.db #0x0e	;  14
      001485 12                    5322 	.db #0x12	;  18
      001486 F3                    5323 	.db #0xf3	; -13
      001487 1B                    5324 	.db #0x1b	;  27
      001488 F8                    5325 	.db #0xf8	; -8
      001489 00                    5326 	.db #0x00	;  0
      00148A AA                    5327 	.db #0xaa	; -86
      00148B E1                    5328 	.db #0xe1	; -31
      00148C FE                    5329 	.db #0xfe	; -2
      00148D 0A                    5330 	.db #0x0a	;  10
      00148E 13                    5331 	.db #0x13	;  19
      00148F FA                    5332 	.db #0xfa	; -6
      001490 1D                    5333 	.db #0x1d	;  29
      001491 F3                    5334 	.db #0xf3	; -13
      001492 C3                    5335 	.db #0xc3	; -61
      001493 FF                    5336 	.db #0xff	; -1
      001494 10                    5337 	.db #0x10	;  16
      001495 00                    5338 	.db #0x00	;  0
      001496 F7                    5339 	.db #0xf7	; -9
      001497 12                    5340 	.db #0x12	;  18
      001498 0A                    5341 	.db #0x0a	;  10
      001499 0F                    5342 	.db #0x0f	;  15
      00149A 08                    5343 	.db #0x08	;  8
      00149B F5                    5344 	.db #0xf5	; -11
      00149C F3                    5345 	.db #0xf3	; -13
      00149D F5                    5346 	.db #0xf5	; -11
      00149E 19                    5347 	.db #0x19	;  25
      00149F EC                    5348 	.db #0xec	; -20
      0014A0 FA                    5349 	.db #0xfa	; -6
      0014A1 FC                    5350 	.db #0xfc	; -4
      0014A2 12                    5351 	.db #0x12	;  18
      0014A3 00                    5352 	.db #0x00	;  0
      0014A4 F9                    5353 	.db #0xf9	; -7
      0014A5 17                    5354 	.db #0x17	;  23
      0014A6 0E                    5355 	.db #0x0e	;  14
      0014A7 24                    5356 	.db #0x24	;  36
      0014A8 F6                    5357 	.db #0xf6	; -10
      0014A9 00                    5358 	.db #0x00	;  0
      0014AA A3                    5359 	.db #0xa3	; -93
      0014AB F9                    5360 	.db #0xf9	; -7
      0014AC FA                    5361 	.db #0xfa	; -6
      0014AD FC                    5362 	.db #0xfc	; -4
      0014AE 0B                    5363 	.db #0x0b	;  11
      0014AF F8                    5364 	.db #0xf8	; -8
      0014B0 44                    5365 	.db #0x44	;  68	'D'
      0014B1 EC                    5366 	.db #0xec	; -20
      0014B2 BA                    5367 	.db #0xba	; -70
      0014B3 06                    5368 	.db #0x06	;  6
      0014B4 F6                    5369 	.db #0xf6	; -10
      0014B5 00                    5370 	.db #0x00	;  0
      0014B6 E6                    5371 	.db #0xe6	; -26
      0014B7 0D                    5372 	.db #0x0d	;  13
      0014B8 0E                    5373 	.db #0x0e	;  14
      0014B9 08                    5374 	.db #0x08	;  8
      0014BA FA                    5375 	.db #0xfa	; -6
      0014BB FE                    5376 	.db #0xfe	; -2
      0014BC 07                    5377 	.db #0x07	;  7
      0014BD 22                    5378 	.db #0x22	;  34
      0014BE 07                    5379 	.db #0x07	;  7
      0014BF ED                    5380 	.db #0xed	; -19
      0014C0 03                    5381 	.db #0x03	;  3
      0014C1 EB                    5382 	.db #0xeb	; -21
      0014C2 17                    5383 	.db #0x17	;  23
      0014C3 00                    5384 	.db #0x00	;  0
      0014C4 DE                    5385 	.db #0xde	; -34
      0014C5 FF                    5386 	.db #0xff	; -1
      0014C6 33                    5387 	.db #0x33	;  51	'3'
      0014C7 08                    5388 	.db #0x08	;  8
      0014C8 FC                    5389 	.db #0xfc	; -4
      0014C9 00                    5390 	.db #0x00	;  0
      0014CA 96                    5391 	.db #0x96	; -106
      0014CB FE                    5392 	.db #0xfe	; -2
      0014CC E3                    5393 	.db #0xe3	; -29
      0014CD F8                    5394 	.db #0xf8	; -8
      0014CE FA                    5395 	.db #0xfa	; -6
      0014CF E5                    5396 	.db #0xe5	; -27
      0014D0 E2                    5397 	.db #0xe2	; -30
      0014D1 E5                    5398 	.db #0xe5	; -27
      0014D2 E8                    5399 	.db #0xe8	; -24
      0014D3 11                    5400 	.db #0x11	;  17
      0014D4 FB                    5401 	.db #0xfb	; -5
      0014D5 00                    5402 	.db #0x00	;  0
      0014D6 F0                    5403 	.db #0xf0	; -16
      0014D7 0A                    5404 	.db #0x0a	;  10
      0014D8 03                    5405 	.db #0x03	;  3
      0014D9 08                    5406 	.db #0x08	;  8
      0014DA FA                    5407 	.db #0xfa	; -6
      0014DB FE                    5408 	.db #0xfe	; -2
      0014DC 26                    5409 	.db #0x26	;  38
      0014DD 03                    5410 	.db #0x03	;  3
      0014DE E3                    5411 	.db #0xe3	; -29
      0014DF FD                    5412 	.db #0xfd	; -3
      0014E0 F3                    5413 	.db #0xf3	; -13
      0014E1 FC                    5414 	.db #0xfc	; -4
      0014E2 2C                    5415 	.db #0x2c	;  44
      0014E3 00                    5416 	.db #0x00	;  0
      0014E4 C6                    5417 	.db #0xc6	; -58
      0014E5 06                    5418 	.db #0x06	;  6
      0014E6 12                    5419 	.db #0x12	;  18
      0014E7 16                    5420 	.db #0x16	;  22
      0014E8 0D                    5421 	.db #0x0d	;  13
      0014E9 00                    5422 	.db #0x00	;  0
      0014EA A5                    5423 	.db #0xa5	; -91
      0014EB F8                    5424 	.db #0xf8	; -8
      0014EC F1                    5425 	.db #0xf1	; -15
      0014ED 09                    5426 	.db #0x09	;  9
      0014EE E1                    5427 	.db #0xe1	; -31
      0014EF F5                    5428 	.db #0xf5	; -11
      0014F0 BC                    5429 	.db #0xbc	; -68
      0014F1 06                    5430 	.db #0x06	;  6
      0014F2 03                    5431 	.db #0x03	;  3
      0014F3 09                    5432 	.db #0x09	;  9
      0014F4 22                    5433 	.db #0x22	;  34
      0014F5 00                    5434 	.db #0x00	;  0
      0014F6 12                    5435 	.db #0x12	;  18
      0014F7 FA                    5436 	.db #0xfa	; -6
      0014F8 05                    5437 	.db #0x05	;  5
      0014F9 08                    5438 	.db #0x08	;  8
      0014FA 07                    5439 	.db #0x07	;  7
      0014FB 13                    5440 	.db #0x13	;  19
      0014FC FE                    5441 	.db #0xfe	; -2
      0014FD EB                    5442 	.db #0xeb	; -21
      0014FE E0                    5443 	.db #0xe0	; -32
      0014FF CF                    5444 	.db #0xcf	; -49
      001500 0C                    5445 	.db #0x0c	;  12
      001501 F6                    5446 	.db #0xf6	; -10
      001502 D2                    5447 	.db #0xd2	; -46
      001503 00                    5448 	.db #0x00	;  0
      001504 F5                    5449 	.db #0xf5	; -11
      001505 05                    5450 	.db #0x05	;  5
      001506 FB                    5451 	.db #0xfb	; -5
      001507 F2                    5452 	.db #0xf2	; -14
      001508 EF                    5453 	.db #0xef	; -17
      001509 00                    5454 	.db #0x00	;  0
      00150A CB                    5455 	.db #0xcb	; -53
      00150B 28                    5456 	.db #0x28	;  40
      00150C 18                    5457 	.db #0x18	;  24
      00150D 12                    5458 	.db #0x12	;  18
      00150E 26                    5459 	.db #0x26	;  38
      00150F 0B                    5460 	.db #0x0b	;  11
      001510 E8                    5461 	.db #0xe8	; -24
      001511 09                    5462 	.db #0x09	;  9
      001512 F9                    5463 	.db #0xf9	; -7
      001513 EE                    5464 	.db #0xee	; -18
      001514 0F                    5465 	.db #0x0f	;  15
      001515 00                    5466 	.db #0x00	;  0
      001516 06                    5467 	.db #0x06	;  6
      001517 29                    5468 	.db #0x29	;  41
      001518 FE                    5469 	.db #0xfe	; -2
      001519 0C                    5470 	.db #0x0c	;  12
      00151A 08                    5471 	.db #0x08	;  8
      00151B 06                    5472 	.db #0x06	;  6
      00151C 02                    5473 	.db #0x02	;  2
      00151D 05                    5474 	.db #0x05	;  5
      00151E 21                    5475 	.db #0x21	;  33
      00151F ED                    5476 	.db #0xed	; -19
      001520 FC                    5477 	.db #0xfc	; -4
      001521 0D                    5478 	.db #0x0d	;  13
      001522 E0                    5479 	.db #0xe0	; -32
      001523 00                    5480 	.db #0x00	;  0
      001524 F1                    5481 	.db #0xf1	; -15
      001525 F7                    5482 	.db #0xf7	; -9
      001526 F9                    5483 	.db #0xf9	; -7
      001527 EF                    5484 	.db #0xef	; -17
      001528 FB                    5485 	.db #0xfb	; -5
      001529 00                    5486 	.db #0x00	;  0
      00152A F8                    5487 	.db #0xf8	; -8
      00152B F3                    5488 	.db #0xf3	; -13
      00152C 0A                    5489 	.db #0x0a	;  10
      00152D FC                    5490 	.db #0xfc	; -4
      00152E 2C                    5491 	.db #0x2c	;  44
      00152F 02                    5492 	.db #0x02	;  2
      001530 E5                    5493 	.db #0xe5	; -27
      001531 EE                    5494 	.db #0xee	; -18
      001532 00                    5495 	.db #0x00	;  0
      001533 00                    5496 	.db #0x00	;  0
      001534 FE                    5497 	.db #0xfe	; -2
      001535 00                    5498 	.db #0x00	;  0
      001536 F0                    5499 	.db #0xf0	; -16
      001537 29                    5500 	.db #0x29	;  41
      001538 00                    5501 	.db #0x00	;  0
      001539 00                    5502 	.db #0x00	;  0
      00153A F1                    5503 	.db #0xf1	; -15
      00153B 0B                    5504 	.db #0x0b	;  11
      00153C FD                    5505 	.db #0xfd	; -3
      00153D 09                    5506 	.db #0x09	;  9
      00153E 20                    5507 	.db #0x20	;  32
      00153F 22                    5508 	.db #0x22	;  34
      001540 F5                    5509 	.db #0xf5	; -11
      001541 01                    5510 	.db #0x01	;  1
      001542 FE                    5511 	.db #0xfe	; -2
      001543 00                    5512 	.db #0x00	;  0
      001544 F3                    5513 	.db #0xf3	; -13
      001545 ED                    5514 	.db #0xed	; -19
      001546 F4                    5515 	.db #0xf4	; -12
      001547 07                    5516 	.db #0x07	;  7
      001548 02                    5517 	.db #0x02	;  2
      001549 00                    5518 	.db #0x00	;  0
      00154A FC                    5519 	.db #0xfc	; -4
      00154B E9                    5520 	.db #0xe9	; -23
      00154C 0A                    5521 	.db #0x0a	;  10
      00154D FE                    5522 	.db #0xfe	; -2
      00154E F5                    5523 	.db #0xf5	; -11
      00154F 06                    5524 	.db #0x06	;  6
      001550 E9                    5525 	.db #0xe9	; -23
      001551 11                    5526 	.db #0x11	;  17
      001552 03                    5527 	.db #0x03	;  3
      001553 0C                    5528 	.db #0x0c	;  12
      001554 F7                    5529 	.db #0xf7	; -9
      001555 00                    5530 	.db #0x00	;  0
      001556 F4                    5531 	.db #0xf4	; -12
      001557 0D                    5532 	.db #0x0d	;  13
      001558 0A                    5533 	.db #0x0a	;  10
      001559 F7                    5534 	.db #0xf7	; -9
      00155A E4                    5535 	.db #0xe4	; -28
      00155B 06                    5536 	.db #0x06	;  6
      00155C F3                    5537 	.db #0xf3	; -13
      00155D 12                    5538 	.db #0x12	;  18
      00155E 17                    5539 	.db #0x17	;  23
      00155F 32                    5540 	.db #0x32	;  50	'2'
      001560 F9                    5541 	.db #0xf9	; -7
      001561 06                    5542 	.db #0x06	;  6
      001562 19                    5543 	.db #0x19	;  25
      001563 00                    5544 	.db #0x00	;  0
      001564 01                    5545 	.db #0x01	;  1
      001565 FA                    5546 	.db #0xfa	; -6
      001566 F4                    5547 	.db #0xf4	; -12
      001567 F8                    5548 	.db #0xf8	; -8
      001568 E0                    5549 	.db #0xe0	; -32
      001569 00                    5550 	.db #0x00	;  0
      00156A 02                    5551 	.db #0x02	;  2
      00156B EF                    5552 	.db #0xef	; -17
      00156C 05                    5553 	.db #0x05	;  5
      00156D FF                    5554 	.db #0xff	; -1
      00156E C5                    5555 	.db #0xc5	; -59
      00156F 05                    5556 	.db #0x05	;  5
      001570 FC                    5557 	.db #0xfc	; -4
      001571 06                    5558 	.db #0x06	;  6
      001572 04                    5559 	.db #0x04	;  4
      001573 01                    5560 	.db #0x01	;  1
      001574 FE                    5561 	.db #0xfe	; -2
      001575 00                    5562 	.db #0x00	;  0
      001576 F3                    5563 	.db #0xf3	; -13
      001577 0C                    5564 	.db #0x0c	;  12
      001578 08                    5565 	.db #0x08	;  8
      001579 F3                    5566 	.db #0xf3	; -13
      00157A D1                    5567 	.db #0xd1	; -47
      00157B F7                    5568 	.db #0xf7	; -9
      00157C F2                    5569 	.db #0xf2	; -14
      00157D F9                    5570 	.db #0xf9	; -7
      00157E FA                    5571 	.db #0xfa	; -6
      00157F 28                    5572 	.db #0x28	;  40
      001580 F5                    5573 	.db #0xf5	; -11
      001581 F7                    5574 	.db #0xf7	; -9
      001582 0E                    5575 	.db #0x0e	;  14
      001583 00                    5576 	.db #0x00	;  0
      001584 F1                    5577 	.db #0xf1	; -15
      001585 EE                    5578 	.db #0xee	; -18
      001586 07                    5579 	.db #0x07	;  7
      001587 04                    5580 	.db #0x04	;  4
      001588 E5                    5581 	.db #0xe5	; -27
      001589 00                    5582 	.db #0x00	;  0
      00158A ED                    5583 	.db #0xed	; -19
      00158B EF                    5584 	.db #0xef	; -17
      00158C 06                    5585 	.db #0x06	;  6
      00158D 02                    5586 	.db #0x02	;  2
      00158E E0                    5587 	.db #0xe0	; -32
      00158F F5                    5588 	.db #0xf5	; -11
      001590 FE                    5589 	.db #0xfe	; -2
      001591 09                    5590 	.db #0x09	;  9
      001592 F2                    5591 	.db #0xf2	; -14
      001593 ED                    5592 	.db #0xed	; -19
      001594 FF                    5593 	.db #0xff	; -1
      001595 00                    5594 	.db #0x00	;  0
      001596 E7                    5595 	.db #0xe7	; -25
      001597 17                    5596 	.db #0x17	;  23
      001598 00                    5597 	.db #0x00	;  0
      001599 FC                    5598 	.db #0xfc	; -4
      00159A DF                    5599 	.db #0xdf	; -33
      00159B 04                    5600 	.db #0x04	;  4
      00159C F9                    5601 	.db #0xf9	; -7
      00159D FC                    5602 	.db #0xfc	; -4
      00159E F9                    5603 	.db #0xf9	; -7
      00159F 0B                    5604 	.db #0x0b	;  11
      0015A0 FE                    5605 	.db #0xfe	; -2
      0015A1 01                    5606 	.db #0x01	;  1
      0015A2 11                    5607 	.db #0x11	;  17
      0015A3 00                    5608 	.db #0x00	;  0
      0015A4 01                    5609 	.db #0x01	;  1
      0015A5 FE                    5610 	.db #0xfe	; -2
      0015A6 03                    5611 	.db #0x03	;  3
      0015A7 07                    5612 	.db #0x07	;  7
      0015A8 FF                    5613 	.db #0xff	; -1
      0015A9 00                    5614 	.db #0x00	;  0
      0015AA F9                    5615 	.db #0xf9	; -7
      0015AB FB                    5616 	.db #0xfb	; -5
      0015AC 13                    5617 	.db #0x13	;  19
      0015AD FB                    5618 	.db #0xfb	; -5
      0015AE FD                    5619 	.db #0xfd	; -3
      0015AF FE                    5620 	.db #0xfe	; -2
      0015B0 F5                    5621 	.db #0xf5	; -11
      0015B1 01                    5622 	.db #0x01	;  1
      0015B2 FF                    5623 	.db #0xff	; -1
      0015B3 F8                    5624 	.db #0xf8	; -8
      0015B4 F8                    5625 	.db #0xf8	; -8
      0015B5 00                    5626 	.db #0x00	;  0
      0015B6 FF                    5627 	.db #0xff	; -1
      0015B7 16                    5628 	.db #0x16	;  22
      0015B8 0E                    5629 	.db #0x0e	;  14
      0015B9 02                    5630 	.db #0x02	;  2
      0015BA 02                    5631 	.db #0x02	;  2
      0015BB 0E                    5632 	.db #0x0e	;  14
      0015BC FA                    5633 	.db #0xfa	; -6
      0015BD 01                    5634 	.db #0x01	;  1
      0015BE FE                    5635 	.db #0xfe	; -2
      0015BF FF                    5636 	.db #0xff	; -1
      0015C0 00                    5637 	.db #0x00	;  0
      0015C1 02                    5638 	.db #0x02	;  2
      0015C2 03                    5639 	.db #0x03	;  3
      0015C3 00                    5640 	.db #0x00	;  0
      0015C4 00                    5641 	.db #0x00	;  0
      0015C5 00                    5642 	.db #0x00	;  0
      0015C6 FE                    5643 	.db #0xfe	; -2
      0015C7 FE                    5644 	.db #0xfe	; -2
      0015C8 FD                    5645 	.db #0xfd	; -3
      0015C9 00                    5646 	.db #0x00	;  0
      0015CA 00                    5647 	.db #0x00	;  0
      0015CB 00                    5648 	.db #0x00	;  0
      0015CC 00                    5649 	.db #0x00	;  0
      0015CD 00                    5650 	.db #0x00	;  0
      0015CE FE                    5651 	.db #0xfe	; -2
      0015CF 00                    5652 	.db #0x00	;  0
      0015D0 FF                    5653 	.db #0xff	; -1
      0015D1 02                    5654 	.db #0x02	;  2
      0015D2 01                    5655 	.db #0x01	;  1
      0015D3 04                    5656 	.db #0x04	;  4
      0015D4 01                    5657 	.db #0x01	;  1
      0015D5 00                    5658 	.db #0x00	;  0
      0015D6 00                    5659 	.db #0x00	;  0
      0015D7 02                    5660 	.db #0x02	;  2
      0015D8 FE                    5661 	.db #0xfe	; -2
      0015D9 02                    5662 	.db #0x02	;  2
      0015DA 02                    5663 	.db #0x02	;  2
      0015DB FF                    5664 	.db #0xff	; -1
      0015DC FF                    5665 	.db #0xff	; -1
      0015DD 00                    5666 	.db #0x00	;  0
      0015DE 00                    5667 	.db #0x00	;  0
      0015DF 00                    5668 	.db #0x00	;  0
      0015E0 00                    5669 	.db #0x00	;  0
      0015E1 00                    5670 	.db #0x00	;  0
      0015E2 00                    5671 	.db #0x00	;  0
      0015E3 00                    5672 	.db #0x00	;  0
      0015E4 00                    5673 	.db #0x00	;  0
      0015E5 00                    5674 	.db #0x00	;  0
      0015E6 00                    5675 	.db #0x00	;  0
      0015E7 00                    5676 	.db #0x00	;  0
      0015E8 00                    5677 	.db #0x00	;  0
      0015E9 00                    5678 	.db #0x00	;  0
      0015EA 00                    5679 	.db #0x00	;  0
      0015EB 00                    5680 	.db #0x00	;  0
      0015EC 00                    5681 	.db #0x00	;  0
      0015ED 00                    5682 	.db #0x00	;  0
      0015EE 00                    5683 	.db #0x00	;  0
      0015EF 00                    5684 	.db #0x00	;  0
      0015F0 00                    5685 	.db #0x00	;  0
      0015F1 00                    5686 	.db #0x00	;  0
      0015F2 00                    5687 	.db #0x00	;  0
      0015F3 00                    5688 	.db #0x00	;  0
      0015F4 00                    5689 	.db #0x00	;  0
      0015F5 00                    5690 	.db #0x00	;  0
      0015F6 00                    5691 	.db #0x00	;  0
      0015F7 00                    5692 	.db #0x00	;  0
      0015F8 00                    5693 	.db #0x00	;  0
      0015F9 00                    5694 	.db #0x00	;  0
      0015FA 00                    5695 	.db #0x00	;  0
      0015FB 00                    5696 	.db #0x00	;  0
      0015FC 00                    5697 	.db #0x00	;  0
      0015FD 01                    5698 	.db #0x01	;  1
      0015FE 01                    5699 	.db #0x01	;  1
      0015FF 08                    5700 	.db #0x08	;  8
      001600 02                    5701 	.db #0x02	;  2
      001601 04                    5702 	.db #0x04	;  4
      001602 01                    5703 	.db #0x01	;  1
      001603 00                    5704 	.db #0x00	;  0
      001604 F8                    5705 	.db #0xf8	; -8
      001605 FC                    5706 	.db #0xfc	; -4
      001606 0B                    5707 	.db #0x0b	;  11
      001607 F3                    5708 	.db #0xf3	; -13
      001608 F6                    5709 	.db #0xf6	; -10
      001609 00                    5710 	.db #0x00	;  0
      00160A 02                    5711 	.db #0x02	;  2
      00160B FE                    5712 	.db #0xfe	; -2
      00160C 04                    5713 	.db #0x04	;  4
      00160D FD                    5714 	.db #0xfd	; -3
      00160E F6                    5715 	.db #0xf6	; -10
      00160F 07                    5716 	.db #0x07	;  7
      001610 08                    5717 	.db #0x08	;  8
      001611 F7                    5718 	.db #0xf7	; -9
      001612 FA                    5719 	.db #0xfa	; -6
      001613 FC                    5720 	.db #0xfc	; -4
      001614 07                    5721 	.db #0x07	;  7
      001615 00                    5722 	.db #0x00	;  0
      001616 02                    5723 	.db #0x02	;  2
      001617 14                    5724 	.db #0x14	;  20
      001618 FA                    5725 	.db #0xfa	; -6
      001619 0F                    5726 	.db #0x0f	;  15
      00161A F3                    5727 	.db #0xf3	; -13
      00161B 05                    5728 	.db #0x05	;  5
      00161C FD                    5729 	.db #0xfd	; -3
      00161D 07                    5730 	.db #0x07	;  7
      00161E 08                    5731 	.db #0x08	;  8
      00161F E3                    5732 	.db #0xe3	; -29
      001620 FB                    5733 	.db #0xfb	; -5
      001621 EF                    5734 	.db #0xef	; -17
      001622 09                    5735 	.db #0x09	;  9
      001623 00                    5736 	.db #0x00	;  0
      001624 23                    5737 	.db #0x23	;  35
      001625 0A                    5738 	.db #0x0a	;  10
      001626 FF                    5739 	.db #0xff	; -1
      001627 07                    5740 	.db #0x07	;  7
      001628 EC                    5741 	.db #0xec	; -20
      001629 00                    5742 	.db #0x00	;  0
      00162A EF                    5743 	.db #0xef	; -17
      00162B F2                    5744 	.db #0xf2	; -14
      00162C 1F                    5745 	.db #0x1f	;  31
      00162D 0F                    5746 	.db #0x0f	;  15
      00162E 0A                    5747 	.db #0x0a	;  10
      00162F 09                    5748 	.db #0x09	;  9
      001630 1E                    5749 	.db #0x1e	;  30
      001631 F9                    5750 	.db #0xf9	; -7
      001632 ED                    5751 	.db #0xed	; -19
      001633 F4                    5752 	.db #0xf4	; -12
      001634 05                    5753 	.db #0x05	;  5
      001635 00                    5754 	.db #0x00	;  0
      001636 F5                    5755 	.db #0xf5	; -11
      001637 F9                    5756 	.db #0xf9	; -7
      001638 FF                    5757 	.db #0xff	; -1
      001639 03                    5758 	.db #0x03	;  3
      00163A DF                    5759 	.db #0xdf	; -33
      00163B FC                    5760 	.db #0xfc	; -4
      00163C FA                    5761 	.db #0xfa	; -6
      00163D FF                    5762 	.db #0xff	; -1
      00163E D9                    5763 	.db #0xd9	; -39
      00163F 00                    5764 	.db #0x00	;  0
      001640 0B                    5765 	.db #0x0b	;  11
      001641 FA                    5766 	.db #0xfa	; -6
      001642 09                    5767 	.db #0x09	;  9
      001643 00                    5768 	.db #0x00	;  0
      001644 27                    5769 	.db #0x27	;  39
      001645 EE                    5770 	.db #0xee	; -18
      001646 1C                    5771 	.db #0x1c	;  28
      001647 F7                    5772 	.db #0xf7	; -9
      001648 E5                    5773 	.db #0xe5	; -27
      001649 00                    5774 	.db #0x00	;  0
      00164A EF                    5775 	.db #0xef	; -17
      00164B EE                    5776 	.db #0xee	; -18
      00164C 0E                    5777 	.db #0x0e	;  14
      00164D 04                    5778 	.db #0x04	;  4
      00164E 24                    5779 	.db #0x24	;  36
      00164F 07                    5780 	.db #0x07	;  7
      001650 27                    5781 	.db #0x27	;  39
      001651 FB                    5782 	.db #0xfb	; -5
      001652 D1                    5783 	.db #0xd1	; -47
      001653 FD                    5784 	.db #0xfd	; -3
      001654 02                    5785 	.db #0x02	;  2
      001655 00                    5786 	.db #0x00	;  0
      001656 EF                    5787 	.db #0xef	; -17
      001657 06                    5788 	.db #0x06	;  6
      001658 FC                    5789 	.db #0xfc	; -4
      001659 FE                    5790 	.db #0xfe	; -2
      00165A 1D                    5791 	.db #0x1d	;  29
      00165B EE                    5792 	.db #0xee	; -18
      00165C D6                    5793 	.db #0xd6	; -42
      00165D F2                    5794 	.db #0xf2	; -14
      00165E EF                    5795 	.db #0xef	; -17
      00165F FC                    5796 	.db #0xfc	; -4
      001660 F7                    5797 	.db #0xf7	; -9
      001661 FD                    5798 	.db #0xfd	; -3
      001662 0B                    5799 	.db #0x0b	;  11
      001663 00                    5800 	.db #0x00	;  0
      001664 16                    5801 	.db #0x16	;  22
      001665 D5                    5802 	.db #0xd5	; -43
      001666 00                    5803 	.db #0x00	;  0
      001667 0E                    5804 	.db #0x0e	;  14
      001668 FD                    5805 	.db #0xfd	; -3
      001669 00                    5806 	.db #0x00	;  0
      00166A EE                    5807 	.db #0xee	; -18
      00166B E2                    5808 	.db #0xe2	; -30
      00166C 0E                    5809 	.db #0x0e	;  14
      00166D 01                    5810 	.db #0x01	;  1
      00166E 21                    5811 	.db #0x21	;  33
      00166F F5                    5812 	.db #0xf5	; -11
      001670 29                    5813 	.db #0x29	;  41
      001671 FA                    5814 	.db #0xfa	; -6
      001672 F3                    5815 	.db #0xf3	; -13
      001673 03                    5816 	.db #0x03	;  3
      001674 12                    5817 	.db #0x12	;  18
      001675 00                    5818 	.db #0x00	;  0
      001676 F2                    5819 	.db #0xf2	; -14
      001677 FE                    5820 	.db #0xfe	; -2
      001678 02                    5821 	.db #0x02	;  2
      001679 15                    5822 	.db #0x15	;  21
      00167A FB                    5823 	.db #0xfb	; -5
      00167B 05                    5824 	.db #0x05	;  5
      00167C 03                    5825 	.db #0x03	;  3
      00167D F7                    5826 	.db #0xf7	; -9
      00167E FB                    5827 	.db #0xfb	; -5
      00167F 06                    5828 	.db #0x06	;  6
      001680 EB                    5829 	.db #0xeb	; -21
      001681 EE                    5830 	.db #0xee	; -18
      001682 20                    5831 	.db #0x20	;  32
      001683 00                    5832 	.db #0x00	;  0
      001684 19                    5833 	.db #0x19	;  25
      001685 CD                    5834 	.db #0xcd	; -51
      001686 18                    5835 	.db #0x18	;  24
      001687 00                    5836 	.db #0x00	;  0
      001688 07                    5837 	.db #0x07	;  7
      001689 00                    5838 	.db #0x00	;  0
      00168A E7                    5839 	.db #0xe7	; -25
      00168B DE                    5840 	.db #0xde	; -34
      00168C 02                    5841 	.db #0x02	;  2
      00168D E9                    5842 	.db #0xe9	; -23
      00168E 13                    5843 	.db #0x13	;  19
      00168F F8                    5844 	.db #0xf8	; -8
      001690 ED                    5845 	.db #0xed	; -19
      001691 F9                    5846 	.db #0xf9	; -7
      001692 12                    5847 	.db #0x12	;  18
      001693 01                    5848 	.db #0x01	;  1
      001694 18                    5849 	.db #0x18	;  24
      001695 00                    5850 	.db #0x00	;  0
      001696 00                    5851 	.db #0x00	;  0
      001697 F8                    5852 	.db #0xf8	; -8
      001698 FF                    5853 	.db #0xff	; -1
      001699 12                    5854 	.db #0x12	;  18
      00169A F9                    5855 	.db #0xf9	; -7
      00169B 15                    5856 	.db #0x15	;  21
      00169C 09                    5857 	.db #0x09	;  9
      00169D FA                    5858 	.db #0xfa	; -6
      00169E E2                    5859 	.db #0xe2	; -30
      00169F 00                    5860 	.db #0x00	;  0
      0016A0 FC                    5861 	.db #0xfc	; -4
      0016A1 F8                    5862 	.db #0xf8	; -8
      0016A2 12                    5863 	.db #0x12	;  18
      0016A3 00                    5864 	.db #0x00	;  0
      0016A4 FC                    5865 	.db #0xfc	; -4
      0016A5 CF                    5866 	.db #0xcf	; -49
      0016A6 13                    5867 	.db #0x13	;  19
      0016A7 06                    5868 	.db #0x06	;  6
      0016A8 0A                    5869 	.db #0x0a	;  10
      0016A9 00                    5870 	.db #0x00	;  0
      0016AA 09                    5871 	.db #0x09	;  9
      0016AB 1B                    5872 	.db #0x1b	;  27
      0016AC 10                    5873 	.db #0x10	;  16
      0016AD F8                    5874 	.db #0xf8	; -8
      0016AE 16                    5875 	.db #0x16	;  22
      0016AF FE                    5876 	.db #0xfe	; -2
      0016B0 DB                    5877 	.db #0xdb	; -37
      0016B1 F7                    5878 	.db #0xf7	; -9
      0016B2 09                    5879 	.db #0x09	;  9
      0016B3 02                    5880 	.db #0x02	;  2
      0016B4 1C                    5881 	.db #0x1c	;  28
      0016B5 00                    5882 	.db #0x00	;  0
      0016B6 FB                    5883 	.db #0xfb	; -5
      0016B7 EB                    5884 	.db #0xeb	; -21
      0016B8 0A                    5885 	.db #0x0a	;  10
      0016B9 14                    5886 	.db #0x14	;  20
      0016BA FD                    5887 	.db #0xfd	; -3
      0016BB 1B                    5888 	.db #0x1b	;  27
      0016BC 07                    5889 	.db #0x07	;  7
      0016BD F8                    5890 	.db #0xf8	; -8
      0016BE 07                    5891 	.db #0x07	;  7
      0016BF 07                    5892 	.db #0x07	;  7
      0016C0 FB                    5893 	.db #0xfb	; -5
      0016C1 06                    5894 	.db #0x06	;  6
      0016C2 F5                    5895 	.db #0xf5	; -11
      0016C3 00                    5896 	.db #0x00	;  0
      0016C4 F6                    5897 	.db #0xf6	; -10
      0016C5 F5                    5898 	.db #0xf5	; -11
      0016C6 02                    5899 	.db #0x02	;  2
      0016C7 07                    5900 	.db #0x07	;  7
      0016C8 D4                    5901 	.db #0xd4	; -44
      0016C9 00                    5902 	.db #0x00	;  0
      0016CA F6                    5903 	.db #0xf6	; -10
      0016CB 11                    5904 	.db #0x11	;  17
      0016CC 15                    5905 	.db #0x15	;  21
      0016CD F2                    5906 	.db #0xf2	; -14
      0016CE 22                    5907 	.db #0x22	;  34
      0016CF 0F                    5908 	.db #0x0f	;  15
      0016D0 06                    5909 	.db #0x06	;  6
      0016D1 07                    5910 	.db #0x07	;  7
      0016D2 F6                    5911 	.db #0xf6	; -10
      0016D3 FC                    5912 	.db #0xfc	; -4
      0016D4 1A                    5913 	.db #0x1a	;  26
      0016D5 00                    5914 	.db #0x00	;  0
      0016D6 0D                    5915 	.db #0x0d	;  13
      0016D7 E4                    5916 	.db #0xe4	; -28
      0016D8 0B                    5917 	.db #0x0b	;  11
      0016D9 22                    5918 	.db #0x22	;  34
      0016DA F9                    5919 	.db #0xf9	; -7
      0016DB 16                    5920 	.db #0x16	;  22
      0016DC FE                    5921 	.db #0xfe	; -2
      0016DD 14                    5922 	.db #0x14	;  20
      0016DE 1A                    5923 	.db #0x1a	;  26
      0016DF 2B                    5924 	.db #0x2b	;  43
      0016E0 0D                    5925 	.db #0x0d	;  13
      0016E1 03                    5926 	.db #0x03	;  3
      0016E2 11                    5927 	.db #0x11	;  17
      0016E3 00                    5928 	.db #0x00	;  0
      0016E4 FD                    5929 	.db #0xfd	; -3
      0016E5 05                    5930 	.db #0x05	;  5
      0016E6 F1                    5931 	.db #0xf1	; -15
      0016E7 F3                    5932 	.db #0xf3	; -13
      0016E8 EE                    5933 	.db #0xee	; -18
      0016E9 00                    5934 	.db #0x00	;  0
      0016EA F2                    5935 	.db #0xf2	; -14
      0016EB EA                    5936 	.db #0xea	; -22
      0016EC 0B                    5937 	.db #0x0b	;  11
      0016ED FA                    5938 	.db #0xfa	; -6
      0016EE FF                    5939 	.db #0xff	; -1
      0016EF F7                    5940 	.db #0xf7	; -9
      0016F0 E6                    5941 	.db #0xe6	; -26
      0016F1 03                    5942 	.db #0x03	;  3
      0016F2 01                    5943 	.db #0x01	;  1
      0016F3 03                    5944 	.db #0x03	;  3
      0016F4 0D                    5945 	.db #0x0d	;  13
      0016F5 00                    5946 	.db #0x00	;  0
      0016F6 EB                    5947 	.db #0xeb	; -21
      0016F7 EA                    5948 	.db #0xea	; -22
      0016F8 0B                    5949 	.db #0x0b	;  11
      0016F9 0C                    5950 	.db #0x0c	;  12
      0016FA F2                    5951 	.db #0xf2	; -14
      0016FB FD                    5952 	.db #0xfd	; -3
      0016FC 11                    5953 	.db #0x11	;  17
      0016FD 00                    5954 	.db #0x00	;  0
      0016FE 05                    5955 	.db #0x05	;  5
      0016FF 32                    5956 	.db #0x32	;  50	'2'
      001700 03                    5957 	.db #0x03	;  3
      001701 0A                    5958 	.db #0x0a	;  10
      001702 11                    5959 	.db #0x11	;  17
      001703 00                    5960 	.db #0x00	;  0
      001704 06                    5961 	.db #0x06	;  6
      001705 11                    5962 	.db #0x11	;  17
      001706 FA                    5963 	.db #0xfa	; -6
      001707 F1                    5964 	.db #0xf1	; -15
      001708 EB                    5965 	.db #0xeb	; -21
      001709 00                    5966 	.db #0x00	;  0
      00170A EB                    5967 	.db #0xeb	; -21
      00170B EC                    5968 	.db #0xec	; -20
      00170C 04                    5969 	.db #0x04	;  4
      00170D F7                    5970 	.db #0xf7	; -9
      00170E C2                    5971 	.db #0xc2	; -62
      00170F F8                    5972 	.db #0xf8	; -8
      001710 E3                    5973 	.db #0xe3	; -29
      001711 FE                    5974 	.db #0xfe	; -2
      001712 0C                    5975 	.db #0x0c	;  12
      001713 F9                    5976 	.db #0xf9	; -7
      001714 0B                    5977 	.db #0x0b	;  11
      001715 00                    5978 	.db #0x00	;  0
      001716 FB                    5979 	.db #0xfb	; -5
      001717 02                    5980 	.db #0x02	;  2
      001718 05                    5981 	.db #0x05	;  5
      001719 F7                    5982 	.db #0xf7	; -9
      00171A E4                    5983 	.db #0xe4	; -28
      00171B EF                    5984 	.db #0xef	; -17
      00171C 13                    5985 	.db #0x13	;  19
      00171D 01                    5986 	.db #0x01	;  1
      00171E F4                    5987 	.db #0xf4	; -12
      00171F 27                    5988 	.db #0x27	;  39
      001720 00                    5989 	.db #0x00	;  0
      001721 FA                    5990 	.db #0xfa	; -6
      001722 29                    5991 	.db #0x29	;  41
      001723 00                    5992 	.db #0x00	;  0
      001724 F1                    5993 	.db #0xf1	; -15
      001725 05                    5994 	.db #0x05	;  5
      001726 E2                    5995 	.db #0xe2	; -30
      001727 FA                    5996 	.db #0xfa	; -6
      001728 DE                    5997 	.db #0xde	; -34
      001729 00                    5998 	.db #0x00	;  0
      00172A FB                    5999 	.db #0xfb	; -5
      00172B DA                    6000 	.db #0xda	; -38
      00172C 02                    6001 	.db #0x02	;  2
      00172D DE                    6002 	.db #0xde	; -34
      00172E DA                    6003 	.db #0xda	; -38
      00172F 0B                    6004 	.db #0x0b	;  11
      001730 F9                    6005 	.db #0xf9	; -7
      001731 00                    6006 	.db #0x00	;  0
      001732 01                    6007 	.db #0x01	;  1
      001733 F5                    6008 	.db #0xf5	; -11
      001734 06                    6009 	.db #0x06	;  6
      001735 00                    6010 	.db #0x00	;  0
      001736 FB                    6011 	.db #0xfb	; -5
      001737 0F                    6012 	.db #0x0f	;  15
      001738 05                    6013 	.db #0x05	;  5
      001739 F3                    6014 	.db #0xf3	; -13
      00173A D4                    6015 	.db #0xd4	; -44
      00173B F8                    6016 	.db #0xf8	; -8
      00173C F0                    6017 	.db #0xf0	; -16
      00173D F4                    6018 	.db #0xf4	; -12
      00173E F5                    6019 	.db #0xf5	; -11
      00173F 2C                    6020 	.db #0x2c	;  44
      001740 F4                    6021 	.db #0xf4	; -12
      001741 F7                    6022 	.db #0xf7	; -9
      001742 24                    6023 	.db #0x24	;  36
      001743 00                    6024 	.db #0x00	;  0
      001744 F5                    6025 	.db #0xf5	; -11
      001745 FB                    6026 	.db #0xfb	; -5
      001746 FA                    6027 	.db #0xfa	; -6
      001747 0C                    6028 	.db #0x0c	;  12
      001748 E6                    6029 	.db #0xe6	; -26
      001749 00                    6030 	.db #0x00	;  0
      00174A 00                    6031 	.db #0x00	;  0
      00174B F4                    6032 	.db #0xf4	; -12
      00174C 0A                    6033 	.db #0x0a	;  10
      00174D F8                    6034 	.db #0xf8	; -8
      00174E EF                    6035 	.db #0xef	; -17
      00174F FD                    6036 	.db #0xfd	; -3
      001750 0A                    6037 	.db #0x0a	;  10
      001751 F4                    6038 	.db #0xf4	; -12
      001752 FF                    6039 	.db #0xff	; -1
      001753 04                    6040 	.db #0x04	;  4
      001754 F4                    6041 	.db #0xf4	; -12
      001755 00                    6042 	.db #0x00	;  0
      001756 FE                    6043 	.db #0xfe	; -2
      001757 0F                    6044 	.db #0x0f	;  15
      001758 13                    6045 	.db #0x13	;  19
      001759 10                    6046 	.db #0x10	;  16
      00175A EE                    6047 	.db #0xee	; -18
      00175B E1                    6048 	.db #0xe1	; -31
      00175C 13                    6049 	.db #0x13	;  19
      00175D 07                    6050 	.db #0x07	;  7
      00175E FE                    6051 	.db #0xfe	; -2
      00175F 05                    6052 	.db #0x05	;  5
      001760 F9                    6053 	.db #0xf9	; -7
      001761 04                    6054 	.db #0x04	;  4
      001762 15                    6055 	.db #0x15	;  21
      001763 00                    6056 	.db #0x00	;  0
      001764 F7                    6057 	.db #0xf7	; -9
      001765 0E                    6058 	.db #0x0e	;  14
      001766 04                    6059 	.db #0x04	;  4
      001767 04                    6060 	.db #0x04	;  4
      001768 F5                    6061 	.db #0xf5	; -11
      001769 00                    6062 	.db #0x00	;  0
      00176A FE                    6063 	.db #0xfe	; -2
      00176B 04                    6064 	.db #0x04	;  4
      00176C 08                    6065 	.db #0x08	;  8
      00176D FC                    6066 	.db #0xfc	; -4
      00176E FE                    6067 	.db #0xfe	; -2
      00176F 00                    6068 	.db #0x00	;  0
      001770 F1                    6069 	.db #0xf1	; -15
      001771 F8                    6070 	.db #0xf8	; -8
      001772 F8                    6071 	.db #0xf8	; -8
      001773 00                    6072 	.db #0x00	;  0
      001774 FD                    6073 	.db #0xfd	; -3
      001775 00                    6074 	.db #0x00	;  0
      001776 02                    6075 	.db #0x02	;  2
      001777 02                    6076 	.db #0x02	;  2
      001778 11                    6077 	.db #0x11	;  17
      001779 06                    6078 	.db #0x06	;  6
      00177A 02                    6079 	.db #0x02	;  2
      00177B EA                    6080 	.db #0xea	; -22
      00177C 02                    6081 	.db #0x02	;  2
      00177D 00                    6082 	.db #0x00	;  0
      00177E 00                    6083 	.db #0x00	;  0
      00177F 00                    6084 	.db #0x00	;  0
      001780 00                    6085 	.db #0x00	;  0
      001781 00                    6086 	.db #0x00	;  0
      001782 00                    6087 	.db #0x00	;  0
      001783 00                    6088 	.db #0x00	;  0
      001784 00                    6089 	.db #0x00	;  0
      001785 00                    6090 	.db #0x00	;  0
      001786 00                    6091 	.db #0x00	;  0
      001787 00                    6092 	.db #0x00	;  0
      001788 00                    6093 	.db #0x00	;  0
      001789 00                    6094 	.db #0x00	;  0
      00178A 00                    6095 	.db #0x00	;  0
      00178B 00                    6096 	.db #0x00	;  0
      00178C 00                    6097 	.db #0x00	;  0
      00178D 00                    6098 	.db #0x00	;  0
      00178E 00                    6099 	.db #0x00	;  0
      00178F 00                    6100 	.db #0x00	;  0
      001790 00                    6101 	.db #0x00	;  0
      001791 00                    6102 	.db #0x00	;  0
      001792 00                    6103 	.db #0x00	;  0
      001793 00                    6104 	.db #0x00	;  0
      001794 00                    6105 	.db #0x00	;  0
      001795 00                    6106 	.db #0x00	;  0
      001796 00                    6107 	.db #0x00	;  0
      001797 00                    6108 	.db #0x00	;  0
      001798 00                    6109 	.db #0x00	;  0
      001799 00                    6110 	.db #0x00	;  0
      00179A 00                    6111 	.db #0x00	;  0
      00179B 00                    6112 	.db #0x00	;  0
      00179C 00                    6113 	.db #0x00	;  0
      00179D 00                    6114 	.db #0x00	;  0
      00179E 00                    6115 	.db #0x00	;  0
      00179F 00                    6116 	.db #0x00	;  0
      0017A0 00                    6117 	.db #0x00	;  0
      0017A1 00                    6118 	.db #0x00	;  0
      0017A2 00                    6119 	.db #0x00	;  0
      0017A3 00                    6120 	.db #0x00	;  0
      0017A4 00                    6121 	.db #0x00	;  0
      0017A5 00                    6122 	.db #0x00	;  0
      0017A6 00                    6123 	.db #0x00	;  0
      0017A7 00                    6124 	.db #0x00	;  0
      0017A8 00                    6125 	.db #0x00	;  0
      0017A9 00                    6126 	.db #0x00	;  0
      0017AA 00                    6127 	.db #0x00	;  0
      0017AB 00                    6128 	.db #0x00	;  0
      0017AC 00                    6129 	.db #0x00	;  0
      0017AD 00                    6130 	.db #0x00	;  0
      0017AE 00                    6131 	.db #0x00	;  0
      0017AF 00                    6132 	.db #0x00	;  0
      0017B0 00                    6133 	.db #0x00	;  0
      0017B1 00                    6134 	.db #0x00	;  0
      0017B2 00                    6135 	.db #0x00	;  0
      0017B3 00                    6136 	.db #0x00	;  0
      0017B4 00                    6137 	.db #0x00	;  0
      0017B5 00                    6138 	.db #0x00	;  0
      0017B6 00                    6139 	.db #0x00	;  0
      0017B7 00                    6140 	.db #0x00	;  0
      0017B8 00                    6141 	.db #0x00	;  0
      0017B9 00                    6142 	.db #0x00	;  0
      0017BA 00                    6143 	.db #0x00	;  0
      0017BB 00                    6144 	.db #0x00	;  0
      0017BC 00                    6145 	.db #0x00	;  0
      0017BD 01                    6146 	.db #0x01	;  1
      0017BE FF                    6147 	.db #0xff	; -1
      0017BF 00                    6148 	.db #0x00	;  0
      0017C0 01                    6149 	.db #0x01	;  1
      0017C1 05                    6150 	.db #0x05	;  5
      0017C2 03                    6151 	.db #0x03	;  3
      0017C3 00                    6152 	.db #0x00	;  0
      0017C4 FE                    6153 	.db #0xfe	; -2
      0017C5 00                    6154 	.db #0x00	;  0
      0017C6 04                    6155 	.db #0x04	;  4
      0017C7 00                    6156 	.db #0x00	;  0
      0017C8 F9                    6157 	.db #0xf9	; -7
      0017C9 00                    6158 	.db #0x00	;  0
      0017CA 02                    6159 	.db #0x02	;  2
      0017CB FF                    6160 	.db #0xff	; -1
      0017CC FF                    6161 	.db #0xff	; -1
      0017CD 00                    6162 	.db #0x00	;  0
      0017CE 02                    6163 	.db #0x02	;  2
      0017CF 03                    6164 	.db #0x03	;  3
      0017D0 03                    6165 	.db #0x03	;  3
      0017D1 00                    6166 	.db #0x00	;  0
      0017D2 00                    6167 	.db #0x00	;  0
      0017D3 00                    6168 	.db #0x00	;  0
      0017D4 03                    6169 	.db #0x03	;  3
      0017D5 00                    6170 	.db #0x00	;  0
      0017D6 FE                    6171 	.db #0xfe	; -2
      0017D7 04                    6172 	.db #0x04	;  4
      0017D8 FD                    6173 	.db #0xfd	; -3
      0017D9 08                    6174 	.db #0x08	;  8
      0017DA FC                    6175 	.db #0xfc	; -4
      0017DB 01                    6176 	.db #0x01	;  1
      0017DC 01                    6177 	.db #0x01	;  1
      0017DD FD                    6178 	.db #0xfd	; -3
      0017DE F1                    6179 	.db #0xf1	; -15
      0017DF 1F                    6180 	.db #0x1f	;  31
      0017E0 1D                    6181 	.db #0x1d	;  29
      0017E1 FE                    6182 	.db #0xfe	; -2
      0017E2 0C                    6183 	.db #0x0c	;  12
      0017E3 00                    6184 	.db #0x00	;  0
      0017E4 0D                    6185 	.db #0x0d	;  13
      0017E5 0D                    6186 	.db #0x0d	;  13
      0017E6 05                    6187 	.db #0x05	;  5
      0017E7 ED                    6188 	.db #0xed	; -19
      0017E8 F2                    6189 	.db #0xf2	; -14
      0017E9 00                    6190 	.db #0x00	;  0
      0017EA 09                    6191 	.db #0x09	;  9
      0017EB EC                    6192 	.db #0xec	; -20
      0017EC 09                    6193 	.db #0x09	;  9
      0017ED FC                    6194 	.db #0xfc	; -4
      0017EE FE                    6195 	.db #0xfe	; -2
      0017EF 08                    6196 	.db #0x08	;  8
      0017F0 0D                    6197 	.db #0x0d	;  13
      0017F1 FB                    6198 	.db #0xfb	; -5
      0017F2 FC                    6199 	.db #0xfc	; -4
      0017F3 00                    6200 	.db #0x00	;  0
      0017F4 15                    6201 	.db #0x15	;  21
      0017F5 00                    6202 	.db #0x00	;  0
      0017F6 F5                    6203 	.db #0xf5	; -11
      0017F7 F8                    6204 	.db #0xf8	; -8
      0017F8 0A                    6205 	.db #0x0a	;  10
      0017F9 00                    6206 	.db #0x00	;  0
      0017FA 05                    6207 	.db #0x05	;  5
      0017FB 03                    6208 	.db #0x03	;  3
      0017FC F7                    6209 	.db #0xf7	; -9
      0017FD 0D                    6210 	.db #0x0d	;  13
      0017FE F8                    6211 	.db #0xf8	; -8
      0017FF 12                    6212 	.db #0x12	;  18
      001800 2E                    6213 	.db #0x2e	;  46
      001801 0E                    6214 	.db #0x0e	;  14
      001802 00                    6215 	.db #0x00	;  0
      001803 00                    6216 	.db #0x00	;  0
      001804 0A                    6217 	.db #0x0a	;  10
      001805 FB                    6218 	.db #0xfb	; -5
      001806 04                    6219 	.db #0x04	;  4
      001807 E9                    6220 	.db #0xe9	; -23
      001808 16                    6221 	.db #0x16	;  22
      001809 00                    6222 	.db #0x00	;  0
      00180A 12                    6223 	.db #0x12	;  18
      00180B E7                    6224 	.db #0xe7	; -25
      00180C 0B                    6225 	.db #0x0b	;  11
      00180D F2                    6226 	.db #0xf2	; -14
      00180E 08                    6227 	.db #0x08	;  8
      00180F 1B                    6228 	.db #0x1b	;  27
      001810 1C                    6229 	.db #0x1c	;  28
      001811 F7                    6230 	.db #0xf7	; -9
      001812 FB                    6231 	.db #0xfb	; -5
      001813 F9                    6232 	.db #0xf9	; -7
      001814 F8                    6233 	.db #0xf8	; -8
      001815 00                    6234 	.db #0x00	;  0
      001816 FC                    6235 	.db #0xfc	; -4
      001817 F4                    6236 	.db #0xf4	; -12
      001818 FC                    6237 	.db #0xfc	; -4
      001819 18                    6238 	.db #0x18	;  24
      00181A 07                    6239 	.db #0x07	;  7
      00181B 03                    6240 	.db #0x03	;  3
      00181C E8                    6241 	.db #0xe8	; -24
      00181D 01                    6242 	.db #0x01	;  1
      00181E E7                    6243 	.db #0xe7	; -25
      00181F 06                    6244 	.db #0x06	;  6
      001820 0F                    6245 	.db #0x0f	;  15
      001821 F5                    6246 	.db #0xf5	; -11
      001822 04                    6247 	.db #0x04	;  4
      001823 00                    6248 	.db #0x00	;  0
      001824 13                    6249 	.db #0x13	;  19
      001825 CB                    6250 	.db #0xcb	; -53
      001826 FD                    6251 	.db #0xfd	; -3
      001827 FF                    6252 	.db #0xff	; -1
      001828 07                    6253 	.db #0x07	;  7
      001829 00                    6254 	.db #0x00	;  0
      00182A 1D                    6255 	.db #0x1d	;  29
      00182B EC                    6256 	.db #0xec	; -20
      00182C 0E                    6257 	.db #0x0e	;  14
      00182D FA                    6258 	.db #0xfa	; -6
      00182E 08                    6259 	.db #0x08	;  8
      00182F FA                    6260 	.db #0xfa	; -6
      001830 24                    6261 	.db #0x24	;  36
      001831 01                    6262 	.db #0x01	;  1
      001832 11                    6263 	.db #0x11	;  17
      001833 07                    6264 	.db #0x07	;  7
      001834 02                    6265 	.db #0x02	;  2
      001835 00                    6266 	.db #0x00	;  0
      001836 FB                    6267 	.db #0xfb	; -5
      001837 F0                    6268 	.db #0xf0	; -16
      001838 FC                    6269 	.db #0xfc	; -4
      001839 1C                    6270 	.db #0x1c	;  28
      00183A 12                    6271 	.db #0x12	;  18
      00183B E4                    6272 	.db #0xe4	; -28
      00183C EE                    6273 	.db #0xee	; -18
      00183D 05                    6274 	.db #0x05	;  5
      00183E E8                    6275 	.db #0xe8	; -24
      00183F 0B                    6276 	.db #0x0b	;  11
      001840 F9                    6277 	.db #0xf9	; -7
      001841 F9                    6278 	.db #0xf9	; -7
      001842 04                    6279 	.db #0x04	;  4
      001843 00                    6280 	.db #0x00	;  0
      001844 07                    6281 	.db #0x07	;  7
      001845 DE                    6282 	.db #0xde	; -34
      001846 12                    6283 	.db #0x12	;  18
      001847 08                    6284 	.db #0x08	;  8
      001848 13                    6285 	.db #0x13	;  19
      001849 00                    6286 	.db #0x00	;  0
      00184A 24                    6287 	.db #0x24	;  36
      00184B FF                    6288 	.db #0xff	; -1
      00184C 0C                    6289 	.db #0x0c	;  12
      00184D ED                    6290 	.db #0xed	; -19
      00184E 20                    6291 	.db #0x20	;  32
      00184F F9                    6292 	.db #0xf9	; -7
      001850 30                    6293 	.db #0x30	;  48	'0'
      001851 02                    6294 	.db #0x02	;  2
      001852 03                    6295 	.db #0x03	;  3
      001853 08                    6296 	.db #0x08	;  8
      001854 0A                    6297 	.db #0x0a	;  10
      001855 00                    6298 	.db #0x00	;  0
      001856 F6                    6299 	.db #0xf6	; -10
      001857 FE                    6300 	.db #0xfe	; -2
      001858 04                    6301 	.db #0x04	;  4
      001859 0A                    6302 	.db #0x0a	;  10
      00185A FB                    6303 	.db #0xfb	; -5
      00185B FB                    6304 	.db #0xfb	; -5
      00185C FF                    6305 	.db #0xff	; -1
      00185D 0F                    6306 	.db #0x0f	;  15
      00185E FB                    6307 	.db #0xfb	; -5
      00185F 36                    6308 	.db #0x36	;  54	'6'
      001860 0A                    6309 	.db #0x0a	;  10
      001861 08                    6310 	.db #0x08	;  8
      001862 FC                    6311 	.db #0xfc	; -4
      001863 00                    6312 	.db #0x00	;  0
      001864 07                    6313 	.db #0x07	;  7
      001865 E6                    6314 	.db #0xe6	; -26
      001866 14                    6315 	.db #0x14	;  20
      001867 04                    6316 	.db #0x04	;  4
      001868 22                    6317 	.db #0x22	;  34
      001869 00                    6318 	.db #0x00	;  0
      00186A 09                    6319 	.db #0x09	;  9
      00186B FD                    6320 	.db #0xfd	; -3
      00186C 14                    6321 	.db #0x14	;  20
      00186D FA                    6322 	.db #0xfa	; -6
      00186E 07                    6323 	.db #0x07	;  7
      00186F 0C                    6324 	.db #0x0c	;  12
      001870 FB                    6325 	.db #0xfb	; -5
      001871 FD                    6326 	.db #0xfd	; -3
      001872 07                    6327 	.db #0x07	;  7
      001873 0D                    6328 	.db #0x0d	;  13
      001874 0E                    6329 	.db #0x0e	;  14
      001875 00                    6330 	.db #0x00	;  0
      001876 00                    6331 	.db #0x00	;  0
      001877 EE                    6332 	.db #0xee	; -18
      001878 0D                    6333 	.db #0x0d	;  13
      001879 0F                    6334 	.db #0x0f	;  15
      00187A 16                    6335 	.db #0x16	;  22
      00187B E6                    6336 	.db #0xe6	; -26
      00187C 09                    6337 	.db #0x09	;  9
      00187D 0D                    6338 	.db #0x0d	;  13
      00187E 1D                    6339 	.db #0x1d	;  29
      00187F 43                    6340 	.db #0x43	;  67	'C'
      001880 03                    6341 	.db #0x03	;  3
      001881 00                    6342 	.db #0x00	;  0
      001882 ED                    6343 	.db #0xed	; -19
      001883 00                    6344 	.db #0x00	;  0
      001884 FE                    6345 	.db #0xfe	; -2
      001885 EE                    6346 	.db #0xee	; -18
      001886 1C                    6347 	.db #0x1c	;  28
      001887 F3                    6348 	.db #0xf3	; -13
      001888 FA                    6349 	.db #0xfa	; -6
      001889 00                    6350 	.db #0x00	;  0
      00188A 00                    6351 	.db #0x00	;  0
      00188B 19                    6352 	.db #0x19	;  25
      00188C 0B                    6353 	.db #0x0b	;  11
      00188D F5                    6354 	.db #0xf5	; -11
      00188E F2                    6355 	.db #0xf2	; -14
      00188F FA                    6356 	.db #0xfa	; -6
      001890 D2                    6357 	.db #0xd2	; -46
      001891 F6                    6358 	.db #0xf6	; -10
      001892 0D                    6359 	.db #0x0d	;  13
      001893 07                    6360 	.db #0x07	;  7
      001894 0A                    6361 	.db #0x0a	;  10
      001895 00                    6362 	.db #0x00	;  0
      001896 FF                    6363 	.db #0xff	; -1
      001897 D8                    6364 	.db #0xd8	; -40
      001898 FB                    6365 	.db #0xfb	; -5
      001899 FB                    6366 	.db #0xfb	; -5
      00189A F4                    6367 	.db #0xf4	; -12
      00189B E1                    6368 	.db #0xe1	; -31
      00189C 0C                    6369 	.db #0x0c	;  12
      00189D F6                    6370 	.db #0xf6	; -10
      00189E 28                    6371 	.db #0x28	;  40
      00189F 25                    6372 	.db #0x25	;  37
      0018A0 F6                    6373 	.db #0xf6	; -10
      0018A1 00                    6374 	.db #0x00	;  0
      0018A2 E8                    6375 	.db #0xe8	; -24
      0018A3 00                    6376 	.db #0x00	;  0
      0018A4 F6                    6377 	.db #0xf6	; -10
      0018A5 FA                    6378 	.db #0xfa	; -6
      0018A6 00                    6379 	.db #0x00	;  0
      0018A7 F8                    6380 	.db #0xf8	; -8
      0018A8 DD                    6381 	.db #0xdd	; -35
      0018A9 00                    6382 	.db #0x00	;  0
      0018AA EE                    6383 	.db #0xee	; -18
      0018AB F9                    6384 	.db #0xf9	; -7
      0018AC 03                    6385 	.db #0x03	;  3
      0018AD F5                    6386 	.db #0xf5	; -11
      0018AE B5                    6387 	.db #0xb5	; -75
      0018AF F5                    6388 	.db #0xf5	; -11
      0018B0 E2                    6389 	.db #0xe2	; -30
      0018B1 01                    6390 	.db #0x01	;  1
      0018B2 05                    6391 	.db #0x05	;  5
      0018B3 E8                    6392 	.db #0xe8	; -24
      0018B4 F9                    6393 	.db #0xf9	; -7
      0018B5 00                    6394 	.db #0x00	;  0
      0018B6 0E                    6395 	.db #0x0e	;  14
      0018B7 D3                    6396 	.db #0xd3	; -45
      0018B8 09                    6397 	.db #0x09	;  9
      0018B9 10                    6398 	.db #0x10	;  16
      0018BA E9                    6399 	.db #0xe9	; -23
      0018BB E3                    6400 	.db #0xe3	; -29
      0018BC 13                    6401 	.db #0x13	;  19
      0018BD ED                    6402 	.db #0xed	; -19
      0018BE FF                    6403 	.db #0xff	; -1
      0018BF 10                    6404 	.db #0x10	;  16
      0018C0 F6                    6405 	.db #0xf6	; -10
      0018C1 F9                    6406 	.db #0xf9	; -7
      0018C2 0C                    6407 	.db #0x0c	;  12
      0018C3 00                    6408 	.db #0x00	;  0
      0018C4 06                    6409 	.db #0x06	;  6
      0018C5 F0                    6410 	.db #0xf0	; -16
      0018C6 00                    6411 	.db #0x00	;  0
      0018C7 00                    6412 	.db #0x00	;  0
      0018C8 DB                    6413 	.db #0xdb	; -37
      0018C9 00                    6414 	.db #0x00	;  0
      0018CA F3                    6415 	.db #0xf3	; -13
      0018CB E6                    6416 	.db #0xe6	; -26
      0018CC 05                    6417 	.db #0x05	;  5
      0018CD EB                    6418 	.db #0xeb	; -21
      0018CE ED                    6419 	.db #0xed	; -19
      0018CF 03                    6420 	.db #0x03	;  3
      0018D0 FC                    6421 	.db #0xfc	; -4
      0018D1 06                    6422 	.db #0x06	;  6
      0018D2 FF                    6423 	.db #0xff	; -1
      0018D3 FE                    6424 	.db #0xfe	; -2
      0018D4 13                    6425 	.db #0x13	;  19
      0018D5 00                    6426 	.db #0x00	;  0
      0018D6 06                    6427 	.db #0x06	;  6
      0018D7 DF                    6428 	.db #0xdf	; -33
      0018D8 00                    6429 	.db #0x00	;  0
      0018D9 1D                    6430 	.db #0x1d	;  29
      0018DA E7                    6431 	.db #0xe7	; -25
      0018DB EF                    6432 	.db #0xef	; -17
      0018DC 15                    6433 	.db #0x15	;  21
      0018DD ED                    6434 	.db #0xed	; -19
      0018DE 01                    6435 	.db #0x01	;  1
      0018DF 17                    6436 	.db #0x17	;  23
      0018E0 F8                    6437 	.db #0xf8	; -8
      0018E1 F3                    6438 	.db #0xf3	; -13
      0018E2 1A                    6439 	.db #0x1a	;  26
      0018E3 00                    6440 	.db #0x00	;  0
      0018E4 FE                    6441 	.db #0xfe	; -2
      0018E5 08                    6442 	.db #0x08	;  8
      0018E6 FF                    6443 	.db #0xff	; -1
      0018E7 04                    6444 	.db #0x04	;  4
      0018E8 E2                    6445 	.db #0xe2	; -30
      0018E9 00                    6446 	.db #0x00	;  0
      0018EA E7                    6447 	.db #0xe7	; -25
      0018EB F7                    6448 	.db #0xf7	; -9
      0018EC 08                    6449 	.db #0x08	;  8
      0018ED F5                    6450 	.db #0xf5	; -11
      0018EE F5                    6451 	.db #0xf5	; -11
      0018EF FC                    6452 	.db #0xfc	; -4
      0018F0 F2                    6453 	.db #0xf2	; -14
      0018F1 01                    6454 	.db #0x01	;  1
      0018F2 01                    6455 	.db #0x01	;  1
      0018F3 0B                    6456 	.db #0x0b	;  11
      0018F4 F8                    6457 	.db #0xf8	; -8
      0018F5 00                    6458 	.db #0x00	;  0
      0018F6 13                    6459 	.db #0x13	;  19
      0018F7 F8                    6460 	.db #0xf8	; -8
      0018F8 F8                    6461 	.db #0xf8	; -8
      0018F9 03                    6462 	.db #0x03	;  3
      0018FA EB                    6463 	.db #0xeb	; -21
      0018FB E8                    6464 	.db #0xe8	; -24
      0018FC F7                    6465 	.db #0xf7	; -9
      0018FD 02                    6466 	.db #0x02	;  2
      0018FE F9                    6467 	.db #0xf9	; -7
      0018FF 16                    6468 	.db #0x16	;  22
      001900 04                    6469 	.db #0x04	;  4
      001901 F0                    6470 	.db #0xf0	; -16
      001902 14                    6471 	.db #0x14	;  20
      001903 00                    6472 	.db #0x00	;  0
      001904 F6                    6473 	.db #0xf6	; -10
      001905 08                    6474 	.db #0x08	;  8
      001906 0C                    6475 	.db #0x0c	;  12
      001907 04                    6476 	.db #0x04	;  4
      001908 F2                    6477 	.db #0xf2	; -14
      001909 00                    6478 	.db #0x00	;  0
      00190A FE                    6479 	.db #0xfe	; -2
      00190B F7                    6480 	.db #0xf7	; -9
      00190C 10                    6481 	.db #0x10	;  16
      00190D F6                    6482 	.db #0xf6	; -10
      00190E F8                    6483 	.db #0xf8	; -8
      00190F FE                    6484 	.db #0xfe	; -2
      001910 ED                    6485 	.db #0xed	; -19
      001911 E8                    6486 	.db #0xe8	; -24
      001912 0A                    6487 	.db #0x0a	;  10
      001913 09                    6488 	.db #0x09	;  9
      001914 F4                    6489 	.db #0xf4	; -12
      001915 00                    6490 	.db #0x00	;  0
      001916 1D                    6491 	.db #0x1d	;  29
      001917 F6                    6492 	.db #0xf6	; -10
      001918 02                    6493 	.db #0x02	;  2
      001919 1E                    6494 	.db #0x1e	;  30
      00191A FB                    6495 	.db #0xfb	; -5
      00191B DA                    6496 	.db #0xda	; -38
      00191C 04                    6497 	.db #0x04	;  4
      00191D 0A                    6498 	.db #0x0a	;  10
      00191E FD                    6499 	.db #0xfd	; -3
      00191F FD                    6500 	.db #0xfd	; -3
      001920 FD                    6501 	.db #0xfd	; -3
      001921 00                    6502 	.db #0x00	;  0
      001922 01                    6503 	.db #0x01	;  1
      001923 00                    6504 	.db #0x00	;  0
      001924 F2                    6505 	.db #0xf2	; -14
      001925 09                    6506 	.db #0x09	;  9
      001926 04                    6507 	.db #0x04	;  4
      001927 FF                    6508 	.db #0xff	; -1
      001928 FB                    6509 	.db #0xfb	; -5
      001929 00                    6510 	.db #0x00	;  0
      00192A 01                    6511 	.db #0x01	;  1
      00192B 00                    6512 	.db #0x00	;  0
      00192C 06                    6513 	.db #0x06	;  6
      00192D 01                    6514 	.db #0x01	;  1
      00192E 00                    6515 	.db #0x00	;  0
      00192F 01                    6516 	.db #0x01	;  1
      001930 F5                    6517 	.db #0xf5	; -11
      001931 02                    6518 	.db #0x02	;  2
      001932 06                    6519 	.db #0x06	;  6
      001933 00                    6520 	.db #0x00	;  0
      001934 FD                    6521 	.db #0xfd	; -3
      001935 00                    6522 	.db #0x00	;  0
      001936 01                    6523 	.db #0x01	;  1
      001937 F8                    6524 	.db #0xf8	; -8
      001938 07                    6525 	.db #0x07	;  7
      001939 09                    6526 	.db #0x09	;  9
      00193A 00                    6527 	.db #0x00	;  0
      00193B ED                    6528 	.db #0xed	; -19
      00193C FE                    6529 	.db #0xfe	; -2
      00193D 00                    6530 	.db #0x00	;  0
      00193E 00                    6531 	.db #0x00	;  0
      00193F 00                    6532 	.db #0x00	;  0
      001940 00                    6533 	.db #0x00	;  0
      001941 00                    6534 	.db #0x00	;  0
      001942 00                    6535 	.db #0x00	;  0
      001943 00                    6536 	.db #0x00	;  0
      001944 00                    6537 	.db #0x00	;  0
      001945 00                    6538 	.db #0x00	;  0
      001946 00                    6539 	.db #0x00	;  0
      001947 00                    6540 	.db #0x00	;  0
      001948 00                    6541 	.db #0x00	;  0
      001949 00                    6542 	.db #0x00	;  0
      00194A 00                    6543 	.db #0x00	;  0
      00194B 00                    6544 	.db #0x00	;  0
      00194C 00                    6545 	.db #0x00	;  0
      00194D 00                    6546 	.db #0x00	;  0
      00194E 00                    6547 	.db #0x00	;  0
      00194F 00                    6548 	.db #0x00	;  0
      001950 00                    6549 	.db #0x00	;  0
      001951 00                    6550 	.db #0x00	;  0
      001952 00                    6551 	.db #0x00	;  0
      001953 00                    6552 	.db #0x00	;  0
      001954 00                    6553 	.db #0x00	;  0
      001955 00                    6554 	.db #0x00	;  0
      001956 00                    6555 	.db #0x00	;  0
      001957 00                    6556 	.db #0x00	;  0
      001958 00                    6557 	.db #0x00	;  0
      001959 00                    6558 	.db #0x00	;  0
      00195A 00                    6559 	.db #0x00	;  0
      00195B 00                    6560 	.db #0x00	;  0
      00195C 00                    6561 	.db #0x00	;  0
      00195D 00                    6562 	.db #0x00	;  0
      00195E 00                    6563 	.db #0x00	;  0
      00195F 00                    6564 	.db #0x00	;  0
      001960 00                    6565 	.db #0x00	;  0
      001961 00                    6566 	.db #0x00	;  0
      001962 00                    6567 	.db #0x00	;  0
      001963 00                    6568 	.db #0x00	;  0
      001964 00                    6569 	.db #0x00	;  0
      001965 00                    6570 	.db #0x00	;  0
      001966 00                    6571 	.db #0x00	;  0
      001967 00                    6572 	.db #0x00	;  0
      001968 00                    6573 	.db #0x00	;  0
      001969 00                    6574 	.db #0x00	;  0
      00196A 00                    6575 	.db #0x00	;  0
      00196B 00                    6576 	.db #0x00	;  0
      00196C 00                    6577 	.db #0x00	;  0
      00196D 00                    6578 	.db #0x00	;  0
      00196E 00                    6579 	.db #0x00	;  0
      00196F 00                    6580 	.db #0x00	;  0
      001970 00                    6581 	.db #0x00	;  0
      001971 00                    6582 	.db #0x00	;  0
      001972 00                    6583 	.db #0x00	;  0
      001973 00                    6584 	.db #0x00	;  0
      001974 00                    6585 	.db #0x00	;  0
      001975 00                    6586 	.db #0x00	;  0
      001976 00                    6587 	.db #0x00	;  0
      001977 00                    6588 	.db #0x00	;  0
      001978 00                    6589 	.db #0x00	;  0
      001979 00                    6590 	.db #0x00	;  0
      00197A 00                    6591 	.db #0x00	;  0
      00197B 00                    6592 	.db #0x00	;  0
      00197C 00                    6593 	.db #0x00	;  0
      00197D 00                    6594 	.db #0x00	;  0
      00197E 00                    6595 	.db #0x00	;  0
      00197F 01                    6596 	.db #0x01	;  1
      001980 00                    6597 	.db #0x00	;  0
      001981 00                    6598 	.db #0x00	;  0
      001982 00                    6599 	.db #0x00	;  0
      001983 00                    6600 	.db #0x00	;  0
      001984 01                    6601 	.db #0x01	;  1
      001985 01                    6602 	.db #0x01	;  1
      001986 00                    6603 	.db #0x00	;  0
      001987 00                    6604 	.db #0x00	;  0
      001988 00                    6605 	.db #0x00	;  0
      001989 00                    6606 	.db #0x00	;  0
      00198A 01                    6607 	.db #0x01	;  1
      00198B 00                    6608 	.db #0x00	;  0
      00198C 00                    6609 	.db #0x00	;  0
      00198D 00                    6610 	.db #0x00	;  0
      00198E 00                    6611 	.db #0x00	;  0
      00198F 00                    6612 	.db #0x00	;  0
      001990 00                    6613 	.db #0x00	;  0
      001991 00                    6614 	.db #0x00	;  0
      001992 FF                    6615 	.db #0xff	; -1
      001993 00                    6616 	.db #0x00	;  0
      001994 00                    6617 	.db #0x00	;  0
      001995 00                    6618 	.db #0x00	;  0
      001996 00                    6619 	.db #0x00	;  0
      001997 00                    6620 	.db #0x00	;  0
      001998 01                    6621 	.db #0x01	;  1
      001999 00                    6622 	.db #0x00	;  0
      00199A 00                    6623 	.db #0x00	;  0
      00199B 00                    6624 	.db #0x00	;  0
      00199C 00                    6625 	.db #0x00	;  0
      00199D FF                    6626 	.db #0xff	; -1
      00199E FE                    6627 	.db #0xfe	; -2
      00199F FB                    6628 	.db #0xfb	; -5
      0019A0 FD                    6629 	.db #0xfd	; -3
      0019A1 05                    6630 	.db #0x05	;  5
      0019A2 0D                    6631 	.db #0x0d	;  13
      0019A3 00                    6632 	.db #0x00	;  0
      0019A4 0D                    6633 	.db #0x0d	;  13
      0019A5 0E                    6634 	.db #0x0e	;  14
      0019A6 09                    6635 	.db #0x09	;  9
      0019A7 01                    6636 	.db #0x01	;  1
      0019A8 12                    6637 	.db #0x12	;  18
      0019A9 00                    6638 	.db #0x00	;  0
      0019AA 15                    6639 	.db #0x15	;  21
      0019AB FC                    6640 	.db #0xfc	; -4
      0019AC FD                    6641 	.db #0xfd	; -3
      0019AD 02                    6642 	.db #0x02	;  2
      0019AE EC                    6643 	.db #0xec	; -20
      0019AF 04                    6644 	.db #0x04	;  4
      0019B0 EC                    6645 	.db #0xec	; -20
      0019B1 FD                    6646 	.db #0xfd	; -3
      0019B2 F5                    6647 	.db #0xf5	; -11
      0019B3 FD                    6648 	.db #0xfd	; -3
      0019B4 FA                    6649 	.db #0xfa	; -6
      0019B5 00                    6650 	.db #0x00	;  0
      0019B6 00                    6651 	.db #0x00	;  0
      0019B7 FE                    6652 	.db #0xfe	; -2
      0019B8 FE                    6653 	.db #0xfe	; -2
      0019B9 0E                    6654 	.db #0x0e	;  14
      0019BA FD                    6655 	.db #0xfd	; -3
      0019BB FF                    6656 	.db #0xff	; -1
      0019BC E7                    6657 	.db #0xe7	; -25
      0019BD F8                    6658 	.db #0xf8	; -8
      0019BE FB                    6659 	.db #0xfb	; -5
      0019BF 13                    6660 	.db #0x13	;  19
      0019C0 F6                    6661 	.db #0xf6	; -10
      0019C1 0A                    6662 	.db #0x0a	;  10
      0019C2 07                    6663 	.db #0x07	;  7
      0019C3 00                    6664 	.db #0x00	;  0
      0019C4 09                    6665 	.db #0x09	;  9
      0019C5 08                    6666 	.db #0x08	;  8
      0019C6 EE                    6667 	.db #0xee	; -18
      0019C7 03                    6668 	.db #0x03	;  3
      0019C8 1E                    6669 	.db #0x1e	;  30
      0019C9 00                    6670 	.db #0x00	;  0
      0019CA 27                    6671 	.db #0x27	;  39
      0019CB E1                    6672 	.db #0xe1	; -31
      0019CC FF                    6673 	.db #0xff	; -1
      0019CD EA                    6674 	.db #0xea	; -22
      0019CE EE                    6675 	.db #0xee	; -18
      0019CF 0B                    6676 	.db #0x0b	;  11
      0019D0 FB                    6677 	.db #0xfb	; -5
      0019D1 0B                    6678 	.db #0x0b	;  11
      0019D2 F6                    6679 	.db #0xf6	; -10
      0019D3 E2                    6680 	.db #0xe2	; -30
      0019D4 F3                    6681 	.db #0xf3	; -13
      0019D5 00                    6682 	.db #0x00	;  0
      0019D6 05                    6683 	.db #0x05	;  5
      0019D7 EC                    6684 	.db #0xec	; -20
      0019D8 FB                    6685 	.db #0xfb	; -5
      0019D9 13                    6686 	.db #0x13	;  19
      0019DA F2                    6687 	.db #0xf2	; -14
      0019DB EE                    6688 	.db #0xee	; -18
      0019DC EC                    6689 	.db #0xec	; -20
      0019DD F5                    6690 	.db #0xf5	; -11
      0019DE 01                    6691 	.db #0x01	;  1
      0019DF 30                    6692 	.db #0x30	;  48	'0'
      0019E0 04                    6693 	.db #0x04	;  4
      0019E1 27                    6694 	.db #0x27	;  39
      0019E2 F5                    6695 	.db #0xf5	; -11
      0019E3 00                    6696 	.db #0x00	;  0
      0019E4 FE                    6697 	.db #0xfe	; -2
      0019E5 16                    6698 	.db #0x16	;  22
      0019E6 F3                    6699 	.db #0xf3	; -13
      0019E7 06                    6700 	.db #0x06	;  6
      0019E8 1B                    6701 	.db #0x1b	;  27
      0019E9 00                    6702 	.db #0x00	;  0
      0019EA 1B                    6703 	.db #0x1b	;  27
      0019EB F4                    6704 	.db #0xf4	; -12
      0019EC 0A                    6705 	.db #0x0a	;  10
      0019ED F9                    6706 	.db #0xf9	; -7
      0019EE FD                    6707 	.db #0xfd	; -3
      0019EF FB                    6708 	.db #0xfb	; -5
      0019F0 13                    6709 	.db #0x13	;  19
      0019F1 0B                    6710 	.db #0x0b	;  11
      0019F2 FF                    6711 	.db #0xff	; -1
      0019F3 05                    6712 	.db #0x05	;  5
      0019F4 E2                    6713 	.db #0xe2	; -30
      0019F5 00                    6714 	.db #0x00	;  0
      0019F6 EA                    6715 	.db #0xea	; -22
      0019F7 D7                    6716 	.db #0xd7	; -41
      0019F8 FF                    6717 	.db #0xff	; -1
      0019F9 0E                    6718 	.db #0x0e	;  14
      0019FA 03                    6719 	.db #0x03	;  3
      0019FB DE                    6720 	.db #0xde	; -34
      0019FC FD                    6721 	.db #0xfd	; -3
      0019FD F2                    6722 	.db #0xf2	; -14
      0019FE 0D                    6723 	.db #0x0d	;  13
      0019FF 2B                    6724 	.db #0x2b	;  43
      001A00 F4                    6725 	.db #0xf4	; -12
      001A01 03                    6726 	.db #0x03	;  3
      001A02 0F                    6727 	.db #0x0f	;  15
      001A03 00                    6728 	.db #0x00	;  0
      001A04 01                    6729 	.db #0x01	;  1
      001A05 29                    6730 	.db #0x29	;  41
      001A06 FC                    6731 	.db #0xfc	; -4
      001A07 01                    6732 	.db #0x01	;  1
      001A08 0F                    6733 	.db #0x0f	;  15
      001A09 00                    6734 	.db #0x00	;  0
      001A0A 07                    6735 	.db #0x07	;  7
      001A0B EF                    6736 	.db #0xef	; -17
      001A0C FE                    6737 	.db #0xfe	; -2
      001A0D 0C                    6738 	.db #0x0c	;  12
      001A0E E9                    6739 	.db #0xe9	; -23
      001A0F 05                    6740 	.db #0x05	;  5
      001A10 13                    6741 	.db #0x13	;  19
      001A11 17                    6742 	.db #0x17	;  23
      001A12 03                    6743 	.db #0x03	;  3
      001A13 FE                    6744 	.db #0xfe	; -2
      001A14 F2                    6745 	.db #0xf2	; -14
      001A15 00                    6746 	.db #0x00	;  0
      001A16 0F                    6747 	.db #0x0f	;  15
      001A17 D5                    6748 	.db #0xd5	; -43
      001A18 FB                    6749 	.db #0xfb	; -5
      001A19 07                    6750 	.db #0x07	;  7
      001A1A 09                    6751 	.db #0x09	;  9
      001A1B F5                    6752 	.db #0xf5	; -11
      001A1C F6                    6753 	.db #0xf6	; -10
      001A1D FA                    6754 	.db #0xfa	; -6
      001A1E FC                    6755 	.db #0xfc	; -4
      001A1F 30                    6756 	.db #0x30	;  48	'0'
      001A20 05                    6757 	.db #0x05	;  5
      001A21 07                    6758 	.db #0x07	;  7
      001A22 06                    6759 	.db #0x06	;  6
      001A23 00                    6760 	.db #0x00	;  0
      001A24 F7                    6761 	.db #0xf7	; -9
      001A25 0E                    6762 	.db #0x0e	;  14
      001A26 FC                    6763 	.db #0xfc	; -4
      001A27 03                    6764 	.db #0x03	;  3
      001A28 29                    6765 	.db #0x29	;  41
      001A29 00                    6766 	.db #0x00	;  0
      001A2A 0C                    6767 	.db #0x0c	;  12
      001A2B 03                    6768 	.db #0x03	;  3
      001A2C 09                    6769 	.db #0x09	;  9
      001A2D FF                    6770 	.db #0xff	; -1
      001A2E E4                    6771 	.db #0xe4	; -28
      001A2F 07                    6772 	.db #0x07	;  7
      001A30 0A                    6773 	.db #0x0a	;  10
      001A31 0B                    6774 	.db #0x0b	;  11
      001A32 0D                    6775 	.db #0x0d	;  13
      001A33 F7                    6776 	.db #0xf7	; -9
      001A34 E2                    6777 	.db #0xe2	; -30
      001A35 00                    6778 	.db #0x00	;  0
      001A36 FB                    6779 	.db #0xfb	; -5
      001A37 C4                    6780 	.db #0xc4	; -60
      001A38 02                    6781 	.db #0x02	;  2
      001A39 F5                    6782 	.db #0xf5	; -11
      001A3A 04                    6783 	.db #0x04	;  4
      001A3B F0                    6784 	.db #0xf0	; -16
      001A3C 04                    6785 	.db #0x04	;  4
      001A3D 0D                    6786 	.db #0x0d	;  13
      001A3E 18                    6787 	.db #0x18	;  24
      001A3F 15                    6788 	.db #0x15	;  21
      001A40 FA                    6789 	.db #0xfa	; -6
      001A41 EF                    6790 	.db #0xef	; -17
      001A42 EC                    6791 	.db #0xec	; -20
      001A43 00                    6792 	.db #0x00	;  0
      001A44 FB                    6793 	.db #0xfb	; -5
      001A45 02                    6794 	.db #0x02	;  2
      001A46 1E                    6795 	.db #0x1e	;  30
      001A47 03                    6796 	.db #0x03	;  3
      001A48 ED                    6797 	.db #0xed	; -19
      001A49 00                    6798 	.db #0x00	;  0
      001A4A 05                    6799 	.db #0x05	;  5
      001A4B 0F                    6800 	.db #0x0f	;  15
      001A4C F6                    6801 	.db #0xf6	; -10
      001A4D 06                    6802 	.db #0x06	;  6
      001A4E C5                    6803 	.db #0xc5	; -59
      001A4F 05                    6804 	.db #0x05	;  5
      001A50 FF                    6805 	.db #0xff	; -1
      001A51 F6                    6806 	.db #0xf6	; -10
      001A52 0D                    6807 	.db #0x0d	;  13
      001A53 F7                    6808 	.db #0xf7	; -9
      001A54 E8                    6809 	.db #0xe8	; -24
      001A55 00                    6810 	.db #0x00	;  0
      001A56 03                    6811 	.db #0x03	;  3
      001A57 D2                    6812 	.db #0xd2	; -46
      001A58 FD                    6813 	.db #0xfd	; -3
      001A59 F9                    6814 	.db #0xf9	; -7
      001A5A 07                    6815 	.db #0x07	;  7
      001A5B ED                    6816 	.db #0xed	; -19
      001A5C FF                    6817 	.db #0xff	; -1
      001A5D FB                    6818 	.db #0xfb	; -5
      001A5E 16                    6819 	.db #0x16	;  22
      001A5F 0E                    6820 	.db #0x0e	;  14
      001A60 FC                    6821 	.db #0xfc	; -4
      001A61 04                    6822 	.db #0x04	;  4
      001A62 EB                    6823 	.db #0xeb	; -21
      001A63 00                    6824 	.db #0x00	;  0
      001A64 F8                    6825 	.db #0xf8	; -8
      001A65 1F                    6826 	.db #0x1f	;  31
      001A66 0E                    6827 	.db #0x0e	;  14
      001A67 00                    6828 	.db #0x00	;  0
      001A68 D5                    6829 	.db #0xd5	; -43
      001A69 00                    6830 	.db #0x00	;  0
      001A6A ED                    6831 	.db #0xed	; -19
      001A6B 22                    6832 	.db #0x22	;  34
      001A6C F0                    6833 	.db #0xf0	; -16
      001A6D 10                    6834 	.db #0x10	;  16
      001A6E FC                    6835 	.db #0xfc	; -4
      001A6F F5                    6836 	.db #0xf5	; -11
      001A70 F0                    6837 	.db #0xf0	; -16
      001A71 F0                    6838 	.db #0xf0	; -16
      001A72 0C                    6839 	.db #0x0c	;  12
      001A73 06                    6840 	.db #0x06	;  6
      001A74 F7                    6841 	.db #0xf7	; -9
      001A75 00                    6842 	.db #0x00	;  0
      001A76 F3                    6843 	.db #0xf3	; -13
      001A77 D7                    6844 	.db #0xd7	; -41
      001A78 16                    6845 	.db #0x16	;  22
      001A79 F7                    6846 	.db #0xf7	; -9
      001A7A D4                    6847 	.db #0xd4	; -44
      001A7B FA                    6848 	.db #0xfa	; -6
      001A7C 19                    6849 	.db #0x19	;  25
      001A7D 08                    6850 	.db #0x08	;  8
      001A7E 07                    6851 	.db #0x07	;  7
      001A7F F7                    6852 	.db #0xf7	; -9
      001A80 ED                    6853 	.db #0xed	; -19
      001A81 FC                    6854 	.db #0xfc	; -4
      001A82 E7                    6855 	.db #0xe7	; -25
      001A83 00                    6856 	.db #0x00	;  0
      001A84 EC                    6857 	.db #0xec	; -20
      001A85 1B                    6858 	.db #0x1b	;  27
      001A86 FC                    6859 	.db #0xfc	; -4
      001A87 F3                    6860 	.db #0xf3	; -13
      001A88 DD                    6861 	.db #0xdd	; -35
      001A89 00                    6862 	.db #0x00	;  0
      001A8A E8                    6863 	.db #0xe8	; -24
      001A8B F3                    6864 	.db #0xf3	; -13
      001A8C 01                    6865 	.db #0x01	;  1
      001A8D 09                    6866 	.db #0x09	;  9
      001A8E 09                    6867 	.db #0x09	;  9
      001A8F F6                    6868 	.db #0xf6	; -10
      001A90 F6                    6869 	.db #0xf6	; -10
      001A91 0E                    6870 	.db #0x0e	;  14
      001A92 09                    6871 	.db #0x09	;  9
      001A93 04                    6872 	.db #0x04	;  4
      001A94 E3                    6873 	.db #0xe3	; -29
      001A95 00                    6874 	.db #0x00	;  0
      001A96 1B                    6875 	.db #0x1b	;  27
      001A97 E0                    6876 	.db #0xe0	; -32
      001A98 16                    6877 	.db #0x16	;  22
      001A99 03                    6878 	.db #0x03	;  3
      001A9A F5                    6879 	.db #0xf5	; -11
      001A9B EF                    6880 	.db #0xef	; -17
      001A9C 06                    6881 	.db #0x06	;  6
      001A9D 1C                    6882 	.db #0x1c	;  28
      001A9E 03                    6883 	.db #0x03	;  3
      001A9F FC                    6884 	.db #0xfc	; -4
      001AA0 F2                    6885 	.db #0xf2	; -14
      001AA1 F5                    6886 	.db #0xf5	; -11
      001AA2 F7                    6887 	.db #0xf7	; -9
      001AA3 00                    6888 	.db #0x00	;  0
      001AA4 09                    6889 	.db #0x09	;  9
      001AA5 12                    6890 	.db #0x12	;  18
      001AA6 07                    6891 	.db #0x07	;  7
      001AA7 FC                    6892 	.db #0xfc	; -4
      001AA8 F4                    6893 	.db #0xf4	; -12
      001AA9 00                    6894 	.db #0x00	;  0
      001AAA 05                    6895 	.db #0x05	;  5
      001AAB F0                    6896 	.db #0xf0	; -16
      001AAC F1                    6897 	.db #0xf1	; -15
      001AAD FE                    6898 	.db #0xfe	; -2
      001AAE 00                    6899 	.db #0x00	;  0
      001AAF FA                    6900 	.db #0xfa	; -6
      001AB0 ED                    6901 	.db #0xed	; -19
      001AB1 FB                    6902 	.db #0xfb	; -5
      001AB2 01                    6903 	.db #0x01	;  1
      001AB3 03                    6904 	.db #0x03	;  3
      001AB4 F7                    6905 	.db #0xf7	; -9
      001AB5 00                    6906 	.db #0x00	;  0
      001AB6 04                    6907 	.db #0x04	;  4
      001AB7 EB                    6908 	.db #0xeb	; -21
      001AB8 08                    6909 	.db #0x08	;  8
      001AB9 0E                    6910 	.db #0x0e	;  14
      001ABA ED                    6911 	.db #0xed	; -19
      001ABB 02                    6912 	.db #0x02	;  2
      001ABC 0E                    6913 	.db #0x0e	;  14
      001ABD 0A                    6914 	.db #0x0a	;  10
      001ABE 01                    6915 	.db #0x01	;  1
      001ABF 00                    6916 	.db #0x00	;  0
      001AC0 FE                    6917 	.db #0xfe	; -2
      001AC1 F6                    6918 	.db #0xf6	; -10
      001AC2 0A                    6919 	.db #0x0a	;  10
      001AC3 00                    6920 	.db #0x00	;  0
      001AC4 0C                    6921 	.db #0x0c	;  12
      001AC5 06                    6922 	.db #0x06	;  6
      001AC6 F3                    6923 	.db #0xf3	; -13
      001AC7 FF                    6924 	.db #0xff	; -1
      001AC8 FE                    6925 	.db #0xfe	; -2
      001AC9 00                    6926 	.db #0x00	;  0
      001ACA 02                    6927 	.db #0x02	;  2
      001ACB 02                    6928 	.db #0x02	;  2
      001ACC 03                    6929 	.db #0x03	;  3
      001ACD FC                    6930 	.db #0xfc	; -4
      001ACE 00                    6931 	.db #0x00	;  0
      001ACF F5                    6932 	.db #0xf5	; -11
      001AD0 F9                    6933 	.db #0xf9	; -7
      001AD1 F9                    6934 	.db #0xf9	; -7
      001AD2 F8                    6935 	.db #0xf8	; -8
      001AD3 03                    6936 	.db #0x03	;  3
      001AD4 F7                    6937 	.db #0xf7	; -9
      001AD5 00                    6938 	.db #0x00	;  0
      001AD6 0F                    6939 	.db #0x0f	;  15
      001AD7 EE                    6940 	.db #0xee	; -18
      001AD8 FF                    6941 	.db #0xff	; -1
      001AD9 05                    6942 	.db #0x05	;  5
      001ADA 00                    6943 	.db #0x00	;  0
      001ADB FA                    6944 	.db #0xfa	; -6
      001ADC 04                    6945 	.db #0x04	;  4
      001ADD 01                    6946 	.db #0x01	;  1
      001ADE 00                    6947 	.db #0x00	;  0
      001ADF 00                    6948 	.db #0x00	;  0
      001AE0 FF                    6949 	.db #0xff	; -1
      001AE1 FF                    6950 	.db #0xff	; -1
      001AE2 00                    6951 	.db #0x00	;  0
      001AE3 00                    6952 	.db #0x00	;  0
      001AE4 00                    6953 	.db #0x00	;  0
      001AE5 00                    6954 	.db #0x00	;  0
      001AE6 00                    6955 	.db #0x00	;  0
      001AE7 00                    6956 	.db #0x00	;  0
      001AE8 00                    6957 	.db #0x00	;  0
      001AE9 00                    6958 	.db #0x00	;  0
      001AEA 01                    6959 	.db #0x01	;  1
      001AEB 00                    6960 	.db #0x00	;  0
      001AEC 00                    6961 	.db #0x00	;  0
      001AED 01                    6962 	.db #0x01	;  1
      001AEE 00                    6963 	.db #0x00	;  0
      001AEF 00                    6964 	.db #0x00	;  0
      001AF0 FF                    6965 	.db #0xff	; -1
      001AF1 00                    6966 	.db #0x00	;  0
      001AF2 00                    6967 	.db #0x00	;  0
      001AF3 00                    6968 	.db #0x00	;  0
      001AF4 00                    6969 	.db #0x00	;  0
      001AF5 00                    6970 	.db #0x00	;  0
      001AF6 00                    6971 	.db #0x00	;  0
      001AF7 00                    6972 	.db #0x00	;  0
      001AF8 01                    6973 	.db #0x01	;  1
      001AF9 00                    6974 	.db #0x00	;  0
      001AFA 00                    6975 	.db #0x00	;  0
      001AFB 00                    6976 	.db #0x00	;  0
      001AFC 00                    6977 	.db #0x00	;  0
      001AFD 00                    6978 	.db #0x00	;  0
      001AFE 00                    6979 	.db #0x00	;  0
      001AFF 00                    6980 	.db #0x00	;  0
      001B00 00                    6981 	.db #0x00	;  0
      001B01 00                    6982 	.db #0x00	;  0
      001B02 00                    6983 	.db #0x00	;  0
      001B03 00                    6984 	.db #0x00	;  0
      001B04 00                    6985 	.db #0x00	;  0
      001B05 00                    6986 	.db #0x00	;  0
      001B06 00                    6987 	.db #0x00	;  0
      001B07 00                    6988 	.db #0x00	;  0
      001B08 00                    6989 	.db #0x00	;  0
      001B09 00                    6990 	.db #0x00	;  0
      001B0A 00                    6991 	.db #0x00	;  0
      001B0B 00                    6992 	.db #0x00	;  0
      001B0C 00                    6993 	.db #0x00	;  0
      001B0D 00                    6994 	.db #0x00	;  0
      001B0E 00                    6995 	.db #0x00	;  0
      001B0F 00                    6996 	.db #0x00	;  0
      001B10 00                    6997 	.db #0x00	;  0
      001B11 00                    6998 	.db #0x00	;  0
      001B12 00                    6999 	.db #0x00	;  0
      001B13 00                    7000 	.db #0x00	;  0
      001B14 00                    7001 	.db #0x00	;  0
      001B15 00                    7002 	.db #0x00	;  0
      001B16 00                    7003 	.db #0x00	;  0
      001B17 00                    7004 	.db #0x00	;  0
      001B18 00                    7005 	.db #0x00	;  0
      001B19 00                    7006 	.db #0x00	;  0
      001B1A 00                    7007 	.db #0x00	;  0
      001B1B 00                    7008 	.db #0x00	;  0
      001B1C 00                    7009 	.db #0x00	;  0
      001B1D 00                    7010 	.db #0x00	;  0
      001B1E 00                    7011 	.db #0x00	;  0
      001B1F 00                    7012 	.db #0x00	;  0
      001B20 00                    7013 	.db #0x00	;  0
      001B21 00                    7014 	.db #0x00	;  0
      001B22 00                    7015 	.db #0x00	;  0
      001B23 00                    7016 	.db #0x00	;  0
      001B24 00                    7017 	.db #0x00	;  0
      001B25 00                    7018 	.db #0x00	;  0
      001B26 00                    7019 	.db #0x00	;  0
      001B27 00                    7020 	.db #0x00	;  0
      001B28 00                    7021 	.db #0x00	;  0
      001B29 00                    7022 	.db #0x00	;  0
      001B2A 00                    7023 	.db #0x00	;  0
      001B2B 00                    7024 	.db #0x00	;  0
      001B2C 00                    7025 	.db #0x00	;  0
      001B2D 00                    7026 	.db #0x00	;  0
      001B2E 00                    7027 	.db #0x00	;  0
      001B2F 00                    7028 	.db #0x00	;  0
      001B30 00                    7029 	.db #0x00	;  0
      001B31 00                    7030 	.db #0x00	;  0
      001B32 00                    7031 	.db #0x00	;  0
      001B33 00                    7032 	.db #0x00	;  0
      001B34 00                    7033 	.db #0x00	;  0
      001B35 00                    7034 	.db #0x00	;  0
      001B36 00                    7035 	.db #0x00	;  0
      001B37 00                    7036 	.db #0x00	;  0
      001B38 00                    7037 	.db #0x00	;  0
      001B39 00                    7038 	.db #0x00	;  0
      001B3A 00                    7039 	.db #0x00	;  0
      001B3B 00                    7040 	.db #0x00	;  0
      001B3C 00                    7041 	.db #0x00	;  0
      001B3D 00                    7042 	.db #0x00	;  0
      001B3E 00                    7043 	.db #0x00	;  0
      001B3F 00                    7044 	.db #0x00	;  0
      001B40 00                    7045 	.db #0x00	;  0
      001B41 00                    7046 	.db #0x00	;  0
      001B42 00                    7047 	.db #0x00	;  0
      001B43 00                    7048 	.db #0x00	;  0
      001B44 00                    7049 	.db #0x00	;  0
      001B45 00                    7050 	.db #0x00	;  0
      001B46 00                    7051 	.db #0x00	;  0
      001B47 00                    7052 	.db #0x00	;  0
      001B48 00                    7053 	.db #0x00	;  0
      001B49 00                    7054 	.db #0x00	;  0
      001B4A 00                    7055 	.db #0x00	;  0
      001B4B 00                    7056 	.db #0x00	;  0
      001B4C 00                    7057 	.db #0x00	;  0
      001B4D 00                    7058 	.db #0x00	;  0
      001B4E 00                    7059 	.db #0x00	;  0
      001B4F 00                    7060 	.db #0x00	;  0
      001B50 00                    7061 	.db #0x00	;  0
      001B51 00                    7062 	.db #0x00	;  0
      001B52 00                    7063 	.db #0x00	;  0
      001B53 00                    7064 	.db #0x00	;  0
      001B54 00                    7065 	.db #0x00	;  0
      001B55 00                    7066 	.db #0x00	;  0
      001B56 00                    7067 	.db #0x00	;  0
      001B57 00                    7068 	.db #0x00	;  0
      001B58 00                    7069 	.db #0x00	;  0
      001B59 00                    7070 	.db #0x00	;  0
      001B5A 00                    7071 	.db #0x00	;  0
      001B5B 00                    7072 	.db #0x00	;  0
      001B5C 00                    7073 	.db #0x00	;  0
      001B5D 00                    7074 	.db #0x00	;  0
      001B5E 00                    7075 	.db #0x00	;  0
      001B5F 02                    7076 	.db #0x02	;  2
      001B60 FB                    7077 	.db #0xfb	; -5
      001B61 00                    7078 	.db #0x00	;  0
      001B62 FF                    7079 	.db #0xff	; -1
      001B63 00                    7080 	.db #0x00	;  0
      001B64 05                    7081 	.db #0x05	;  5
      001B65 01                    7082 	.db #0x01	;  1
      001B66 FA                    7083 	.db #0xfa	; -6
      001B67 01                    7084 	.db #0x01	;  1
      001B68 FF                    7085 	.db #0xff	; -1
      001B69 00                    7086 	.db #0x00	;  0
      001B6A 01                    7087 	.db #0x01	;  1
      001B6B 00                    7088 	.db #0x00	;  0
      001B6C 00                    7089 	.db #0x00	;  0
      001B6D 00                    7090 	.db #0x00	;  0
      001B6E 00                    7091 	.db #0x00	;  0
      001B6F 00                    7092 	.db #0x00	;  0
      001B70 00                    7093 	.db #0x00	;  0
      001B71 00                    7094 	.db #0x00	;  0
      001B72 F8                    7095 	.db #0xf8	; -8
      001B73 FF                    7096 	.db #0xff	; -1
      001B74 FD                    7097 	.db #0xfd	; -3
      001B75 00                    7098 	.db #0x00	;  0
      001B76 02                    7099 	.db #0x02	;  2
      001B77 00                    7100 	.db #0x00	;  0
      001B78 00                    7101 	.db #0x00	;  0
      001B79 00                    7102 	.db #0x00	;  0
      001B7A 02                    7103 	.db #0x02	;  2
      001B7B 00                    7104 	.db #0x00	;  0
      001B7C 05                    7105 	.db #0x05	;  5
      001B7D 00                    7106 	.db #0x00	;  0
      001B7E 00                    7107 	.db #0x00	;  0
      001B7F FC                    7108 	.db #0xfc	; -4
      001B80 F9                    7109 	.db #0xf9	; -7
      001B81 00                    7110 	.db #0x00	;  0
      001B82 03                    7111 	.db #0x03	;  3
      001B83 00                    7112 	.db #0x00	;  0
      001B84 FF                    7113 	.db #0xff	; -1
      001B85 04                    7114 	.db #0x04	;  4
      001B86 04                    7115 	.db #0x04	;  4
      001B87 00                    7116 	.db #0x00	;  0
      001B88 08                    7117 	.db #0x08	;  8
      001B89 00                    7118 	.db #0x00	;  0
      001B8A 04                    7119 	.db #0x04	;  4
      001B8B 01                    7120 	.db #0x01	;  1
      001B8C 00                    7121 	.db #0x00	;  0
      001B8D FF                    7122 	.db #0xff	; -1
      001B8E FA                    7123 	.db #0xfa	; -6
      001B8F 03                    7124 	.db #0x03	;  3
      001B90 FF                    7125 	.db #0xff	; -1
      001B91 00                    7126 	.db #0x00	;  0
      001B92 00                    7127 	.db #0x00	;  0
      001B93 FD                    7128 	.db #0xfd	; -3
      001B94 F5                    7129 	.db #0xf5	; -11
      001B95 00                    7130 	.db #0x00	;  0
      001B96 02                    7131 	.db #0x02	;  2
      001B97 FC                    7132 	.db #0xfc	; -4
      001B98 00                    7133 	.db #0x00	;  0
      001B99 07                    7134 	.db #0x07	;  7
      001B9A FF                    7135 	.db #0xff	; -1
      001B9B 00                    7136 	.db #0x00	;  0
      001B9C 00                    7137 	.db #0x00	;  0
      001B9D 02                    7138 	.db #0x02	;  2
      001B9E 03                    7139 	.db #0x03	;  3
      001B9F F8                    7140 	.db #0xf8	; -8
      001BA0 FE                    7141 	.db #0xfe	; -2
      001BA1 01                    7142 	.db #0x01	;  1
      001BA2 00                    7143 	.db #0x00	;  0
      001BA3 00                    7144 	.db #0x00	;  0
      001BA4 F9                    7145 	.db #0xf9	; -7
      001BA5 05                    7146 	.db #0x05	;  5
      001BA6 F8                    7147 	.db #0xf8	; -8
      001BA7 FF                    7148 	.db #0xff	; -1
      001BA8 0A                    7149 	.db #0x0a	;  10
      001BA9 00                    7150 	.db #0x00	;  0
      001BAA 07                    7151 	.db #0x07	;  7
      001BAB 05                    7152 	.db #0x05	;  5
      001BAC 03                    7153 	.db #0x03	;  3
      001BAD 06                    7154 	.db #0x06	;  6
      001BAE F4                    7155 	.db #0xf4	; -12
      001BAF 01                    7156 	.db #0x01	;  1
      001BB0 FA                    7157 	.db #0xfa	; -6
      001BB1 04                    7158 	.db #0x04	;  4
      001BB2 08                    7159 	.db #0x08	;  8
      001BB3 FC                    7160 	.db #0xfc	; -4
      001BB4 FB                    7161 	.db #0xfb	; -5
      001BB5 00                    7162 	.db #0x00	;  0
      001BB6 01                    7163 	.db #0x01	;  1
      001BB7 FE                    7164 	.db #0xfe	; -2
      001BB8 00                    7165 	.db #0x00	;  0
      001BB9 04                    7166 	.db #0x04	;  4
      001BBA FE                    7167 	.db #0xfe	; -2
      001BBB FB                    7168 	.db #0xfb	; -5
      001BBC F4                    7169 	.db #0xf4	; -12
      001BBD FA                    7170 	.db #0xfa	; -6
      001BBE FA                    7171 	.db #0xfa	; -6
      001BBF 04                    7172 	.db #0x04	;  4
      001BC0 F4                    7173 	.db #0xf4	; -12
      001BC1 F8                    7174 	.db #0xf8	; -8
      001BC2 FD                    7175 	.db #0xfd	; -3
      001BC3 00                    7176 	.db #0x00	;  0
      001BC4 FF                    7177 	.db #0xff	; -1
      001BC5 0F                    7178 	.db #0x0f	;  15
      001BC6 01                    7179 	.db #0x01	;  1
      001BC7 00                    7180 	.db #0x00	;  0
      001BC8 01                    7181 	.db #0x01	;  1
      001BC9 00                    7182 	.db #0x00	;  0
      001BCA 04                    7183 	.db #0x04	;  4
      001BCB 02                    7184 	.db #0x02	;  2
      001BCC FE                    7185 	.db #0xfe	; -2
      001BCD 01                    7186 	.db #0x01	;  1
      001BCE F5                    7187 	.db #0xf5	; -11
      001BCF 08                    7188 	.db #0x08	;  8
      001BD0 FF                    7189 	.db #0xff	; -1
      001BD1 0E                    7190 	.db #0x0e	;  14
      001BD2 FD                    7191 	.db #0xfd	; -3
      001BD3 F6                    7192 	.db #0xf6	; -10
      001BD4 F1                    7193 	.db #0xf1	; -15
      001BD5 00                    7194 	.db #0x00	;  0
      001BD6 01                    7195 	.db #0x01	;  1
      001BD7 FA                    7196 	.db #0xfa	; -6
      001BD8 00                    7197 	.db #0x00	;  0
      001BD9 08                    7198 	.db #0x08	;  8
      001BDA FE                    7199 	.db #0xfe	; -2
      001BDB 00                    7200 	.db #0x00	;  0
      001BDC FC                    7201 	.db #0xfc	; -4
      001BDD 09                    7202 	.db #0x09	;  9
      001BDE FD                    7203 	.db #0xfd	; -3
      001BDF 09                    7204 	.db #0x09	;  9
      001BE0 EE                    7205 	.db #0xee	; -18
      001BE1 FC                    7206 	.db #0xfc	; -4
      001BE2 08                    7207 	.db #0x08	;  8
      001BE3 00                    7208 	.db #0x00	;  0
      001BE4 00                    7209 	.db #0x00	;  0
      001BE5 05                    7210 	.db #0x05	;  5
      001BE6 03                    7211 	.db #0x03	;  3
      001BE7 FC                    7212 	.db #0xfc	; -4
      001BE8 0E                    7213 	.db #0x0e	;  14
      001BE9 00                    7214 	.db #0x00	;  0
      001BEA FE                    7215 	.db #0xfe	; -2
      001BEB 01                    7216 	.db #0x01	;  1
      001BEC 04                    7217 	.db #0x04	;  4
      001BED 13                    7218 	.db #0x13	;  19
      001BEE FC                    7219 	.db #0xfc	; -4
      001BEF 0B                    7220 	.db #0x0b	;  11
      001BF0 FE                    7221 	.db #0xfe	; -2
      001BF1 F8                    7222 	.db #0xf8	; -8
      001BF2 06                    7223 	.db #0x06	;  6
      001BF3 04                    7224 	.db #0x04	;  4
      001BF4 F6                    7225 	.db #0xf6	; -10
      001BF5 00                    7226 	.db #0x00	;  0
      001BF6 00                    7227 	.db #0x00	;  0
      001BF7 FA                    7228 	.db #0xfa	; -6
      001BF8 02                    7229 	.db #0x02	;  2
      001BF9 02                    7230 	.db #0x02	;  2
      001BFA 0B                    7231 	.db #0x0b	;  11
      001BFB FF                    7232 	.db #0xff	; -1
      001BFC 04                    7233 	.db #0x04	;  4
      001BFD FB                    7234 	.db #0xfb	; -5
      001BFE 00                    7235 	.db #0x00	;  0
      001BFF F4                    7236 	.db #0xf4	; -12
      001C00 F8                    7237 	.db #0xf8	; -8
      001C01 FD                    7238 	.db #0xfd	; -3
      001C02 FE                    7239 	.db #0xfe	; -2
      001C03 00                    7240 	.db #0x00	;  0
      001C04 0C                    7241 	.db #0x0c	;  12
      001C05 17                    7242 	.db #0x17	;  23
      001C06 09                    7243 	.db #0x09	;  9
      001C07 F8                    7244 	.db #0xf8	; -8
      001C08 0B                    7245 	.db #0x0b	;  11
      001C09 00                    7246 	.db #0x00	;  0
      001C0A 03                    7247 	.db #0x03	;  3
      001C0B 08                    7248 	.db #0x08	;  8
      001C0C 0D                    7249 	.db #0x0d	;  13
      001C0D 12                    7250 	.db #0x12	;  18
      001C0E FC                    7251 	.db #0xfc	; -4
      001C0F 0A                    7252 	.db #0x0a	;  10
      001C10 01                    7253 	.db #0x01	;  1
      001C11 FD                    7254 	.db #0xfd	; -3
      001C12 1A                    7255 	.db #0x1a	;  26
      001C13 01                    7256 	.db #0x01	;  1
      001C14 EF                    7257 	.db #0xef	; -17
      001C15 00                    7258 	.db #0x00	;  0
      001C16 F2                    7259 	.db #0xf2	; -14
      001C17 FA                    7260 	.db #0xfa	; -6
      001C18 F8                    7261 	.db #0xf8	; -8
      001C19 02                    7262 	.db #0x02	;  2
      001C1A 04                    7263 	.db #0x04	;  4
      001C1B FA                    7264 	.db #0xfa	; -6
      001C1C F5                    7265 	.db #0xf5	; -11
      001C1D 05                    7266 	.db #0x05	;  5
      001C1E 06                    7267 	.db #0x06	;  6
      001C1F FC                    7268 	.db #0xfc	; -4
      001C20 F4                    7269 	.db #0xf4	; -12
      001C21 FE                    7270 	.db #0xfe	; -2
      001C22 FA                    7271 	.db #0xfa	; -6
      001C23 00                    7272 	.db #0x00	;  0
      001C24 02                    7273 	.db #0x02	;  2
      001C25 0A                    7274 	.db #0x0a	;  10
      001C26 F3                    7275 	.db #0xf3	; -13
      001C27 F6                    7276 	.db #0xf6	; -10
      001C28 01                    7277 	.db #0x01	;  1
      001C29 00                    7278 	.db #0x00	;  0
      001C2A 03                    7279 	.db #0x03	;  3
      001C2B 01                    7280 	.db #0x01	;  1
      001C2C 06                    7281 	.db #0x06	;  6
      001C2D 11                    7282 	.db #0x11	;  17
      001C2E 01                    7283 	.db #0x01	;  1
      001C2F 0A                    7284 	.db #0x0a	;  10
      001C30 02                    7285 	.db #0x02	;  2
      001C31 00                    7286 	.db #0x00	;  0
      001C32 05                    7287 	.db #0x05	;  5
      001C33 FE                    7288 	.db #0xfe	; -2
      001C34 FD                    7289 	.db #0xfd	; -3
      001C35 00                    7290 	.db #0x00	;  0
      001C36 FF                    7291 	.db #0xff	; -1
      001C37 F6                    7292 	.db #0xf6	; -10
      001C38 0D                    7293 	.db #0x0d	;  13
      001C39 FF                    7294 	.db #0xff	; -1
      001C3A 03                    7295 	.db #0x03	;  3
      001C3B 04                    7296 	.db #0x04	;  4
      001C3C 07                    7297 	.db #0x07	;  7
      001C3D 0A                    7298 	.db #0x0a	;  10
      001C3E 02                    7299 	.db #0x02	;  2
      001C3F FF                    7300 	.db #0xff	; -1
      001C40 EF                    7301 	.db #0xef	; -17
      001C41 02                    7302 	.db #0x02	;  2
      001C42 FF                    7303 	.db #0xff	; -1
      001C43 00                    7304 	.db #0x00	;  0
      001C44 FD                    7305 	.db #0xfd	; -3
      001C45 09                    7306 	.db #0x09	;  9
      001C46 09                    7307 	.db #0x09	;  9
      001C47 FB                    7308 	.db #0xfb	; -5
      001C48 00                    7309 	.db #0x00	;  0
      001C49 00                    7310 	.db #0x00	;  0
      001C4A 05                    7311 	.db #0x05	;  5
      001C4B FF                    7312 	.db #0xff	; -1
      001C4C 04                    7313 	.db #0x04	;  4
      001C4D 11                    7314 	.db #0x11	;  17
      001C4E 02                    7315 	.db #0x02	;  2
      001C4F FF                    7316 	.db #0xff	; -1
      001C50 03                    7317 	.db #0x03	;  3
      001C51 06                    7318 	.db #0x06	;  6
      001C52 05                    7319 	.db #0x05	;  5
      001C53 FC                    7320 	.db #0xfc	; -4
      001C54 FE                    7321 	.db #0xfe	; -2
      001C55 00                    7322 	.db #0x00	;  0
      001C56 F9                    7323 	.db #0xf9	; -7
      001C57 FE                    7324 	.db #0xfe	; -2
      001C58 FE                    7325 	.db #0xfe	; -2
      001C59 FF                    7326 	.db #0xff	; -1
      001C5A 01                    7327 	.db #0x01	;  1
      001C5B FB                    7328 	.db #0xfb	; -5
      001C5C 02                    7329 	.db #0x02	;  2
      001C5D 0D                    7330 	.db #0x0d	;  13
      001C5E FF                    7331 	.db #0xff	; -1
      001C5F 04                    7332 	.db #0x04	;  4
      001C60 FA                    7333 	.db #0xfa	; -6
      001C61 F9                    7334 	.db #0xf9	; -7
      001C62 05                    7335 	.db #0x05	;  5
      001C63 00                    7336 	.db #0x00	;  0
      001C64 01                    7337 	.db #0x01	;  1
      001C65 02                    7338 	.db #0x02	;  2
      001C66 FA                    7339 	.db #0xfa	; -6
      001C67 FC                    7340 	.db #0xfc	; -4
      001C68 FF                    7341 	.db #0xff	; -1
      001C69 00                    7342 	.db #0x00	;  0
      001C6A 01                    7343 	.db #0x01	;  1
      001C6B FE                    7344 	.db #0xfe	; -2
      001C6C 05                    7345 	.db #0x05	;  5
      001C6D 08                    7346 	.db #0x08	;  8
      001C6E 00                    7347 	.db #0x00	;  0
      001C6F 01                    7348 	.db #0x01	;  1
      001C70 02                    7349 	.db #0x02	;  2
      001C71 F3                    7350 	.db #0xf3	; -13
      001C72 01                    7351 	.db #0x01	;  1
      001C73 F9                    7352 	.db #0xf9	; -7
      001C74 FD                    7353 	.db #0xfd	; -3
      001C75 00                    7354 	.db #0x00	;  0
      001C76 00                    7355 	.db #0x00	;  0
      001C77 FF                    7356 	.db #0xff	; -1
      001C78 09                    7357 	.db #0x09	;  9
      001C79 01                    7358 	.db #0x01	;  1
      001C7A 00                    7359 	.db #0x00	;  0
      001C7B 00                    7360 	.db #0x00	;  0
      001C7C 01                    7361 	.db #0x01	;  1
      001C7D 01                    7362 	.db #0x01	;  1
      001C7E 01                    7363 	.db #0x01	;  1
      001C7F 00                    7364 	.db #0x00	;  0
      001C80 FF                    7365 	.db #0xff	; -1
      001C81 00                    7366 	.db #0x00	;  0
      001C82 00                    7367 	.db #0x00	;  0
      001C83 00                    7368 	.db #0x00	;  0
      001C84 00                    7369 	.db #0x00	;  0
      001C85 03                    7370 	.db #0x03	;  3
      001C86 00                    7371 	.db #0x00	;  0
      001C87 00                    7372 	.db #0x00	;  0
      001C88 00                    7373 	.db #0x00	;  0
      001C89 00                    7374 	.db #0x00	;  0
      001C8A 00                    7375 	.db #0x00	;  0
      001C8B 00                    7376 	.db #0x00	;  0
      001C8C FF                    7377 	.db #0xff	; -1
      001C8D 02                    7378 	.db #0x02	;  2
      001C8E 00                    7379 	.db #0x00	;  0
      001C8F 00                    7380 	.db #0x00	;  0
      001C90 FD                    7381 	.db #0xfd	; -3
      001C91 00                    7382 	.db #0x00	;  0
      001C92 03                    7383 	.db #0x03	;  3
      001C93 00                    7384 	.db #0x00	;  0
      001C94 FD                    7385 	.db #0xfd	; -3
      001C95 00                    7386 	.db #0x00	;  0
      001C96 FE                    7387 	.db #0xfe	; -2
      001C97 FE                    7388 	.db #0xfe	; -2
      001C98 00                    7389 	.db #0x00	;  0
      001C99 00                    7390 	.db #0x00	;  0
      001C9A 00                    7391 	.db #0x00	;  0
      001C9B 00                    7392 	.db #0x00	;  0
      001C9C 02                    7393 	.db #0x02	;  2
      001C9D 00                    7394 	.db #0x00	;  0
      001C9E 00                    7395 	.db #0x00	;  0
      001C9F 00                    7396 	.db #0x00	;  0
      001CA0 00                    7397 	.db #0x00	;  0
      001CA1 00                    7398 	.db #0x00	;  0
      001CA2 00                    7399 	.db #0x00	;  0
      001CA3 00                    7400 	.db #0x00	;  0
      001CA4 00                    7401 	.db #0x00	;  0
      001CA5 00                    7402 	.db #0x00	;  0
      001CA6 00                    7403 	.db #0x00	;  0
      001CA7 00                    7404 	.db #0x00	;  0
      001CA8 00                    7405 	.db #0x00	;  0
      001CA9 00                    7406 	.db #0x00	;  0
      001CAA 00                    7407 	.db #0x00	;  0
      001CAB 00                    7408 	.db #0x00	;  0
      001CAC 00                    7409 	.db #0x00	;  0
      001CAD 00                    7410 	.db #0x00	;  0
      001CAE 00                    7411 	.db #0x00	;  0
      001CAF 00                    7412 	.db #0x00	;  0
      001CB0 00                    7413 	.db #0x00	;  0
      001CB1 00                    7414 	.db #0x00	;  0
      001CB2 00                    7415 	.db #0x00	;  0
      001CB3 00                    7416 	.db #0x00	;  0
      001CB4 00                    7417 	.db #0x00	;  0
      001CB5 00                    7418 	.db #0x00	;  0
      001CB6 00                    7419 	.db #0x00	;  0
      001CB7 00                    7420 	.db #0x00	;  0
      001CB8 00                    7421 	.db #0x00	;  0
      001CB9 00                    7422 	.db #0x00	;  0
      001CBA 00                    7423 	.db #0x00	;  0
      001CBB 00                    7424 	.db #0x00	;  0
      001CBC 00                    7425 	.db #0x00	;  0
      001CBD 00                    7426 	.db #0x00	;  0
      001CBE 00                    7427 	.db #0x00	;  0
      001CBF 00                    7428 	.db #0x00	;  0
      001CC0 00                    7429 	.db #0x00	;  0
      001CC1 00                    7430 	.db #0x00	;  0
      001CC2 00                    7431 	.db #0x00	;  0
      001CC3 00                    7432 	.db #0x00	;  0
      001CC4 00                    7433 	.db #0x00	;  0
      001CC5 00                    7434 	.db #0x00	;  0
      001CC6 00                    7435 	.db #0x00	;  0
      001CC7 00                    7436 	.db #0x00	;  0
      001CC8 00                    7437 	.db #0x00	;  0
      001CC9 00                    7438 	.db #0x00	;  0
      001CCA 00                    7439 	.db #0x00	;  0
      001CCB 00                    7440 	.db #0x00	;  0
      001CCC 00                    7441 	.db #0x00	;  0
      001CCD 00                    7442 	.db #0x00	;  0
      001CCE 00                    7443 	.db #0x00	;  0
      001CCF 00                    7444 	.db #0x00	;  0
      001CD0 00                    7445 	.db #0x00	;  0
      001CD1 00                    7446 	.db #0x00	;  0
      001CD2 00                    7447 	.db #0x00	;  0
      001CD3 00                    7448 	.db #0x00	;  0
      001CD4 00                    7449 	.db #0x00	;  0
      001CD5 00                    7450 	.db #0x00	;  0
      001CD6 00                    7451 	.db #0x00	;  0
      001CD7 00                    7452 	.db #0x00	;  0
      001CD8 00                    7453 	.db #0x00	;  0
      001CD9 00                    7454 	.db #0x00	;  0
      001CDA 00                    7455 	.db #0x00	;  0
      001CDB 00                    7456 	.db #0x00	;  0
      001CDC 00                    7457 	.db #0x00	;  0
                                   7458 	.area CSEG    (CODE)
                                   7459 	.area CONST   (CODE)
      001CDD                       7460 _B2:
      001CDD 1F F8 FF FF           7461 	.byte #0x1f, #0xf8, #0xff, #0xff	; -2017
      001CE1 56 FD FF FF           7462 	.byte #0x56, #0xfd, #0xff, #0xff	; -682
      001CE5 4E FC FF FF           7463 	.byte #0x4e, #0xfc, #0xff, #0xff	; -946
      001CE9 F2 FC FF FF           7464 	.byte #0xf2, #0xfc, #0xff, #0xff	; -782
      001CED 27 00 00 00           7465 	.byte #0x27, #0x00, #0x00, #0x00	;  39
      001CF1 72 FD FF FF           7466 	.byte #0x72, #0xfd, #0xff, #0xff	; -654
      001CF5 99 FB FF FF           7467 	.byte #0x99, #0xfb, #0xff, #0xff	; -1127
      001CF9 1C F9 FF FF           7468 	.byte #0x1c, #0xf9, #0xff, #0xff	; -1764
      001CFD 27 11 00 00           7469 	.byte #0x27, #0x11, #0x00, #0x00	;  4391
      001D01 F7 04 00 00           7470 	.byte #0xf7, #0x04, #0x00, #0x00	;  1271
                                   7471 	.area CSEG    (CODE)
                                   7472 	.area CONST   (CODE)
      001D05                       7473 _W2:
      001D05 2B                    7474 	.db #0x2b	;  43
      001D06 31                    7475 	.db #0x31	;  49	'1'
      001D07 22                    7476 	.db #0x22	;  34
      001D08 E9                    7477 	.db #0xe9	; -23
      001D09 DF                    7478 	.db #0xdf	; -33
      001D0A DD                    7479 	.db #0xdd	; -35
      001D0B 00                    7480 	.db #0x00	;  0
      001D0C C1                    7481 	.db #0xc1	; -63
      001D0D B4                    7482 	.db #0xb4	; -76
      001D0E EA                    7483 	.db #0xea	; -22
      001D0F AE                    7484 	.db #0xae	; -82
      001D10 47                    7485 	.db #0x47	;  71	'G'
      001D11 00                    7486 	.db #0x00	;  0
      001D12 93                    7487 	.db #0x93	; -109
      001D13 2C                    7488 	.db #0x2c	;  44
      001D14 FB                    7489 	.db #0xfb	; -5
      001D15 20                    7490 	.db #0x20	;  32
      001D16 30                    7491 	.db #0x30	;  48	'0'
      001D17 CF                    7492 	.db #0xcf	; -49
      001D18 34                    7493 	.db #0x34	;  52	'4'
      001D19 EE                    7494 	.db #0xee	; -18
      001D1A B9                    7495 	.db #0xb9	; -71
      001D1B 02                    7496 	.db #0x02	;  2
      001D1C 15                    7497 	.db #0x15	;  21
      001D1D 00                    7498 	.db #0x00	;  0
      001D1E 02                    7499 	.db #0x02	;  2
      001D1F 10                    7500 	.db #0x10	;  16
      001D20 CE                    7501 	.db #0xce	; -50
      001D21 1A                    7502 	.db #0x1a	;  26
      001D22 A1                    7503 	.db #0xa1	; -95
      001D23 EB                    7504 	.db #0xeb	; -21
      001D24 FB                    7505 	.db #0xfb	; -5
      001D25 BC                    7506 	.db #0xbc	; -68
      001D26 DE                    7507 	.db #0xde	; -34
      001D27 EE                    7508 	.db #0xee	; -18
      001D28 50                    7509 	.db #0x50	;  80	'P'
      001D29 3F                    7510 	.db #0x3f	;  63
      001D2A 41                    7511 	.db #0x41	;  65	'A'
      001D2B 00                    7512 	.db #0x00	;  0
      001D2C EF                    7513 	.db #0xef	; -17
      001D2D E4                    7514 	.db #0xe4	; -28
      001D2E FD                    7515 	.db #0xfd	; -3
      001D2F D3                    7516 	.db #0xd3	; -45
      001D30 CB                    7517 	.db #0xcb	; -53
      001D31 00                    7518 	.db #0x00	;  0
      001D32 CC                    7519 	.db #0xcc	; -52
      001D33 01                    7520 	.db #0x01	;  1
      001D34 3A                    7521 	.db #0x3a	;  58
      001D35 A8                    7522 	.db #0xa8	; -88
      001D36 EC                    7523 	.db #0xec	; -20
      001D37 0F                    7524 	.db #0x0f	;  15
      001D38 FF                    7525 	.db #0xff	; -1
      001D39 51                    7526 	.db #0x51	;  81	'Q'
      001D3A 35                    7527 	.db #0x35	;  53	'5'
      001D3B 44                    7528 	.db #0x44	;  68	'D'
      001D3C 09                    7529 	.db #0x09	;  9
      001D3D 00                    7530 	.db #0x00	;  0
      001D3E 92                    7531 	.db #0x92	; -110
      001D3F E5                    7532 	.db #0xe5	; -27
      001D40 C8                    7533 	.db #0xc8	; -56
      001D41 FA                    7534 	.db #0xfa	; -6
      001D42 0D                    7535 	.db #0x0d	;  13
      001D43 FD                    7536 	.db #0xfd	; -3
      001D44 F9                    7537 	.db #0xf9	; -7
      001D45 0A                    7538 	.db #0x0a	;  10
      001D46 C9                    7539 	.db #0xc9	; -55
      001D47 00                    7540 	.db #0x00	;  0
      001D48 E2                    7541 	.db #0xe2	; -30
      001D49 07                    7542 	.db #0x07	;  7
      001D4A 4C                    7543 	.db #0x4c	;  76	'L'
      001D4B 00                    7544 	.db #0x00	;  0
      001D4C AD                    7545 	.db #0xad	; -83
      001D4D 08                    7546 	.db #0x08	;  8
      001D4E 3A                    7547 	.db #0x3a	;  58
      001D4F DE                    7548 	.db #0xde	; -34
      001D50 D3                    7549 	.db #0xd3	; -45
      001D51 00                    7550 	.db #0x00	;  0
      001D52 EB                    7551 	.db #0xeb	; -21
      001D53 DB                    7552 	.db #0xdb	; -37
      001D54 1E                    7553 	.db #0x1e	;  30
      001D55 13                    7554 	.db #0x13	;  19
      001D56 DC                    7555 	.db #0xdc	; -36
      001D57 0F                    7556 	.db #0x0f	;  15
      001D58 2B                    7557 	.db #0x2b	;  43
      001D59 1F                    7558 	.db #0x1f	;  31
      001D5A 49                    7559 	.db #0x49	;  73	'I'
      001D5B AB                    7560 	.db #0xab	; -85
      001D5C F3                    7561 	.db #0xf3	; -13
      001D5D 00                    7562 	.db #0x00	;  0
      001D5E ED                    7563 	.db #0xed	; -19
      001D5F 56                    7564 	.db #0x56	;  86	'V'
      001D60 CC                    7565 	.db #0xcc	; -52
      001D61 46                    7566 	.db #0x46	;  70	'F'
      001D62 A1                    7567 	.db #0xa1	; -95
      001D63 21                    7568 	.db #0x21	;  33
      001D64 FB                    7569 	.db #0xfb	; -5
      001D65 FF                    7570 	.db #0xff	; -1
      001D66 D7                    7571 	.db #0xd7	; -41
      001D67 24                    7572 	.db #0x24	;  36
      001D68 E0                    7573 	.db #0xe0	; -32
      001D69 28                    7574 	.db #0x28	;  40
      001D6A CA                    7575 	.db #0xca	; -54
      001D6B 00                    7576 	.db #0x00	;  0
      001D6C 1D                    7577 	.db #0x1d	;  29
      001D6D 41                    7578 	.db #0x41	;  65	'A'
      001D6E 24                    7579 	.db #0x24	;  36
      001D6F 45                    7580 	.db #0x45	;  69	'E'
      001D70 F0                    7581 	.db #0xf0	; -16
      001D71 00                    7582 	.db #0x00	;  0
      001D72 35                    7583 	.db #0x35	;  53	'5'
      001D73 C0                    7584 	.db #0xc0	; -64
      001D74 FB                    7585 	.db #0xfb	; -5
      001D75 1B                    7586 	.db #0x1b	;  27
      001D76 3A                    7587 	.db #0x3a	;  58
      001D77 29                    7588 	.db #0x29	;  41
      001D78 C7                    7589 	.db #0xc7	; -57
      001D79 20                    7590 	.db #0x20	;  32
      001D7A 07                    7591 	.db #0x07	;  7
      001D7B B9                    7592 	.db #0xb9	; -71
      001D7C F9                    7593 	.db #0xf9	; -7
      001D7D 00                    7594 	.db #0x00	;  0
      001D7E C2                    7595 	.db #0xc2	; -62
      001D7F E2                    7596 	.db #0xe2	; -30
      001D80 0C                    7597 	.db #0x0c	;  12
      001D81 1E                    7598 	.db #0x1e	;  30
      001D82 E7                    7599 	.db #0xe7	; -25
      001D83 F5                    7600 	.db #0xf5	; -11
      001D84 D1                    7601 	.db #0xd1	; -47
      001D85 C9                    7602 	.db #0xc9	; -55
      001D86 30                    7603 	.db #0x30	;  48	'0'
      001D87 A4                    7604 	.db #0xa4	; -92
      001D88 54                    7605 	.db #0x54	;  84	'T'
      001D89 3A                    7606 	.db #0x3a	;  58
      001D8A 01                    7607 	.db #0x01	;  1
      001D8B 00                    7608 	.db #0x00	;  0
      001D8C 45                    7609 	.db #0x45	;  69	'E'
      001D8D F6                    7610 	.db #0xf6	; -10
      001D8E EC                    7611 	.db #0xec	; -20
      001D8F FD                    7612 	.db #0xfd	; -3
      001D90 14                    7613 	.db #0x14	;  20
      001D91 00                    7614 	.db #0x00	;  0
      001D92 18                    7615 	.db #0x18	;  24
      001D93 16                    7616 	.db #0x16	;  22
      001D94 9E                    7617 	.db #0x9e	; -98
      001D95 9E                    7618 	.db #0x9e	; -98
      001D96 9D                    7619 	.db #0x9d	; -99
      001D97 02                    7620 	.db #0x02	;  2
      001D98 DE                    7621 	.db #0xde	; -34
      001D99 24                    7622 	.db #0x24	;  36
      001D9A EF                    7623 	.db #0xef	; -17
      001D9B 2B                    7624 	.db #0x2b	;  43
      001D9C 41                    7625 	.db #0x41	;  65	'A'
      001D9D 00                    7626 	.db #0x00	;  0
      001D9E 39                    7627 	.db #0x39	;  57	'9'
      001D9F 26                    7628 	.db #0x26	;  38
      001DA0 D2                    7629 	.db #0xd2	; -46
      001DA1 B2                    7630 	.db #0xb2	; -78
      001DA2 FE                    7631 	.db #0xfe	; -2
      001DA3 B4                    7632 	.db #0xb4	; -76
      001DA4 0B                    7633 	.db #0x0b	;  11
      001DA5 E3                    7634 	.db #0xe3	; -29
      001DA6 EF                    7635 	.db #0xef	; -17
      001DA7 33                    7636 	.db #0x33	;  51	'3'
      001DA8 D8                    7637 	.db #0xd8	; -40
      001DA9 A0                    7638 	.db #0xa0	; -96
      001DAA D2                    7639 	.db #0xd2	; -46
      001DAB 00                    7640 	.db #0x00	;  0
      001DAC 1D                    7641 	.db #0x1d	;  29
      001DAD 1A                    7642 	.db #0x1a	;  26
      001DAE E7                    7643 	.db #0xe7	; -25
      001DAF 3E                    7644 	.db #0x3e	;  62
      001DB0 09                    7645 	.db #0x09	;  9
      001DB1 00                    7646 	.db #0x00	;  0
      001DB2 24                    7647 	.db #0x24	;  36
      001DB3 CD                    7648 	.db #0xcd	; -51
      001DB4 23                    7649 	.db #0x23	;  35
      001DB5 2E                    7650 	.db #0x2e	;  46
      001DB6 43                    7651 	.db #0x43	;  67	'C'
      001DB7 B1                    7652 	.db #0xb1	; -79
      001DB8 E4                    7653 	.db #0xe4	; -28
      001DB9 81                    7654 	.db #0x81	; -127
      001DBA FB                    7655 	.db #0xfb	; -5
      001DBB 18                    7656 	.db #0x18	;  24
      001DBC F9                    7657 	.db #0xf9	; -7
      001DBD 00                    7658 	.db #0x00	;  0
      001DBE 04                    7659 	.db #0x04	;  4
      001DBF 02                    7660 	.db #0x02	;  2
      001DC0 60                    7661 	.db #0x60	;  96
      001DC1 E3                    7662 	.db #0xe3	; -29
      001DC2 49                    7663 	.db #0x49	;  73	'I'
      001DC3 22                    7664 	.db #0x22	;  34
      001DC4 FB                    7665 	.db #0xfb	; -5
      001DC5 02                    7666 	.db #0x02	;  2
      001DC6 22                    7667 	.db #0x22	;  34
      001DC7 19                    7668 	.db #0x19	;  25
      001DC8 4A                    7669 	.db #0x4a	;  74	'J'
      001DC9 C9                    7670 	.db #0xc9	; -55
      001DCA DD                    7671 	.db #0xdd	; -35
      001DCB 00                    7672 	.db #0x00	;  0
      001DCC 99                    7673 	.db #0x99	; -103
      001DCD B9                    7674 	.db #0xb9	; -71
      001DCE D6                    7675 	.db #0xd6	; -42
      001DCF D5                    7676 	.db #0xd5	; -43
      001DD0 E7                    7677 	.db #0xe7	; -25
      001DD1 00                    7678 	.db #0x00	;  0
      001DD2 A9                    7679 	.db #0xa9	; -87
      001DD3 19                    7680 	.db #0x19	;  25
      001DD4 ED                    7681 	.db #0xed	; -19
      001DD5 C5                    7682 	.db #0xc5	; -59
      001DD6 1C                    7683 	.db #0x1c	;  28
      001DD7 D6                    7684 	.db #0xd6	; -42
      001DD8 16                    7685 	.db #0x16	;  22
      001DD9 CB                    7686 	.db #0xcb	; -53
      001DDA DA                    7687 	.db #0xda	; -38
      001DDB 60                    7688 	.db #0x60	;  96
      001DDC 2B                    7689 	.db #0x2b	;  43
      001DDD 00                    7690 	.db #0x00	;  0
      001DDE 07                    7691 	.db #0x07	;  7
      001DDF 0A                    7692 	.db #0x0a	;  10
      001DE0 5C                    7693 	.db #0x5c	;  92
      001DE1 DE                    7694 	.db #0xde	; -34
      001DE2 E1                    7695 	.db #0xe1	; -31
      001DE3 56                    7696 	.db #0x56	;  86	'V'
      001DE4 13                    7697 	.db #0x13	;  19
      001DE5 F2                    7698 	.db #0xf2	; -14
      001DE6 26                    7699 	.db #0x26	;  38
      001DE7 B9                    7700 	.db #0xb9	; -71
      001DE8 F0                    7701 	.db #0xf0	; -16
      001DE9 2B                    7702 	.db #0x2b	;  43
      001DEA 29                    7703 	.db #0x29	;  41
      001DEB 00                    7704 	.db #0x00	;  0
      001DEC EC                    7705 	.db #0xec	; -20
      001DED 24                    7706 	.db #0x24	;  36
      001DEE 3F                    7707 	.db #0x3f	;  63
      001DEF C2                    7708 	.db #0xc2	; -62
      001DF0 31                    7709 	.db #0x31	;  49	'1'
      001DF1 00                    7710 	.db #0x00	;  0
      001DF2 21                    7711 	.db #0x21	;  33
      001DF3 19                    7712 	.db #0x19	;  25
      001DF4 1F                    7713 	.db #0x1f	;  31
      001DF5 27                    7714 	.db #0x27	;  39
      001DF6 9F                    7715 	.db #0x9f	; -97
      001DF7 20                    7716 	.db #0x20	;  32
      001DF8 E4                    7717 	.db #0xe4	; -28
      001DF9 15                    7718 	.db #0x15	;  21
      001DFA 52                    7719 	.db #0x52	;  82	'R'
      001DFB CA                    7720 	.db #0xca	; -54
      001DFC C3                    7721 	.db #0xc3	; -61
      001DFD 00                    7722 	.db #0x00	;  0
      001DFE F1                    7723 	.db #0xf1	; -15
      001DFF E1                    7724 	.db #0xe1	; -31
      001E00 F8                    7725 	.db #0xf8	; -8
      001E01 14                    7726 	.db #0x14	;  20
      001E02 10                    7727 	.db #0x10	;  16
      001E03 0E                    7728 	.db #0x0e	;  14
      001E04 BD                    7729 	.db #0xbd	; -67
      001E05 02                    7730 	.db #0x02	;  2
      001E06 B3                    7731 	.db #0xb3	; -77
      001E07 29                    7732 	.db #0x29	;  41
      001E08 CA                    7733 	.db #0xca	; -54
      001E09 F6                    7734 	.db #0xf6	; -10
      001E0A CE                    7735 	.db #0xce	; -50
      001E0B 00                    7736 	.db #0x00	;  0
      001E0C D4                    7737 	.db #0xd4	; -44
      001E0D E1                    7738 	.db #0xe1	; -31
      001E0E 1D                    7739 	.db #0x1d	;  29
      001E0F 17                    7740 	.db #0x17	;  23
      001E10 01                    7741 	.db #0x01	;  1
      001E11 00                    7742 	.db #0x00	;  0
      001E12 C9                    7743 	.db #0xc9	; -55
      001E13 C0                    7744 	.db #0xc0	; -64
      001E14 E0                    7745 	.db #0xe0	; -32
      001E15 01                    7746 	.db #0x01	;  1
      001E16 25                    7747 	.db #0x25	;  37
      001E17 28                    7748 	.db #0x28	;  40
      001E18 37                    7749 	.db #0x37	;  55	'7'
      001E19 E7                    7750 	.db #0xe7	; -25
      001E1A DE                    7751 	.db #0xde	; -34
      001E1B EC                    7752 	.db #0xec	; -20
      001E1C E6                    7753 	.db #0xe6	; -26
      001E1D 00                    7754 	.db #0x00	;  0
      001E1E 34                    7755 	.db #0x34	;  52	'4'
      001E1F C9                    7756 	.db #0xc9	; -55
      001E20 ED                    7757 	.db #0xed	; -19
      001E21 E6                    7758 	.db #0xe6	; -26
      001E22 0C                    7759 	.db #0x0c	;  12
      001E23 FA                    7760 	.db #0xfa	; -6
      001E24 2C                    7761 	.db #0x2c	;  44
      001E25 3D                    7762 	.db #0x3d	;  61
      001E26 0F                    7763 	.db #0x0f	;  15
      001E27 D0                    7764 	.db #0xd0	; -48
      001E28 BE                    7765 	.db #0xbe	; -66
      001E29 E8                    7766 	.db #0xe8	; -24
      001E2A 15                    7767 	.db #0x15	;  21
      001E2B 00                    7768 	.db #0x00	;  0
      001E2C 41                    7769 	.db #0x41	;  65	'A'
      001E2D 25                    7770 	.db #0x25	;  37
      001E2E AB                    7771 	.db #0xab	; -85
      001E2F 2D                    7772 	.db #0x2d	;  45
      001E30 23                    7773 	.db #0x23	;  35
      001E31 00                    7774 	.db #0x00	;  0
      001E32 24                    7775 	.db #0x24	;  36
      001E33 23                    7776 	.db #0x23	;  35
      001E34 F3                    7777 	.db #0xf3	; -13
      001E35 0C                    7778 	.db #0x0c	;  12
      001E36 DF                    7779 	.db #0xdf	; -33
      001E37 1C                    7780 	.db #0x1c	;  28
      001E38 D0                    7781 	.db #0xd0	; -48
      001E39 E7                    7782 	.db #0xe7	; -25
      001E3A C5                    7783 	.db #0xc5	; -59
      001E3B EB                    7784 	.db #0xeb	; -21
      001E3C B7                    7785 	.db #0xb7	; -73
      001E3D 00                    7786 	.db #0x00	;  0
      001E3E 1E                    7787 	.db #0x1e	;  30
      001E3F D5                    7788 	.db #0xd5	; -43
      001E40 04                    7789 	.db #0x04	;  4
      001E41 01                    7790 	.db #0x01	;  1
      001E42 21                    7791 	.db #0x21	;  33
      001E43 AB                    7792 	.db #0xab	; -85
      001E44 1A                    7793 	.db #0x1a	;  26
                                   7794 	.area CSEG    (CODE)
                                   7795 	.area CONST   (CODE)
      001E45                       7796 _dsel:
      001E45 F7                    7797 	.db #0xf7	; 247
      001E46 EF                    7798 	.db #0xef	; 239
      001E47 DF                    7799 	.db #0xdf	; 223
      001E48 BF                    7800 	.db #0xbf	; 191
                                   7801 	.area CSEG    (CODE)
                                   7802 	.area CONST   (CODE)
      001E49                       7803 _segs:
      001E49 C0                    7804 	.db #0xc0	; 192
      001E4A F9                    7805 	.db #0xf9	; 249
      001E4B A4                    7806 	.db #0xa4	; 164
      001E4C B0                    7807 	.db #0xb0	; 176
      001E4D 99                    7808 	.db #0x99	; 153
      001E4E 92                    7809 	.db #0x92	; 146
      001E4F 82                    7810 	.db #0x82	; 130
      001E50 F8                    7811 	.db #0xf8	; 248
      001E51 80                    7812 	.db #0x80	; 128
      001E52 90                    7813 	.db #0x90	; 144
                                   7814 	.area CSEG    (CODE)
                                   7815 	.area CONST   (CODE)
      001E53                       7816 _hexd:
      001E53 30 31 32 33 34 35 36  7817 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      001E63 00                    7818 	.db 0x00
                                   7819 	.area CSEG    (CODE)
                                   7820 	.area CONST   (CODE)
      001E64                       7821 ___str_0:
      001E64 4E 4E 20 52 45 41 44  7822 	.ascii "NN READY"
             59
      001E6C 0D                    7823 	.db 0x0d
      001E6D 0A                    7824 	.db 0x0a
      001E6E 00                    7825 	.db 0x00
                                   7826 	.area CSEG    (CODE)
                                   7827 	.area XINIT   (CODE)
                                   7828 	.area CABS    (ABS,CODE)
