                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ISO C Compiler
                                      3 ; Version 4.6.0 #16555 (MINGW64)
                                      4 ;--------------------------------------------------------
                                      5 	.module digit_nn
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
      00001D                        300 	.ds 1
      00001E                        301 _main_sloc1_1_0:
      00001E                        302 	.ds 4
                                    303 ;--------------------------------------------------------
                                    304 ; overlayable items in internal ram
                                    305 ;--------------------------------------------------------
                                    306 	.area	OSEG    (OVR,DATA)
                                    307 ;--------------------------------------------------------
                                    308 ; Stack segment in internal ram
                                    309 ;--------------------------------------------------------
                                    310 	.area SSEG
      0000B9                        311 __start__stack:
      0000B9                        312 	.ds	1
                                    313 
                                    314 ;--------------------------------------------------------
                                    315 ; indirectly addressable internal ram data
                                    316 ;--------------------------------------------------------
                                    317 	.area ISEG    (DATA)
      000026                        318 _pix::
      000026                        319 	.ds 35
      000049                        320 _acc::
      000049                        321 	.ds 48
      000079                        322 _hid::
      000079                        323 	.ds 24
      000091                        324 _score::
      000091                        325 	.ds 40
                                    326 ;--------------------------------------------------------
                                    327 ; absolute internal ram data
                                    328 ;--------------------------------------------------------
                                    329 	.area IABS    (ABS,DATA)
                                    330 	.area IABS    (ABS,DATA)
                                    331 ;--------------------------------------------------------
                                    332 ; bit data
                                    333 ;--------------------------------------------------------
                                    334 	.area BSEG    (BIT)
                                    335 ;--------------------------------------------------------
                                    336 ; paged external ram data
                                    337 ;--------------------------------------------------------
                                    338 	.area PSEG    (PAG,XDATA)
                                    339 ;--------------------------------------------------------
                                    340 ; uninitialized external ram data
                                    341 ;--------------------------------------------------------
                                    342 	.area XSEG    (XDATA)
                                    343 ;--------------------------------------------------------
                                    344 ; absolute external ram data
                                    345 ;--------------------------------------------------------
                                    346 	.area XABS    (ABS,XDATA)
                                    347 ;--------------------------------------------------------
                                    348 ; initialized external ram data
                                    349 ;--------------------------------------------------------
                                    350 	.area XISEG   (XDATA)
                                    351 	.area HOME    (CODE)
                                    352 	.area GSINIT0 (CODE)
                                    353 	.area GSINIT1 (CODE)
                                    354 	.area GSINIT2 (CODE)
                                    355 	.area GSINIT3 (CODE)
                                    356 	.area GSINIT4 (CODE)
                                    357 	.area GSINIT5 (CODE)
                                    358 	.area GSINIT  (CODE)
                                    359 	.area GSFINAL (CODE)
                                    360 	.area CSEG    (CODE)
                                    361 ;--------------------------------------------------------
                                    362 ; interrupt vector
                                    363 ;--------------------------------------------------------
                                    364 	.area HOME    (CODE)
      000000                        365 __interrupt_vect:
      000000 02 00 56         [24]  366 	ljmp	__sdcc_gsinit_startup
      000003 32               [24]  367 	reti
      000004                        368 	.ds	7
      00000B 02 00 B2         [24]  369 	ljmp	_t0_isr
                                    370 ; restartable atomic support routines
      00000E                        371 	.ds	2
      000010                        372 sdcc_atomic_exchange_rollback_start::
      000010 00               [12]  373 	nop
      000011 00               [12]  374 	nop
      000012                        375 sdcc_atomic_exchange_pdata_impl:
      000012 E2               [24]  376 	movx	a, @r0
      000013 FB               [12]  377 	mov	r3, a
      000014 EA               [12]  378 	mov	a, r2
      000015 F2               [24]  379 	movx	@r0, a
      000016 80 2C            [24]  380 	sjmp	sdcc_atomic_exchange_exit
      000018 00               [12]  381 	nop
      000019 00               [12]  382 	nop
      00001A                        383 sdcc_atomic_exchange_xdata_impl:
      00001A E0               [24]  384 	movx	a, @dptr
      00001B FB               [12]  385 	mov	r3, a
      00001C EA               [12]  386 	mov	a, r2
      00001D F0               [24]  387 	movx	@dptr, a
      00001E 80 24            [24]  388 	sjmp	sdcc_atomic_exchange_exit
      000020                        389 sdcc_atomic_compare_exchange_idata_impl:
      000020 E6               [12]  390 	mov	a, @r0
      000021 B5 02 02         [24]  391 	cjne	a, ar2, .+#5
      000024 EB               [12]  392 	mov	a, r3
      000025 F6               [12]  393 	mov	@r0, a
      000026 22               [24]  394 	ret
      000027 00               [12]  395 	nop
      000028                        396 sdcc_atomic_compare_exchange_pdata_impl:
      000028 E2               [24]  397 	movx	a, @r0
      000029 B5 02 02         [24]  398 	cjne	a, ar2, .+#5
      00002C EB               [12]  399 	mov	a, r3
      00002D F2               [24]  400 	movx	@r0, a
      00002E 22               [24]  401 	ret
      00002F 00               [12]  402 	nop
      000030                        403 sdcc_atomic_compare_exchange_xdata_impl:
      000030 E0               [24]  404 	movx	a, @dptr
      000031 B5 02 02         [24]  405 	cjne	a, ar2, .+#5
      000034 EB               [12]  406 	mov	a, r3
      000035 F0               [24]  407 	movx	@dptr, a
      000036 22               [24]  408 	ret
      000037                        409 sdcc_atomic_exchange_rollback_end::
                                    410 
      000037                        411 sdcc_atomic_exchange_gptr_impl::
      000037 30 F6 E0         [24]  412 	jnb	b.6, sdcc_atomic_exchange_xdata_impl
      00003A A8 82            [24]  413 	mov	r0, dpl
      00003C 20 F5 D3         [24]  414 	jb	b.5, sdcc_atomic_exchange_pdata_impl
      00003F                        415 sdcc_atomic_exchange_idata_impl:
      00003F EA               [12]  416 	mov	a, r2
      000040 C6               [12]  417 	xch	a, @r0
      000041 F5 82            [12]  418 	mov	dpl, a
      000043 22               [24]  419 	ret
      000044                        420 sdcc_atomic_exchange_exit:
      000044 8B 82            [24]  421 	mov	dpl, r3
      000046 22               [24]  422 	ret
      000047                        423 sdcc_atomic_compare_exchange_gptr_impl::
      000047 30 F6 E6         [24]  424 	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
      00004A A8 82            [24]  425 	mov	r0, dpl
      00004C 20 F5 D9         [24]  426 	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
      00004F 80 CF            [24]  427 	sjmp	sdcc_atomic_compare_exchange_idata_impl
                                    428 ;--------------------------------------------------------
                                    429 ; global & static initialisations
                                    430 ;--------------------------------------------------------
                                    431 	.area HOME    (CODE)
                                    432 	.area GSINIT  (CODE)
                                    433 	.area GSFINAL (CODE)
                                    434 	.area GSINIT  (CODE)
                                    435 	.globl __sdcc_gsinit_startup
                                    436 	.globl __sdcc_program_startup
                                    437 	.globl __start__stack
                                    438 	.globl __mcs51_genXINIT
                                    439 	.globl __mcs51_genXRAMCLEAR
                                    440 	.globl __mcs51_genRAMCLEAR
                                    441 	.area GSFINAL (CODE)
      0000AF 02 00 51         [24]  442 	ljmp	__sdcc_program_startup
                                    443 ;--------------------------------------------------------
                                    444 ; Home
                                    445 ;--------------------------------------------------------
                                    446 	.area HOME    (CODE)
                                    447 	.area HOME    (CODE)
      000051                        448 __sdcc_program_startup:
      000051 12 01 31         [24]  449 	lcall	_main
      000054                        450 __sdcc_program_exit:
      000054 80 FE            [24]  451 	sjmp	.
                                    452 ;	return from main will return to caller
                                    453 ;--------------------------------------------------------
                                    454 ; code
                                    455 ;--------------------------------------------------------
                                    456 	.area CSEG    (CODE)
                                    457 ;------------------------------------------------------------
                                    458 ;Allocation info for local variables in function 't0_isr'
                                    459 ;------------------------------------------------------------
                                    460 ;	digit_nn.c:26: void t0_isr(void) T0_ISR
                                    461 ;	-----------------------------------------
                                    462 ;	 function t0_isr
                                    463 ;	-----------------------------------------
      0000B2                        464 _t0_isr:
                           00000F   465 	ar7 = 0x0f
                           00000E   466 	ar6 = 0x0e
                           00000D   467 	ar5 = 0x0d
                           00000C   468 	ar4 = 0x0c
                           00000B   469 	ar3 = 0x0b
                           00000A   470 	ar2 = 0x0a
                           000009   471 	ar1 = 0x09
                           000008   472 	ar0 = 0x08
      0000B2 C0 E0            [24]  473 	push	acc
      0000B4 C0 82            [24]  474 	push	dpl
      0000B6 C0 83            [24]  475 	push	dph
      0000B8 C0 D0            [24]  476 	push	psw
      0000BA 75 D0 08         [24]  477 	mov	psw,#0x08
                                    478 ;	digit_nn.c:28: P1 = 0xFF;
      0000BD 75 90 FF         [24]  479 	mov	_P1,#0xff
                                    480 ;	digit_nn.c:29: digi = (digi + 1) & 3;
      0000C0 AF 14            [24]  481 	mov	r7,_digi
      0000C2 0F               [12]  482 	inc	r7
      0000C3 74 03            [12]  483 	mov	a,#0x03
      0000C5 5F               [12]  484 	anl	a,r7
                                    485 ;	digit_nn.c:30: P0 = dbuf[digi];
      0000C6 F5 14            [12]  486 	mov	_digi,a
      0000C8 24 10            [12]  487 	add	a, #_dbuf
      0000CA F9               [12]  488 	mov	r1,a
      0000CB 87 80            [24]  489 	mov	_P0,@r1
                                    490 ;	digit_nn.c:31: P1 = dsel[digi];
      0000CD E5 14            [12]  491 	mov	a,_digi
      0000CF 90 08 DA         [24]  492 	mov	dptr,#_dsel
      0000D2 93               [24]  493 	movc	a,@a+dptr
      0000D3 F5 90            [12]  494 	mov	_P1,a
                                    495 ;	digit_nn.c:32: }
      0000D5 D0 D0            [24]  496 	pop	psw
      0000D7 D0 83            [24]  497 	pop	dph
      0000D9 D0 82            [24]  498 	pop	dpl
      0000DB D0 E0            [24]  499 	pop	acc
      0000DD 32               [24]  500 	reti
                                    501 ;	eliminated unneeded push/pop b
                                    502 ;------------------------------------------------------------
                                    503 ;Allocation info for local variables in function 'getc_'
                                    504 ;------------------------------------------------------------
                                    505 ;	digit_nn.c:34: static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
                                    506 ;	-----------------------------------------
                                    507 ;	 function getc_
                                    508 ;	-----------------------------------------
      0000DE                        509 _getc_:
                           000007   510 	ar7 = 0x07
                           000006   511 	ar6 = 0x06
                           000005   512 	ar5 = 0x05
                           000004   513 	ar4 = 0x04
                           000003   514 	ar3 = 0x03
                           000002   515 	ar2 = 0x02
                           000001   516 	ar1 = 0x01
                           000000   517 	ar0 = 0x00
      0000DE                        518 00101$:
                                    519 ;	assignBit
      0000DE 10 98 02         [24]  520 	jbc	_RI,00120$
      0000E1 80 FB            [24]  521 	sjmp	00101$
      0000E3                        522 00120$:
      0000E3 85 99 82         [24]  523 	mov	dpl, _SBUF
      0000E6 22               [24]  524 	ret
                                    525 ;------------------------------------------------------------
                                    526 ;Allocation info for local variables in function 'putc_'
                                    527 ;------------------------------------------------------------
                                    528 ;c             Allocated to registers 
                                    529 ;------------------------------------------------------------
                                    530 ;	digit_nn.c:35: static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
                                    531 ;	-----------------------------------------
                                    532 ;	 function putc_
                                    533 ;	-----------------------------------------
      0000E7                        534 _putc_:
      0000E7 85 82 99         [24]  535 	mov	_SBUF,dpl
      0000EA                        536 00101$:
                                    537 ;	assignBit
      0000EA 10 99 02         [24]  538 	jbc	_TI,00120$
      0000ED 80 FB            [24]  539 	sjmp	00101$
      0000EF                        540 00120$:
      0000EF 22               [24]  541 	ret
                                    542 ;------------------------------------------------------------
                                    543 ;Allocation info for local variables in function 'puthex'
                                    544 ;------------------------------------------------------------
                                    545 ;v             Allocated to registers r7 
                                    546 ;------------------------------------------------------------
                                    547 ;	digit_nn.c:36: static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
                                    548 ;	-----------------------------------------
                                    549 ;	 function puthex
                                    550 ;	-----------------------------------------
      0000F0                        551 _puthex:
      0000F0 E5 82            [12]  552 	mov	a,dpl
      0000F2 FF               [12]  553 	mov	r7,a
      0000F3 C4               [12]  554 	swap	a
      0000F4 54 0F            [12]  555 	anl	a,#0x0f
      0000F6 90 08 E8         [24]  556 	mov	dptr,#_hexd
      0000F9 93               [24]  557 	movc	a,@a+dptr
      0000FA F5 82            [12]  558 	mov	dpl,a
      0000FC C0 07            [24]  559 	push	ar7
      0000FE 12 00 E7         [24]  560 	lcall	_putc_
      000101 D0 07            [24]  561 	pop	ar7
      000103 74 0F            [12]  562 	mov	a,#0x0f
      000105 5F               [12]  563 	anl	a,r7
      000106 90 08 E8         [24]  564 	mov	dptr,#_hexd
      000109 93               [24]  565 	movc	a,@a+dptr
      00010A F5 82            [12]  566 	mov	dpl,a
      00010C 02 00 E7         [24]  567 	ljmp	_putc_
                                    568 ;------------------------------------------------------------
                                    569 ;Allocation info for local variables in function 'puts_'
                                    570 ;------------------------------------------------------------
                                    571 ;s             Allocated to registers 
                                    572 ;------------------------------------------------------------
                                    573 ;	digit_nn.c:37: static void puts_(char code *s) { while (*s) putc_(*s++); }
                                    574 ;	-----------------------------------------
                                    575 ;	 function puts_
                                    576 ;	-----------------------------------------
      00010F                        577 _puts_:
      00010F AE 82            [24]  578 	mov	r6, dpl
      000111 AF 83            [24]  579 	mov	r7, dph
      000113                        580 00101$:
      000113 8E 82            [24]  581 	mov	dpl,r6
      000115 8F 83            [24]  582 	mov	dph,r7
      000117 E4               [12]  583 	clr	a
      000118 93               [24]  584 	movc	a,@a+dptr
      000119 FD               [12]  585 	mov	r5,a
      00011A 60 14            [24]  586 	jz	00104$
      00011C 8D 82            [24]  587 	mov	dpl,r5
      00011E 0E               [12]  588 	inc	r6
      00011F BE 00 01         [24]  589 	cjne	r6,#0x00,00122$
      000122 0F               [12]  590 	inc	r7
      000123                        591 00122$:
      000123 C0 07            [24]  592 	push	ar7
      000125 C0 06            [24]  593 	push	ar6
      000127 12 00 E7         [24]  594 	lcall	_putc_
      00012A D0 06            [24]  595 	pop	ar6
      00012C D0 07            [24]  596 	pop	ar7
      00012E 80 E3            [24]  597 	sjmp	00101$
      000130                        598 00104$:
      000130 22               [24]  599 	ret
                                    600 ;------------------------------------------------------------
                                    601 ;Allocation info for local variables in function 'main'
                                    602 ;------------------------------------------------------------
                                    603 ;i             Allocated with name '_main_i_10000_12'
                                    604 ;j             Allocated with name '_main_j_10000_12'
                                    605 ;k             Allocated with name '_main_k_10000_12'
                                    606 ;best          Allocated with name '_main_best_10000_12'
                                    607 ;a             Allocated to registers r5 r6 
                                    608 ;s             Allocated with name '_main_s_10000_12'
                                    609 ;u             Allocated to registers r3 r4 r5 r7 
                                    610 ;sloc0         Allocated with name '_main_sloc0_1_0'
                                    611 ;sloc1         Allocated with name '_main_sloc1_1_0'
                                    612 ;------------------------------------------------------------
                                    613 ;	digit_nn.c:39: void main(void)
                                    614 ;	-----------------------------------------
                                    615 ;	 function main
                                    616 ;	-----------------------------------------
      000131                        617 _main:
                                    618 ;	digit_nn.c:52: dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
      000131 75 11 AB         [24]  619 	mov	(_dbuf + 0x0001),#0xab
      000134 75 10 AB         [24]  620 	mov	_dbuf,#0xab
                                    621 ;	digit_nn.c:53: dbuf[2] = dbuf[3] = 0xBF;
      000137 75 13 BF         [24]  622 	mov	(_dbuf + 0x0003),#0xbf
      00013A 75 12 BF         [24]  623 	mov	(_dbuf + 0x0002),#0xbf
                                    624 ;	digit_nn.c:54: digi = 0;
      00013D 75 14 00         [24]  625 	mov	_digi,#0x00
                                    626 ;	digit_nn.c:55: TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
      000140 75 89 22         [24]  627 	mov	_TMOD,#0x22
                                    628 ;	digit_nn.c:56: TH1 = TL1 = 0xFD;
      000143 75 8B FD         [24]  629 	mov	_TL1,#0xfd
      000146 75 8D FD         [24]  630 	mov	_TH1,#0xfd
                                    631 ;	digit_nn.c:57: PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
      000149 43 87 80         [24]  632 	orl	_PCON,#0x80
                                    633 ;	digit_nn.c:58: SCON = 0x50;
      00014C 75 98 50         [24]  634 	mov	_SCON,#0x50
                                    635 ;	digit_nn.c:59: TH0 = TL0 = 0;
      00014F 75 8A 00         [24]  636 	mov	_TL0,#0x00
      000152 75 8C 00         [24]  637 	mov	_TH0,#0x00
                                    638 ;	digit_nn.c:60: TR1 = 1; TR0 = 1; ET0 = 1; EA = 1;
                                    639 ;	assignBit
      000155 D2 8E            [12]  640 	setb	_TR1
                                    641 ;	assignBit
      000157 D2 8C            [12]  642 	setb	_TR0
                                    643 ;	assignBit
      000159 D2 A9            [12]  644 	setb	_ET0
                                    645 ;	assignBit
      00015B D2 AF            [12]  646 	setb	_EA
                                    647 ;	digit_nn.c:61: puts_("NN READY\r\n");
      00015D 90 08 F9         [24]  648 	mov	dptr,#___str_0
      000160 12 01 0F         [24]  649 	lcall	_puts_
                                    650 ;	digit_nn.c:64: while (getc_() != 'D') ;
      000163                        651 00101$:
      000163 12 00 DE         [24]  652 	lcall	_getc_
      000166 AF 82            [24]  653 	mov	r7, dpl
      000168 BF 44 F8         [24]  654 	cjne	r7,#0x44,00101$
                                    655 ;	digit_nn.c:65: for (i = 0; i < 35; i++) pix[i] = (getc_() == '1');
      00016B 7F 00            [12]  656 	mov	r7,#0x00
      00016D                        657 00121$:
      00016D EF               [12]  658 	mov	a,r7
      00016E 24 26            [12]  659 	add	a, #_pix
      000170 F9               [12]  660 	mov	r1,a
      000171 C0 07            [24]  661 	push	ar7
      000173 C0 01            [24]  662 	push	ar1
      000175 12 00 DE         [24]  663 	lcall	_getc_
      000178 AE 82            [24]  664 	mov	r6, dpl
      00017A D0 01            [24]  665 	pop	ar1
      00017C D0 07            [24]  666 	pop	ar7
      00017E E4               [12]  667 	clr	a
      00017F BE 31 01         [24]  668 	cjne	r6,#0x31,00340$
      000182 04               [12]  669 	inc	a
      000183                        670 00340$:
      000183 F7               [12]  671 	mov	@r1,a
      000184 0F               [12]  672 	inc	r7
      000185 BF 23 00         [24]  673 	cjne	r7,#0x23,00342$
      000188                        674 00342$:
      000188 40 E3            [24]  675 	jc	00121$
                                    676 ;	digit_nn.c:68: for (j = 0; j < NH; j++) acc[j] = B1[j];
      00018A 7F 00            [12]  677 	mov	r7,#0x00
      00018C                        678 00123$:
      00018C EF               [12]  679 	mov	a,r7
      00018D 2F               [12]  680 	add	a,r7
      00018E 24 49            [12]  681 	add	a, #_acc
      000190 F9               [12]  682 	mov	r1,a
      000191 EF               [12]  683 	mov	a,r7
      000192 75 F0 02         [24]  684 	mov	b,#0x02
      000195 A4               [48]  685 	mul	ab
      000196 24 4A            [12]  686 	add	a, #_B1
      000198 F5 82            [12]  687 	mov	dpl,a
      00019A 74 04            [12]  688 	mov	a,#(_B1 >> 8)
      00019C 35 F0            [12]  689 	addc	a, b
      00019E F5 83            [12]  690 	mov	dph,a
      0001A0 E4               [12]  691 	clr	a
      0001A1 93               [24]  692 	movc	a,@a+dptr
      0001A2 FD               [12]  693 	mov	r5,a
      0001A3 A3               [24]  694 	inc	dptr
      0001A4 E4               [12]  695 	clr	a
      0001A5 93               [24]  696 	movc	a,@a+dptr
      0001A6 FE               [12]  697 	mov	r6,a
      0001A7 A7 05            [24]  698 	mov	@r1,ar5
      0001A9 09               [12]  699 	inc	r1
      0001AA A7 06            [24]  700 	mov	@r1,ar6
      0001AC 19               [12]  701 	dec	r1
      0001AD 0F               [12]  702 	inc	r7
      0001AE BF 18 00         [24]  703 	cjne	r7,#0x18,00344$
      0001B1                        704 00344$:
      0001B1 40 D9            [24]  705 	jc	00123$
                                    706 ;	digit_nn.c:78: for (i = 0; i < 35; i++)
      0001B3 75 15 00         [24]  707 	mov	_main_i_10000_12,#0x00
      0001B6                        708 00127$:
                                    709 ;	digit_nn.c:79: if (pix[i])
      0001B6 E5 15            [12]  710 	mov	a,_main_i_10000_12
      0001B8 24 26            [12]  711 	add	a, #_pix
      0001BA F9               [12]  712 	mov	r1,a
      0001BB E7               [12]  713 	mov	a,@r1
      0001BC 60 42            [24]  714 	jz	00128$
                                    715 ;	digit_nn.c:80: for (j = 0; j < NH; j++) acc[j] += W1[i][j];
      0001BE E5 15            [12]  716 	mov	a,_main_i_10000_12
      0001C0 75 F0 18         [24]  717 	mov	b,#0x18
      0001C3 A4               [48]  718 	mul	ab
      0001C4 24 7A            [12]  719 	add	a, #_W1
      0001C6 FD               [12]  720 	mov	r5,a
      0001C7 74 04            [12]  721 	mov	a,#(_W1 >> 8)
      0001C9 35 F0            [12]  722 	addc	a, b
      0001CB FE               [12]  723 	mov	r6,a
      0001CC 75 16 00         [24]  724 	mov	_main_j_10000_12,#0x00
      0001CF                        725 00125$:
      0001CF E5 16            [12]  726 	mov	a,_main_j_10000_12
      0001D1 25 16            [12]  727 	add	a,_main_j_10000_12
      0001D3 24 49            [12]  728 	add	a, #_acc
      0001D5 F9               [12]  729 	mov	r1,a
      0001D6 87 02            [24]  730 	mov	ar2,@r1
      0001D8 09               [12]  731 	inc	r1
      0001D9 87 03            [24]  732 	mov	ar3,@r1
      0001DB 19               [12]  733 	dec	r1
      0001DC E5 16            [12]  734 	mov	a,_main_j_10000_12
      0001DE 2D               [12]  735 	add	a, r5
      0001DF F5 82            [12]  736 	mov	dpl,a
      0001E1 E4               [12]  737 	clr	a
      0001E2 3E               [12]  738 	addc	a, r6
      0001E3 F5 83            [12]  739 	mov	dph,a
      0001E5 E4               [12]  740 	clr	a
      0001E6 93               [24]  741 	movc	a,@a+dptr
      0001E7 FC               [12]  742 	mov	r4,a
      0001E8 33               [12]  743 	rlc	a
      0001E9 95 E0            [12]  744 	subb	a,acc
      0001EB FF               [12]  745 	mov	r7,a
      0001EC EC               [12]  746 	mov	a,r4
      0001ED 2A               [12]  747 	add	a, r2
      0001EE FA               [12]  748 	mov	r2,a
      0001EF EF               [12]  749 	mov	a,r7
      0001F0 3B               [12]  750 	addc	a, r3
      0001F1 FB               [12]  751 	mov	r3,a
      0001F2 A7 02            [24]  752 	mov	@r1,ar2
      0001F4 09               [12]  753 	inc	r1
      0001F5 A7 03            [24]  754 	mov	@r1,ar3
      0001F7 19               [12]  755 	dec	r1
      0001F8 05 16            [12]  756 	inc	_main_j_10000_12
      0001FA 74 E8            [12]  757 	mov	a,#0x100 - 0x18
      0001FC 25 16            [12]  758 	add	a,_main_j_10000_12
      0001FE 50 CF            [24]  759 	jnc	00125$
      000200                        760 00128$:
                                    761 ;	digit_nn.c:78: for (i = 0; i < 35; i++)
      000200 05 15            [12]  762 	inc	_main_i_10000_12
      000202 74 DD            [12]  763 	mov	a,#0x100 - 0x23
      000204 25 15            [12]  764 	add	a,_main_i_10000_12
      000206 50 AE            [24]  765 	jnc	00127$
                                    766 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      000208 7F 00            [12]  767 	mov	r7,#0x00
      00020A                        768 00129$:
                                    769 ;	digit_nn.c:84: a = acc[j];
      00020A EF               [12]  770 	mov	a,r7
      00020B 2F               [12]  771 	add	a,r7
      00020C 24 49            [12]  772 	add	a, #_acc
      00020E F9               [12]  773 	mov	r1,a
      00020F 87 05            [24]  774 	mov	ar5,@r1
      000211 09               [12]  775 	inc	r1
      000212 87 06            [24]  776 	mov	ar6,@r1
      000214 19               [12]  777 	dec	r1
                                    778 ;	digit_nn.c:85: if (a < 0) hid[j] = 0;
      000215 EE               [12]  779 	mov	a,r6
      000216 30 E7 08         [24]  780 	jnb	acc.7,00111$
      000219 EF               [12]  781 	mov	a,r7
      00021A 24 79            [12]  782 	add	a, #_hid
      00021C F8               [12]  783 	mov	r0,a
      00021D 76 00            [12]  784 	mov	@r0,#0x00
      00021F 80 23            [24]  785 	sjmp	00130$
      000221                        786 00111$:
                                    787 ;	digit_nn.c:86: else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
      000221 EE               [12]  788 	mov	a,r6
      000222 A2 E7            [12]  789 	mov	c,acc.7
      000224 13               [12]  790 	rrc	a
      000225 CD               [12]  791 	xch	a,r5
      000226 13               [12]  792 	rrc	a
      000227 CD               [12]  793 	xch	a,r5
      000228 FE               [12]  794 	mov	r6,a
      000229 EF               [12]  795 	mov	a,r7
      00022A 24 79            [12]  796 	add	a, #_hid
      00022C F9               [12]  797 	mov	r1,a
      00022D C3               [12]  798 	clr	c
      00022E 74 FF            [12]  799 	mov	a,#0xff
      000230 9D               [12]  800 	subb	a,r5
      000231 74 80            [12]  801 	mov	a,#(0x00 ^ 0x80)
      000233 8E F0            [24]  802 	mov	b,r6
      000235 63 F0 80         [24]  803 	xrl	b,#0x80
      000238 95 F0            [12]  804 	subb	a,b
      00023A 50 04            [24]  805 	jnc	00143$
                                    806 ;	free result
      00023C 7C FF            [12]  807 	mov	r4,#0xff
      00023E 80 02            [24]  808 	sjmp	00144$
      000240                        809 00143$:
      000240 8D 04            [24]  810 	mov	ar4,r5
      000242                        811 00144$:
      000242 A7 04            [24]  812 	mov	@r1,ar4
      000244                        813 00130$:
                                    814 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      000244 0F               [12]  815 	inc	r7
      000245 BF 18 00         [24]  816 	cjne	r7,#0x18,00351$
      000248                        817 00351$:
      000248 40 C0            [24]  818 	jc	00129$
                                    819 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      00024A 75 17 00         [24]  820 	mov	_main_k_10000_12,#0x00
      00024D                        821 00133$:
                                    822 ;	digit_nn.c:91: s = B2[k];
      00024D E5 17            [12]  823 	mov	a,_main_k_10000_12
      00024F 75 F0 04         [24]  824 	mov	b,#0x04
      000252 A4               [48]  825 	mul	ab
      000253 24 C2            [12]  826 	add	a, #_B2
      000255 F5 82            [12]  827 	mov	dpl,a
      000257 74 07            [12]  828 	mov	a,#(_B2 >> 8)
      000259 35 F0            [12]  829 	addc	a, b
      00025B F5 83            [12]  830 	mov	dph,a
      00025D E4               [12]  831 	clr	a
      00025E 93               [24]  832 	movc	a,@a+dptr
      00025F F5 19            [12]  833 	mov	_main_s_10000_12,a
      000261 A3               [24]  834 	inc	dptr
      000262 E4               [12]  835 	clr	a
      000263 93               [24]  836 	movc	a,@a+dptr
      000264 F5 1A            [12]  837 	mov	(_main_s_10000_12 + 1),a
      000266 A3               [24]  838 	inc	dptr
      000267 E4               [12]  839 	clr	a
      000268 93               [24]  840 	movc	a,@a+dptr
      000269 F5 1B            [12]  841 	mov	(_main_s_10000_12 + 2),a
      00026B A3               [24]  842 	inc	dptr
      00026C E4               [12]  843 	clr	a
      00026D 93               [24]  844 	movc	a,@a+dptr
      00026E F5 1C            [12]  845 	mov	(_main_s_10000_12 + 3),a
                                    846 ;	digit_nn.c:102: for (j = 0; j < NH; j++)
      000270 E5 17            [12]  847 	mov	a,_main_k_10000_12
      000272 75 F0 18         [24]  848 	mov	b,#0x18
      000275 A4               [48]  849 	mul	ab
      000276 24 EA            [12]  850 	add	a, #_W2
      000278 FA               [12]  851 	mov	r2,a
      000279 74 07            [12]  852 	mov	a,#(_W2 >> 8)
      00027B 35 F0            [12]  853 	addc	a, b
      00027D FE               [12]  854 	mov	r6,a
      00027E 75 16 00         [24]  855 	mov	_main_j_10000_12,#0x00
      000281                        856 00131$:
                                    857 ;	digit_nn.c:104: s += (long)hid[j] * W2[k][j];
      000281 E5 16            [12]  858 	mov	a,_main_j_10000_12
      000283 24 79            [12]  859 	add	a, #_hid
      000285 F9               [12]  860 	mov	r1,a
      000286 87 04            [24]  861 	mov	ar4,@r1
      000288 8C 03            [24]  862 	mov	ar3,r4
      00028A E4               [12]  863 	clr	a
      00028B FC               [12]  864 	mov	r4,a
      00028C FD               [12]  865 	mov	r5,a
      00028D FF               [12]  866 	mov	r7,a
      00028E E5 16            [12]  867 	mov	a,_main_j_10000_12
      000290 2A               [12]  868 	add	a, r2
      000291 F5 82            [12]  869 	mov	dpl,a
      000293 E4               [12]  870 	clr	a
      000294 3E               [12]  871 	addc	a, r6
      000295 F5 83            [12]  872 	mov	dph,a
      000297 C0 02            [24]  873 	push	ar2
      000299 C0 06            [24]  874 	push	ar6
      00029B E4               [12]  875 	clr	a
      00029C 93               [24]  876 	movc	a,@a+dptr
      00029D F5 22            [12]  877 	mov	__mullong_PARM_2, a
      00029F 33               [12]  878 	rlc	a
      0002A0 95 E0            [12]  879 	subb	a,acc
      0002A2 F5 23            [12]  880 	mov	(__mullong_PARM_2 + 1),a
      0002A4 F5 24            [12]  881 	mov	(__mullong_PARM_2 + 2),a
      0002A6 F5 25            [12]  882 	mov	(__mullong_PARM_2 + 3),a
      0002A8 8B 82            [24]  883 	mov	dpl, r3
      0002AA 8C 83            [24]  884 	mov	dph, r4
      0002AC 8D F0            [24]  885 	mov	b, r5
      0002AE EF               [12]  886 	mov	a, r7
      0002AF C0 02            [24]  887 	push	ar2
      0002B1 12 03 D8         [24]  888 	lcall	__mullong
      0002B4 AF 82            [24]  889 	mov	r7, dpl
      0002B6 AC 83            [24]  890 	mov	r4, dph
      0002B8 AD F0            [24]  891 	mov	r5, b
      0002BA FE               [12]  892 	mov	r6, a
      0002BB D0 02            [24]  893 	pop	ar2
      0002BD EF               [12]  894 	mov	a,r7
      0002BE 25 19            [12]  895 	add	a, _main_s_10000_12
      0002C0 F5 19            [12]  896 	mov	_main_s_10000_12,a
      0002C2 EC               [12]  897 	mov	a,r4
      0002C3 35 1A            [12]  898 	addc	a, (_main_s_10000_12 + 1)
      0002C5 F5 1A            [12]  899 	mov	(_main_s_10000_12 + 1),a
      0002C7 ED               [12]  900 	mov	a,r5
      0002C8 35 1B            [12]  901 	addc	a, (_main_s_10000_12 + 2)
      0002CA F5 1B            [12]  902 	mov	(_main_s_10000_12 + 2),a
      0002CC EE               [12]  903 	mov	a,r6
      0002CD 35 1C            [12]  904 	addc	a, (_main_s_10000_12 + 3)
      0002CF F5 1C            [12]  905 	mov	(_main_s_10000_12 + 3),a
                                    906 ;	digit_nn.c:102: for (j = 0; j < NH; j++)
      0002D1 05 16            [12]  907 	inc	_main_j_10000_12
      0002D3 C3               [12]  908 	clr	c
      0002D4 E5 16            [12]  909 	mov	a,_main_j_10000_12
      0002D6 94 18            [12]  910 	subb	a,#0x18
      0002D8 D0 06            [24]  911 	pop	ar6
      0002DA D0 02            [24]  912 	pop	ar2
      0002DC 40 A3            [24]  913 	jc	00131$
                                    914 ;	digit_nn.c:109: score[k] = s;
      0002DE E5 17            [12]  915 	mov	a,_main_k_10000_12
      0002E0 25 17            [12]  916 	add	a,_main_k_10000_12
      0002E2 25 E0            [12]  917 	add	a,acc
      0002E4 24 91            [12]  918 	add	a, #_score
      0002E6 F8               [12]  919 	mov	r0,a
      0002E7 A6 19            [24]  920 	mov	@r0,_main_s_10000_12
      0002E9 08               [12]  921 	inc	r0
      0002EA A6 1A            [24]  922 	mov	@r0,(_main_s_10000_12 + 1)
      0002EC 08               [12]  923 	inc	r0
      0002ED A6 1B            [24]  924 	mov	@r0,(_main_s_10000_12 + 2)
      0002EF 08               [12]  925 	inc	r0
      0002F0 A6 1C            [24]  926 	mov	@r0,(_main_s_10000_12 + 3)
                                    927 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      0002F2 05 17            [12]  928 	inc	_main_k_10000_12
      0002F4 74 F6            [12]  929 	mov	a,#0x100 - 0x0a
      0002F6 25 17            [12]  930 	add	a,_main_k_10000_12
      0002F8 40 03            [24]  931 	jc	00354$
      0002FA 02 02 4D         [24]  932 	ljmp	00133$
      0002FD                        933 00354$:
                                    934 ;	digit_nn.c:113: best = 0;
      0002FD 75 1D 00         [24]  935 	mov	_main_sloc0_1_0,#0x00
                                    936 ;	digit_nn.c:114: for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;
      000300 75 18 01         [24]  937 	mov	_main_best_10000_12,#0x01
      000303                        938 00135$:
      000303 E5 18            [12]  939 	mov	a,_main_best_10000_12
      000305 25 18            [12]  940 	add	a,_main_best_10000_12
      000307 25 E0            [12]  941 	add	a,acc
      000309 24 91            [12]  942 	add	a, #_score
      00030B F9               [12]  943 	mov	r1,a
      00030C 87 1E            [24]  944 	mov	_main_sloc1_1_0,@r1
      00030E 09               [12]  945 	inc	r1
      00030F 87 1F            [24]  946 	mov	(_main_sloc1_1_0 + 1),@r1
      000311 09               [12]  947 	inc	r1
      000312 87 20            [24]  948 	mov	(_main_sloc1_1_0 + 2),@r1
      000314 09               [12]  949 	inc	r1
      000315 87 21            [24]  950 	mov	(_main_sloc1_1_0 + 3),@r1
      000317 19               [12]  951 	dec	r1
      000318 19               [12]  952 	dec	r1
      000319 19               [12]  953 	dec	r1
      00031A E5 1D            [12]  954 	mov	a,_main_sloc0_1_0
      00031C 25 1D            [12]  955 	add	a,_main_sloc0_1_0
      00031E 25 E0            [12]  956 	add	a,acc
      000320 24 91            [12]  957 	add	a, #_score
      000322 F9               [12]  958 	mov	r1,a
      000323 87 03            [24]  959 	mov	ar3,@r1
      000325 09               [12]  960 	inc	r1
      000326 87 04            [24]  961 	mov	ar4,@r1
      000328 09               [12]  962 	inc	r1
      000329 87 05            [24]  963 	mov	ar5,@r1
      00032B 09               [12]  964 	inc	r1
      00032C 87 07            [24]  965 	mov	ar7,@r1
      00032E 19               [12]  966 	dec	r1
      00032F 19               [12]  967 	dec	r1
      000330 19               [12]  968 	dec	r1
      000331 C3               [12]  969 	clr	c
      000332 EB               [12]  970 	mov	a,r3
      000333 95 1E            [12]  971 	subb	a,_main_sloc1_1_0
      000335 EC               [12]  972 	mov	a,r4
      000336 95 1F            [12]  973 	subb	a,(_main_sloc1_1_0 + 1)
      000338 ED               [12]  974 	mov	a,r5
      000339 95 20            [12]  975 	subb	a,(_main_sloc1_1_0 + 2)
      00033B EF               [12]  976 	mov	a,r7
      00033C 64 80            [12]  977 	xrl	a,#0x80
      00033E 85 21 F0         [24]  978 	mov	b,(_main_sloc1_1_0 + 3)
      000341 63 F0 80         [24]  979 	xrl	b,#0x80
      000344 95 F0            [12]  980 	subb	a,b
      000346 50 03            [24]  981 	jnc	00136$
                                    982 ;	free result
      000348 85 18 1D         [24]  983 	mov	_main_sloc0_1_0,_main_best_10000_12
      00034B                        984 00136$:
      00034B 05 18            [12]  985 	inc	_main_best_10000_12
      00034D 74 F6            [12]  986 	mov	a,#0x100 - 0x0a
      00034F 25 18            [12]  987 	add	a,_main_best_10000_12
      000351 50 B0            [24]  988 	jnc	00135$
                                    989 ;	digit_nn.c:116: dbuf[2] = 0xFF;
      000353 75 12 FF         [24]  990 	mov	(_dbuf + 0x0002),#0xff
                                    991 ;	digit_nn.c:117: dbuf[3] = segs[best];
      000356 E5 1D            [12]  992 	mov	a,_main_sloc0_1_0
      000358 90 08 DE         [24]  993 	mov	dptr,#_segs
      00035B 93               [24]  994 	movc	a,@a+dptr
      00035C F5 13            [12]  995 	mov	(_dbuf + 0x0003), a
                                    996 ;	digit_nn.c:118: putc_('=');
      00035E 75 82 3D         [24]  997 	mov	dpl, #0x3d
      000361 12 00 E7         [24]  998 	lcall	_putc_
                                    999 ;	digit_nn.c:119: putc_('0' + best);
      000364 AF 1D            [24] 1000 	mov	r7,_main_sloc0_1_0
      000366 74 30            [12] 1001 	mov	a,#0x30
      000368 2F               [12] 1002 	add	a, r7
      000369 F5 82            [12] 1003 	mov	dpl,a
      00036B 12 00 E7         [24] 1004 	lcall	_putc_
                                   1005 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      00036E 75 17 00         [24] 1006 	mov	_main_k_10000_12,#0x00
      000371                       1007 00137$:
                                   1008 ;	digit_nn.c:121: u = (unsigned long)score[k];
      000371 E5 17            [12] 1009 	mov	a,_main_k_10000_12
      000373 25 17            [12] 1010 	add	a,_main_k_10000_12
      000375 25 E0            [12] 1011 	add	a,acc
      000377 24 91            [12] 1012 	add	a, #_score
      000379 F9               [12] 1013 	mov	r1,a
      00037A 87 03            [24] 1014 	mov	ar3,@r1
      00037C 09               [12] 1015 	inc	r1
      00037D 87 04            [24] 1016 	mov	ar4,@r1
      00037F 09               [12] 1017 	inc	r1
      000380 87 05            [24] 1018 	mov	ar5,@r1
      000382 09               [12] 1019 	inc	r1
      000383 87 07            [24] 1020 	mov	ar7,@r1
      000385 19               [12] 1021 	dec	r1
      000386 19               [12] 1022 	dec	r1
      000387 19               [12] 1023 	dec	r1
                                   1024 ;	digit_nn.c:122: putc_(' ');
      000388 75 82 20         [24] 1025 	mov	dpl, #0x20
      00038B C0 07            [24] 1026 	push	ar7
      00038D C0 05            [24] 1027 	push	ar5
      00038F C0 04            [24] 1028 	push	ar4
      000391 C0 03            [24] 1029 	push	ar3
      000393 12 00 E7         [24] 1030 	lcall	_putc_
      000396 D0 03            [24] 1031 	pop	ar3
      000398 D0 04            [24] 1032 	pop	ar4
      00039A D0 05            [24] 1033 	pop	ar5
                                   1034 ;	digit_nn.c:123: puthex((unsigned char)(u >> 16));
      00039C 8D 82            [24] 1035 	mov	dpl,r5
      00039E C0 05            [24] 1036 	push	ar5
      0003A0 C0 04            [24] 1037 	push	ar4
      0003A2 C0 03            [24] 1038 	push	ar3
      0003A4 12 00 F0         [24] 1039 	lcall	_puthex
      0003A7 D0 03            [24] 1040 	pop	ar3
      0003A9 D0 04            [24] 1041 	pop	ar4
                                   1042 ;	digit_nn.c:124: puthex((unsigned char)(u >> 8));
      0003AB 8C 82            [24] 1043 	mov	dpl,r4
      0003AD C0 04            [24] 1044 	push	ar4
      0003AF C0 03            [24] 1045 	push	ar3
      0003B1 12 00 F0         [24] 1046 	lcall	_puthex
      0003B4 D0 03            [24] 1047 	pop	ar3
      0003B6 D0 04            [24] 1048 	pop	ar4
      0003B8 D0 05            [24] 1049 	pop	ar5
      0003BA D0 07            [24] 1050 	pop	ar7
                                   1051 ;	digit_nn.c:125: puthex((unsigned char)u);
      0003BC 8B 82            [24] 1052 	mov	dpl,r3
      0003BE 12 00 F0         [24] 1053 	lcall	_puthex
                                   1054 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      0003C1 05 17            [12] 1055 	inc	_main_k_10000_12
      0003C3 74 F6            [12] 1056 	mov	a,#0x100 - 0x0a
      0003C5 25 17            [12] 1057 	add	a,_main_k_10000_12
      0003C7 50 A8            [24] 1058 	jnc	00137$
                                   1059 ;	digit_nn.c:127: putc_('\r');
      0003C9 75 82 0D         [24] 1060 	mov	dpl, #0x0d
      0003CC 12 00 E7         [24] 1061 	lcall	_putc_
                                   1062 ;	digit_nn.c:128: putc_('\n');
      0003CF 75 82 0A         [24] 1063 	mov	dpl, #0x0a
      0003D2 12 00 E7         [24] 1064 	lcall	_putc_
                                   1065 ;	digit_nn.c:130: }
      0003D5 02 01 63         [24] 1066 	ljmp	00101$
                                   1067 	.area CSEG    (CODE)
                                   1068 	.area CONST   (CODE)
                                   1069 	.area CONST   (CODE)
      00044A                       1070 _B1:
      00044A BB FF                 1071 	.byte #0xbb, #0xff	; -69
      00044C 62 00                 1072 	.byte #0x62, #0x00	;  98
      00044E D8 FF                 1073 	.byte #0xd8, #0xff	; -40
      000450 9D FF                 1074 	.byte #0x9d, #0xff	; -99
      000452 F0 FF                 1075 	.byte #0xf0, #0xff	; -16
      000454 F7 FF                 1076 	.byte #0xf7, #0xff	; -9
      000456 25 00                 1077 	.byte #0x25, #0x00	;  37
      000458 2B 00                 1078 	.byte #0x2b, #0x00	;  43
      00045A F7 FF                 1079 	.byte #0xf7, #0xff	; -9
      00045C CF FF                 1080 	.byte #0xcf, #0xff	; -49
      00045E 18 00                 1081 	.byte #0x18, #0x00	;  24
      000460 E9 FF                 1082 	.byte #0xe9, #0xff	; -23
      000462 BB FF                 1083 	.byte #0xbb, #0xff	; -69
      000464 28 00                 1084 	.byte #0x28, #0x00	;  40
      000466 FD FF                 1085 	.byte #0xfd, #0xff	; -3
      000468 39 00                 1086 	.byte #0x39, #0x00	;  57
      00046A F2 FF                 1087 	.byte #0xf2, #0xff	; -14
      00046C D3 FF                 1088 	.byte #0xd3, #0xff	; -45
      00046E BD FF                 1089 	.byte #0xbd, #0xff	; -67
      000470 E2 FF                 1090 	.byte #0xe2, #0xff	; -30
      000472 DA FF                 1091 	.byte #0xda, #0xff	; -38
      000474 CE FF                 1092 	.byte #0xce, #0xff	; -50
      000476 01 00                 1093 	.byte #0x01, #0x00	;  1
      000478 92 FF                 1094 	.byte #0x92, #0xff	; -110
                                   1095 	.area CSEG    (CODE)
                                   1096 	.area CONST   (CODE)
      00047A                       1097 _W1:
      00047A F0                    1098 	.db #0xf0	; -16
      00047B F9                    1099 	.db #0xf9	; -7
      00047C F6                    1100 	.db #0xf6	; -10
      00047D DB                    1101 	.db #0xdb	; -37
      00047E F9                    1102 	.db #0xf9	; -7
      00047F 0A                    1103 	.db #0x0a	;  10
      000480 21                    1104 	.db #0x21	;  33
      000481 0C                    1105 	.db #0x0c	;  12
      000482 61                    1106 	.db #0x61	;  97	'a'
      000483 11                    1107 	.db #0x11	;  17
      000484 0C                    1108 	.db #0x0c	;  12
      000485 BC                    1109 	.db #0xbc	; -68
      000486 00                    1110 	.db #0x00	;  0
      000487 EF                    1111 	.db #0xef	; -17
      000488 00                    1112 	.db #0x00	;  0
      000489 0D                    1113 	.db #0x0d	;  13
      00048A EB                    1114 	.db #0xeb	; -21
      00048B 00                    1115 	.db #0x00	;  0
      00048C 1B                    1116 	.db #0x1b	;  27
      00048D 47                    1117 	.db #0x47	;  71	'G'
      00048E 04                    1118 	.db #0x04	;  4
      00048F EE                    1119 	.db #0xee	; -18
      000490 4B                    1120 	.db #0x4b	;  75	'K'
      000491 D7                    1121 	.db #0xd7	; -41
      000492 DE                    1122 	.db #0xde	; -34
      000493 06                    1123 	.db #0x06	;  6
      000494 ED                    1124 	.db #0xed	; -19
      000495 04                    1125 	.db #0x04	;  4
      000496 CE                    1126 	.db #0xce	; -50
      000497 E9                    1127 	.db #0xe9	; -23
      000498 4F                    1128 	.db #0x4f	;  79	'O'
      000499 EE                    1129 	.db #0xee	; -18
      00049A 62                    1130 	.db #0x62	;  98	'b'
      00049B 3D                    1131 	.db #0x3d	;  61
      00049C 0B                    1132 	.db #0x0b	;  11
      00049D C7                    1133 	.db #0xc7	; -57
      00049E F5                    1134 	.db #0xf5	; -11
      00049F E8                    1135 	.db #0xe8	; -24
      0004A0 00                    1136 	.db #0x00	;  0
      0004A1 07                    1137 	.db #0x07	;  7
      0004A2 DE                    1138 	.db #0xde	; -34
      0004A3 EC                    1139 	.db #0xec	; -20
      0004A4 1E                    1140 	.db #0x1e	;  30
      0004A5 47                    1141 	.db #0x47	;  71	'G'
      0004A6 EA                    1142 	.db #0xea	; -22
      0004A7 00                    1143 	.db #0x00	;  0
      0004A8 26                    1144 	.db #0x26	;  38
      0004A9 F7                    1145 	.db #0xf7	; -9
      0004AA EF                    1146 	.db #0xef	; -17
      0004AB DA                    1147 	.db #0xda	; -38
      0004AC 0F                    1148 	.db #0x0f	;  15
      0004AD F6                    1149 	.db #0xf6	; -10
      0004AE E5                    1150 	.db #0xe5	; -27
      0004AF 1A                    1151 	.db #0x1a	;  26
      0004B0 D1                    1152 	.db #0xd1	; -47
      0004B1 00                    1153 	.db #0x00	;  0
      0004B2 49                    1154 	.db #0x49	;  73	'I'
      0004B3 E2                    1155 	.db #0xe2	; -30
      0004B4 DB                    1156 	.db #0xdb	; -37
      0004B5 B9                    1157 	.db #0xb9	; -71
      0004B6 FF                    1158 	.db #0xff	; -1
      0004B7 DA                    1159 	.db #0xda	; -38
      0004B8 00                    1160 	.db #0x00	;  0
      0004B9 B9                    1161 	.db #0xb9	; -71
      0004BA E4                    1162 	.db #0xe4	; -28
      0004BB FD                    1163 	.db #0xfd	; -3
      0004BC F6                    1164 	.db #0xf6	; -10
      0004BD 56                    1165 	.db #0x56	;  86	'V'
      0004BE EA                    1166 	.db #0xea	; -22
      0004BF FC                    1167 	.db #0xfc	; -4
      0004C0 25                    1168 	.db #0x25	;  37
      0004C1 36                    1169 	.db #0x36	;  54	'6'
      0004C2 55                    1170 	.db #0x55	;  85	'U'
      0004C3 F4                    1171 	.db #0xf4	; -12
      0004C4 FC                    1172 	.db #0xfc	; -4
      0004C5 2B                    1173 	.db #0x2b	;  43
      0004C6 F8                    1174 	.db #0xf8	; -8
      0004C7 0A                    1175 	.db #0x0a	;  10
      0004C8 FD                    1176 	.db #0xfd	; -3
      0004C9 CF                    1177 	.db #0xcf	; -49
      0004CA 66                    1178 	.db #0x66	;  102	'f'
      0004CB FB                    1179 	.db #0xfb	; -5
      0004CC F6                    1180 	.db #0xf6	; -10
      0004CD BF                    1181 	.db #0xbf	; -65
      0004CE EE                    1182 	.db #0xee	; -18
      0004CF E9                    1183 	.db #0xe9	; -23
      0004D0 00                    1184 	.db #0x00	;  0
      0004D1 FB                    1185 	.db #0xfb	; -5
      0004D2 F1                    1186 	.db #0xf1	; -15
      0004D3 11                    1187 	.db #0x11	;  17
      0004D4 EF                    1188 	.db #0xef	; -17
      0004D5 46                    1189 	.db #0x46	;  70	'F'
      0004D6 EA                    1190 	.db #0xea	; -22
      0004D7 22                    1191 	.db #0x22	;  34
      0004D8 07                    1192 	.db #0x07	;  7
      0004D9 EF                    1193 	.db #0xef	; -17
      0004DA D3                    1194 	.db #0xd3	; -45
      0004DB F2                    1195 	.db #0xf2	; -14
      0004DC F4                    1196 	.db #0xf4	; -12
      0004DD E5                    1197 	.db #0xe5	; -27
      0004DE 02                    1198 	.db #0x02	;  2
      0004DF 09                    1199 	.db #0x09	;  9
      0004E0 02                    1200 	.db #0x02	;  2
      0004E1 0A                    1201 	.db #0x0a	;  10
      0004E2 2C                    1202 	.db #0x2c	;  44
      0004E3 FC                    1203 	.db #0xfc	; -4
      0004E4 F0                    1204 	.db #0xf0	; -16
      0004E5 C9                    1205 	.db #0xc9	; -55
      0004E6 F8                    1206 	.db #0xf8	; -8
      0004E7 E4                    1207 	.db #0xe4	; -28
      0004E8 00                    1208 	.db #0x00	;  0
      0004E9 EC                    1209 	.db #0xec	; -20
      0004EA F3                    1210 	.db #0xf3	; -13
      0004EB EB                    1211 	.db #0xeb	; -21
      0004EC F6                    1212 	.db #0xf6	; -10
      0004ED 04                    1213 	.db #0x04	;  4
      0004EE 07                    1214 	.db #0x07	;  7
      0004EF E5                    1215 	.db #0xe5	; -27
      0004F0 1B                    1216 	.db #0x1b	;  27
      0004F1 DA                    1217 	.db #0xda	; -38
      0004F2 F8                    1218 	.db #0xf8	; -8
      0004F3 27                    1219 	.db #0x27	;  39
      0004F4 01                    1220 	.db #0x01	;  1
      0004F5 40                    1221 	.db #0x40	;  64
      0004F6 16                    1222 	.db #0x16	;  22
      0004F7 13                    1223 	.db #0x13	;  19
      0004F8 37                    1224 	.db #0x37	;  55	'7'
      0004F9 01                    1225 	.db #0x01	;  1
      0004FA 1F                    1226 	.db #0x1f	;  31
      0004FB FA                    1227 	.db #0xfa	; -6
      0004FC 1B                    1228 	.db #0x1b	;  27
      0004FD 76                    1229 	.db #0x76	;  118	'v'
      0004FE F4                    1230 	.db #0xf4	; -12
      0004FF 02                    1231 	.db #0x02	;  2
      000500 00                    1232 	.db #0x00	;  0
      000501 0B                    1233 	.db #0x0b	;  11
      000502 F3                    1234 	.db #0xf3	; -13
      000503 F6                    1235 	.db #0xf6	; -10
      000504 EE                    1236 	.db #0xee	; -18
      000505 1D                    1237 	.db #0x1d	;  29
      000506 0F                    1238 	.db #0x0f	;  15
      000507 05                    1239 	.db #0x05	;  5
      000508 3F                    1240 	.db #0x3f	;  63
      000509 EF                    1241 	.db #0xef	; -17
      00050A E6                    1242 	.db #0xe6	; -26
      00050B 05                    1243 	.db #0x05	;  5
      00050C FE                    1244 	.db #0xfe	; -2
      00050D 2B                    1245 	.db #0x2b	;  43
      00050E 2A                    1246 	.db #0x2a	;  42
      00050F 00                    1247 	.db #0x00	;  0
      000510 4C                    1248 	.db #0x4c	;  76	'L'
      000511 F5                    1249 	.db #0xf5	; -11
      000512 FE                    1250 	.db #0xfe	; -2
      000513 14                    1251 	.db #0x14	;  20
      000514 DD                    1252 	.db #0xdd	; -35
      000515 40                    1253 	.db #0x40	;  64
      000516 E9                    1254 	.db #0xe9	; -23
      000517 F1                    1255 	.db #0xf1	; -15
      000518 00                    1256 	.db #0x00	;  0
      000519 F2                    1257 	.db #0xf2	; -14
      00051A EA                    1258 	.db #0xea	; -22
      00051B 06                    1259 	.db #0x06	;  6
      00051C 1C                    1260 	.db #0x1c	;  28
      00051D 1E                    1261 	.db #0x1e	;  30
      00051E FC                    1262 	.db #0xfc	; -4
      00051F EA                    1263 	.db #0xea	; -22
      000520 24                    1264 	.db #0x24	;  36
      000521 F8                    1265 	.db #0xf8	; -8
      000522 EF                    1266 	.db #0xef	; -17
      000523 FA                    1267 	.db #0xfa	; -6
      000524 F6                    1268 	.db #0xf6	; -10
      000525 40                    1269 	.db #0x40	;  64
      000526 54                    1270 	.db #0x54	;  84	'T'
      000527 29                    1271 	.db #0x29	;  41
      000528 9C                    1272 	.db #0x9c	; -100
      000529 0E                    1273 	.db #0x0e	;  14
      00052A 08                    1274 	.db #0x08	;  8
      00052B 09                    1275 	.db #0x09	;  9
      00052C EF                    1276 	.db #0xef	; -17
      00052D 1D                    1277 	.db #0x1d	;  29
      00052E 0C                    1278 	.db #0x0c	;  12
      00052F FA                    1279 	.db #0xfa	; -6
      000530 00                    1280 	.db #0x00	;  0
      000531 E9                    1281 	.db #0xe9	; -23
      000532 EA                    1282 	.db #0xea	; -22
      000533 00                    1283 	.db #0x00	;  0
      000534 00                    1284 	.db #0x00	;  0
      000535 11                    1285 	.db #0x11	;  17
      000536 FD                    1286 	.db #0xfd	; -3
      000537 D0                    1287 	.db #0xd0	; -48
      000538 20                    1288 	.db #0x20	;  32
      000539 46                    1289 	.db #0x46	;  70	'F'
      00053A 69                    1290 	.db #0x69	;  105	'i'
      00053B FC                    1291 	.db #0xfc	; -4
      00053C 0F                    1292 	.db #0x0f	;  15
      00053D 33                    1293 	.db #0x33	;  51	'3'
      00053E 5E                    1294 	.db #0x5e	;  94
      00053F 14                    1295 	.db #0x14	;  20
      000540 02                    1296 	.db #0x02	;  2
      000541 FF                    1297 	.db #0xff	; -1
      000542 33                    1298 	.db #0x33	;  51	'3'
      000543 00                    1299 	.db #0x00	;  0
      000544 0B                    1300 	.db #0x0b	;  11
      000545 FD                    1301 	.db #0xfd	; -3
      000546 F9                    1302 	.db #0xf9	; -7
      000547 08                    1303 	.db #0x08	;  8
      000548 00                    1304 	.db #0x00	;  0
      000549 F4                    1305 	.db #0xf4	; -12
      00054A EE                    1306 	.db #0xee	; -18
      00054B 13                    1307 	.db #0x13	;  19
      00054C 62                    1308 	.db #0x62	;  98	'b'
      00054D 0F                    1309 	.db #0x0f	;  15
      00054E FF                    1310 	.db #0xff	; -1
      00054F D7                    1311 	.db #0xd7	; -41
      000550 21                    1312 	.db #0x21	;  33
      000551 0A                    1313 	.db #0x0a	;  10
      000552 DA                    1314 	.db #0xda	; -38
      000553 F7                    1315 	.db #0xf7	; -9
      000554 EB                    1316 	.db #0xeb	; -21
      000555 27                    1317 	.db #0x27	;  39
      000556 40                    1318 	.db #0x40	;  64
      000557 23                    1319 	.db #0x23	;  35
      000558 0E                    1320 	.db #0x0e	;  14
      000559 0E                    1321 	.db #0x0e	;  14
      00055A 35                    1322 	.db #0x35	;  53	'5'
      00055B 07                    1323 	.db #0x07	;  7
      00055C F2                    1324 	.db #0xf2	; -14
      00055D 03                    1325 	.db #0x03	;  3
      00055E FB                    1326 	.db #0xfb	; -5
      00055F 17                    1327 	.db #0x17	;  23
      000560 00                    1328 	.db #0x00	;  0
      000561 FE                    1329 	.db #0xfe	; -2
      000562 F0                    1330 	.db #0xf0	; -16
      000563 06                    1331 	.db #0x06	;  6
      000564 15                    1332 	.db #0x15	;  21
      000565 EC                    1333 	.db #0xec	; -20
      000566 06                    1334 	.db #0x06	;  6
      000567 61                    1335 	.db #0x61	;  97	'a'
      000568 15                    1336 	.db #0x15	;  21
      000569 DA                    1337 	.db #0xda	; -38
      00056A E6                    1338 	.db #0xe6	; -26
      00056B D3                    1339 	.db #0xd3	; -45
      00056C 03                    1340 	.db #0x03	;  3
      00056D E3                    1341 	.db #0xe3	; -29
      00056E ED                    1342 	.db #0xed	; -19
      00056F 01                    1343 	.db #0x01	;  1
      000570 1F                    1344 	.db #0x1f	;  31
      000571 E0                    1345 	.db #0xe0	; -32
      000572 B7                    1346 	.db #0xb7	; -73
      000573 EF                    1347 	.db #0xef	; -17
      000574 4A                    1348 	.db #0x4a	;  74	'J'
      000575 D7                    1349 	.db #0xd7	; -41
      000576 AA                    1350 	.db #0xaa	; -86
      000577 07                    1351 	.db #0x07	;  7
      000578 00                    1352 	.db #0x00	;  0
      000579 0A                    1353 	.db #0x0a	;  10
      00057A EC                    1354 	.db #0xec	; -20
      00057B 00                    1355 	.db #0x00	;  0
      00057C 47                    1356 	.db #0x47	;  71	'G'
      00057D EA                    1357 	.db #0xea	; -22
      00057E 04                    1358 	.db #0x04	;  4
      00057F F5                    1359 	.db #0xf5	; -11
      000580 1F                    1360 	.db #0x1f	;  31
      000581 F2                    1361 	.db #0xf2	; -14
      000582 FA                    1362 	.db #0xfa	; -6
      000583 E6                    1363 	.db #0xe6	; -26
      000584 09                    1364 	.db #0x09	;  9
      000585 1B                    1365 	.db #0x1b	;  27
      000586 E5                    1366 	.db #0xe5	; -27
      000587 0F                    1367 	.db #0x0f	;  15
      000588 1C                    1368 	.db #0x1c	;  28
      000589 FE                    1369 	.db #0xfe	; -2
      00058A CA                    1370 	.db #0xca	; -54
      00058B 50                    1371 	.db #0x50	;  80	'P'
      00058C BA                    1372 	.db #0xba	; -70
      00058D FF                    1373 	.db #0xff	; -1
      00058E E6                    1374 	.db #0xe6	; -26
      00058F C9                    1375 	.db #0xc9	; -55
      000590 00                    1376 	.db #0x00	;  0
      000591 06                    1377 	.db #0x06	;  6
      000592 F0                    1378 	.db #0xf0	; -16
      000593 1E                    1379 	.db #0x1e	;  30
      000594 01                    1380 	.db #0x01	;  1
      000595 1B                    1381 	.db #0x1b	;  27
      000596 1E                    1382 	.db #0x1e	;  30
      000597 07                    1383 	.db #0x07	;  7
      000598 30                    1384 	.db #0x30	;  48	'0'
      000599 E8                    1385 	.db #0xe8	; -24
      00059A E5                    1386 	.db #0xe5	; -27
      00059B E8                    1387 	.db #0xe8	; -24
      00059C EF                    1388 	.db #0xef	; -17
      00059D 25                    1389 	.db #0x25	;  37
      00059E E0                    1390 	.db #0xe0	; -32
      00059F 12                    1391 	.db #0x12	;  18
      0005A0 9E                    1392 	.db #0x9e	; -98
      0005A1 05                    1393 	.db #0x05	;  5
      0005A2 D7                    1394 	.db #0xd7	; -41
      0005A3 1B                    1395 	.db #0x1b	;  27
      0005A4 F9                    1396 	.db #0xf9	; -7
      0005A5 08                    1397 	.db #0x08	;  8
      0005A6 EF                    1398 	.db #0xef	; -17
      0005A7 C6                    1399 	.db #0xc6	; -58
      0005A8 00                    1400 	.db #0x00	;  0
      0005A9 F6                    1401 	.db #0xf6	; -10
      0005AA EF                    1402 	.db #0xef	; -17
      0005AB 03                    1403 	.db #0x03	;  3
      0005AC E5                    1404 	.db #0xe5	; -27
      0005AD 0A                    1405 	.db #0x0a	;  10
      0005AE 29                    1406 	.db #0x29	;  41
      0005AF DD                    1407 	.db #0xdd	; -35
      0005B0 11                    1408 	.db #0x11	;  17
      0005B1 48                    1409 	.db #0x48	;  72	'H'
      0005B2 47                    1410 	.db #0x47	;  71	'G'
      0005B3 EE                    1411 	.db #0xee	; -18
      0005B4 1B                    1412 	.db #0x1b	;  27
      0005B5 05                    1413 	.db #0x05	;  5
      0005B6 BB                    1414 	.db #0xbb	; -69
      0005B7 F7                    1415 	.db #0xf7	; -9
      0005B8 E9                    1416 	.db #0xe9	; -23
      0005B9 0E                    1417 	.db #0x0e	;  14
      0005BA E2                    1418 	.db #0xe2	; -30
      0005BB FF                    1419 	.db #0xff	; -1
      0005BC 00                    1420 	.db #0x00	;  0
      0005BD 0B                    1421 	.db #0x0b	;  11
      0005BE E3                    1422 	.db #0xe3	; -29
      0005BF BD                    1423 	.db #0xbd	; -67
      0005C0 00                    1424 	.db #0x00	;  0
      0005C1 E3                    1425 	.db #0xe3	; -29
      0005C2 F2                    1426 	.db #0xf2	; -14
      0005C3 09                    1427 	.db #0x09	;  9
      0005C4 21                    1428 	.db #0x21	;  33
      0005C5 06                    1429 	.db #0x06	;  6
      0005C6 2B                    1430 	.db #0x2b	;  43
      0005C7 CA                    1431 	.db #0xca	; -54
      0005C8 03                    1432 	.db #0x03	;  3
      0005C9 E4                    1433 	.db #0xe4	; -28
      0005CA CB                    1434 	.db #0xcb	; -53
      0005CB 0F                    1435 	.db #0x0f	;  15
      0005CC A8                    1436 	.db #0xa8	; -88
      0005CD 21                    1437 	.db #0x21	;  33
      0005CE A0                    1438 	.db #0xa0	; -96
      0005CF 05                    1439 	.db #0x05	;  5
      0005D0 FD                    1440 	.db #0xfd	; -3
      0005D1 15                    1441 	.db #0x15	;  21
      0005D2 0A                    1442 	.db #0x0a	;  10
      0005D3 F4                    1443 	.db #0xf4	; -12
      0005D4 07                    1444 	.db #0x07	;  7
      0005D5 40                    1445 	.db #0x40	;  64
      0005D6 DD                    1446 	.db #0xdd	; -35
      0005D7 D9                    1447 	.db #0xd9	; -39
      0005D8 00                    1448 	.db #0x00	;  0
      0005D9 05                    1449 	.db #0x05	;  5
      0005DA E6                    1450 	.db #0xe6	; -26
      0005DB 13                    1451 	.db #0x13	;  19
      0005DC E4                    1452 	.db #0xe4	; -28
      0005DD 0F                    1453 	.db #0x0f	;  15
      0005DE FD                    1454 	.db #0xfd	; -3
      0005DF 3B                    1455 	.db #0x3b	;  59
      0005E0 17                    1456 	.db #0x17	;  23
      0005E1 EA                    1457 	.db #0xea	; -22
      0005E2 0B                    1458 	.db #0x0b	;  11
      0005E3 DF                    1459 	.db #0xdf	; -33
      0005E4 F8                    1460 	.db #0xf8	; -8
      0005E5 3F                    1461 	.db #0x3f	;  63
      0005E6 E9                    1462 	.db #0xe9	; -23
      0005E7 07                    1463 	.db #0x07	;  7
      0005E8 1D                    1464 	.db #0x1d	;  29
      0005E9 E8                    1465 	.db #0xe8	; -24
      0005EA 08                    1466 	.db #0x08	;  8
      0005EB 47                    1467 	.db #0x47	;  71	'G'
      0005EC 49                    1468 	.db #0x49	;  73	'I'
      0005ED 05                    1469 	.db #0x05	;  5
      0005EE D0                    1470 	.db #0xd0	; -48
      0005EF 1B                    1471 	.db #0x1b	;  27
      0005F0 00                    1472 	.db #0x00	;  0
      0005F1 E2                    1473 	.db #0xe2	; -30
      0005F2 03                    1474 	.db #0x03	;  3
      0005F3 C5                    1475 	.db #0xc5	; -59
      0005F4 FF                    1476 	.db #0xff	; -1
      0005F5 F5                    1477 	.db #0xf5	; -11
      0005F6 E1                    1478 	.db #0xe1	; -31
      0005F7 18                    1479 	.db #0x18	;  24
      0005F8 C5                    1480 	.db #0xc5	; -59
      0005F9 1C                    1481 	.db #0x1c	;  28
      0005FA 0C                    1482 	.db #0x0c	;  12
      0005FB F5                    1483 	.db #0xf5	; -11
      0005FC 0C                    1484 	.db #0x0c	;  12
      0005FD 3B                    1485 	.db #0x3b	;  59
      0005FE EE                    1486 	.db #0xee	; -18
      0005FF 19                    1487 	.db #0x19	;  25
      000600 16                    1488 	.db #0x16	;  22
      000601 07                    1489 	.db #0x07	;  7
      000602 17                    1490 	.db #0x17	;  23
      000603 37                    1491 	.db #0x37	;  55	'7'
      000604 A9                    1492 	.db #0xa9	; -87
      000605 F9                    1493 	.db #0xf9	; -7
      000606 F7                    1494 	.db #0xf7	; -9
      000607 42                    1495 	.db #0x42	;  66	'B'
      000608 00                    1496 	.db #0x00	;  0
      000609 0A                    1497 	.db #0x0a	;  10
      00060A 23                    1498 	.db #0x23	;  35
      00060B 16                    1499 	.db #0x16	;  22
      00060C EF                    1500 	.db #0xef	; -17
      00060D 07                    1501 	.db #0x07	;  7
      00060E B1                    1502 	.db #0xb1	; -79
      00060F F1                    1503 	.db #0xf1	; -15
      000610 ED                    1504 	.db #0xed	; -19
      000611 DD                    1505 	.db #0xdd	; -35
      000612 EA                    1506 	.db #0xea	; -22
      000613 EF                    1507 	.db #0xef	; -17
      000614 E7                    1508 	.db #0xe7	; -25
      000615 07                    1509 	.db #0x07	;  7
      000616 FF                    1510 	.db #0xff	; -1
      000617 27                    1511 	.db #0x27	;  39
      000618 B6                    1512 	.db #0xb6	; -74
      000619 FA                    1513 	.db #0xfa	; -6
      00061A FD                    1514 	.db #0xfd	; -3
      00061B CD                    1515 	.db #0xcd	; -51
      00061C 2B                    1516 	.db #0x2b	;  43
      00061D E6                    1517 	.db #0xe6	; -26
      00061E EB                    1518 	.db #0xeb	; -21
      00061F 3E                    1519 	.db #0x3e	;  62
      000620 00                    1520 	.db #0x00	;  0
      000621 19                    1521 	.db #0x19	;  25
      000622 12                    1522 	.db #0x12	;  18
      000623 31                    1523 	.db #0x31	;  49	'1'
      000624 31                    1524 	.db #0x31	;  49	'1'
      000625 2D                    1525 	.db #0x2d	;  45
      000626 BA                    1526 	.db #0xba	; -70
      000627 F1                    1527 	.db #0xf1	; -15
      000628 F9                    1528 	.db #0xf9	; -7
      000629 41                    1529 	.db #0x41	;  65	'A'
      00062A 39                    1530 	.db #0x39	;  57	'9'
      00062B FB                    1531 	.db #0xfb	; -5
      00062C 49                    1532 	.db #0x49	;  73	'I'
      00062D FA                    1533 	.db #0xfa	; -6
      00062E F0                    1534 	.db #0xf0	; -16
      00062F 01                    1535 	.db #0x01	;  1
      000630 05                    1536 	.db #0x05	;  5
      000631 ED                    1537 	.db #0xed	; -19
      000632 F8                    1538 	.db #0xf8	; -8
      000633 F7                    1539 	.db #0xf7	; -9
      000634 F5                    1540 	.db #0xf5	; -11
      000635 12                    1541 	.db #0x12	;  18
      000636 EF                    1542 	.db #0xef	; -17
      000637 20                    1543 	.db #0x20	;  32
      000638 00                    1544 	.db #0x00	;  0
      000639 D7                    1545 	.db #0xd7	; -41
      00063A E0                    1546 	.db #0xe0	; -32
      00063B 01                    1547 	.db #0x01	;  1
      00063C 21                    1548 	.db #0x21	;  33
      00063D 44                    1549 	.db #0x44	;  68	'D'
      00063E A3                    1550 	.db #0xa3	; -93
      00063F F2                    1551 	.db #0xf2	; -14
      000640 1E                    1552 	.db #0x1e	;  30
      000641 E8                    1553 	.db #0xe8	; -24
      000642 D2                    1554 	.db #0xd2	; -46
      000643 FA                    1555 	.db #0xfa	; -6
      000644 81                    1556 	.db #0x81	; -127
      000645 37                    1557 	.db #0x37	;  55	'7'
      000646 F9                    1558 	.db #0xf9	; -7
      000647 F4                    1559 	.db #0xf4	; -12
      000648 FE                    1560 	.db #0xfe	; -2
      000649 18                    1561 	.db #0x18	;  24
      00064A D4                    1562 	.db #0xd4	; -44
      00064B 0D                    1563 	.db #0x0d	;  13
      00064C 0B                    1564 	.db #0x0b	;  11
      00064D 16                    1565 	.db #0x16	;  22
      00064E EA                    1566 	.db #0xea	; -22
      00064F D7                    1567 	.db #0xd7	; -41
      000650 00                    1568 	.db #0x00	;  0
      000651 E4                    1569 	.db #0xe4	; -28
      000652 C5                    1570 	.db #0xc5	; -59
      000653 02                    1571 	.db #0x02	;  2
      000654 17                    1572 	.db #0x17	;  23
      000655 2E                    1573 	.db #0x2e	;  46
      000656 F0                    1574 	.db #0xf0	; -16
      000657 5F                    1575 	.db #0x5f	;  95
      000658 13                    1576 	.db #0x13	;  19
      000659 E8                    1577 	.db #0xe8	; -24
      00065A 20                    1578 	.db #0x20	;  32
      00065B 0A                    1579 	.db #0x0a	;  10
      00065C 04                    1580 	.db #0x04	;  4
      00065D 2A                    1581 	.db #0x2a	;  42
      00065E 01                    1582 	.db #0x01	;  1
      00065F 29                    1583 	.db #0x29	;  41
      000660 1D                    1584 	.db #0x1d	;  29
      000661 F7                    1585 	.db #0xf7	; -9
      000662 24                    1586 	.db #0x24	;  36
      000663 10                    1587 	.db #0x10	;  16
      000664 4A                    1588 	.db #0x4a	;  74	'J'
      000665 1C                    1589 	.db #0x1c	;  28
      000666 29                    1590 	.db #0x29	;  41
      000667 F5                    1591 	.db #0xf5	; -11
      000668 00                    1592 	.db #0x00	;  0
      000669 EB                    1593 	.db #0xeb	; -21
      00066A D3                    1594 	.db #0xd3	; -45
      00066B 97                    1595 	.db #0x97	; -105
      00066C 0E                    1596 	.db #0x0e	;  14
      00066D F3                    1597 	.db #0xf3	; -13
      00066E 1F                    1598 	.db #0x1f	;  31
      00066F F6                    1599 	.db #0xf6	; -10
      000670 B9                    1600 	.db #0xb9	; -71
      000671 19                    1601 	.db #0x19	;  25
      000672 0D                    1602 	.db #0x0d	;  13
      000673 F0                    1603 	.db #0xf0	; -16
      000674 01                    1604 	.db #0x01	;  1
      000675 42                    1605 	.db #0x42	;  66	'B'
      000676 0A                    1606 	.db #0x0a	;  10
      000677 F7                    1607 	.db #0xf7	; -9
      000678 10                    1608 	.db #0x10	;  16
      000679 12                    1609 	.db #0x12	;  18
      00067A 02                    1610 	.db #0x02	;  2
      00067B E0                    1611 	.db #0xe0	; -32
      00067C BF                    1612 	.db #0xbf	; -65
      00067D F9                    1613 	.db #0xf9	; -7
      00067E 48                    1614 	.db #0x48	;  72	'H'
      00067F 05                    1615 	.db #0x05	;  5
      000680 00                    1616 	.db #0x00	;  0
      000681 F5                    1617 	.db #0xf5	; -11
      000682 EF                    1618 	.db #0xef	; -17
      000683 0D                    1619 	.db #0x0d	;  13
      000684 08                    1620 	.db #0x08	;  8
      000685 B5                    1621 	.db #0xb5	; -75
      000686 4F                    1622 	.db #0x4f	;  79	'O'
      000687 F8                    1623 	.db #0xf8	; -8
      000688 92                    1624 	.db #0x92	; -110
      000689 E8                    1625 	.db #0xe8	; -24
      00068A D8                    1626 	.db #0xd8	; -40
      00068B ED                    1627 	.db #0xed	; -19
      00068C F6                    1628 	.db #0xf6	; -10
      00068D 22                    1629 	.db #0x22	;  34
      00068E 12                    1630 	.db #0x12	;  18
      00068F 2A                    1631 	.db #0x2a	;  42
      000690 EF                    1632 	.db #0xef	; -17
      000691 CA                    1633 	.db #0xca	; -54
      000692 02                    1634 	.db #0x02	;  2
      000693 F5                    1635 	.db #0xf5	; -11
      000694 2A                    1636 	.db #0x2a	;  42
      000695 08                    1637 	.db #0x08	;  8
      000696 1A                    1638 	.db #0x1a	;  26
      000697 10                    1639 	.db #0x10	;  16
      000698 00                    1640 	.db #0x00	;  0
      000699 3F                    1641 	.db #0x3f	;  63
      00069A ED                    1642 	.db #0xed	; -19
      00069B 30                    1643 	.db #0x30	;  48	'0'
      00069C 1D                    1644 	.db #0x1d	;  29
      00069D F2                    1645 	.db #0xf2	; -14
      00069E 52                    1646 	.db #0x52	;  82	'R'
      00069F 13                    1647 	.db #0x13	;  19
      0006A0 DB                    1648 	.db #0xdb	; -37
      0006A1 38                    1649 	.db #0x38	;  56	'8'
      0006A2 35                    1650 	.db #0x35	;  53	'5'
      0006A3 C8                    1651 	.db #0xc8	; -56
      0006A4 3A                    1652 	.db #0x3a	;  58
      0006A5 08                    1653 	.db #0x08	;  8
      0006A6 14                    1654 	.db #0x14	;  20
      0006A7 38                    1655 	.db #0x38	;  56	'8'
      0006A8 11                    1656 	.db #0x11	;  17
      0006A9 B9                    1657 	.db #0xb9	; -71
      0006AA 17                    1658 	.db #0x17	;  23
      0006AB FA                    1659 	.db #0xfa	; -6
      0006AC EE                    1660 	.db #0xee	; -18
      0006AD 18                    1661 	.db #0x18	;  24
      0006AE 16                    1662 	.db #0x16	;  22
      0006AF 19                    1663 	.db #0x19	;  25
      0006B0 00                    1664 	.db #0x00	;  0
      0006B1 F3                    1665 	.db #0xf3	; -13
      0006B2 E5                    1666 	.db #0xe5	; -27
      0006B3 E6                    1667 	.db #0xe6	; -26
      0006B4 00                    1668 	.db #0x00	;  0
      0006B5 FE                    1669 	.db #0xfe	; -2
      0006B6 3E                    1670 	.db #0x3e	;  62
      0006B7 14                    1671 	.db #0x14	;  20
      0006B8 F2                    1672 	.db #0xf2	; -14
      0006B9 ED                    1673 	.db #0xed	; -19
      0006BA F5                    1674 	.db #0xf5	; -11
      0006BB C8                    1675 	.db #0xc8	; -56
      0006BC AD                    1676 	.db #0xad	; -83
      0006BD 13                    1677 	.db #0x13	;  19
      0006BE 0C                    1678 	.db #0x0c	;  12
      0006BF 17                    1679 	.db #0x17	;  23
      0006C0 0E                    1680 	.db #0x0e	;  14
      0006C1 10                    1681 	.db #0x10	;  16
      0006C2 03                    1682 	.db #0x03	;  3
      0006C3 E9                    1683 	.db #0xe9	; -23
      0006C4 04                    1684 	.db #0x04	;  4
      0006C5 FA                    1685 	.db #0xfa	; -6
      0006C6 06                    1686 	.db #0x06	;  6
      0006C7 13                    1687 	.db #0x13	;  19
      0006C8 00                    1688 	.db #0x00	;  0
      0006C9 E5                    1689 	.db #0xe5	; -27
      0006CA 1C                    1690 	.db #0x1c	;  28
      0006CB 10                    1691 	.db #0x10	;  16
      0006CC 3F                    1692 	.db #0x3f	;  63
      0006CD 2A                    1693 	.db #0x2a	;  42
      0006CE F4                    1694 	.db #0xf4	; -12
      0006CF 1A                    1695 	.db #0x1a	;  26
      0006D0 F5                    1696 	.db #0xf5	; -11
      0006D1 D2                    1697 	.db #0xd2	; -46
      0006D2 FE                    1698 	.db #0xfe	; -2
      0006D3 79                    1699 	.db #0x79	;  121	'y'
      0006D4 FA                    1700 	.db #0xfa	; -6
      0006D5 FA                    1701 	.db #0xfa	; -6
      0006D6 07                    1702 	.db #0x07	;  7
      0006D7 BE                    1703 	.db #0xbe	; -66
      0006D8 0B                    1704 	.db #0x0b	;  11
      0006D9 EC                    1705 	.db #0xec	; -20
      0006DA 00                    1706 	.db #0x00	;  0
      0006DB D2                    1707 	.db #0xd2	; -46
      0006DC 45                    1708 	.db #0x45	;  69	'E'
      0006DD 12                    1709 	.db #0x12	;  18
      0006DE 76                    1710 	.db #0x76	;  118	'v'
      0006DF 09                    1711 	.db #0x09	;  9
      0006E0 00                    1712 	.db #0x00	;  0
      0006E1 EF                    1713 	.db #0xef	; -17
      0006E2 11                    1714 	.db #0x11	;  17
      0006E3 A4                    1715 	.db #0xa4	; -92
      0006E4 19                    1716 	.db #0x19	;  25
      0006E5 01                    1717 	.db #0x01	;  1
      0006E6 F5                    1718 	.db #0xf5	; -11
      0006E7 FA                    1719 	.db #0xfa	; -6
      0006E8 FD                    1720 	.db #0xfd	; -3
      0006E9 F2                    1721 	.db #0xf2	; -14
      0006EA FF                    1722 	.db #0xff	; -1
      0006EB 4B                    1723 	.db #0x4b	;  75	'K'
      0006EC 01                    1724 	.db #0x01	;  1
      0006ED 1D                    1725 	.db #0x1d	;  29
      0006EE 07                    1726 	.db #0x07	;  7
      0006EF E4                    1727 	.db #0xe4	; -28
      0006F0 1D                    1728 	.db #0x1d	;  29
      0006F1 38                    1729 	.db #0x38	;  56	'8'
      0006F2 0C                    1730 	.db #0x0c	;  12
      0006F3 09                    1731 	.db #0x09	;  9
      0006F4 DC                    1732 	.db #0xdc	; -36
      0006F5 F4                    1733 	.db #0xf4	; -12
      0006F6 39                    1734 	.db #0x39	;  57	'9'
      0006F7 FE                    1735 	.db #0xfe	; -2
      0006F8 00                    1736 	.db #0x00	;  0
      0006F9 29                    1737 	.db #0x29	;  41
      0006FA 0E                    1738 	.db #0x0e	;  14
      0006FB 37                    1739 	.db #0x37	;  55	'7'
      0006FC 2B                    1740 	.db #0x2b	;  43
      0006FD 2F                    1741 	.db #0x2f	;  47
      0006FE F1                    1742 	.db #0xf1	; -15
      0006FF E9                    1743 	.db #0xe9	; -23
      000700 02                    1744 	.db #0x02	;  2
      000701 E2                    1745 	.db #0xe2	; -30
      000702 C6                    1746 	.db #0xc6	; -58
      000703 3F                    1747 	.db #0x3f	;  63
      000704 F7                    1748 	.db #0xf7	; -9
      000705 01                    1749 	.db #0x01	;  1
      000706 1A                    1750 	.db #0x1a	;  26
      000707 01                    1751 	.db #0x01	;  1
      000708 FC                    1752 	.db #0xfc	; -4
      000709 AF                    1753 	.db #0xaf	; -81
      00070A FE                    1754 	.db #0xfe	; -2
      00070B CE                    1755 	.db #0xce	; -50
      00070C 24                    1756 	.db #0x24	;  36
      00070D 09                    1757 	.db #0x09	;  9
      00070E 49                    1758 	.db #0x49	;  73	'I'
      00070F 27                    1759 	.db #0x27	;  39
      000710 00                    1760 	.db #0x00	;  0
      000711 49                    1761 	.db #0x49	;  73	'I'
      000712 34                    1762 	.db #0x34	;  52	'4'
      000713 29                    1763 	.db #0x29	;  41
      000714 21                    1764 	.db #0x21	;  33
      000715 F1                    1765 	.db #0xf1	; -15
      000716 F4                    1766 	.db #0xf4	; -12
      000717 FB                    1767 	.db #0xfb	; -5
      000718 FF                    1768 	.db #0xff	; -1
      000719 2F                    1769 	.db #0x2f	;  47
      00071A 2D                    1770 	.db #0x2d	;  45
      00071B 12                    1771 	.db #0x12	;  18
      00071C 2F                    1772 	.db #0x2f	;  47
      00071D 1D                    1773 	.db #0x1d	;  29
      00071E 15                    1774 	.db #0x15	;  21
      00071F 03                    1775 	.db #0x03	;  3
      000720 02                    1776 	.db #0x02	;  2
      000721 C4                    1777 	.db #0xc4	; -60
      000722 0D                    1778 	.db #0x0d	;  13
      000723 CF                    1779 	.db #0xcf	; -49
      000724 F7                    1780 	.db #0xf7	; -9
      000725 29                    1781 	.db #0x29	;  41
      000726 2B                    1782 	.db #0x2b	;  43
      000727 2B                    1783 	.db #0x2b	;  43
      000728 00                    1784 	.db #0x00	;  0
      000729 D1                    1785 	.db #0xd1	; -47
      00072A 33                    1786 	.db #0x33	;  51	'3'
      00072B CB                    1787 	.db #0xcb	; -53
      00072C F0                    1788 	.db #0xf0	; -16
      00072D E7                    1789 	.db #0xe7	; -25
      00072E 03                    1790 	.db #0x03	;  3
      00072F 02                    1791 	.db #0x02	;  2
      000730 E4                    1792 	.db #0xe4	; -28
      000731 FE                    1793 	.db #0xfe	; -2
      000732 F9                    1794 	.db #0xf9	; -7
      000733 11                    1795 	.db #0x11	;  17
      000734 C8                    1796 	.db #0xc8	; -56
      000735 32                    1797 	.db #0x32	;  50	'2'
      000736 14                    1798 	.db #0x14	;  20
      000737 1A                    1799 	.db #0x1a	;  26
      000738 FA                    1800 	.db #0xfa	; -6
      000739 2C                    1801 	.db #0x2c	;  44
      00073A 10                    1802 	.db #0x10	;  16
      00073B D7                    1803 	.db #0xd7	; -41
      00073C 03                    1804 	.db #0x03	;  3
      00073D 27                    1805 	.db #0x27	;  39
      00073E 3C                    1806 	.db #0x3c	;  60
      00073F 4A                    1807 	.db #0x4a	;  74	'J'
      000740 00                    1808 	.db #0x00	;  0
      000741 C4                    1809 	.db #0xc4	; -60
      000742 6B                    1810 	.db #0x6b	;  107	'k'
      000743 E7                    1811 	.db #0xe7	; -25
      000744 08                    1812 	.db #0x08	;  8
      000745 EA                    1813 	.db #0xea	; -22
      000746 11                    1814 	.db #0x11	;  17
      000747 29                    1815 	.db #0x29	;  41
      000748 D9                    1816 	.db #0xd9	; -39
      000749 D7                    1817 	.db #0xd7	; -41
      00074A EB                    1818 	.db #0xeb	; -21
      00074B 35                    1819 	.db #0x35	;  53	'5'
      00074C FA                    1820 	.db #0xfa	; -6
      00074D 00                    1821 	.db #0x00	;  0
      00074E EF                    1822 	.db #0xef	; -17
      00074F EE                    1823 	.db #0xee	; -18
      000750 10                    1824 	.db #0x10	;  16
      000751 CE                    1825 	.db #0xce	; -50
      000752 E6                    1826 	.db #0xe6	; -26
      000753 02                    1827 	.db #0x02	;  2
      000754 08                    1828 	.db #0x08	;  8
      000755 07                    1829 	.db #0x07	;  7
      000756 01                    1830 	.db #0x01	;  1
      000757 F1                    1831 	.db #0xf1	; -15
      000758 00                    1832 	.db #0x00	;  0
      000759 05                    1833 	.db #0x05	;  5
      00075A 0D                    1834 	.db #0x0d	;  13
      00075B DA                    1835 	.db #0xda	; -38
      00075C 0C                    1836 	.db #0x0c	;  12
      00075D F6                    1837 	.db #0xf6	; -10
      00075E FD                    1838 	.db #0xfd	; -3
      00075F EF                    1839 	.db #0xef	; -17
      000760 00                    1840 	.db #0x00	;  0
      000761 DA                    1841 	.db #0xda	; -38
      000762 F7                    1842 	.db #0xf7	; -9
      000763 38                    1843 	.db #0x38	;  56	'8'
      000764 FB                    1844 	.db #0xfb	; -5
      000765 03                    1845 	.db #0x03	;  3
      000766 FB                    1846 	.db #0xfb	; -5
      000767 C8                    1847 	.db #0xc8	; -56
      000768 00                    1848 	.db #0x00	;  0
      000769 54                    1849 	.db #0x54	;  84	'T'
      00076A C8                    1850 	.db #0xc8	; -56
      00076B D6                    1851 	.db #0xd6	; -42
      00076C 12                    1852 	.db #0x12	;  18
      00076D F4                    1853 	.db #0xf4	; -12
      00076E 19                    1854 	.db #0x19	;  25
      00076F 24                    1855 	.db #0x24	;  36
      000770 00                    1856 	.db #0x00	;  0
      000771 13                    1857 	.db #0x13	;  19
      000772 61                    1858 	.db #0x61	;  97	'a'
      000773 30                    1859 	.db #0x30	;  48	'0'
      000774 5B                    1860 	.db #0x5b	;  91
      000775 F1                    1861 	.db #0xf1	; -15
      000776 16                    1862 	.db #0x16	;  22
      000777 F1                    1863 	.db #0xf1	; -15
      000778 D9                    1864 	.db #0xd9	; -39
      000779 F0                    1865 	.db #0xf0	; -16
      00077A DB                    1866 	.db #0xdb	; -37
      00077B 3B                    1867 	.db #0x3b	;  59
      00077C 1A                    1868 	.db #0x1a	;  26
      00077D 00                    1869 	.db #0x00	;  0
      00077E E9                    1870 	.db #0xe9	; -23
      00077F A0                    1871 	.db #0xa0	; -96
      000780 01                    1872 	.db #0x01	;  1
      000781 B1                    1873 	.db #0xb1	; -79
      000782 DB                    1874 	.db #0xdb	; -37
      000783 FB                    1875 	.db #0xfb	; -5
      000784 FF                    1876 	.db #0xff	; -1
      000785 02                    1877 	.db #0x02	;  2
      000786 37                    1878 	.db #0x37	;  55	'7'
      000787 1D                    1879 	.db #0x1d	;  29
      000788 00                    1880 	.db #0x00	;  0
      000789 F2                    1881 	.db #0xf2	; -14
      00078A 3F                    1882 	.db #0x3f	;  63
      00078B 19                    1883 	.db #0x19	;  25
      00078C 13                    1884 	.db #0x13	;  19
      00078D F4                    1885 	.db #0xf4	; -12
      00078E 0E                    1886 	.db #0x0e	;  14
      00078F 0C                    1887 	.db #0x0c	;  12
      000790 EC                    1888 	.db #0xec	; -20
      000791 21                    1889 	.db #0x21	;  33
      000792 26                    1890 	.db #0x26	;  38
      000793 39                    1891 	.db #0x39	;  57	'9'
      000794 E1                    1892 	.db #0xe1	; -31
      000795 29                    1893 	.db #0x29	;  41
      000796 FA                    1894 	.db #0xfa	; -6
      000797 A1                    1895 	.db #0xa1	; -95
      000798 E6                    1896 	.db #0xe6	; -26
      000799 D9                    1897 	.db #0xd9	; -39
      00079A E2                    1898 	.db #0xe2	; -30
      00079B EF                    1899 	.db #0xef	; -17
      00079C 0A                    1900 	.db #0x0a	;  10
      00079D 22                    1901 	.db #0x22	;  34
      00079E 42                    1902 	.db #0x42	;  66	'B'
      00079F 18                    1903 	.db #0x18	;  24
      0007A0 00                    1904 	.db #0x00	;  0
      0007A1 AE                    1905 	.db #0xae	; -82
      0007A2 46                    1906 	.db #0x46	;  70	'F'
      0007A3 F0                    1907 	.db #0xf0	; -16
      0007A4 F7                    1908 	.db #0xf7	; -9
      0007A5 E0                    1909 	.db #0xe0	; -32
      0007A6 16                    1910 	.db #0x16	;  22
      0007A7 0E                    1911 	.db #0x0e	;  14
      0007A8 E1                    1912 	.db #0xe1	; -31
      0007A9 05                    1913 	.db #0x05	;  5
      0007AA F2                    1914 	.db #0xf2	; -14
      0007AB 46                    1915 	.db #0x46	;  70	'F'
      0007AC 00                    1916 	.db #0x00	;  0
      0007AD 1A                    1917 	.db #0x1a	;  26
      0007AE F1                    1918 	.db #0xf1	; -15
      0007AF AE                    1919 	.db #0xae	; -82
      0007B0 FB                    1920 	.db #0xfb	; -5
      0007B1 32                    1921 	.db #0x32	;  50	'2'
      0007B2 ED                    1922 	.db #0xed	; -19
      0007B3 EA                    1923 	.db #0xea	; -22
      0007B4 F5                    1924 	.db #0xf5	; -11
      0007B5 EE                    1925 	.db #0xee	; -18
      0007B6 1C                    1926 	.db #0x1c	;  28
      0007B7 2D                    1927 	.db #0x2d	;  45
      0007B8 00                    1928 	.db #0x00	;  0
      0007B9 E5                    1929 	.db #0xe5	; -27
      0007BA 1E                    1930 	.db #0x1e	;  30
      0007BB F1                    1931 	.db #0xf1	; -15
      0007BC FD                    1932 	.db #0xfd	; -3
      0007BD E4                    1933 	.db #0xe4	; -28
      0007BE FE                    1934 	.db #0xfe	; -2
      0007BF E8                    1935 	.db #0xe8	; -24
      0007C0 EA                    1936 	.db #0xea	; -22
      0007C1 DB                    1937 	.db #0xdb	; -37
                                   1938 	.area CSEG    (CODE)
                                   1939 	.area CONST   (CODE)
      0007C2                       1940 _B2:
      0007C2 14 FE FF FF           1941 	.byte #0x14, #0xfe, #0xff, #0xff	; -492
      0007C6 50 0B 00 00           1942 	.byte #0x50, #0x0b, #0x00, #0x00	;  2896
      0007CA C8 02 00 00           1943 	.byte #0xc8, #0x02, #0x00, #0x00	;  712
      0007CE 91 08 00 00           1944 	.byte #0x91, #0x08, #0x00, #0x00	;  2193
      0007D2 72 F3 FF FF           1945 	.byte #0x72, #0xf3, #0xff, #0xff	; -3214
      0007D6 6F 06 00 00           1946 	.byte #0x6f, #0x06, #0x00, #0x00	;  1647
      0007DA 31 F7 FF FF           1947 	.byte #0x31, #0xf7, #0xff, #0xff	; -2255
      0007DE 8B 0F 00 00           1948 	.byte #0x8b, #0x0f, #0x00, #0x00	;  3979
      0007E2 1D EE FF FF           1949 	.byte #0x1d, #0xee, #0xff, #0xff	; -4579
      0007E6 45 01 00 00           1950 	.byte #0x45, #0x01, #0x00, #0x00	;  325
                                   1951 	.area CSEG    (CODE)
                                   1952 	.area CONST   (CODE)
      0007EA                       1953 _W2:
      0007EA DF                    1954 	.db #0xdf	; -33
      0007EB DA                    1955 	.db #0xda	; -38
      0007EC 4A                    1956 	.db #0x4a	;  74	'J'
      0007ED 3C                    1957 	.db #0x3c	;  60
      0007EE CB                    1958 	.db #0xcb	; -53
      0007EF 19                    1959 	.db #0x19	;  25
      0007F0 FF                    1960 	.db #0xff	; -1
      0007F1 E9                    1961 	.db #0xe9	; -23
      0007F2 EE                    1962 	.db #0xee	; -18
      0007F3 ED                    1963 	.db #0xed	; -19
      0007F4 3A                    1964 	.db #0x3a	;  58
      0007F5 E3                    1965 	.db #0xe3	; -29
      0007F6 45                    1966 	.db #0x45	;  69	'E'
      0007F7 B9                    1967 	.db #0xb9	; -71
      0007F8 00                    1968 	.db #0x00	;  0
      0007F9 F2                    1969 	.db #0xf2	; -14
      0007FA 24                    1970 	.db #0x24	;  36
      0007FB 07                    1971 	.db #0x07	;  7
      0007FC 1B                    1972 	.db #0x1b	;  27
      0007FD CF                    1973 	.db #0xcf	; -49
      0007FE 81                    1974 	.db #0x81	; -127
      0007FF 14                    1975 	.db #0x14	;  20
      000800 0F                    1976 	.db #0x0f	;  15
      000801 E7                    1977 	.db #0xe7	; -25
      000802 6F                    1978 	.db #0x6f	;  111	'o'
      000803 2C                    1979 	.db #0x2c	;  44
      000804 C6                    1980 	.db #0xc6	; -58
      000805 B2                    1981 	.db #0xb2	; -78
      000806 35                    1982 	.db #0x35	;  53	'5'
      000807 22                    1983 	.db #0x22	;  34
      000808 4B                    1984 	.db #0x4b	;  75	'K'
      000809 41                    1985 	.db #0x41	;  65	'A'
      00080A D5                    1986 	.db #0xd5	; -43
      00080B 09                    1987 	.db #0x09	;  9
      00080C 0A                    1988 	.db #0x0a	;  10
      00080D D6                    1989 	.db #0xd6	; -42
      00080E DB                    1990 	.db #0xdb	; -37
      00080F FA                    1991 	.db #0xfa	; -6
      000810 00                    1992 	.db #0x00	;  0
      000811 D7                    1993 	.db #0xd7	; -41
      000812 09                    1994 	.db #0x09	;  9
      000813 2D                    1995 	.db #0x2d	;  45
      000814 AD                    1996 	.db #0xad	; -83
      000815 CD                    1997 	.db #0xcd	; -51
      000816 F5                    1998 	.db #0xf5	; -11
      000817 3B                    1999 	.db #0x3b	;  59
      000818 04                    2000 	.db #0x04	;  4
      000819 5C                    2001 	.db #0x5c	;  92
      00081A F0                    2002 	.db #0xf0	; -16
      00081B 7B                    2003 	.db #0x7b	;  123
      00081C B9                    2004 	.db #0xb9	; -71
      00081D DF                    2005 	.db #0xdf	; -33
      00081E EF                    2006 	.db #0xef	; -17
      00081F 30                    2007 	.db #0x30	;  48	'0'
      000820 C2                    2008 	.db #0xc2	; -62
      000821 B5                    2009 	.db #0xb5	; -75
      000822 38                    2010 	.db #0x38	;  56	'8'
      000823 47                    2011 	.db #0x47	;  71	'G'
      000824 C2                    2012 	.db #0xc2	; -62
      000825 FA                    2013 	.db #0xfa	; -6
      000826 D9                    2014 	.db #0xd9	; -39
      000827 02                    2015 	.db #0x02	;  2
      000828 00                    2016 	.db #0x00	;  0
      000829 B3                    2017 	.db #0xb3	; -77
      00082A B6                    2018 	.db #0xb6	; -74
      00082B 17                    2019 	.db #0x17	;  23
      00082C 2A                    2020 	.db #0x2a	;  42
      00082D C9                    2021 	.db #0xc9	; -55
      00082E 0E                    2022 	.db #0x0e	;  14
      00082F F5                    2023 	.db #0xf5	; -11
      000830 C4                    2024 	.db #0xc4	; -60
      000831 F7                    2025 	.db #0xf7	; -9
      000832 D1                    2026 	.db #0xd1	; -47
      000833 15                    2027 	.db #0x15	;  21
      000834 06                    2028 	.db #0x06	;  6
      000835 D5                    2029 	.db #0xd5	; -43
      000836 16                    2030 	.db #0x16	;  22
      000837 E3                    2031 	.db #0xe3	; -29
      000838 B8                    2032 	.db #0xb8	; -72
      000839 DC                    2033 	.db #0xdc	; -36
      00083A 2E                    2034 	.db #0x2e	;  46
      00083B 23                    2035 	.db #0x23	;  35
      00083C A8                    2036 	.db #0xa8	; -88
      00083D 37                    2037 	.db #0x37	;  55	'7'
      00083E DC                    2038 	.db #0xdc	; -36
      00083F EF                    2039 	.db #0xef	; -17
      000840 00                    2040 	.db #0x00	;  0
      000841 2E                    2041 	.db #0x2e	;  46
      000842 14                    2042 	.db #0x14	;  20
      000843 B5                    2043 	.db #0xb5	; -75
      000844 3D                    2044 	.db #0x3d	;  61
      000845 1B                    2045 	.db #0x1b	;  27
      000846 1A                    2046 	.db #0x1a	;  26
      000847 11                    2047 	.db #0x11	;  17
      000848 C6                    2048 	.db #0xc6	; -58
      000849 FE                    2049 	.db #0xfe	; -2
      00084A 5B                    2050 	.db #0x5b	;  91
      00084B E9                    2051 	.db #0xe9	; -23
      00084C B3                    2052 	.db #0xb3	; -77
      00084D F3                    2053 	.db #0xf3	; -13
      00084E C9                    2054 	.db #0xc9	; -55
      00084F 18                    2055 	.db #0x18	;  24
      000850 29                    2056 	.db #0x29	;  41
      000851 46                    2057 	.db #0x46	;  70	'F'
      000852 AB                    2058 	.db #0xab	; -85
      000853 0E                    2059 	.db #0x0e	;  14
      000854 00                    2060 	.db #0x00	;  0
      000855 E3                    2061 	.db #0xe3	; -29
      000856 38                    2062 	.db #0x38	;  56	'8'
      000857 58                    2063 	.db #0x58	;  88	'X'
      000858 00                    2064 	.db #0x00	;  0
      000859 F8                    2065 	.db #0xf8	; -8
      00085A B8                    2066 	.db #0xb8	; -72
      00085B EB                    2067 	.db #0xeb	; -21
      00085C DC                    2068 	.db #0xdc	; -36
      00085D 07                    2069 	.db #0x07	;  7
      00085E 1E                    2070 	.db #0x1e	;  30
      00085F 13                    2071 	.db #0x13	;  19
      000860 40                    2072 	.db #0x40	;  64
      000861 3E                    2073 	.db #0x3e	;  62
      000862 A7                    2074 	.db #0xa7	; -89
      000863 E5                    2075 	.db #0xe5	; -27
      000864 21                    2076 	.db #0x21	;  33
      000865 12                    2077 	.db #0x12	;  18
      000866 4B                    2078 	.db #0x4b	;  75	'K'
      000867 D8                    2079 	.db #0xd8	; -40
      000868 00                    2080 	.db #0x00	;  0
      000869 D9                    2081 	.db #0xd9	; -39
      00086A F5                    2082 	.db #0xf5	; -11
      00086B AA                    2083 	.db #0xaa	; -86
      00086C 01                    2084 	.db #0x01	;  1
      00086D F1                    2085 	.db #0xf1	; -15
      00086E CB                    2086 	.db #0xcb	; -53
      00086F F1                    2087 	.db #0xf1	; -15
      000870 00                    2088 	.db #0x00	;  0
      000871 29                    2089 	.db #0x29	;  41
      000872 51                    2090 	.db #0x51	;  81	'Q'
      000873 C8                    2091 	.db #0xc8	; -56
      000874 ED                    2092 	.db #0xed	; -19
      000875 34                    2093 	.db #0x34	;  52	'4'
      000876 1F                    2094 	.db #0x1f	;  31
      000877 AB                    2095 	.db #0xab	; -85
      000878 04                    2096 	.db #0x04	;  4
      000879 AE                    2097 	.db #0xae	; -82
      00087A E7                    2098 	.db #0xe7	; -25
      00087B EA                    2099 	.db #0xea	; -22
      00087C EE                    2100 	.db #0xee	; -18
      00087D 18                    2101 	.db #0x18	;  24
      00087E 13                    2102 	.db #0x13	;  19
      00087F 2A                    2103 	.db #0x2a	;  42
      000880 32                    2104 	.db #0x32	;  50	'2'
      000881 DD                    2105 	.db #0xdd	; -35
      000882 A9                    2106 	.db #0xa9	; -87
      000883 EE                    2107 	.db #0xee	; -18
      000884 38                    2108 	.db #0x38	;  56	'8'
      000885 BA                    2109 	.db #0xba	; -70
      000886 38                    2110 	.db #0x38	;  56	'8'
      000887 19                    2111 	.db #0x19	;  25
      000888 00                    2112 	.db #0x00	;  0
      000889 DF                    2113 	.db #0xdf	; -33
      00088A 0E                    2114 	.db #0x0e	;  14
      00088B 06                    2115 	.db #0x06	;  6
      00088C D3                    2116 	.db #0xd3	; -45
      00088D 40                    2117 	.db #0x40	;  64
      00088E 09                    2118 	.db #0x09	;  9
      00088F AA                    2119 	.db #0xaa	; -86
      000890 D8                    2120 	.db #0xd8	; -40
      000891 BC                    2121 	.db #0xbc	; -68
      000892 FA                    2122 	.db #0xfa	; -6
      000893 EF                    2123 	.db #0xef	; -17
      000894 18                    2124 	.db #0x18	;  24
      000895 B0                    2125 	.db #0xb0	; -80
      000896 3B                    2126 	.db #0x3b	;  59
      000897 9C                    2127 	.db #0x9c	; -100
      000898 BB                    2128 	.db #0xbb	; -69
      000899 4F                    2129 	.db #0x4f	;  79	'O'
      00089A 70                    2130 	.db #0x70	;  112	'p'
      00089B 18                    2131 	.db #0x18	;  24
      00089C F2                    2132 	.db #0xf2	; -14
      00089D 6E                    2133 	.db #0x6e	;  110	'n'
      00089E B8                    2134 	.db #0xb8	; -72
      00089F D1                    2135 	.db #0xd1	; -47
      0008A0 00                    2136 	.db #0x00	;  0
      0008A1 16                    2137 	.db #0x16	;  22
      0008A2 D5                    2138 	.db #0xd5	; -43
      0008A3 3E                    2139 	.db #0x3e	;  62
      0008A4 06                    2140 	.db #0x06	;  6
      0008A5 C1                    2141 	.db #0xc1	; -63
      0008A6 FA                    2142 	.db #0xfa	; -6
      0008A7 18                    2143 	.db #0x18	;  24
      0008A8 17                    2144 	.db #0x17	;  23
      0008A9 25                    2145 	.db #0x25	;  37
      0008AA EC                    2146 	.db #0xec	; -20
      0008AB 00                    2147 	.db #0x00	;  0
      0008AC 2C                    2148 	.db #0x2c	;  44
      0008AD 27                    2149 	.db #0x27	;  39
      0008AE DA                    2150 	.db #0xda	; -38
      0008AF 15                    2151 	.db #0x15	;  21
      0008B0 ED                    2152 	.db #0xed	; -19
      0008B1 E4                    2153 	.db #0xe4	; -28
      0008B2 E7                    2154 	.db #0xe7	; -25
      0008B3 0B                    2155 	.db #0x0b	;  11
      0008B4 1B                    2156 	.db #0x1b	;  27
      0008B5 E2                    2157 	.db #0xe2	; -30
      0008B6 1A                    2158 	.db #0x1a	;  26
      0008B7 02                    2159 	.db #0x02	;  2
      0008B8 00                    2160 	.db #0x00	;  0
      0008B9 F0                    2161 	.db #0xf0	; -16
      0008BA FB                    2162 	.db #0xfb	; -5
      0008BB 01                    2163 	.db #0x01	;  1
      0008BC 14                    2164 	.db #0x14	;  20
      0008BD 0C                    2165 	.db #0x0c	;  12
      0008BE F4                    2166 	.db #0xf4	; -12
      0008BF 0C                    2167 	.db #0x0c	;  12
      0008C0 F1                    2168 	.db #0xf1	; -15
      0008C1 EF                    2169 	.db #0xef	; -17
      0008C2 E3                    2170 	.db #0xe3	; -29
      0008C3 C5                    2171 	.db #0xc5	; -59
      0008C4 30                    2172 	.db #0x30	;  48	'0'
      0008C5 20                    2173 	.db #0x20	;  32
      0008C6 DD                    2174 	.db #0xdd	; -35
      0008C7 CD                    2175 	.db #0xcd	; -51
      0008C8 DD                    2176 	.db #0xdd	; -35
      0008C9 02                    2177 	.db #0x02	;  2
      0008CA F8                    2178 	.db #0xf8	; -8
      0008CB CF                    2179 	.db #0xcf	; -49
      0008CC EA                    2180 	.db #0xea	; -22
      0008CD 10                    2181 	.db #0x10	;  16
      0008CE D4                    2182 	.db #0xd4	; -44
      0008CF 21                    2183 	.db #0x21	;  33
      0008D0 00                    2184 	.db #0x00	;  0
      0008D1 36                    2185 	.db #0x36	;  54	'6'
      0008D2 0A                    2186 	.db #0x0a	;  10
      0008D3 D0                    2187 	.db #0xd0	; -48
      0008D4 18                    2188 	.db #0x18	;  24
      0008D5 06                    2189 	.db #0x06	;  6
      0008D6 11                    2190 	.db #0x11	;  17
      0008D7 0A                    2191 	.db #0x0a	;  10
      0008D8 3B                    2192 	.db #0x3b	;  59
      0008D9 FE                    2193 	.db #0xfe	; -2
                                   2194 	.area CSEG    (CODE)
                                   2195 	.area CONST   (CODE)
      0008DA                       2196 _dsel:
      0008DA F7                    2197 	.db #0xf7	; 247
      0008DB EF                    2198 	.db #0xef	; 239
      0008DC DF                    2199 	.db #0xdf	; 223
      0008DD BF                    2200 	.db #0xbf	; 191
                                   2201 	.area CSEG    (CODE)
                                   2202 	.area CONST   (CODE)
      0008DE                       2203 _segs:
      0008DE C0                    2204 	.db #0xc0	; 192
      0008DF F9                    2205 	.db #0xf9	; 249
      0008E0 A4                    2206 	.db #0xa4	; 164
      0008E1 B0                    2207 	.db #0xb0	; 176
      0008E2 99                    2208 	.db #0x99	; 153
      0008E3 92                    2209 	.db #0x92	; 146
      0008E4 82                    2210 	.db #0x82	; 130
      0008E5 F8                    2211 	.db #0xf8	; 248
      0008E6 80                    2212 	.db #0x80	; 128
      0008E7 90                    2213 	.db #0x90	; 144
                                   2214 	.area CSEG    (CODE)
                                   2215 	.area CONST   (CODE)
      0008E8                       2216 _hexd:
      0008E8 30 31 32 33 34 35 36  2217 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      0008F8 00                    2218 	.db 0x00
                                   2219 	.area CSEG    (CODE)
                                   2220 	.area CONST   (CODE)
      0008F9                       2221 ___str_0:
      0008F9 4E 4E 20 52 45 41 44  2222 	.ascii "NN READY"
             59
      000901 0D                    2223 	.db 0x0d
      000902 0A                    2224 	.db 0x0a
      000903 00                    2225 	.db 0x00
                                   2226 	.area CSEG    (CODE)
                                   2227 	.area XINIT   (CODE)
                                   2228 	.area CABS    (ABS,CODE)
