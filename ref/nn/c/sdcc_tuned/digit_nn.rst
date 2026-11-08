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
      00001D                        299 _main_w_10000_12:
      00001D                        300 	.ds 2
      00001F                        301 _main___700000000_70000_20:
      00001F                        302 	.ds 1
      000020                        303 _main_sloc0_1_0:
      000020                        304 	.ds 4
                                    305 ;--------------------------------------------------------
                                    306 ; overlayable items in internal ram
                                    307 ;--------------------------------------------------------
                                    308 	.area	OSEG    (OVR,DATA)
                                    309 ;--------------------------------------------------------
                                    310 ; Stack segment in internal ram
                                    311 ;--------------------------------------------------------
                                    312 	.area SSEG
      0000B7                        313 __start__stack:
      0000B7                        314 	.ds	1
                                    315 
                                    316 ;--------------------------------------------------------
                                    317 ; indirectly addressable internal ram data
                                    318 ;--------------------------------------------------------
                                    319 	.area ISEG    (DATA)
      000024                        320 _pix::
      000024                        321 	.ds 35
      000047                        322 _acc::
      000047                        323 	.ds 48
      000077                        324 _hid::
      000077                        325 	.ds 24
      00008F                        326 _score::
      00008F                        327 	.ds 40
                                    328 ;--------------------------------------------------------
                                    329 ; absolute internal ram data
                                    330 ;--------------------------------------------------------
                                    331 	.area IABS    (ABS,DATA)
                                    332 	.area IABS    (ABS,DATA)
                                    333 ;--------------------------------------------------------
                                    334 ; bit data
                                    335 ;--------------------------------------------------------
                                    336 	.area BSEG    (BIT)
                                    337 ;--------------------------------------------------------
                                    338 ; paged external ram data
                                    339 ;--------------------------------------------------------
                                    340 	.area PSEG    (PAG,XDATA)
                                    341 ;--------------------------------------------------------
                                    342 ; uninitialized external ram data
                                    343 ;--------------------------------------------------------
                                    344 	.area XSEG    (XDATA)
                                    345 ;--------------------------------------------------------
                                    346 ; absolute external ram data
                                    347 ;--------------------------------------------------------
                                    348 	.area XABS    (ABS,XDATA)
                                    349 ;--------------------------------------------------------
                                    350 ; initialized external ram data
                                    351 ;--------------------------------------------------------
                                    352 	.area XISEG   (XDATA)
                                    353 	.area HOME    (CODE)
                                    354 	.area GSINIT0 (CODE)
                                    355 	.area GSINIT1 (CODE)
                                    356 	.area GSINIT2 (CODE)
                                    357 	.area GSINIT3 (CODE)
                                    358 	.area GSINIT4 (CODE)
                                    359 	.area GSINIT5 (CODE)
                                    360 	.area GSINIT  (CODE)
                                    361 	.area GSFINAL (CODE)
                                    362 	.area CSEG    (CODE)
                                    363 ;--------------------------------------------------------
                                    364 ; interrupt vector
                                    365 ;--------------------------------------------------------
                                    366 	.area HOME    (CODE)
      000000                        367 __interrupt_vect:
      000000 02 00 56         [24]  368 	ljmp	__sdcc_gsinit_startup
      000003 32               [24]  369 	reti
      000004                        370 	.ds	7
      00000B 02 00 B2         [24]  371 	ljmp	_t0_isr
                                    372 ; restartable atomic support routines
      00000E                        373 	.ds	2
      000010                        374 sdcc_atomic_exchange_rollback_start::
      000010 00               [12]  375 	nop
      000011 00               [12]  376 	nop
      000012                        377 sdcc_atomic_exchange_pdata_impl:
      000012 E2               [24]  378 	movx	a, @r0
      000013 FB               [12]  379 	mov	r3, a
      000014 EA               [12]  380 	mov	a, r2
      000015 F2               [24]  381 	movx	@r0, a
      000016 80 2C            [24]  382 	sjmp	sdcc_atomic_exchange_exit
      000018 00               [12]  383 	nop
      000019 00               [12]  384 	nop
      00001A                        385 sdcc_atomic_exchange_xdata_impl:
      00001A E0               [24]  386 	movx	a, @dptr
      00001B FB               [12]  387 	mov	r3, a
      00001C EA               [12]  388 	mov	a, r2
      00001D F0               [24]  389 	movx	@dptr, a
      00001E 80 24            [24]  390 	sjmp	sdcc_atomic_exchange_exit
      000020                        391 sdcc_atomic_compare_exchange_idata_impl:
      000020 E6               [12]  392 	mov	a, @r0
      000021 B5 02 02         [24]  393 	cjne	a, ar2, .+#5
      000024 EB               [12]  394 	mov	a, r3
      000025 F6               [12]  395 	mov	@r0, a
      000026 22               [24]  396 	ret
      000027 00               [12]  397 	nop
      000028                        398 sdcc_atomic_compare_exchange_pdata_impl:
      000028 E2               [24]  399 	movx	a, @r0
      000029 B5 02 02         [24]  400 	cjne	a, ar2, .+#5
      00002C EB               [12]  401 	mov	a, r3
      00002D F2               [24]  402 	movx	@r0, a
      00002E 22               [24]  403 	ret
      00002F 00               [12]  404 	nop
      000030                        405 sdcc_atomic_compare_exchange_xdata_impl:
      000030 E0               [24]  406 	movx	a, @dptr
      000031 B5 02 02         [24]  407 	cjne	a, ar2, .+#5
      000034 EB               [12]  408 	mov	a, r3
      000035 F0               [24]  409 	movx	@dptr, a
      000036 22               [24]  410 	ret
      000037                        411 sdcc_atomic_exchange_rollback_end::
                                    412 
      000037                        413 sdcc_atomic_exchange_gptr_impl::
      000037 30 F6 E0         [24]  414 	jnb	b.6, sdcc_atomic_exchange_xdata_impl
      00003A A8 82            [24]  415 	mov	r0, dpl
      00003C 20 F5 D3         [24]  416 	jb	b.5, sdcc_atomic_exchange_pdata_impl
      00003F                        417 sdcc_atomic_exchange_idata_impl:
      00003F EA               [12]  418 	mov	a, r2
      000040 C6               [12]  419 	xch	a, @r0
      000041 F5 82            [12]  420 	mov	dpl, a
      000043 22               [24]  421 	ret
      000044                        422 sdcc_atomic_exchange_exit:
      000044 8B 82            [24]  423 	mov	dpl, r3
      000046 22               [24]  424 	ret
      000047                        425 sdcc_atomic_compare_exchange_gptr_impl::
      000047 30 F6 E6         [24]  426 	jnb	b.6, sdcc_atomic_compare_exchange_xdata_impl
      00004A A8 82            [24]  427 	mov	r0, dpl
      00004C 20 F5 D9         [24]  428 	jb	b.5, sdcc_atomic_compare_exchange_pdata_impl
      00004F 80 CF            [24]  429 	sjmp	sdcc_atomic_compare_exchange_idata_impl
                                    430 ;--------------------------------------------------------
                                    431 ; global & static initialisations
                                    432 ;--------------------------------------------------------
                                    433 	.area HOME    (CODE)
                                    434 	.area GSINIT  (CODE)
                                    435 	.area GSFINAL (CODE)
                                    436 	.area GSINIT  (CODE)
                                    437 	.globl __sdcc_gsinit_startup
                                    438 	.globl __sdcc_program_startup
                                    439 	.globl __start__stack
                                    440 	.globl __mcs51_genXINIT
                                    441 	.globl __mcs51_genXRAMCLEAR
                                    442 	.globl __mcs51_genRAMCLEAR
                                    443 	.area GSFINAL (CODE)
      0000AF 02 00 51         [24]  444 	ljmp	__sdcc_program_startup
                                    445 ;--------------------------------------------------------
                                    446 ; Home
                                    447 ;--------------------------------------------------------
                                    448 	.area HOME    (CODE)
                                    449 	.area HOME    (CODE)
      000051                        450 __sdcc_program_startup:
      000051 12 01 31         [24]  451 	lcall	_main
      000054                        452 __sdcc_program_exit:
      000054 80 FE            [24]  453 	sjmp	.
                                    454 ;	return from main will return to caller
                                    455 ;--------------------------------------------------------
                                    456 ; code
                                    457 ;--------------------------------------------------------
                                    458 	.area CSEG    (CODE)
                                    459 ;------------------------------------------------------------
                                    460 ;Allocation info for local variables in function 't0_isr'
                                    461 ;------------------------------------------------------------
                                    462 ;	digit_nn.c:26: void t0_isr(void) T0_ISR
                                    463 ;	-----------------------------------------
                                    464 ;	 function t0_isr
                                    465 ;	-----------------------------------------
      0000B2                        466 _t0_isr:
                           00000F   467 	ar7 = 0x0f
                           00000E   468 	ar6 = 0x0e
                           00000D   469 	ar5 = 0x0d
                           00000C   470 	ar4 = 0x0c
                           00000B   471 	ar3 = 0x0b
                           00000A   472 	ar2 = 0x0a
                           000009   473 	ar1 = 0x09
                           000008   474 	ar0 = 0x08
      0000B2 C0 E0            [24]  475 	push	acc
      0000B4 C0 82            [24]  476 	push	dpl
      0000B6 C0 83            [24]  477 	push	dph
      0000B8 C0 D0            [24]  478 	push	psw
      0000BA 75 D0 08         [24]  479 	mov	psw,#0x08
                                    480 ;	digit_nn.c:28: P1 = 0xFF;
      0000BD 75 90 FF         [24]  481 	mov	_P1,#0xff
                                    482 ;	digit_nn.c:29: digi = (digi + 1) & 3;
      0000C0 AF 14            [24]  483 	mov	r7,_digi
      0000C2 0F               [12]  484 	inc	r7
      0000C3 74 03            [12]  485 	mov	a,#0x03
      0000C5 5F               [12]  486 	anl	a,r7
                                    487 ;	digit_nn.c:30: P0 = dbuf[digi];
      0000C6 F5 14            [12]  488 	mov	_digi,a
      0000C8 24 10            [12]  489 	add	a, #_dbuf
      0000CA F9               [12]  490 	mov	r1,a
      0000CB 87 80            [24]  491 	mov	_P0,@r1
                                    492 ;	digit_nn.c:31: P1 = dsel[digi];
      0000CD E5 14            [12]  493 	mov	a,_digi
      0000CF 90 08 7D         [24]  494 	mov	dptr,#_dsel
      0000D2 93               [24]  495 	movc	a,@a+dptr
      0000D3 F5 90            [12]  496 	mov	_P1,a
                                    497 ;	digit_nn.c:32: }
      0000D5 D0 D0            [24]  498 	pop	psw
      0000D7 D0 83            [24]  499 	pop	dph
      0000D9 D0 82            [24]  500 	pop	dpl
      0000DB D0 E0            [24]  501 	pop	acc
      0000DD 32               [24]  502 	reti
                                    503 ;	eliminated unneeded push/pop b
                                    504 ;------------------------------------------------------------
                                    505 ;Allocation info for local variables in function 'getc_'
                                    506 ;------------------------------------------------------------
                                    507 ;	digit_nn.c:34: static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
                                    508 ;	-----------------------------------------
                                    509 ;	 function getc_
                                    510 ;	-----------------------------------------
      0000DE                        511 _getc_:
                           000007   512 	ar7 = 0x07
                           000006   513 	ar6 = 0x06
                           000005   514 	ar5 = 0x05
                           000004   515 	ar4 = 0x04
                           000003   516 	ar3 = 0x03
                           000002   517 	ar2 = 0x02
                           000001   518 	ar1 = 0x01
                           000000   519 	ar0 = 0x00
      0000DE                        520 00101$:
                                    521 ;	assignBit
      0000DE 10 98 02         [24]  522 	jbc	_RI,00120$
      0000E1 80 FB            [24]  523 	sjmp	00101$
      0000E3                        524 00120$:
      0000E3 85 99 82         [24]  525 	mov	dpl, _SBUF
      0000E6 22               [24]  526 	ret
                                    527 ;------------------------------------------------------------
                                    528 ;Allocation info for local variables in function 'putc_'
                                    529 ;------------------------------------------------------------
                                    530 ;c             Allocated to registers 
                                    531 ;------------------------------------------------------------
                                    532 ;	digit_nn.c:35: static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
                                    533 ;	-----------------------------------------
                                    534 ;	 function putc_
                                    535 ;	-----------------------------------------
      0000E7                        536 _putc_:
      0000E7 85 82 99         [24]  537 	mov	_SBUF,dpl
      0000EA                        538 00101$:
                                    539 ;	assignBit
      0000EA 10 99 02         [24]  540 	jbc	_TI,00120$
      0000ED 80 FB            [24]  541 	sjmp	00101$
      0000EF                        542 00120$:
      0000EF 22               [24]  543 	ret
                                    544 ;------------------------------------------------------------
                                    545 ;Allocation info for local variables in function 'puthex'
                                    546 ;------------------------------------------------------------
                                    547 ;v             Allocated to registers r7 
                                    548 ;------------------------------------------------------------
                                    549 ;	digit_nn.c:36: static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
                                    550 ;	-----------------------------------------
                                    551 ;	 function puthex
                                    552 ;	-----------------------------------------
      0000F0                        553 _puthex:
      0000F0 E5 82            [12]  554 	mov	a,dpl
      0000F2 FF               [12]  555 	mov	r7,a
      0000F3 C4               [12]  556 	swap	a
      0000F4 54 0F            [12]  557 	anl	a,#0x0f
      0000F6 90 08 8B         [24]  558 	mov	dptr,#_hexd
      0000F9 93               [24]  559 	movc	a,@a+dptr
      0000FA F5 82            [12]  560 	mov	dpl,a
      0000FC C0 07            [24]  561 	push	ar7
      0000FE 12 00 E7         [24]  562 	lcall	_putc_
      000101 D0 07            [24]  563 	pop	ar7
      000103 74 0F            [12]  564 	mov	a,#0x0f
      000105 5F               [12]  565 	anl	a,r7
      000106 90 08 8B         [24]  566 	mov	dptr,#_hexd
      000109 93               [24]  567 	movc	a,@a+dptr
      00010A F5 82            [12]  568 	mov	dpl,a
      00010C 02 00 E7         [24]  569 	ljmp	_putc_
                                    570 ;------------------------------------------------------------
                                    571 ;Allocation info for local variables in function 'puts_'
                                    572 ;------------------------------------------------------------
                                    573 ;s             Allocated to registers 
                                    574 ;------------------------------------------------------------
                                    575 ;	digit_nn.c:37: static void puts_(char code *s) { while (*s) putc_(*s++); }
                                    576 ;	-----------------------------------------
                                    577 ;	 function puts_
                                    578 ;	-----------------------------------------
      00010F                        579 _puts_:
      00010F AE 82            [24]  580 	mov	r6, dpl
      000111 AF 83            [24]  581 	mov	r7, dph
      000113                        582 00101$:
      000113 8E 82            [24]  583 	mov	dpl,r6
      000115 8F 83            [24]  584 	mov	dph,r7
      000117 E4               [12]  585 	clr	a
      000118 93               [24]  586 	movc	a,@a+dptr
      000119 FD               [12]  587 	mov	r5,a
      00011A 60 14            [24]  588 	jz	00104$
      00011C 8D 82            [24]  589 	mov	dpl,r5
      00011E 0E               [12]  590 	inc	r6
      00011F BE 00 01         [24]  591 	cjne	r6,#0x00,00122$
      000122 0F               [12]  592 	inc	r7
      000123                        593 00122$:
      000123 C0 07            [24]  594 	push	ar7
      000125 C0 06            [24]  595 	push	ar6
      000127 12 00 E7         [24]  596 	lcall	_putc_
      00012A D0 06            [24]  597 	pop	ar6
      00012C D0 07            [24]  598 	pop	ar7
      00012E 80 E3            [24]  599 	sjmp	00101$
      000130                        600 00104$:
      000130 22               [24]  601 	ret
                                    602 ;------------------------------------------------------------
                                    603 ;Allocation info for local variables in function 'main'
                                    604 ;------------------------------------------------------------
                                    605 ;i             Allocated with name '_main_i_10000_12'
                                    606 ;j             Allocated with name '_main_j_10000_12'
                                    607 ;k             Allocated with name '_main_k_10000_12'
                                    608 ;best          Allocated with name '_main_best_10000_12'
                                    609 ;a             Allocated to registers r5 r6 
                                    610 ;s             Allocated with name '_main_s_10000_12'
                                    611 ;u             Allocated to registers r3 r4 r5 r6 
                                    612 ;w             Allocated with name '_main_w_10000_12'
                                    613 ;p             Allocated to registers 
                                    614 ;wv            Allocated to registers r6 
                                    615 ;hv            Allocated to registers r5 
                                    616 ;m             Allocated to registers r6 
                                    617 ;__700000000   Allocated with name '_main___700000000_70000_20'
                                    618 ;sloc0         Allocated with name '_main_sloc0_1_0'
                                    619 ;------------------------------------------------------------
                                    620 ;	digit_nn.c:39: void main(void)
                                    621 ;	-----------------------------------------
                                    622 ;	 function main
                                    623 ;	-----------------------------------------
      000131                        624 _main:
                                    625 ;	digit_nn.c:52: dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
      000131 75 11 AB         [24]  626 	mov	(_dbuf + 0x0001),#0xab
      000134 75 10 AB         [24]  627 	mov	_dbuf,#0xab
                                    628 ;	digit_nn.c:53: dbuf[2] = dbuf[3] = 0xBF;
      000137 75 13 BF         [24]  629 	mov	(_dbuf + 0x0003),#0xbf
      00013A 75 12 BF         [24]  630 	mov	(_dbuf + 0x0002),#0xbf
                                    631 ;	digit_nn.c:54: digi = 0;
      00013D 75 14 00         [24]  632 	mov	_digi,#0x00
                                    633 ;	digit_nn.c:55: TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
      000140 75 89 22         [24]  634 	mov	_TMOD,#0x22
                                    635 ;	digit_nn.c:56: TH1 = TL1 = 0xFD;
      000143 75 8B FD         [24]  636 	mov	_TL1,#0xfd
      000146 75 8D FD         [24]  637 	mov	_TH1,#0xfd
                                    638 ;	digit_nn.c:57: PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
      000149 43 87 80         [24]  639 	orl	_PCON,#0x80
                                    640 ;	digit_nn.c:58: SCON = 0x50;
      00014C 75 98 50         [24]  641 	mov	_SCON,#0x50
                                    642 ;	digit_nn.c:59: TH0 = TL0 = 0;
      00014F 75 8A 00         [24]  643 	mov	_TL0,#0x00
      000152 75 8C 00         [24]  644 	mov	_TH0,#0x00
                                    645 ;	digit_nn.c:60: TR1 = 1; TR0 = 1; ET0 = 1; EA = 1;
                                    646 ;	assignBit
      000155 D2 8E            [12]  647 	setb	_TR1
                                    648 ;	assignBit
      000157 D2 8C            [12]  649 	setb	_TR0
                                    650 ;	assignBit
      000159 D2 A9            [12]  651 	setb	_ET0
                                    652 ;	assignBit
      00015B D2 AF            [12]  653 	setb	_EA
                                    654 ;	digit_nn.c:61: puts_("NN READY\r\n");
      00015D 90 08 9C         [24]  655 	mov	dptr,#___str_0
      000160 12 01 0F         [24]  656 	lcall	_puts_
                                    657 ;	digit_nn.c:64: while (getc_() != 'D') ;
      000163                        658 00101$:
      000163 12 00 DE         [24]  659 	lcall	_getc_
      000166 AF 82            [24]  660 	mov	r7, dpl
      000168 BF 44 F8         [24]  661 	cjne	r7,#0x44,00101$
                                    662 ;	digit_nn.c:65: for (i = 0; i < 35; i++) pix[i] = (getc_() == '1');
      00016B 7F 00            [12]  663 	mov	r7,#0x00
      00016D                        664 00124$:
      00016D EF               [12]  665 	mov	a,r7
      00016E 24 24            [12]  666 	add	a, #_pix
      000170 F9               [12]  667 	mov	r1,a
      000171 C0 07            [24]  668 	push	ar7
      000173 C0 01            [24]  669 	push	ar1
      000175 12 00 DE         [24]  670 	lcall	_getc_
      000178 AE 82            [24]  671 	mov	r6, dpl
      00017A D0 01            [24]  672 	pop	ar1
      00017C D0 07            [24]  673 	pop	ar7
      00017E E4               [12]  674 	clr	a
      00017F BE 31 01         [24]  675 	cjne	r6,#0x31,00351$
      000182 04               [12]  676 	inc	a
      000183                        677 00351$:
      000183 F7               [12]  678 	mov	@r1,a
      000184 0F               [12]  679 	inc	r7
      000185 BF 23 00         [24]  680 	cjne	r7,#0x23,00353$
      000188                        681 00353$:
      000188 40 E3            [24]  682 	jc	00124$
                                    683 ;	digit_nn.c:68: for (j = 0; j < NH; j++) acc[j] = B1[j];
      00018A 7F 00            [12]  684 	mov	r7,#0x00
      00018C                        685 00126$:
      00018C EF               [12]  686 	mov	a,r7
      00018D 2F               [12]  687 	add	a,r7
      00018E 24 47            [12]  688 	add	a, #_acc
      000190 F9               [12]  689 	mov	r1,a
      000191 EF               [12]  690 	mov	a,r7
      000192 75 F0 02         [24]  691 	mov	b,#0x02
      000195 A4               [48]  692 	mul	ab
      000196 24 ED            [12]  693 	add	a, #_B1
      000198 F5 82            [12]  694 	mov	dpl,a
      00019A 74 03            [12]  695 	mov	a,#(_B1 >> 8)
      00019C 35 F0            [12]  696 	addc	a, b
      00019E F5 83            [12]  697 	mov	dph,a
      0001A0 E4               [12]  698 	clr	a
      0001A1 93               [24]  699 	movc	a,@a+dptr
      0001A2 FD               [12]  700 	mov	r5,a
      0001A3 A3               [24]  701 	inc	dptr
      0001A4 E4               [12]  702 	clr	a
      0001A5 93               [24]  703 	movc	a,@a+dptr
      0001A6 FE               [12]  704 	mov	r6,a
      0001A7 A7 05            [24]  705 	mov	@r1,ar5
      0001A9 09               [12]  706 	inc	r1
      0001AA A7 06            [24]  707 	mov	@r1,ar6
      0001AC 19               [12]  708 	dec	r1
      0001AD 0F               [12]  709 	inc	r7
      0001AE BF 18 00         [24]  710 	cjne	r7,#0x18,00355$
      0001B1                        711 00355$:
      0001B1 40 D9            [24]  712 	jc	00126$
                                    713 ;	digit_nn.c:71: w = &W1[0][0];
      0001B3 7E 1D            [12]  714 	mov	r6,#_W1
      0001B5 7F 04            [12]  715 	mov	r7,#(_W1 >> 8)
                                    716 ;	digit_nn.c:72: for (i = 0; i < 35; i++, w += NH)
      0001B7 75 15 00         [24]  717 	mov	_main_i_10000_12,#0x00
      0001BA                        718 00130$:
                                    719 ;	digit_nn.c:73: if (pix[i]) {
      0001BA E5 15            [12]  720 	mov	a,_main_i_10000_12
      0001BC 24 24            [12]  721 	add	a, #_pix
      0001BE F9               [12]  722 	mov	r1,a
      0001BF E7               [12]  723 	mov	a,@r1
      0001C0 60 3F            [24]  724 	jz	00131$
                                    725 ;	digit_nn.c:74: p = acc;
      0001C2 7C 47            [12]  726 	mov	r4,#_acc
                                    727 ;	digit_nn.c:75: for (j = 0; j < NH; j++) *p++ += w[j];
      0001C4 75 16 00         [24]  728 	mov	_main_j_10000_12,#0x00
      0001C7                        729 00128$:
      0001C7 8C 1F            [24]  730 	mov	_main___700000000_70000_20,r4
      0001C9 0C               [12]  731 	inc	r4
      0001CA 0C               [12]  732 	inc	r4
      0001CB A8 1F            [24]  733 	mov	r0,_main___700000000_70000_20
      0001CD 86 02            [24]  734 	mov	ar2,@r0
      0001CF 08               [12]  735 	inc	r0
      0001D0 86 05            [24]  736 	mov	ar5,@r0
      0001D2 E5 16            [12]  737 	mov	a,_main_j_10000_12
      0001D4 2E               [12]  738 	add	a, r6
      0001D5 F5 82            [12]  739 	mov	dpl,a
      0001D7 E4               [12]  740 	clr	a
      0001D8 3F               [12]  741 	addc	a, r7
      0001D9 F5 83            [12]  742 	mov	dph,a
      0001DB E4               [12]  743 	clr	a
      0001DC 93               [24]  744 	movc	a,@a+dptr
      0001DD FB               [12]  745 	mov	r3,a
      0001DE C0 06            [24]  746 	push	ar6
      0001E0 C0 07            [24]  747 	push	ar7
      0001E2 EB               [12]  748 	mov	a,r3
      0001E3 33               [12]  749 	rlc	a
      0001E4 95 E0            [12]  750 	subb	a,acc
      0001E6 FF               [12]  751 	mov	r7,a
      0001E7 EB               [12]  752 	mov	a,r3
      0001E8 2A               [12]  753 	add	a, r2
      0001E9 FA               [12]  754 	mov	r2,a
      0001EA EF               [12]  755 	mov	a,r7
      0001EB 3D               [12]  756 	addc	a, r5
      0001EC FD               [12]  757 	mov	r5,a
      0001ED A8 1F            [24]  758 	mov	r0,_main___700000000_70000_20
      0001EF A6 02            [24]  759 	mov	@r0,ar2
      0001F1 08               [12]  760 	inc	r0
      0001F2 A6 05            [24]  761 	mov	@r0,ar5
      0001F4 05 16            [12]  762 	inc	_main_j_10000_12
      0001F6 C3               [12]  763 	clr	c
      0001F7 E5 16            [12]  764 	mov	a,_main_j_10000_12
      0001F9 94 18            [12]  765 	subb	a,#0x18
      0001FB D0 07            [24]  766 	pop	ar7
      0001FD D0 06            [24]  767 	pop	ar6
      0001FF 40 C6            [24]  768 	jc	00128$
      000201                        769 00131$:
                                    770 ;	digit_nn.c:72: for (i = 0; i < 35; i++, w += NH)
      000201 05 15            [12]  771 	inc	_main_i_10000_12
      000203 74 18            [12]  772 	mov	a,#0x18
      000205 2E               [12]  773 	add	a, r6
      000206 FE               [12]  774 	mov	r6,a
      000207 E4               [12]  775 	clr	a
      000208 3F               [12]  776 	addc	a, r7
      000209 FF               [12]  777 	mov	r7,a
      00020A 74 DD            [12]  778 	mov	a,#0x100 - 0x23
      00020C 25 15            [12]  779 	add	a,_main_i_10000_12
      00020E 50 AA            [24]  780 	jnc	00130$
                                    781 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      000210 7F 00            [12]  782 	mov	r7,#0x00
      000212                        783 00132$:
                                    784 ;	digit_nn.c:84: a = acc[j];
      000212 EF               [12]  785 	mov	a,r7
      000213 2F               [12]  786 	add	a,r7
      000214 24 47            [12]  787 	add	a, #_acc
      000216 F9               [12]  788 	mov	r1,a
      000217 87 05            [24]  789 	mov	ar5,@r1
      000219 09               [12]  790 	inc	r1
      00021A 87 06            [24]  791 	mov	ar6,@r1
      00021C 19               [12]  792 	dec	r1
                                    793 ;	digit_nn.c:85: if (a < 0) hid[j] = 0;
      00021D EE               [12]  794 	mov	a,r6
      00021E 30 E7 08         [24]  795 	jnb	acc.7,00111$
      000221 EF               [12]  796 	mov	a,r7
      000222 24 77            [12]  797 	add	a, #_hid
      000224 F8               [12]  798 	mov	r0,a
      000225 76 00            [12]  799 	mov	@r0,#0x00
      000227 80 23            [24]  800 	sjmp	00133$
      000229                        801 00111$:
                                    802 ;	digit_nn.c:86: else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
      000229 EE               [12]  803 	mov	a,r6
      00022A A2 E7            [12]  804 	mov	c,acc.7
      00022C 13               [12]  805 	rrc	a
      00022D CD               [12]  806 	xch	a,r5
      00022E 13               [12]  807 	rrc	a
      00022F CD               [12]  808 	xch	a,r5
      000230 FE               [12]  809 	mov	r6,a
      000231 EF               [12]  810 	mov	a,r7
      000232 24 77            [12]  811 	add	a, #_hid
      000234 F9               [12]  812 	mov	r1,a
      000235 C3               [12]  813 	clr	c
      000236 74 FF            [12]  814 	mov	a,#0xff
      000238 9D               [12]  815 	subb	a,r5
      000239 74 80            [12]  816 	mov	a,#(0x00 ^ 0x80)
      00023B 8E F0            [24]  817 	mov	b,r6
      00023D 63 F0 80         [24]  818 	xrl	b,#0x80
      000240 95 F0            [12]  819 	subb	a,b
      000242 50 04            [24]  820 	jnc	00146$
                                    821 ;	free result
      000244 7C FF            [12]  822 	mov	r4,#0xff
      000246 80 02            [24]  823 	sjmp	00147$
      000248                        824 00146$:
      000248 8D 04            [24]  825 	mov	ar4,r5
      00024A                        826 00147$:
      00024A A7 04            [24]  827 	mov	@r1,ar4
      00024C                        828 00133$:
                                    829 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      00024C 0F               [12]  830 	inc	r7
      00024D BF 18 00         [24]  831 	cjne	r7,#0x18,00362$
      000250                        832 00362$:
      000250 40 C0            [24]  833 	jc	00132$
                                    834 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      000252 75 17 00         [24]  835 	mov	_main_k_10000_12,#0x00
      000255                        836 00136$:
                                    837 ;	digit_nn.c:91: s = B2[k];
      000255 E5 17            [12]  838 	mov	a,_main_k_10000_12
      000257 75 F0 04         [24]  839 	mov	b,#0x04
      00025A A4               [48]  840 	mul	ab
      00025B 24 65            [12]  841 	add	a, #_B2
      00025D F5 82            [12]  842 	mov	dpl,a
      00025F 74 07            [12]  843 	mov	a,#(_B2 >> 8)
      000261 35 F0            [12]  844 	addc	a, b
      000263 F5 83            [12]  845 	mov	dph,a
      000265 E4               [12]  846 	clr	a
      000266 93               [24]  847 	movc	a,@a+dptr
      000267 F5 19            [12]  848 	mov	_main_s_10000_12,a
      000269 A3               [24]  849 	inc	dptr
      00026A E4               [12]  850 	clr	a
      00026B 93               [24]  851 	movc	a,@a+dptr
      00026C F5 1A            [12]  852 	mov	(_main_s_10000_12 + 1),a
      00026E A3               [24]  853 	inc	dptr
      00026F E4               [12]  854 	clr	a
      000270 93               [24]  855 	movc	a,@a+dptr
      000271 F5 1B            [12]  856 	mov	(_main_s_10000_12 + 2),a
      000273 A3               [24]  857 	inc	dptr
      000274 E4               [12]  858 	clr	a
      000275 93               [24]  859 	movc	a,@a+dptr
      000276 F5 1C            [12]  860 	mov	(_main_s_10000_12 + 3),a
                                    861 ;	digit_nn.c:94: w = W2[k];
      000278 E5 17            [12]  862 	mov	a,_main_k_10000_12
      00027A 75 F0 18         [24]  863 	mov	b,#0x18
      00027D A4               [48]  864 	mul	ab
      00027E 24 8D            [12]  865 	add	a, #_W2
      000280 F5 1D            [12]  866 	mov	_main_w_10000_12,a
      000282 74 07            [12]  867 	mov	a,#(_W2 >> 8)
      000284 35 F0            [12]  868 	addc	a, b
      000286 F5 1E            [12]  869 	mov	(_main_w_10000_12 + 1),a
                                    870 ;	digit_nn.c:95: for (j = 0; j < NH; j++) {
      000288 75 16 00         [24]  871 	mov	_main_j_10000_12,#0x00
      00028B                        872 00134$:
                                    873 ;	digit_nn.c:96: wv = w[j];
      00028B E5 16            [12]  874 	mov	a,_main_j_10000_12
      00028D 25 1D            [12]  875 	add	a, _main_w_10000_12
      00028F F5 82            [12]  876 	mov	dpl,a
      000291 E4               [12]  877 	clr	a
      000292 35 1E            [12]  878 	addc	a, (_main_w_10000_12 + 1)
      000294 F5 83            [12]  879 	mov	dph,a
      000296 E4               [12]  880 	clr	a
      000297 93               [24]  881 	movc	a,@a+dptr
      000298 FE               [12]  882 	mov	r6,a
                                    883 ;	digit_nn.c:97: hv = hid[j];
      000299 E5 16            [12]  884 	mov	a,_main_j_10000_12
      00029B 24 77            [12]  885 	add	a, #_hid
      00029D F9               [12]  886 	mov	r1,a
      00029E 87 05            [24]  887 	mov	ar5,@r1
                                    888 ;	digit_nn.c:98: if (wv < 0) { m = -wv; s -= (unsigned int)(hv * m); }
      0002A0 EE               [12]  889 	mov	a,r6
      0002A1 30 E7 23         [24]  890 	jnb	acc.7,00115$
      0002A4 C3               [12]  891 	clr	c
      0002A5 E4               [12]  892 	clr	a
      0002A6 9E               [12]  893 	subb	a,r6
      0002A7 8D F0            [24]  894 	mov	b,r5
      0002A9 A4               [48]  895 	mul	ab
      0002AA FB               [12]  896 	mov	r3,a
      0002AB AC F0            [24]  897 	mov	r4,b
      0002AD E4               [12]  898 	clr	a
      0002AE FA               [12]  899 	mov	r2,a
      0002AF FF               [12]  900 	mov	r7,a
      0002B0 E5 19            [12]  901 	mov	a,_main_s_10000_12
      0002B2 C3               [12]  902 	clr	c
      0002B3 9B               [12]  903 	subb	a,r3
      0002B4 F5 19            [12]  904 	mov	_main_s_10000_12,a
      0002B6 E5 1A            [12]  905 	mov	a,(_main_s_10000_12 + 1)
      0002B8 9C               [12]  906 	subb	a,r4
      0002B9 F5 1A            [12]  907 	mov	(_main_s_10000_12 + 1),a
      0002BB E5 1B            [12]  908 	mov	a,(_main_s_10000_12 + 2)
      0002BD 9A               [12]  909 	subb	a,r2
      0002BE F5 1B            [12]  910 	mov	(_main_s_10000_12 + 2),a
      0002C0 E5 1C            [12]  911 	mov	a,(_main_s_10000_12 + 3)
      0002C2 9F               [12]  912 	subb	a,r7
      0002C3 F5 1C            [12]  913 	mov	(_main_s_10000_12 + 3),a
      0002C5 80 20            [24]  914 	sjmp	00135$
      0002C7                        915 00115$:
                                    916 ;	digit_nn.c:99: else { m = wv; s += (unsigned int)(hv * m); }
      0002C7 8D F0            [24]  917 	mov	b,r5
      0002C9 EE               [12]  918 	mov	a,r6
      0002CA A4               [48]  919 	mul	ab
      0002CB FF               [12]  920 	mov	r7,a
      0002CC AD F0            [24]  921 	mov	r5,b
      0002CE 8D 04            [24]  922 	mov	ar4,r5
      0002D0 E4               [12]  923 	clr	a
      0002D1 FD               [12]  924 	mov	r5,a
      0002D2 FE               [12]  925 	mov	r6,a
      0002D3 EF               [12]  926 	mov	a,r7
      0002D4 25 19            [12]  927 	add	a, _main_s_10000_12
      0002D6 F5 19            [12]  928 	mov	_main_s_10000_12,a
      0002D8 EC               [12]  929 	mov	a,r4
      0002D9 35 1A            [12]  930 	addc	a, (_main_s_10000_12 + 1)
      0002DB F5 1A            [12]  931 	mov	(_main_s_10000_12 + 1),a
      0002DD ED               [12]  932 	mov	a,r5
      0002DE 35 1B            [12]  933 	addc	a, (_main_s_10000_12 + 2)
      0002E0 F5 1B            [12]  934 	mov	(_main_s_10000_12 + 2),a
      0002E2 EE               [12]  935 	mov	a,r6
      0002E3 35 1C            [12]  936 	addc	a, (_main_s_10000_12 + 3)
      0002E5 F5 1C            [12]  937 	mov	(_main_s_10000_12 + 3),a
      0002E7                        938 00135$:
                                    939 ;	digit_nn.c:95: for (j = 0; j < NH; j++) {
      0002E7 05 16            [12]  940 	inc	_main_j_10000_12
      0002E9 74 E8            [12]  941 	mov	a,#0x100 - 0x18
      0002EB 25 16            [12]  942 	add	a,_main_j_10000_12
      0002ED 50 9C            [24]  943 	jnc	00134$
                                    944 ;	digit_nn.c:109: score[k] = s;
      0002EF E5 17            [12]  945 	mov	a,_main_k_10000_12
      0002F1 25 17            [12]  946 	add	a,_main_k_10000_12
      0002F3 25 E0            [12]  947 	add	a,acc
      0002F5 24 8F            [12]  948 	add	a, #_score
      0002F7 F8               [12]  949 	mov	r0,a
      0002F8 A6 19            [24]  950 	mov	@r0,_main_s_10000_12
      0002FA 08               [12]  951 	inc	r0
      0002FB A6 1A            [24]  952 	mov	@r0,(_main_s_10000_12 + 1)
      0002FD 08               [12]  953 	inc	r0
      0002FE A6 1B            [24]  954 	mov	@r0,(_main_s_10000_12 + 2)
      000300 08               [12]  955 	inc	r0
      000301 A6 1C            [24]  956 	mov	@r0,(_main_s_10000_12 + 3)
                                    957 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      000303 05 17            [12]  958 	inc	_main_k_10000_12
      000305 74 F6            [12]  959 	mov	a,#0x100 - 0x0a
      000307 25 17            [12]  960 	add	a,_main_k_10000_12
      000309 40 03            [24]  961 	jc	00366$
      00030B 02 02 55         [24]  962 	ljmp	00136$
      00030E                        963 00366$:
                                    964 ;	digit_nn.c:113: best = 0;
      00030E 7F 00            [12]  965 	mov	r7,#0x00
                                    966 ;	digit_nn.c:114: for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;
      000310 75 18 01         [24]  967 	mov	_main_best_10000_12,#0x01
      000313                        968 00138$:
      000313 E5 18            [12]  969 	mov	a,_main_best_10000_12
      000315 25 18            [12]  970 	add	a,_main_best_10000_12
      000317 25 E0            [12]  971 	add	a,acc
      000319 24 8F            [12]  972 	add	a, #_score
      00031B F9               [12]  973 	mov	r1,a
      00031C 87 20            [24]  974 	mov	_main_sloc0_1_0,@r1
      00031E 09               [12]  975 	inc	r1
      00031F 87 21            [24]  976 	mov	(_main_sloc0_1_0 + 1),@r1
      000321 09               [12]  977 	inc	r1
      000322 87 22            [24]  978 	mov	(_main_sloc0_1_0 + 2),@r1
      000324 09               [12]  979 	inc	r1
      000325 87 23            [24]  980 	mov	(_main_sloc0_1_0 + 3),@r1
      000327 19               [12]  981 	dec	r1
      000328 19               [12]  982 	dec	r1
      000329 19               [12]  983 	dec	r1
      00032A EF               [12]  984 	mov	a,r7
      00032B 2F               [12]  985 	add	a,r7
      00032C 25 E0            [12]  986 	add	a,acc
      00032E 24 8F            [12]  987 	add	a, #_score
      000330 F9               [12]  988 	mov	r1,a
      000331 C0 07            [24]  989 	push	ar7
      000333 87 04            [24]  990 	mov	ar4,@r1
      000335 09               [12]  991 	inc	r1
      000336 87 05            [24]  992 	mov	ar5,@r1
      000338 09               [12]  993 	inc	r1
      000339 87 06            [24]  994 	mov	ar6,@r1
      00033B 09               [12]  995 	inc	r1
      00033C 87 07            [24]  996 	mov	ar7,@r1
      00033E 19               [12]  997 	dec	r1
      00033F 19               [12]  998 	dec	r1
      000340 19               [12]  999 	dec	r1
      000341 C3               [12] 1000 	clr	c
      000342 EC               [12] 1001 	mov	a,r4
      000343 95 20            [12] 1002 	subb	a,_main_sloc0_1_0
      000345 ED               [12] 1003 	mov	a,r5
      000346 95 21            [12] 1004 	subb	a,(_main_sloc0_1_0 + 1)
      000348 EE               [12] 1005 	mov	a,r6
      000349 95 22            [12] 1006 	subb	a,(_main_sloc0_1_0 + 2)
      00034B EF               [12] 1007 	mov	a,r7
      00034C 64 80            [12] 1008 	xrl	a,#0x80
      00034E 85 23 F0         [24] 1009 	mov	b,(_main_sloc0_1_0 + 3)
      000351 63 F0 80         [24] 1010 	xrl	b,#0x80
      000354 95 F0            [12] 1011 	subb	a,b
      000356 D0 07            [24] 1012 	pop	ar7
      000358 50 02            [24] 1013 	jnc	00139$
                                   1014 ;	free result
      00035A AF 18            [24] 1015 	mov	r7,_main_best_10000_12
      00035C                       1016 00139$:
      00035C 05 18            [12] 1017 	inc	_main_best_10000_12
      00035E 74 F6            [12] 1018 	mov	a,#0x100 - 0x0a
      000360 25 18            [12] 1019 	add	a,_main_best_10000_12
      000362 50 AF            [24] 1020 	jnc	00138$
                                   1021 ;	digit_nn.c:116: dbuf[2] = 0xFF;
      000364 75 12 FF         [24] 1022 	mov	(_dbuf + 0x0002),#0xff
                                   1023 ;	digit_nn.c:117: dbuf[3] = segs[best];
      000367 EF               [12] 1024 	mov	a,r7
      000368 90 08 81         [24] 1025 	mov	dptr,#_segs
      00036B 93               [24] 1026 	movc	a,@a+dptr
      00036C F5 13            [12] 1027 	mov	(_dbuf + 0x0003), a
                                   1028 ;	digit_nn.c:118: putc_('=');
      00036E 75 82 3D         [24] 1029 	mov	dpl, #0x3d
      000371 C0 07            [24] 1030 	push	ar7
      000373 12 00 E7         [24] 1031 	lcall	_putc_
      000376 D0 07            [24] 1032 	pop	ar7
                                   1033 ;	digit_nn.c:119: putc_('0' + best);
      000378 74 30            [12] 1034 	mov	a,#0x30
      00037A 2F               [12] 1035 	add	a, r7
      00037B F5 82            [12] 1036 	mov	dpl,a
      00037D 12 00 E7         [24] 1037 	lcall	_putc_
                                   1038 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      000380 7F 00            [12] 1039 	mov	r7,#0x00
      000382                       1040 00140$:
                                   1041 ;	digit_nn.c:121: u = (unsigned long)score[k];
      000382 EF               [12] 1042 	mov	a,r7
      000383 2F               [12] 1043 	add	a,r7
      000384 25 E0            [12] 1044 	add	a,acc
      000386 24 8F            [12] 1045 	add	a, #_score
      000388 F9               [12] 1046 	mov	r1,a
      000389 87 03            [24] 1047 	mov	ar3,@r1
      00038B 09               [12] 1048 	inc	r1
      00038C 87 04            [24] 1049 	mov	ar4,@r1
      00038E 09               [12] 1050 	inc	r1
      00038F 87 05            [24] 1051 	mov	ar5,@r1
      000391 09               [12] 1052 	inc	r1
      000392 87 06            [24] 1053 	mov	ar6,@r1
      000394 19               [12] 1054 	dec	r1
      000395 19               [12] 1055 	dec	r1
      000396 19               [12] 1056 	dec	r1
                                   1057 ;	digit_nn.c:122: putc_(' ');
      000397 75 82 20         [24] 1058 	mov	dpl, #0x20
      00039A C0 07            [24] 1059 	push	ar7
      00039C C0 06            [24] 1060 	push	ar6
      00039E C0 05            [24] 1061 	push	ar5
      0003A0 C0 04            [24] 1062 	push	ar4
      0003A2 C0 03            [24] 1063 	push	ar3
      0003A4 12 00 E7         [24] 1064 	lcall	_putc_
      0003A7 D0 03            [24] 1065 	pop	ar3
      0003A9 D0 04            [24] 1066 	pop	ar4
      0003AB D0 05            [24] 1067 	pop	ar5
                                   1068 ;	digit_nn.c:123: puthex((unsigned char)(u >> 16));
      0003AD 8D 82            [24] 1069 	mov	dpl,r5
      0003AF C0 05            [24] 1070 	push	ar5
      0003B1 C0 04            [24] 1071 	push	ar4
      0003B3 C0 03            [24] 1072 	push	ar3
      0003B5 12 00 F0         [24] 1073 	lcall	_puthex
      0003B8 D0 03            [24] 1074 	pop	ar3
      0003BA D0 04            [24] 1075 	pop	ar4
                                   1076 ;	digit_nn.c:124: puthex((unsigned char)(u >> 8));
      0003BC 8C 82            [24] 1077 	mov	dpl,r4
      0003BE C0 04            [24] 1078 	push	ar4
      0003C0 C0 03            [24] 1079 	push	ar3
      0003C2 12 00 F0         [24] 1080 	lcall	_puthex
      0003C5 D0 03            [24] 1081 	pop	ar3
      0003C7 D0 04            [24] 1082 	pop	ar4
      0003C9 D0 05            [24] 1083 	pop	ar5
      0003CB D0 06            [24] 1084 	pop	ar6
                                   1085 ;	digit_nn.c:125: puthex((unsigned char)u);
      0003CD 8B 82            [24] 1086 	mov	dpl,r3
      0003CF 12 00 F0         [24] 1087 	lcall	_puthex
      0003D2 D0 07            [24] 1088 	pop	ar7
                                   1089 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      0003D4 0F               [12] 1090 	inc	r7
      0003D5 BF 0A 00         [24] 1091 	cjne	r7,#0x0a,00369$
      0003D8                       1092 00369$:
      0003D8 40 A8            [24] 1093 	jc	00140$
                                   1094 ;	digit_nn.c:127: putc_('\r');
      0003DA 75 82 0D         [24] 1095 	mov	dpl, #0x0d
      0003DD 12 00 E7         [24] 1096 	lcall	_putc_
                                   1097 ;	digit_nn.c:128: putc_('\n');
      0003E0 75 82 0A         [24] 1098 	mov	dpl, #0x0a
      0003E3 12 00 E7         [24] 1099 	lcall	_putc_
                                   1100 ;	digit_nn.c:130: }
      0003E6 02 01 63         [24] 1101 	ljmp	00101$
                                   1102 	.area CSEG    (CODE)
                                   1103 	.area CONST   (CODE)
                                   1104 	.area CONST   (CODE)
      0003ED                       1105 _B1:
      0003ED BB FF                 1106 	.byte #0xbb, #0xff	; -69
      0003EF 62 00                 1107 	.byte #0x62, #0x00	;  98
      0003F1 D8 FF                 1108 	.byte #0xd8, #0xff	; -40
      0003F3 9D FF                 1109 	.byte #0x9d, #0xff	; -99
      0003F5 F0 FF                 1110 	.byte #0xf0, #0xff	; -16
      0003F7 F7 FF                 1111 	.byte #0xf7, #0xff	; -9
      0003F9 25 00                 1112 	.byte #0x25, #0x00	;  37
      0003FB 2B 00                 1113 	.byte #0x2b, #0x00	;  43
      0003FD F7 FF                 1114 	.byte #0xf7, #0xff	; -9
      0003FF CF FF                 1115 	.byte #0xcf, #0xff	; -49
      000401 18 00                 1116 	.byte #0x18, #0x00	;  24
      000403 E9 FF                 1117 	.byte #0xe9, #0xff	; -23
      000405 BB FF                 1118 	.byte #0xbb, #0xff	; -69
      000407 28 00                 1119 	.byte #0x28, #0x00	;  40
      000409 FD FF                 1120 	.byte #0xfd, #0xff	; -3
      00040B 39 00                 1121 	.byte #0x39, #0x00	;  57
      00040D F2 FF                 1122 	.byte #0xf2, #0xff	; -14
      00040F D3 FF                 1123 	.byte #0xd3, #0xff	; -45
      000411 BD FF                 1124 	.byte #0xbd, #0xff	; -67
      000413 E2 FF                 1125 	.byte #0xe2, #0xff	; -30
      000415 DA FF                 1126 	.byte #0xda, #0xff	; -38
      000417 CE FF                 1127 	.byte #0xce, #0xff	; -50
      000419 01 00                 1128 	.byte #0x01, #0x00	;  1
      00041B 92 FF                 1129 	.byte #0x92, #0xff	; -110
                                   1130 	.area CSEG    (CODE)
                                   1131 	.area CONST   (CODE)
      00041D                       1132 _W1:
      00041D F0                    1133 	.db #0xf0	; -16
      00041E F9                    1134 	.db #0xf9	; -7
      00041F F6                    1135 	.db #0xf6	; -10
      000420 DB                    1136 	.db #0xdb	; -37
      000421 F9                    1137 	.db #0xf9	; -7
      000422 0A                    1138 	.db #0x0a	;  10
      000423 21                    1139 	.db #0x21	;  33
      000424 0C                    1140 	.db #0x0c	;  12
      000425 61                    1141 	.db #0x61	;  97	'a'
      000426 11                    1142 	.db #0x11	;  17
      000427 0C                    1143 	.db #0x0c	;  12
      000428 BC                    1144 	.db #0xbc	; -68
      000429 00                    1145 	.db #0x00	;  0
      00042A EF                    1146 	.db #0xef	; -17
      00042B 00                    1147 	.db #0x00	;  0
      00042C 0D                    1148 	.db #0x0d	;  13
      00042D EB                    1149 	.db #0xeb	; -21
      00042E 00                    1150 	.db #0x00	;  0
      00042F 1B                    1151 	.db #0x1b	;  27
      000430 47                    1152 	.db #0x47	;  71	'G'
      000431 04                    1153 	.db #0x04	;  4
      000432 EE                    1154 	.db #0xee	; -18
      000433 4B                    1155 	.db #0x4b	;  75	'K'
      000434 D7                    1156 	.db #0xd7	; -41
      000435 DE                    1157 	.db #0xde	; -34
      000436 06                    1158 	.db #0x06	;  6
      000437 ED                    1159 	.db #0xed	; -19
      000438 04                    1160 	.db #0x04	;  4
      000439 CE                    1161 	.db #0xce	; -50
      00043A E9                    1162 	.db #0xe9	; -23
      00043B 4F                    1163 	.db #0x4f	;  79	'O'
      00043C EE                    1164 	.db #0xee	; -18
      00043D 62                    1165 	.db #0x62	;  98	'b'
      00043E 3D                    1166 	.db #0x3d	;  61
      00043F 0B                    1167 	.db #0x0b	;  11
      000440 C7                    1168 	.db #0xc7	; -57
      000441 F5                    1169 	.db #0xf5	; -11
      000442 E8                    1170 	.db #0xe8	; -24
      000443 00                    1171 	.db #0x00	;  0
      000444 07                    1172 	.db #0x07	;  7
      000445 DE                    1173 	.db #0xde	; -34
      000446 EC                    1174 	.db #0xec	; -20
      000447 1E                    1175 	.db #0x1e	;  30
      000448 47                    1176 	.db #0x47	;  71	'G'
      000449 EA                    1177 	.db #0xea	; -22
      00044A 00                    1178 	.db #0x00	;  0
      00044B 26                    1179 	.db #0x26	;  38
      00044C F7                    1180 	.db #0xf7	; -9
      00044D EF                    1181 	.db #0xef	; -17
      00044E DA                    1182 	.db #0xda	; -38
      00044F 0F                    1183 	.db #0x0f	;  15
      000450 F6                    1184 	.db #0xf6	; -10
      000451 E5                    1185 	.db #0xe5	; -27
      000452 1A                    1186 	.db #0x1a	;  26
      000453 D1                    1187 	.db #0xd1	; -47
      000454 00                    1188 	.db #0x00	;  0
      000455 49                    1189 	.db #0x49	;  73	'I'
      000456 E2                    1190 	.db #0xe2	; -30
      000457 DB                    1191 	.db #0xdb	; -37
      000458 B9                    1192 	.db #0xb9	; -71
      000459 FF                    1193 	.db #0xff	; -1
      00045A DA                    1194 	.db #0xda	; -38
      00045B 00                    1195 	.db #0x00	;  0
      00045C B9                    1196 	.db #0xb9	; -71
      00045D E4                    1197 	.db #0xe4	; -28
      00045E FD                    1198 	.db #0xfd	; -3
      00045F F6                    1199 	.db #0xf6	; -10
      000460 56                    1200 	.db #0x56	;  86	'V'
      000461 EA                    1201 	.db #0xea	; -22
      000462 FC                    1202 	.db #0xfc	; -4
      000463 25                    1203 	.db #0x25	;  37
      000464 36                    1204 	.db #0x36	;  54	'6'
      000465 55                    1205 	.db #0x55	;  85	'U'
      000466 F4                    1206 	.db #0xf4	; -12
      000467 FC                    1207 	.db #0xfc	; -4
      000468 2B                    1208 	.db #0x2b	;  43
      000469 F8                    1209 	.db #0xf8	; -8
      00046A 0A                    1210 	.db #0x0a	;  10
      00046B FD                    1211 	.db #0xfd	; -3
      00046C CF                    1212 	.db #0xcf	; -49
      00046D 66                    1213 	.db #0x66	;  102	'f'
      00046E FB                    1214 	.db #0xfb	; -5
      00046F F6                    1215 	.db #0xf6	; -10
      000470 BF                    1216 	.db #0xbf	; -65
      000471 EE                    1217 	.db #0xee	; -18
      000472 E9                    1218 	.db #0xe9	; -23
      000473 00                    1219 	.db #0x00	;  0
      000474 FB                    1220 	.db #0xfb	; -5
      000475 F1                    1221 	.db #0xf1	; -15
      000476 11                    1222 	.db #0x11	;  17
      000477 EF                    1223 	.db #0xef	; -17
      000478 46                    1224 	.db #0x46	;  70	'F'
      000479 EA                    1225 	.db #0xea	; -22
      00047A 22                    1226 	.db #0x22	;  34
      00047B 07                    1227 	.db #0x07	;  7
      00047C EF                    1228 	.db #0xef	; -17
      00047D D3                    1229 	.db #0xd3	; -45
      00047E F2                    1230 	.db #0xf2	; -14
      00047F F4                    1231 	.db #0xf4	; -12
      000480 E5                    1232 	.db #0xe5	; -27
      000481 02                    1233 	.db #0x02	;  2
      000482 09                    1234 	.db #0x09	;  9
      000483 02                    1235 	.db #0x02	;  2
      000484 0A                    1236 	.db #0x0a	;  10
      000485 2C                    1237 	.db #0x2c	;  44
      000486 FC                    1238 	.db #0xfc	; -4
      000487 F0                    1239 	.db #0xf0	; -16
      000488 C9                    1240 	.db #0xc9	; -55
      000489 F8                    1241 	.db #0xf8	; -8
      00048A E4                    1242 	.db #0xe4	; -28
      00048B 00                    1243 	.db #0x00	;  0
      00048C EC                    1244 	.db #0xec	; -20
      00048D F3                    1245 	.db #0xf3	; -13
      00048E EB                    1246 	.db #0xeb	; -21
      00048F F6                    1247 	.db #0xf6	; -10
      000490 04                    1248 	.db #0x04	;  4
      000491 07                    1249 	.db #0x07	;  7
      000492 E5                    1250 	.db #0xe5	; -27
      000493 1B                    1251 	.db #0x1b	;  27
      000494 DA                    1252 	.db #0xda	; -38
      000495 F8                    1253 	.db #0xf8	; -8
      000496 27                    1254 	.db #0x27	;  39
      000497 01                    1255 	.db #0x01	;  1
      000498 40                    1256 	.db #0x40	;  64
      000499 16                    1257 	.db #0x16	;  22
      00049A 13                    1258 	.db #0x13	;  19
      00049B 37                    1259 	.db #0x37	;  55	'7'
      00049C 01                    1260 	.db #0x01	;  1
      00049D 1F                    1261 	.db #0x1f	;  31
      00049E FA                    1262 	.db #0xfa	; -6
      00049F 1B                    1263 	.db #0x1b	;  27
      0004A0 76                    1264 	.db #0x76	;  118	'v'
      0004A1 F4                    1265 	.db #0xf4	; -12
      0004A2 02                    1266 	.db #0x02	;  2
      0004A3 00                    1267 	.db #0x00	;  0
      0004A4 0B                    1268 	.db #0x0b	;  11
      0004A5 F3                    1269 	.db #0xf3	; -13
      0004A6 F6                    1270 	.db #0xf6	; -10
      0004A7 EE                    1271 	.db #0xee	; -18
      0004A8 1D                    1272 	.db #0x1d	;  29
      0004A9 0F                    1273 	.db #0x0f	;  15
      0004AA 05                    1274 	.db #0x05	;  5
      0004AB 3F                    1275 	.db #0x3f	;  63
      0004AC EF                    1276 	.db #0xef	; -17
      0004AD E6                    1277 	.db #0xe6	; -26
      0004AE 05                    1278 	.db #0x05	;  5
      0004AF FE                    1279 	.db #0xfe	; -2
      0004B0 2B                    1280 	.db #0x2b	;  43
      0004B1 2A                    1281 	.db #0x2a	;  42
      0004B2 00                    1282 	.db #0x00	;  0
      0004B3 4C                    1283 	.db #0x4c	;  76	'L'
      0004B4 F5                    1284 	.db #0xf5	; -11
      0004B5 FE                    1285 	.db #0xfe	; -2
      0004B6 14                    1286 	.db #0x14	;  20
      0004B7 DD                    1287 	.db #0xdd	; -35
      0004B8 40                    1288 	.db #0x40	;  64
      0004B9 E9                    1289 	.db #0xe9	; -23
      0004BA F1                    1290 	.db #0xf1	; -15
      0004BB 00                    1291 	.db #0x00	;  0
      0004BC F2                    1292 	.db #0xf2	; -14
      0004BD EA                    1293 	.db #0xea	; -22
      0004BE 06                    1294 	.db #0x06	;  6
      0004BF 1C                    1295 	.db #0x1c	;  28
      0004C0 1E                    1296 	.db #0x1e	;  30
      0004C1 FC                    1297 	.db #0xfc	; -4
      0004C2 EA                    1298 	.db #0xea	; -22
      0004C3 24                    1299 	.db #0x24	;  36
      0004C4 F8                    1300 	.db #0xf8	; -8
      0004C5 EF                    1301 	.db #0xef	; -17
      0004C6 FA                    1302 	.db #0xfa	; -6
      0004C7 F6                    1303 	.db #0xf6	; -10
      0004C8 40                    1304 	.db #0x40	;  64
      0004C9 54                    1305 	.db #0x54	;  84	'T'
      0004CA 29                    1306 	.db #0x29	;  41
      0004CB 9C                    1307 	.db #0x9c	; -100
      0004CC 0E                    1308 	.db #0x0e	;  14
      0004CD 08                    1309 	.db #0x08	;  8
      0004CE 09                    1310 	.db #0x09	;  9
      0004CF EF                    1311 	.db #0xef	; -17
      0004D0 1D                    1312 	.db #0x1d	;  29
      0004D1 0C                    1313 	.db #0x0c	;  12
      0004D2 FA                    1314 	.db #0xfa	; -6
      0004D3 00                    1315 	.db #0x00	;  0
      0004D4 E9                    1316 	.db #0xe9	; -23
      0004D5 EA                    1317 	.db #0xea	; -22
      0004D6 00                    1318 	.db #0x00	;  0
      0004D7 00                    1319 	.db #0x00	;  0
      0004D8 11                    1320 	.db #0x11	;  17
      0004D9 FD                    1321 	.db #0xfd	; -3
      0004DA D0                    1322 	.db #0xd0	; -48
      0004DB 20                    1323 	.db #0x20	;  32
      0004DC 46                    1324 	.db #0x46	;  70	'F'
      0004DD 69                    1325 	.db #0x69	;  105	'i'
      0004DE FC                    1326 	.db #0xfc	; -4
      0004DF 0F                    1327 	.db #0x0f	;  15
      0004E0 33                    1328 	.db #0x33	;  51	'3'
      0004E1 5E                    1329 	.db #0x5e	;  94
      0004E2 14                    1330 	.db #0x14	;  20
      0004E3 02                    1331 	.db #0x02	;  2
      0004E4 FF                    1332 	.db #0xff	; -1
      0004E5 33                    1333 	.db #0x33	;  51	'3'
      0004E6 00                    1334 	.db #0x00	;  0
      0004E7 0B                    1335 	.db #0x0b	;  11
      0004E8 FD                    1336 	.db #0xfd	; -3
      0004E9 F9                    1337 	.db #0xf9	; -7
      0004EA 08                    1338 	.db #0x08	;  8
      0004EB 00                    1339 	.db #0x00	;  0
      0004EC F4                    1340 	.db #0xf4	; -12
      0004ED EE                    1341 	.db #0xee	; -18
      0004EE 13                    1342 	.db #0x13	;  19
      0004EF 62                    1343 	.db #0x62	;  98	'b'
      0004F0 0F                    1344 	.db #0x0f	;  15
      0004F1 FF                    1345 	.db #0xff	; -1
      0004F2 D7                    1346 	.db #0xd7	; -41
      0004F3 21                    1347 	.db #0x21	;  33
      0004F4 0A                    1348 	.db #0x0a	;  10
      0004F5 DA                    1349 	.db #0xda	; -38
      0004F6 F7                    1350 	.db #0xf7	; -9
      0004F7 EB                    1351 	.db #0xeb	; -21
      0004F8 27                    1352 	.db #0x27	;  39
      0004F9 40                    1353 	.db #0x40	;  64
      0004FA 23                    1354 	.db #0x23	;  35
      0004FB 0E                    1355 	.db #0x0e	;  14
      0004FC 0E                    1356 	.db #0x0e	;  14
      0004FD 35                    1357 	.db #0x35	;  53	'5'
      0004FE 07                    1358 	.db #0x07	;  7
      0004FF F2                    1359 	.db #0xf2	; -14
      000500 03                    1360 	.db #0x03	;  3
      000501 FB                    1361 	.db #0xfb	; -5
      000502 17                    1362 	.db #0x17	;  23
      000503 00                    1363 	.db #0x00	;  0
      000504 FE                    1364 	.db #0xfe	; -2
      000505 F0                    1365 	.db #0xf0	; -16
      000506 06                    1366 	.db #0x06	;  6
      000507 15                    1367 	.db #0x15	;  21
      000508 EC                    1368 	.db #0xec	; -20
      000509 06                    1369 	.db #0x06	;  6
      00050A 61                    1370 	.db #0x61	;  97	'a'
      00050B 15                    1371 	.db #0x15	;  21
      00050C DA                    1372 	.db #0xda	; -38
      00050D E6                    1373 	.db #0xe6	; -26
      00050E D3                    1374 	.db #0xd3	; -45
      00050F 03                    1375 	.db #0x03	;  3
      000510 E3                    1376 	.db #0xe3	; -29
      000511 ED                    1377 	.db #0xed	; -19
      000512 01                    1378 	.db #0x01	;  1
      000513 1F                    1379 	.db #0x1f	;  31
      000514 E0                    1380 	.db #0xe0	; -32
      000515 B7                    1381 	.db #0xb7	; -73
      000516 EF                    1382 	.db #0xef	; -17
      000517 4A                    1383 	.db #0x4a	;  74	'J'
      000518 D7                    1384 	.db #0xd7	; -41
      000519 AA                    1385 	.db #0xaa	; -86
      00051A 07                    1386 	.db #0x07	;  7
      00051B 00                    1387 	.db #0x00	;  0
      00051C 0A                    1388 	.db #0x0a	;  10
      00051D EC                    1389 	.db #0xec	; -20
      00051E 00                    1390 	.db #0x00	;  0
      00051F 47                    1391 	.db #0x47	;  71	'G'
      000520 EA                    1392 	.db #0xea	; -22
      000521 04                    1393 	.db #0x04	;  4
      000522 F5                    1394 	.db #0xf5	; -11
      000523 1F                    1395 	.db #0x1f	;  31
      000524 F2                    1396 	.db #0xf2	; -14
      000525 FA                    1397 	.db #0xfa	; -6
      000526 E6                    1398 	.db #0xe6	; -26
      000527 09                    1399 	.db #0x09	;  9
      000528 1B                    1400 	.db #0x1b	;  27
      000529 E5                    1401 	.db #0xe5	; -27
      00052A 0F                    1402 	.db #0x0f	;  15
      00052B 1C                    1403 	.db #0x1c	;  28
      00052C FE                    1404 	.db #0xfe	; -2
      00052D CA                    1405 	.db #0xca	; -54
      00052E 50                    1406 	.db #0x50	;  80	'P'
      00052F BA                    1407 	.db #0xba	; -70
      000530 FF                    1408 	.db #0xff	; -1
      000531 E6                    1409 	.db #0xe6	; -26
      000532 C9                    1410 	.db #0xc9	; -55
      000533 00                    1411 	.db #0x00	;  0
      000534 06                    1412 	.db #0x06	;  6
      000535 F0                    1413 	.db #0xf0	; -16
      000536 1E                    1414 	.db #0x1e	;  30
      000537 01                    1415 	.db #0x01	;  1
      000538 1B                    1416 	.db #0x1b	;  27
      000539 1E                    1417 	.db #0x1e	;  30
      00053A 07                    1418 	.db #0x07	;  7
      00053B 30                    1419 	.db #0x30	;  48	'0'
      00053C E8                    1420 	.db #0xe8	; -24
      00053D E5                    1421 	.db #0xe5	; -27
      00053E E8                    1422 	.db #0xe8	; -24
      00053F EF                    1423 	.db #0xef	; -17
      000540 25                    1424 	.db #0x25	;  37
      000541 E0                    1425 	.db #0xe0	; -32
      000542 12                    1426 	.db #0x12	;  18
      000543 9E                    1427 	.db #0x9e	; -98
      000544 05                    1428 	.db #0x05	;  5
      000545 D7                    1429 	.db #0xd7	; -41
      000546 1B                    1430 	.db #0x1b	;  27
      000547 F9                    1431 	.db #0xf9	; -7
      000548 08                    1432 	.db #0x08	;  8
      000549 EF                    1433 	.db #0xef	; -17
      00054A C6                    1434 	.db #0xc6	; -58
      00054B 00                    1435 	.db #0x00	;  0
      00054C F6                    1436 	.db #0xf6	; -10
      00054D EF                    1437 	.db #0xef	; -17
      00054E 03                    1438 	.db #0x03	;  3
      00054F E5                    1439 	.db #0xe5	; -27
      000550 0A                    1440 	.db #0x0a	;  10
      000551 29                    1441 	.db #0x29	;  41
      000552 DD                    1442 	.db #0xdd	; -35
      000553 11                    1443 	.db #0x11	;  17
      000554 48                    1444 	.db #0x48	;  72	'H'
      000555 47                    1445 	.db #0x47	;  71	'G'
      000556 EE                    1446 	.db #0xee	; -18
      000557 1B                    1447 	.db #0x1b	;  27
      000558 05                    1448 	.db #0x05	;  5
      000559 BB                    1449 	.db #0xbb	; -69
      00055A F7                    1450 	.db #0xf7	; -9
      00055B E9                    1451 	.db #0xe9	; -23
      00055C 0E                    1452 	.db #0x0e	;  14
      00055D E2                    1453 	.db #0xe2	; -30
      00055E FF                    1454 	.db #0xff	; -1
      00055F 00                    1455 	.db #0x00	;  0
      000560 0B                    1456 	.db #0x0b	;  11
      000561 E3                    1457 	.db #0xe3	; -29
      000562 BD                    1458 	.db #0xbd	; -67
      000563 00                    1459 	.db #0x00	;  0
      000564 E3                    1460 	.db #0xe3	; -29
      000565 F2                    1461 	.db #0xf2	; -14
      000566 09                    1462 	.db #0x09	;  9
      000567 21                    1463 	.db #0x21	;  33
      000568 06                    1464 	.db #0x06	;  6
      000569 2B                    1465 	.db #0x2b	;  43
      00056A CA                    1466 	.db #0xca	; -54
      00056B 03                    1467 	.db #0x03	;  3
      00056C E4                    1468 	.db #0xe4	; -28
      00056D CB                    1469 	.db #0xcb	; -53
      00056E 0F                    1470 	.db #0x0f	;  15
      00056F A8                    1471 	.db #0xa8	; -88
      000570 21                    1472 	.db #0x21	;  33
      000571 A0                    1473 	.db #0xa0	; -96
      000572 05                    1474 	.db #0x05	;  5
      000573 FD                    1475 	.db #0xfd	; -3
      000574 15                    1476 	.db #0x15	;  21
      000575 0A                    1477 	.db #0x0a	;  10
      000576 F4                    1478 	.db #0xf4	; -12
      000577 07                    1479 	.db #0x07	;  7
      000578 40                    1480 	.db #0x40	;  64
      000579 DD                    1481 	.db #0xdd	; -35
      00057A D9                    1482 	.db #0xd9	; -39
      00057B 00                    1483 	.db #0x00	;  0
      00057C 05                    1484 	.db #0x05	;  5
      00057D E6                    1485 	.db #0xe6	; -26
      00057E 13                    1486 	.db #0x13	;  19
      00057F E4                    1487 	.db #0xe4	; -28
      000580 0F                    1488 	.db #0x0f	;  15
      000581 FD                    1489 	.db #0xfd	; -3
      000582 3B                    1490 	.db #0x3b	;  59
      000583 17                    1491 	.db #0x17	;  23
      000584 EA                    1492 	.db #0xea	; -22
      000585 0B                    1493 	.db #0x0b	;  11
      000586 DF                    1494 	.db #0xdf	; -33
      000587 F8                    1495 	.db #0xf8	; -8
      000588 3F                    1496 	.db #0x3f	;  63
      000589 E9                    1497 	.db #0xe9	; -23
      00058A 07                    1498 	.db #0x07	;  7
      00058B 1D                    1499 	.db #0x1d	;  29
      00058C E8                    1500 	.db #0xe8	; -24
      00058D 08                    1501 	.db #0x08	;  8
      00058E 47                    1502 	.db #0x47	;  71	'G'
      00058F 49                    1503 	.db #0x49	;  73	'I'
      000590 05                    1504 	.db #0x05	;  5
      000591 D0                    1505 	.db #0xd0	; -48
      000592 1B                    1506 	.db #0x1b	;  27
      000593 00                    1507 	.db #0x00	;  0
      000594 E2                    1508 	.db #0xe2	; -30
      000595 03                    1509 	.db #0x03	;  3
      000596 C5                    1510 	.db #0xc5	; -59
      000597 FF                    1511 	.db #0xff	; -1
      000598 F5                    1512 	.db #0xf5	; -11
      000599 E1                    1513 	.db #0xe1	; -31
      00059A 18                    1514 	.db #0x18	;  24
      00059B C5                    1515 	.db #0xc5	; -59
      00059C 1C                    1516 	.db #0x1c	;  28
      00059D 0C                    1517 	.db #0x0c	;  12
      00059E F5                    1518 	.db #0xf5	; -11
      00059F 0C                    1519 	.db #0x0c	;  12
      0005A0 3B                    1520 	.db #0x3b	;  59
      0005A1 EE                    1521 	.db #0xee	; -18
      0005A2 19                    1522 	.db #0x19	;  25
      0005A3 16                    1523 	.db #0x16	;  22
      0005A4 07                    1524 	.db #0x07	;  7
      0005A5 17                    1525 	.db #0x17	;  23
      0005A6 37                    1526 	.db #0x37	;  55	'7'
      0005A7 A9                    1527 	.db #0xa9	; -87
      0005A8 F9                    1528 	.db #0xf9	; -7
      0005A9 F7                    1529 	.db #0xf7	; -9
      0005AA 42                    1530 	.db #0x42	;  66	'B'
      0005AB 00                    1531 	.db #0x00	;  0
      0005AC 0A                    1532 	.db #0x0a	;  10
      0005AD 23                    1533 	.db #0x23	;  35
      0005AE 16                    1534 	.db #0x16	;  22
      0005AF EF                    1535 	.db #0xef	; -17
      0005B0 07                    1536 	.db #0x07	;  7
      0005B1 B1                    1537 	.db #0xb1	; -79
      0005B2 F1                    1538 	.db #0xf1	; -15
      0005B3 ED                    1539 	.db #0xed	; -19
      0005B4 DD                    1540 	.db #0xdd	; -35
      0005B5 EA                    1541 	.db #0xea	; -22
      0005B6 EF                    1542 	.db #0xef	; -17
      0005B7 E7                    1543 	.db #0xe7	; -25
      0005B8 07                    1544 	.db #0x07	;  7
      0005B9 FF                    1545 	.db #0xff	; -1
      0005BA 27                    1546 	.db #0x27	;  39
      0005BB B6                    1547 	.db #0xb6	; -74
      0005BC FA                    1548 	.db #0xfa	; -6
      0005BD FD                    1549 	.db #0xfd	; -3
      0005BE CD                    1550 	.db #0xcd	; -51
      0005BF 2B                    1551 	.db #0x2b	;  43
      0005C0 E6                    1552 	.db #0xe6	; -26
      0005C1 EB                    1553 	.db #0xeb	; -21
      0005C2 3E                    1554 	.db #0x3e	;  62
      0005C3 00                    1555 	.db #0x00	;  0
      0005C4 19                    1556 	.db #0x19	;  25
      0005C5 12                    1557 	.db #0x12	;  18
      0005C6 31                    1558 	.db #0x31	;  49	'1'
      0005C7 31                    1559 	.db #0x31	;  49	'1'
      0005C8 2D                    1560 	.db #0x2d	;  45
      0005C9 BA                    1561 	.db #0xba	; -70
      0005CA F1                    1562 	.db #0xf1	; -15
      0005CB F9                    1563 	.db #0xf9	; -7
      0005CC 41                    1564 	.db #0x41	;  65	'A'
      0005CD 39                    1565 	.db #0x39	;  57	'9'
      0005CE FB                    1566 	.db #0xfb	; -5
      0005CF 49                    1567 	.db #0x49	;  73	'I'
      0005D0 FA                    1568 	.db #0xfa	; -6
      0005D1 F0                    1569 	.db #0xf0	; -16
      0005D2 01                    1570 	.db #0x01	;  1
      0005D3 05                    1571 	.db #0x05	;  5
      0005D4 ED                    1572 	.db #0xed	; -19
      0005D5 F8                    1573 	.db #0xf8	; -8
      0005D6 F7                    1574 	.db #0xf7	; -9
      0005D7 F5                    1575 	.db #0xf5	; -11
      0005D8 12                    1576 	.db #0x12	;  18
      0005D9 EF                    1577 	.db #0xef	; -17
      0005DA 20                    1578 	.db #0x20	;  32
      0005DB 00                    1579 	.db #0x00	;  0
      0005DC D7                    1580 	.db #0xd7	; -41
      0005DD E0                    1581 	.db #0xe0	; -32
      0005DE 01                    1582 	.db #0x01	;  1
      0005DF 21                    1583 	.db #0x21	;  33
      0005E0 44                    1584 	.db #0x44	;  68	'D'
      0005E1 A3                    1585 	.db #0xa3	; -93
      0005E2 F2                    1586 	.db #0xf2	; -14
      0005E3 1E                    1587 	.db #0x1e	;  30
      0005E4 E8                    1588 	.db #0xe8	; -24
      0005E5 D2                    1589 	.db #0xd2	; -46
      0005E6 FA                    1590 	.db #0xfa	; -6
      0005E7 81                    1591 	.db #0x81	; -127
      0005E8 37                    1592 	.db #0x37	;  55	'7'
      0005E9 F9                    1593 	.db #0xf9	; -7
      0005EA F4                    1594 	.db #0xf4	; -12
      0005EB FE                    1595 	.db #0xfe	; -2
      0005EC 18                    1596 	.db #0x18	;  24
      0005ED D4                    1597 	.db #0xd4	; -44
      0005EE 0D                    1598 	.db #0x0d	;  13
      0005EF 0B                    1599 	.db #0x0b	;  11
      0005F0 16                    1600 	.db #0x16	;  22
      0005F1 EA                    1601 	.db #0xea	; -22
      0005F2 D7                    1602 	.db #0xd7	; -41
      0005F3 00                    1603 	.db #0x00	;  0
      0005F4 E4                    1604 	.db #0xe4	; -28
      0005F5 C5                    1605 	.db #0xc5	; -59
      0005F6 02                    1606 	.db #0x02	;  2
      0005F7 17                    1607 	.db #0x17	;  23
      0005F8 2E                    1608 	.db #0x2e	;  46
      0005F9 F0                    1609 	.db #0xf0	; -16
      0005FA 5F                    1610 	.db #0x5f	;  95
      0005FB 13                    1611 	.db #0x13	;  19
      0005FC E8                    1612 	.db #0xe8	; -24
      0005FD 20                    1613 	.db #0x20	;  32
      0005FE 0A                    1614 	.db #0x0a	;  10
      0005FF 04                    1615 	.db #0x04	;  4
      000600 2A                    1616 	.db #0x2a	;  42
      000601 01                    1617 	.db #0x01	;  1
      000602 29                    1618 	.db #0x29	;  41
      000603 1D                    1619 	.db #0x1d	;  29
      000604 F7                    1620 	.db #0xf7	; -9
      000605 24                    1621 	.db #0x24	;  36
      000606 10                    1622 	.db #0x10	;  16
      000607 4A                    1623 	.db #0x4a	;  74	'J'
      000608 1C                    1624 	.db #0x1c	;  28
      000609 29                    1625 	.db #0x29	;  41
      00060A F5                    1626 	.db #0xf5	; -11
      00060B 00                    1627 	.db #0x00	;  0
      00060C EB                    1628 	.db #0xeb	; -21
      00060D D3                    1629 	.db #0xd3	; -45
      00060E 97                    1630 	.db #0x97	; -105
      00060F 0E                    1631 	.db #0x0e	;  14
      000610 F3                    1632 	.db #0xf3	; -13
      000611 1F                    1633 	.db #0x1f	;  31
      000612 F6                    1634 	.db #0xf6	; -10
      000613 B9                    1635 	.db #0xb9	; -71
      000614 19                    1636 	.db #0x19	;  25
      000615 0D                    1637 	.db #0x0d	;  13
      000616 F0                    1638 	.db #0xf0	; -16
      000617 01                    1639 	.db #0x01	;  1
      000618 42                    1640 	.db #0x42	;  66	'B'
      000619 0A                    1641 	.db #0x0a	;  10
      00061A F7                    1642 	.db #0xf7	; -9
      00061B 10                    1643 	.db #0x10	;  16
      00061C 12                    1644 	.db #0x12	;  18
      00061D 02                    1645 	.db #0x02	;  2
      00061E E0                    1646 	.db #0xe0	; -32
      00061F BF                    1647 	.db #0xbf	; -65
      000620 F9                    1648 	.db #0xf9	; -7
      000621 48                    1649 	.db #0x48	;  72	'H'
      000622 05                    1650 	.db #0x05	;  5
      000623 00                    1651 	.db #0x00	;  0
      000624 F5                    1652 	.db #0xf5	; -11
      000625 EF                    1653 	.db #0xef	; -17
      000626 0D                    1654 	.db #0x0d	;  13
      000627 08                    1655 	.db #0x08	;  8
      000628 B5                    1656 	.db #0xb5	; -75
      000629 4F                    1657 	.db #0x4f	;  79	'O'
      00062A F8                    1658 	.db #0xf8	; -8
      00062B 92                    1659 	.db #0x92	; -110
      00062C E8                    1660 	.db #0xe8	; -24
      00062D D8                    1661 	.db #0xd8	; -40
      00062E ED                    1662 	.db #0xed	; -19
      00062F F6                    1663 	.db #0xf6	; -10
      000630 22                    1664 	.db #0x22	;  34
      000631 12                    1665 	.db #0x12	;  18
      000632 2A                    1666 	.db #0x2a	;  42
      000633 EF                    1667 	.db #0xef	; -17
      000634 CA                    1668 	.db #0xca	; -54
      000635 02                    1669 	.db #0x02	;  2
      000636 F5                    1670 	.db #0xf5	; -11
      000637 2A                    1671 	.db #0x2a	;  42
      000638 08                    1672 	.db #0x08	;  8
      000639 1A                    1673 	.db #0x1a	;  26
      00063A 10                    1674 	.db #0x10	;  16
      00063B 00                    1675 	.db #0x00	;  0
      00063C 3F                    1676 	.db #0x3f	;  63
      00063D ED                    1677 	.db #0xed	; -19
      00063E 30                    1678 	.db #0x30	;  48	'0'
      00063F 1D                    1679 	.db #0x1d	;  29
      000640 F2                    1680 	.db #0xf2	; -14
      000641 52                    1681 	.db #0x52	;  82	'R'
      000642 13                    1682 	.db #0x13	;  19
      000643 DB                    1683 	.db #0xdb	; -37
      000644 38                    1684 	.db #0x38	;  56	'8'
      000645 35                    1685 	.db #0x35	;  53	'5'
      000646 C8                    1686 	.db #0xc8	; -56
      000647 3A                    1687 	.db #0x3a	;  58
      000648 08                    1688 	.db #0x08	;  8
      000649 14                    1689 	.db #0x14	;  20
      00064A 38                    1690 	.db #0x38	;  56	'8'
      00064B 11                    1691 	.db #0x11	;  17
      00064C B9                    1692 	.db #0xb9	; -71
      00064D 17                    1693 	.db #0x17	;  23
      00064E FA                    1694 	.db #0xfa	; -6
      00064F EE                    1695 	.db #0xee	; -18
      000650 18                    1696 	.db #0x18	;  24
      000651 16                    1697 	.db #0x16	;  22
      000652 19                    1698 	.db #0x19	;  25
      000653 00                    1699 	.db #0x00	;  0
      000654 F3                    1700 	.db #0xf3	; -13
      000655 E5                    1701 	.db #0xe5	; -27
      000656 E6                    1702 	.db #0xe6	; -26
      000657 00                    1703 	.db #0x00	;  0
      000658 FE                    1704 	.db #0xfe	; -2
      000659 3E                    1705 	.db #0x3e	;  62
      00065A 14                    1706 	.db #0x14	;  20
      00065B F2                    1707 	.db #0xf2	; -14
      00065C ED                    1708 	.db #0xed	; -19
      00065D F5                    1709 	.db #0xf5	; -11
      00065E C8                    1710 	.db #0xc8	; -56
      00065F AD                    1711 	.db #0xad	; -83
      000660 13                    1712 	.db #0x13	;  19
      000661 0C                    1713 	.db #0x0c	;  12
      000662 17                    1714 	.db #0x17	;  23
      000663 0E                    1715 	.db #0x0e	;  14
      000664 10                    1716 	.db #0x10	;  16
      000665 03                    1717 	.db #0x03	;  3
      000666 E9                    1718 	.db #0xe9	; -23
      000667 04                    1719 	.db #0x04	;  4
      000668 FA                    1720 	.db #0xfa	; -6
      000669 06                    1721 	.db #0x06	;  6
      00066A 13                    1722 	.db #0x13	;  19
      00066B 00                    1723 	.db #0x00	;  0
      00066C E5                    1724 	.db #0xe5	; -27
      00066D 1C                    1725 	.db #0x1c	;  28
      00066E 10                    1726 	.db #0x10	;  16
      00066F 3F                    1727 	.db #0x3f	;  63
      000670 2A                    1728 	.db #0x2a	;  42
      000671 F4                    1729 	.db #0xf4	; -12
      000672 1A                    1730 	.db #0x1a	;  26
      000673 F5                    1731 	.db #0xf5	; -11
      000674 D2                    1732 	.db #0xd2	; -46
      000675 FE                    1733 	.db #0xfe	; -2
      000676 79                    1734 	.db #0x79	;  121	'y'
      000677 FA                    1735 	.db #0xfa	; -6
      000678 FA                    1736 	.db #0xfa	; -6
      000679 07                    1737 	.db #0x07	;  7
      00067A BE                    1738 	.db #0xbe	; -66
      00067B 0B                    1739 	.db #0x0b	;  11
      00067C EC                    1740 	.db #0xec	; -20
      00067D 00                    1741 	.db #0x00	;  0
      00067E D2                    1742 	.db #0xd2	; -46
      00067F 45                    1743 	.db #0x45	;  69	'E'
      000680 12                    1744 	.db #0x12	;  18
      000681 76                    1745 	.db #0x76	;  118	'v'
      000682 09                    1746 	.db #0x09	;  9
      000683 00                    1747 	.db #0x00	;  0
      000684 EF                    1748 	.db #0xef	; -17
      000685 11                    1749 	.db #0x11	;  17
      000686 A4                    1750 	.db #0xa4	; -92
      000687 19                    1751 	.db #0x19	;  25
      000688 01                    1752 	.db #0x01	;  1
      000689 F5                    1753 	.db #0xf5	; -11
      00068A FA                    1754 	.db #0xfa	; -6
      00068B FD                    1755 	.db #0xfd	; -3
      00068C F2                    1756 	.db #0xf2	; -14
      00068D FF                    1757 	.db #0xff	; -1
      00068E 4B                    1758 	.db #0x4b	;  75	'K'
      00068F 01                    1759 	.db #0x01	;  1
      000690 1D                    1760 	.db #0x1d	;  29
      000691 07                    1761 	.db #0x07	;  7
      000692 E4                    1762 	.db #0xe4	; -28
      000693 1D                    1763 	.db #0x1d	;  29
      000694 38                    1764 	.db #0x38	;  56	'8'
      000695 0C                    1765 	.db #0x0c	;  12
      000696 09                    1766 	.db #0x09	;  9
      000697 DC                    1767 	.db #0xdc	; -36
      000698 F4                    1768 	.db #0xf4	; -12
      000699 39                    1769 	.db #0x39	;  57	'9'
      00069A FE                    1770 	.db #0xfe	; -2
      00069B 00                    1771 	.db #0x00	;  0
      00069C 29                    1772 	.db #0x29	;  41
      00069D 0E                    1773 	.db #0x0e	;  14
      00069E 37                    1774 	.db #0x37	;  55	'7'
      00069F 2B                    1775 	.db #0x2b	;  43
      0006A0 2F                    1776 	.db #0x2f	;  47
      0006A1 F1                    1777 	.db #0xf1	; -15
      0006A2 E9                    1778 	.db #0xe9	; -23
      0006A3 02                    1779 	.db #0x02	;  2
      0006A4 E2                    1780 	.db #0xe2	; -30
      0006A5 C6                    1781 	.db #0xc6	; -58
      0006A6 3F                    1782 	.db #0x3f	;  63
      0006A7 F7                    1783 	.db #0xf7	; -9
      0006A8 01                    1784 	.db #0x01	;  1
      0006A9 1A                    1785 	.db #0x1a	;  26
      0006AA 01                    1786 	.db #0x01	;  1
      0006AB FC                    1787 	.db #0xfc	; -4
      0006AC AF                    1788 	.db #0xaf	; -81
      0006AD FE                    1789 	.db #0xfe	; -2
      0006AE CE                    1790 	.db #0xce	; -50
      0006AF 24                    1791 	.db #0x24	;  36
      0006B0 09                    1792 	.db #0x09	;  9
      0006B1 49                    1793 	.db #0x49	;  73	'I'
      0006B2 27                    1794 	.db #0x27	;  39
      0006B3 00                    1795 	.db #0x00	;  0
      0006B4 49                    1796 	.db #0x49	;  73	'I'
      0006B5 34                    1797 	.db #0x34	;  52	'4'
      0006B6 29                    1798 	.db #0x29	;  41
      0006B7 21                    1799 	.db #0x21	;  33
      0006B8 F1                    1800 	.db #0xf1	; -15
      0006B9 F4                    1801 	.db #0xf4	; -12
      0006BA FB                    1802 	.db #0xfb	; -5
      0006BB FF                    1803 	.db #0xff	; -1
      0006BC 2F                    1804 	.db #0x2f	;  47
      0006BD 2D                    1805 	.db #0x2d	;  45
      0006BE 12                    1806 	.db #0x12	;  18
      0006BF 2F                    1807 	.db #0x2f	;  47
      0006C0 1D                    1808 	.db #0x1d	;  29
      0006C1 15                    1809 	.db #0x15	;  21
      0006C2 03                    1810 	.db #0x03	;  3
      0006C3 02                    1811 	.db #0x02	;  2
      0006C4 C4                    1812 	.db #0xc4	; -60
      0006C5 0D                    1813 	.db #0x0d	;  13
      0006C6 CF                    1814 	.db #0xcf	; -49
      0006C7 F7                    1815 	.db #0xf7	; -9
      0006C8 29                    1816 	.db #0x29	;  41
      0006C9 2B                    1817 	.db #0x2b	;  43
      0006CA 2B                    1818 	.db #0x2b	;  43
      0006CB 00                    1819 	.db #0x00	;  0
      0006CC D1                    1820 	.db #0xd1	; -47
      0006CD 33                    1821 	.db #0x33	;  51	'3'
      0006CE CB                    1822 	.db #0xcb	; -53
      0006CF F0                    1823 	.db #0xf0	; -16
      0006D0 E7                    1824 	.db #0xe7	; -25
      0006D1 03                    1825 	.db #0x03	;  3
      0006D2 02                    1826 	.db #0x02	;  2
      0006D3 E4                    1827 	.db #0xe4	; -28
      0006D4 FE                    1828 	.db #0xfe	; -2
      0006D5 F9                    1829 	.db #0xf9	; -7
      0006D6 11                    1830 	.db #0x11	;  17
      0006D7 C8                    1831 	.db #0xc8	; -56
      0006D8 32                    1832 	.db #0x32	;  50	'2'
      0006D9 14                    1833 	.db #0x14	;  20
      0006DA 1A                    1834 	.db #0x1a	;  26
      0006DB FA                    1835 	.db #0xfa	; -6
      0006DC 2C                    1836 	.db #0x2c	;  44
      0006DD 10                    1837 	.db #0x10	;  16
      0006DE D7                    1838 	.db #0xd7	; -41
      0006DF 03                    1839 	.db #0x03	;  3
      0006E0 27                    1840 	.db #0x27	;  39
      0006E1 3C                    1841 	.db #0x3c	;  60
      0006E2 4A                    1842 	.db #0x4a	;  74	'J'
      0006E3 00                    1843 	.db #0x00	;  0
      0006E4 C4                    1844 	.db #0xc4	; -60
      0006E5 6B                    1845 	.db #0x6b	;  107	'k'
      0006E6 E7                    1846 	.db #0xe7	; -25
      0006E7 08                    1847 	.db #0x08	;  8
      0006E8 EA                    1848 	.db #0xea	; -22
      0006E9 11                    1849 	.db #0x11	;  17
      0006EA 29                    1850 	.db #0x29	;  41
      0006EB D9                    1851 	.db #0xd9	; -39
      0006EC D7                    1852 	.db #0xd7	; -41
      0006ED EB                    1853 	.db #0xeb	; -21
      0006EE 35                    1854 	.db #0x35	;  53	'5'
      0006EF FA                    1855 	.db #0xfa	; -6
      0006F0 00                    1856 	.db #0x00	;  0
      0006F1 EF                    1857 	.db #0xef	; -17
      0006F2 EE                    1858 	.db #0xee	; -18
      0006F3 10                    1859 	.db #0x10	;  16
      0006F4 CE                    1860 	.db #0xce	; -50
      0006F5 E6                    1861 	.db #0xe6	; -26
      0006F6 02                    1862 	.db #0x02	;  2
      0006F7 08                    1863 	.db #0x08	;  8
      0006F8 07                    1864 	.db #0x07	;  7
      0006F9 01                    1865 	.db #0x01	;  1
      0006FA F1                    1866 	.db #0xf1	; -15
      0006FB 00                    1867 	.db #0x00	;  0
      0006FC 05                    1868 	.db #0x05	;  5
      0006FD 0D                    1869 	.db #0x0d	;  13
      0006FE DA                    1870 	.db #0xda	; -38
      0006FF 0C                    1871 	.db #0x0c	;  12
      000700 F6                    1872 	.db #0xf6	; -10
      000701 FD                    1873 	.db #0xfd	; -3
      000702 EF                    1874 	.db #0xef	; -17
      000703 00                    1875 	.db #0x00	;  0
      000704 DA                    1876 	.db #0xda	; -38
      000705 F7                    1877 	.db #0xf7	; -9
      000706 38                    1878 	.db #0x38	;  56	'8'
      000707 FB                    1879 	.db #0xfb	; -5
      000708 03                    1880 	.db #0x03	;  3
      000709 FB                    1881 	.db #0xfb	; -5
      00070A C8                    1882 	.db #0xc8	; -56
      00070B 00                    1883 	.db #0x00	;  0
      00070C 54                    1884 	.db #0x54	;  84	'T'
      00070D C8                    1885 	.db #0xc8	; -56
      00070E D6                    1886 	.db #0xd6	; -42
      00070F 12                    1887 	.db #0x12	;  18
      000710 F4                    1888 	.db #0xf4	; -12
      000711 19                    1889 	.db #0x19	;  25
      000712 24                    1890 	.db #0x24	;  36
      000713 00                    1891 	.db #0x00	;  0
      000714 13                    1892 	.db #0x13	;  19
      000715 61                    1893 	.db #0x61	;  97	'a'
      000716 30                    1894 	.db #0x30	;  48	'0'
      000717 5B                    1895 	.db #0x5b	;  91
      000718 F1                    1896 	.db #0xf1	; -15
      000719 16                    1897 	.db #0x16	;  22
      00071A F1                    1898 	.db #0xf1	; -15
      00071B D9                    1899 	.db #0xd9	; -39
      00071C F0                    1900 	.db #0xf0	; -16
      00071D DB                    1901 	.db #0xdb	; -37
      00071E 3B                    1902 	.db #0x3b	;  59
      00071F 1A                    1903 	.db #0x1a	;  26
      000720 00                    1904 	.db #0x00	;  0
      000721 E9                    1905 	.db #0xe9	; -23
      000722 A0                    1906 	.db #0xa0	; -96
      000723 01                    1907 	.db #0x01	;  1
      000724 B1                    1908 	.db #0xb1	; -79
      000725 DB                    1909 	.db #0xdb	; -37
      000726 FB                    1910 	.db #0xfb	; -5
      000727 FF                    1911 	.db #0xff	; -1
      000728 02                    1912 	.db #0x02	;  2
      000729 37                    1913 	.db #0x37	;  55	'7'
      00072A 1D                    1914 	.db #0x1d	;  29
      00072B 00                    1915 	.db #0x00	;  0
      00072C F2                    1916 	.db #0xf2	; -14
      00072D 3F                    1917 	.db #0x3f	;  63
      00072E 19                    1918 	.db #0x19	;  25
      00072F 13                    1919 	.db #0x13	;  19
      000730 F4                    1920 	.db #0xf4	; -12
      000731 0E                    1921 	.db #0x0e	;  14
      000732 0C                    1922 	.db #0x0c	;  12
      000733 EC                    1923 	.db #0xec	; -20
      000734 21                    1924 	.db #0x21	;  33
      000735 26                    1925 	.db #0x26	;  38
      000736 39                    1926 	.db #0x39	;  57	'9'
      000737 E1                    1927 	.db #0xe1	; -31
      000738 29                    1928 	.db #0x29	;  41
      000739 FA                    1929 	.db #0xfa	; -6
      00073A A1                    1930 	.db #0xa1	; -95
      00073B E6                    1931 	.db #0xe6	; -26
      00073C D9                    1932 	.db #0xd9	; -39
      00073D E2                    1933 	.db #0xe2	; -30
      00073E EF                    1934 	.db #0xef	; -17
      00073F 0A                    1935 	.db #0x0a	;  10
      000740 22                    1936 	.db #0x22	;  34
      000741 42                    1937 	.db #0x42	;  66	'B'
      000742 18                    1938 	.db #0x18	;  24
      000743 00                    1939 	.db #0x00	;  0
      000744 AE                    1940 	.db #0xae	; -82
      000745 46                    1941 	.db #0x46	;  70	'F'
      000746 F0                    1942 	.db #0xf0	; -16
      000747 F7                    1943 	.db #0xf7	; -9
      000748 E0                    1944 	.db #0xe0	; -32
      000749 16                    1945 	.db #0x16	;  22
      00074A 0E                    1946 	.db #0x0e	;  14
      00074B E1                    1947 	.db #0xe1	; -31
      00074C 05                    1948 	.db #0x05	;  5
      00074D F2                    1949 	.db #0xf2	; -14
      00074E 46                    1950 	.db #0x46	;  70	'F'
      00074F 00                    1951 	.db #0x00	;  0
      000750 1A                    1952 	.db #0x1a	;  26
      000751 F1                    1953 	.db #0xf1	; -15
      000752 AE                    1954 	.db #0xae	; -82
      000753 FB                    1955 	.db #0xfb	; -5
      000754 32                    1956 	.db #0x32	;  50	'2'
      000755 ED                    1957 	.db #0xed	; -19
      000756 EA                    1958 	.db #0xea	; -22
      000757 F5                    1959 	.db #0xf5	; -11
      000758 EE                    1960 	.db #0xee	; -18
      000759 1C                    1961 	.db #0x1c	;  28
      00075A 2D                    1962 	.db #0x2d	;  45
      00075B 00                    1963 	.db #0x00	;  0
      00075C E5                    1964 	.db #0xe5	; -27
      00075D 1E                    1965 	.db #0x1e	;  30
      00075E F1                    1966 	.db #0xf1	; -15
      00075F FD                    1967 	.db #0xfd	; -3
      000760 E4                    1968 	.db #0xe4	; -28
      000761 FE                    1969 	.db #0xfe	; -2
      000762 E8                    1970 	.db #0xe8	; -24
      000763 EA                    1971 	.db #0xea	; -22
      000764 DB                    1972 	.db #0xdb	; -37
                                   1973 	.area CSEG    (CODE)
                                   1974 	.area CONST   (CODE)
      000765                       1975 _B2:
      000765 14 FE FF FF           1976 	.byte #0x14, #0xfe, #0xff, #0xff	; -492
      000769 50 0B 00 00           1977 	.byte #0x50, #0x0b, #0x00, #0x00	;  2896
      00076D C8 02 00 00           1978 	.byte #0xc8, #0x02, #0x00, #0x00	;  712
      000771 91 08 00 00           1979 	.byte #0x91, #0x08, #0x00, #0x00	;  2193
      000775 72 F3 FF FF           1980 	.byte #0x72, #0xf3, #0xff, #0xff	; -3214
      000779 6F 06 00 00           1981 	.byte #0x6f, #0x06, #0x00, #0x00	;  1647
      00077D 31 F7 FF FF           1982 	.byte #0x31, #0xf7, #0xff, #0xff	; -2255
      000781 8B 0F 00 00           1983 	.byte #0x8b, #0x0f, #0x00, #0x00	;  3979
      000785 1D EE FF FF           1984 	.byte #0x1d, #0xee, #0xff, #0xff	; -4579
      000789 45 01 00 00           1985 	.byte #0x45, #0x01, #0x00, #0x00	;  325
                                   1986 	.area CSEG    (CODE)
                                   1987 	.area CONST   (CODE)
      00078D                       1988 _W2:
      00078D DF                    1989 	.db #0xdf	; -33
      00078E DA                    1990 	.db #0xda	; -38
      00078F 4A                    1991 	.db #0x4a	;  74	'J'
      000790 3C                    1992 	.db #0x3c	;  60
      000791 CB                    1993 	.db #0xcb	; -53
      000792 19                    1994 	.db #0x19	;  25
      000793 FF                    1995 	.db #0xff	; -1
      000794 E9                    1996 	.db #0xe9	; -23
      000795 EE                    1997 	.db #0xee	; -18
      000796 ED                    1998 	.db #0xed	; -19
      000797 3A                    1999 	.db #0x3a	;  58
      000798 E3                    2000 	.db #0xe3	; -29
      000799 45                    2001 	.db #0x45	;  69	'E'
      00079A B9                    2002 	.db #0xb9	; -71
      00079B 00                    2003 	.db #0x00	;  0
      00079C F2                    2004 	.db #0xf2	; -14
      00079D 24                    2005 	.db #0x24	;  36
      00079E 07                    2006 	.db #0x07	;  7
      00079F 1B                    2007 	.db #0x1b	;  27
      0007A0 CF                    2008 	.db #0xcf	; -49
      0007A1 81                    2009 	.db #0x81	; -127
      0007A2 14                    2010 	.db #0x14	;  20
      0007A3 0F                    2011 	.db #0x0f	;  15
      0007A4 E7                    2012 	.db #0xe7	; -25
      0007A5 6F                    2013 	.db #0x6f	;  111	'o'
      0007A6 2C                    2014 	.db #0x2c	;  44
      0007A7 C6                    2015 	.db #0xc6	; -58
      0007A8 B2                    2016 	.db #0xb2	; -78
      0007A9 35                    2017 	.db #0x35	;  53	'5'
      0007AA 22                    2018 	.db #0x22	;  34
      0007AB 4B                    2019 	.db #0x4b	;  75	'K'
      0007AC 41                    2020 	.db #0x41	;  65	'A'
      0007AD D5                    2021 	.db #0xd5	; -43
      0007AE 09                    2022 	.db #0x09	;  9
      0007AF 0A                    2023 	.db #0x0a	;  10
      0007B0 D6                    2024 	.db #0xd6	; -42
      0007B1 DB                    2025 	.db #0xdb	; -37
      0007B2 FA                    2026 	.db #0xfa	; -6
      0007B3 00                    2027 	.db #0x00	;  0
      0007B4 D7                    2028 	.db #0xd7	; -41
      0007B5 09                    2029 	.db #0x09	;  9
      0007B6 2D                    2030 	.db #0x2d	;  45
      0007B7 AD                    2031 	.db #0xad	; -83
      0007B8 CD                    2032 	.db #0xcd	; -51
      0007B9 F5                    2033 	.db #0xf5	; -11
      0007BA 3B                    2034 	.db #0x3b	;  59
      0007BB 04                    2035 	.db #0x04	;  4
      0007BC 5C                    2036 	.db #0x5c	;  92
      0007BD F0                    2037 	.db #0xf0	; -16
      0007BE 7B                    2038 	.db #0x7b	;  123
      0007BF B9                    2039 	.db #0xb9	; -71
      0007C0 DF                    2040 	.db #0xdf	; -33
      0007C1 EF                    2041 	.db #0xef	; -17
      0007C2 30                    2042 	.db #0x30	;  48	'0'
      0007C3 C2                    2043 	.db #0xc2	; -62
      0007C4 B5                    2044 	.db #0xb5	; -75
      0007C5 38                    2045 	.db #0x38	;  56	'8'
      0007C6 47                    2046 	.db #0x47	;  71	'G'
      0007C7 C2                    2047 	.db #0xc2	; -62
      0007C8 FA                    2048 	.db #0xfa	; -6
      0007C9 D9                    2049 	.db #0xd9	; -39
      0007CA 02                    2050 	.db #0x02	;  2
      0007CB 00                    2051 	.db #0x00	;  0
      0007CC B3                    2052 	.db #0xb3	; -77
      0007CD B6                    2053 	.db #0xb6	; -74
      0007CE 17                    2054 	.db #0x17	;  23
      0007CF 2A                    2055 	.db #0x2a	;  42
      0007D0 C9                    2056 	.db #0xc9	; -55
      0007D1 0E                    2057 	.db #0x0e	;  14
      0007D2 F5                    2058 	.db #0xf5	; -11
      0007D3 C4                    2059 	.db #0xc4	; -60
      0007D4 F7                    2060 	.db #0xf7	; -9
      0007D5 D1                    2061 	.db #0xd1	; -47
      0007D6 15                    2062 	.db #0x15	;  21
      0007D7 06                    2063 	.db #0x06	;  6
      0007D8 D5                    2064 	.db #0xd5	; -43
      0007D9 16                    2065 	.db #0x16	;  22
      0007DA E3                    2066 	.db #0xe3	; -29
      0007DB B8                    2067 	.db #0xb8	; -72
      0007DC DC                    2068 	.db #0xdc	; -36
      0007DD 2E                    2069 	.db #0x2e	;  46
      0007DE 23                    2070 	.db #0x23	;  35
      0007DF A8                    2071 	.db #0xa8	; -88
      0007E0 37                    2072 	.db #0x37	;  55	'7'
      0007E1 DC                    2073 	.db #0xdc	; -36
      0007E2 EF                    2074 	.db #0xef	; -17
      0007E3 00                    2075 	.db #0x00	;  0
      0007E4 2E                    2076 	.db #0x2e	;  46
      0007E5 14                    2077 	.db #0x14	;  20
      0007E6 B5                    2078 	.db #0xb5	; -75
      0007E7 3D                    2079 	.db #0x3d	;  61
      0007E8 1B                    2080 	.db #0x1b	;  27
      0007E9 1A                    2081 	.db #0x1a	;  26
      0007EA 11                    2082 	.db #0x11	;  17
      0007EB C6                    2083 	.db #0xc6	; -58
      0007EC FE                    2084 	.db #0xfe	; -2
      0007ED 5B                    2085 	.db #0x5b	;  91
      0007EE E9                    2086 	.db #0xe9	; -23
      0007EF B3                    2087 	.db #0xb3	; -77
      0007F0 F3                    2088 	.db #0xf3	; -13
      0007F1 C9                    2089 	.db #0xc9	; -55
      0007F2 18                    2090 	.db #0x18	;  24
      0007F3 29                    2091 	.db #0x29	;  41
      0007F4 46                    2092 	.db #0x46	;  70	'F'
      0007F5 AB                    2093 	.db #0xab	; -85
      0007F6 0E                    2094 	.db #0x0e	;  14
      0007F7 00                    2095 	.db #0x00	;  0
      0007F8 E3                    2096 	.db #0xe3	; -29
      0007F9 38                    2097 	.db #0x38	;  56	'8'
      0007FA 58                    2098 	.db #0x58	;  88	'X'
      0007FB 00                    2099 	.db #0x00	;  0
      0007FC F8                    2100 	.db #0xf8	; -8
      0007FD B8                    2101 	.db #0xb8	; -72
      0007FE EB                    2102 	.db #0xeb	; -21
      0007FF DC                    2103 	.db #0xdc	; -36
      000800 07                    2104 	.db #0x07	;  7
      000801 1E                    2105 	.db #0x1e	;  30
      000802 13                    2106 	.db #0x13	;  19
      000803 40                    2107 	.db #0x40	;  64
      000804 3E                    2108 	.db #0x3e	;  62
      000805 A7                    2109 	.db #0xa7	; -89
      000806 E5                    2110 	.db #0xe5	; -27
      000807 21                    2111 	.db #0x21	;  33
      000808 12                    2112 	.db #0x12	;  18
      000809 4B                    2113 	.db #0x4b	;  75	'K'
      00080A D8                    2114 	.db #0xd8	; -40
      00080B 00                    2115 	.db #0x00	;  0
      00080C D9                    2116 	.db #0xd9	; -39
      00080D F5                    2117 	.db #0xf5	; -11
      00080E AA                    2118 	.db #0xaa	; -86
      00080F 01                    2119 	.db #0x01	;  1
      000810 F1                    2120 	.db #0xf1	; -15
      000811 CB                    2121 	.db #0xcb	; -53
      000812 F1                    2122 	.db #0xf1	; -15
      000813 00                    2123 	.db #0x00	;  0
      000814 29                    2124 	.db #0x29	;  41
      000815 51                    2125 	.db #0x51	;  81	'Q'
      000816 C8                    2126 	.db #0xc8	; -56
      000817 ED                    2127 	.db #0xed	; -19
      000818 34                    2128 	.db #0x34	;  52	'4'
      000819 1F                    2129 	.db #0x1f	;  31
      00081A AB                    2130 	.db #0xab	; -85
      00081B 04                    2131 	.db #0x04	;  4
      00081C AE                    2132 	.db #0xae	; -82
      00081D E7                    2133 	.db #0xe7	; -25
      00081E EA                    2134 	.db #0xea	; -22
      00081F EE                    2135 	.db #0xee	; -18
      000820 18                    2136 	.db #0x18	;  24
      000821 13                    2137 	.db #0x13	;  19
      000822 2A                    2138 	.db #0x2a	;  42
      000823 32                    2139 	.db #0x32	;  50	'2'
      000824 DD                    2140 	.db #0xdd	; -35
      000825 A9                    2141 	.db #0xa9	; -87
      000826 EE                    2142 	.db #0xee	; -18
      000827 38                    2143 	.db #0x38	;  56	'8'
      000828 BA                    2144 	.db #0xba	; -70
      000829 38                    2145 	.db #0x38	;  56	'8'
      00082A 19                    2146 	.db #0x19	;  25
      00082B 00                    2147 	.db #0x00	;  0
      00082C DF                    2148 	.db #0xdf	; -33
      00082D 0E                    2149 	.db #0x0e	;  14
      00082E 06                    2150 	.db #0x06	;  6
      00082F D3                    2151 	.db #0xd3	; -45
      000830 40                    2152 	.db #0x40	;  64
      000831 09                    2153 	.db #0x09	;  9
      000832 AA                    2154 	.db #0xaa	; -86
      000833 D8                    2155 	.db #0xd8	; -40
      000834 BC                    2156 	.db #0xbc	; -68
      000835 FA                    2157 	.db #0xfa	; -6
      000836 EF                    2158 	.db #0xef	; -17
      000837 18                    2159 	.db #0x18	;  24
      000838 B0                    2160 	.db #0xb0	; -80
      000839 3B                    2161 	.db #0x3b	;  59
      00083A 9C                    2162 	.db #0x9c	; -100
      00083B BB                    2163 	.db #0xbb	; -69
      00083C 4F                    2164 	.db #0x4f	;  79	'O'
      00083D 70                    2165 	.db #0x70	;  112	'p'
      00083E 18                    2166 	.db #0x18	;  24
      00083F F2                    2167 	.db #0xf2	; -14
      000840 6E                    2168 	.db #0x6e	;  110	'n'
      000841 B8                    2169 	.db #0xb8	; -72
      000842 D1                    2170 	.db #0xd1	; -47
      000843 00                    2171 	.db #0x00	;  0
      000844 16                    2172 	.db #0x16	;  22
      000845 D5                    2173 	.db #0xd5	; -43
      000846 3E                    2174 	.db #0x3e	;  62
      000847 06                    2175 	.db #0x06	;  6
      000848 C1                    2176 	.db #0xc1	; -63
      000849 FA                    2177 	.db #0xfa	; -6
      00084A 18                    2178 	.db #0x18	;  24
      00084B 17                    2179 	.db #0x17	;  23
      00084C 25                    2180 	.db #0x25	;  37
      00084D EC                    2181 	.db #0xec	; -20
      00084E 00                    2182 	.db #0x00	;  0
      00084F 2C                    2183 	.db #0x2c	;  44
      000850 27                    2184 	.db #0x27	;  39
      000851 DA                    2185 	.db #0xda	; -38
      000852 15                    2186 	.db #0x15	;  21
      000853 ED                    2187 	.db #0xed	; -19
      000854 E4                    2188 	.db #0xe4	; -28
      000855 E7                    2189 	.db #0xe7	; -25
      000856 0B                    2190 	.db #0x0b	;  11
      000857 1B                    2191 	.db #0x1b	;  27
      000858 E2                    2192 	.db #0xe2	; -30
      000859 1A                    2193 	.db #0x1a	;  26
      00085A 02                    2194 	.db #0x02	;  2
      00085B 00                    2195 	.db #0x00	;  0
      00085C F0                    2196 	.db #0xf0	; -16
      00085D FB                    2197 	.db #0xfb	; -5
      00085E 01                    2198 	.db #0x01	;  1
      00085F 14                    2199 	.db #0x14	;  20
      000860 0C                    2200 	.db #0x0c	;  12
      000861 F4                    2201 	.db #0xf4	; -12
      000862 0C                    2202 	.db #0x0c	;  12
      000863 F1                    2203 	.db #0xf1	; -15
      000864 EF                    2204 	.db #0xef	; -17
      000865 E3                    2205 	.db #0xe3	; -29
      000866 C5                    2206 	.db #0xc5	; -59
      000867 30                    2207 	.db #0x30	;  48	'0'
      000868 20                    2208 	.db #0x20	;  32
      000869 DD                    2209 	.db #0xdd	; -35
      00086A CD                    2210 	.db #0xcd	; -51
      00086B DD                    2211 	.db #0xdd	; -35
      00086C 02                    2212 	.db #0x02	;  2
      00086D F8                    2213 	.db #0xf8	; -8
      00086E CF                    2214 	.db #0xcf	; -49
      00086F EA                    2215 	.db #0xea	; -22
      000870 10                    2216 	.db #0x10	;  16
      000871 D4                    2217 	.db #0xd4	; -44
      000872 21                    2218 	.db #0x21	;  33
      000873 00                    2219 	.db #0x00	;  0
      000874 36                    2220 	.db #0x36	;  54	'6'
      000875 0A                    2221 	.db #0x0a	;  10
      000876 D0                    2222 	.db #0xd0	; -48
      000877 18                    2223 	.db #0x18	;  24
      000878 06                    2224 	.db #0x06	;  6
      000879 11                    2225 	.db #0x11	;  17
      00087A 0A                    2226 	.db #0x0a	;  10
      00087B 3B                    2227 	.db #0x3b	;  59
      00087C FE                    2228 	.db #0xfe	; -2
                                   2229 	.area CSEG    (CODE)
                                   2230 	.area CONST   (CODE)
      00087D                       2231 _dsel:
      00087D F7                    2232 	.db #0xf7	; 247
      00087E EF                    2233 	.db #0xef	; 239
      00087F DF                    2234 	.db #0xdf	; 223
      000880 BF                    2235 	.db #0xbf	; 191
                                   2236 	.area CSEG    (CODE)
                                   2237 	.area CONST   (CODE)
      000881                       2238 _segs:
      000881 C0                    2239 	.db #0xc0	; 192
      000882 F9                    2240 	.db #0xf9	; 249
      000883 A4                    2241 	.db #0xa4	; 164
      000884 B0                    2242 	.db #0xb0	; 176
      000885 99                    2243 	.db #0x99	; 153
      000886 92                    2244 	.db #0x92	; 146
      000887 82                    2245 	.db #0x82	; 130
      000888 F8                    2246 	.db #0xf8	; 248
      000889 80                    2247 	.db #0x80	; 128
      00088A 90                    2248 	.db #0x90	; 144
                                   2249 	.area CSEG    (CODE)
                                   2250 	.area CONST   (CODE)
      00088B                       2251 _hexd:
      00088B 30 31 32 33 34 35 36  2252 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      00089B 00                    2253 	.db 0x00
                                   2254 	.area CSEG    (CODE)
                                   2255 	.area CONST   (CODE)
      00089C                       2256 ___str_0:
      00089C 4E 4E 20 52 45 41 44  2257 	.ascii "NN READY"
             59
      0008A4 0D                    2258 	.db 0x0d
      0008A5 0A                    2259 	.db 0x0a
      0008A6 00                    2260 	.db 0x00
                                   2261 	.area CSEG    (CODE)
                                   2262 	.area XINIT   (CODE)
                                   2263 	.area CABS    (ABS,CODE)
