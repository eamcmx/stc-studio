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
      00001D                        300 	.ds 4
                                    301 ;--------------------------------------------------------
                                    302 ; overlayable items in internal ram
                                    303 ;--------------------------------------------------------
                                    304 	.area	OSEG    (OVR,DATA)
                                    305 ;--------------------------------------------------------
                                    306 ; Stack segment in internal ram
                                    307 ;--------------------------------------------------------
                                    308 	.area SSEG
      0000B6                        309 __start__stack:
      0000B6                        310 	.ds	1
                                    311 
                                    312 ;--------------------------------------------------------
                                    313 ; indirectly addressable internal ram data
                                    314 ;--------------------------------------------------------
                                    315 	.area ISEG    (DATA)
      000023                        316 _pix::
      000023                        317 	.ds 35
      000046                        318 _acc::
      000046                        319 	.ds 48
      000076                        320 _hid::
      000076                        321 	.ds 24
      00008E                        322 _score::
      00008E                        323 	.ds 40
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
                                    458 ;	digit_nn.c:26: void t0_isr(void) T0_ISR
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
                                    476 ;	digit_nn.c:28: P1 = 0xFF;
      0000BD 75 90 FF         [24]  477 	mov	_P1,#0xff
                                    478 ;	digit_nn.c:29: digi = (digi + 1) & 3;
      0000C0 AF 14            [24]  479 	mov	r7,_digi
      0000C2 0F               [12]  480 	inc	r7
      0000C3 74 03            [12]  481 	mov	a,#0x03
      0000C5 5F               [12]  482 	anl	a,r7
                                    483 ;	digit_nn.c:30: P0 = dbuf[digi];
      0000C6 F5 14            [12]  484 	mov	_digi,a
      0000C8 24 10            [12]  485 	add	a, #_dbuf
      0000CA F9               [12]  486 	mov	r1,a
      0000CB 87 80            [24]  487 	mov	_P0,@r1
                                    488 ;	digit_nn.c:31: P1 = dsel[digi];
      0000CD E5 14            [12]  489 	mov	a,_digi
      0000CF 90 08 7E         [24]  490 	mov	dptr,#_dsel
      0000D2 93               [24]  491 	movc	a,@a+dptr
      0000D3 F5 90            [12]  492 	mov	_P1,a
                                    493 ;	digit_nn.c:32: }
      0000D5 D0 D0            [24]  494 	pop	psw
      0000D7 D0 83            [24]  495 	pop	dph
      0000D9 D0 82            [24]  496 	pop	dpl
      0000DB D0 E0            [24]  497 	pop	acc
      0000DD 32               [24]  498 	reti
                                    499 ;	eliminated unneeded push/pop b
                                    500 ;------------------------------------------------------------
                                    501 ;Allocation info for local variables in function 'getc_'
                                    502 ;------------------------------------------------------------
                                    503 ;	digit_nn.c:34: static unsigned char getc_(void) { while (!RI) ; RI = 0; return SBUF; }
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
                                    528 ;	digit_nn.c:35: static void putc_(unsigned char c) { SBUF = c; while (!TI) ; TI = 0; }
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
                                    545 ;	digit_nn.c:36: static void puthex(unsigned char v) { putc_(hexd[v >> 4]); putc_(hexd[v & 15]); }
                                    546 ;	-----------------------------------------
                                    547 ;	 function puthex
                                    548 ;	-----------------------------------------
      0000F0                        549 _puthex:
      0000F0 E5 82            [12]  550 	mov	a,dpl
      0000F2 FF               [12]  551 	mov	r7,a
      0000F3 C4               [12]  552 	swap	a
      0000F4 54 0F            [12]  553 	anl	a,#0x0f
      0000F6 90 08 8C         [24]  554 	mov	dptr,#_hexd
      0000F9 93               [24]  555 	movc	a,@a+dptr
      0000FA F5 82            [12]  556 	mov	dpl,a
      0000FC C0 07            [24]  557 	push	ar7
      0000FE 12 00 E7         [24]  558 	lcall	_putc_
      000101 D0 07            [24]  559 	pop	ar7
      000103 74 0F            [12]  560 	mov	a,#0x0f
      000105 5F               [12]  561 	anl	a,r7
      000106 90 08 8C         [24]  562 	mov	dptr,#_hexd
      000109 93               [24]  563 	movc	a,@a+dptr
      00010A F5 82            [12]  564 	mov	dpl,a
      00010C 02 00 E7         [24]  565 	ljmp	_putc_
                                    566 ;------------------------------------------------------------
                                    567 ;Allocation info for local variables in function 'puts_'
                                    568 ;------------------------------------------------------------
                                    569 ;s             Allocated to registers 
                                    570 ;------------------------------------------------------------
                                    571 ;	digit_nn.c:37: static void puts_(char code *s) { while (*s) putc_(*s++); }
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
                                    605 ;a             Allocated to registers r5 r6 
                                    606 ;s             Allocated with name '_main_s_10000_12'
                                    607 ;u             Allocated to registers r3 r4 r5 r6 
                                    608 ;sloc0         Allocated with name '_main_sloc0_1_0'
                                    609 ;------------------------------------------------------------
                                    610 ;	digit_nn.c:39: void main(void)
                                    611 ;	-----------------------------------------
                                    612 ;	 function main
                                    613 ;	-----------------------------------------
      000131                        614 _main:
                                    615 ;	digit_nn.c:52: dbuf[0] = dbuf[1] = 0xAB;      /* "nn--" until the first digit arrives */
      000131 75 11 AB         [24]  616 	mov	(_dbuf + 0x0001),#0xab
      000134 75 10 AB         [24]  617 	mov	_dbuf,#0xab
                                    618 ;	digit_nn.c:53: dbuf[2] = dbuf[3] = 0xBF;
      000137 75 13 BF         [24]  619 	mov	(_dbuf + 0x0003),#0xbf
      00013A 75 12 BF         [24]  620 	mov	(_dbuf + 0x0002),#0xbf
                                    621 ;	digit_nn.c:54: digi = 0;
      00013D 75 14 00         [24]  622 	mov	_digi,#0x00
                                    623 ;	digit_nn.c:55: TMOD = 0x22;                   /* Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload */
      000140 75 89 22         [24]  624 	mov	_TMOD,#0x22
                                    625 ;	digit_nn.c:56: TH1 = TL1 = 0xFD;
      000143 75 8B FD         [24]  626 	mov	_TL1,#0xfd
      000146 75 8D FD         [24]  627 	mov	_TH1,#0xfd
                                    628 ;	digit_nn.c:57: PCON |= 0x80;                  /* SMOD = 1: 19200 baud */
      000149 43 87 80         [24]  629 	orl	_PCON,#0x80
                                    630 ;	digit_nn.c:58: SCON = 0x50;
      00014C 75 98 50         [24]  631 	mov	_SCON,#0x50
                                    632 ;	digit_nn.c:59: TH0 = TL0 = 0;
      00014F 75 8A 00         [24]  633 	mov	_TL0,#0x00
      000152 75 8C 00         [24]  634 	mov	_TH0,#0x00
                                    635 ;	digit_nn.c:60: TR1 = 1; TR0 = 1; ET0 = 0;   /* DISPLAY OFF BUILD (nn/energy_build.py) */ EA = 1;
                                    636 ;	assignBit
      000155 D2 8E            [12]  637 	setb	_TR1
                                    638 ;	assignBit
      000157 D2 8C            [12]  639 	setb	_TR0
                                    640 ;	assignBit
      000159 C2 A9            [12]  641 	clr	_ET0
                                    642 ;	assignBit
      00015B D2 AF            [12]  643 	setb	_EA
                                    644 ;	digit_nn.c:61: puts_("NN READY\r\n");
      00015D 90 08 9D         [24]  645 	mov	dptr,#___str_0
      000160 12 01 0F         [24]  646 	lcall	_puts_
                                    647 ;	digit_nn.c:64: while (getc_() != 'D') ;
      000163                        648 00101$:
      000163 12 00 DE         [24]  649 	lcall	_getc_
      000166 AF 82            [24]  650 	mov	r7, dpl
      000168 BF 44 F8         [24]  651 	cjne	r7,#0x44,00101$
                                    652 ;	digit_nn.c:65: for (i = 0; i < 35; i++) pix[i] = (getc_() == '1');
      00016B 7F 00            [12]  653 	mov	r7,#0x00
      00016D                        654 00121$:
      00016D EF               [12]  655 	mov	a,r7
      00016E 24 23            [12]  656 	add	a, #_pix
      000170 F9               [12]  657 	mov	r1,a
      000171 C0 07            [24]  658 	push	ar7
      000173 C0 01            [24]  659 	push	ar1
      000175 12 00 DE         [24]  660 	lcall	_getc_
      000178 AE 82            [24]  661 	mov	r6, dpl
      00017A D0 01            [24]  662 	pop	ar1
      00017C D0 07            [24]  663 	pop	ar7
      00017E E4               [12]  664 	clr	a
      00017F BE 31 01         [24]  665 	cjne	r6,#0x31,00340$
      000182 04               [12]  666 	inc	a
      000183                        667 00340$:
      000183 F7               [12]  668 	mov	@r1,a
      000184 0F               [12]  669 	inc	r7
      000185 BF 23 00         [24]  670 	cjne	r7,#0x23,00342$
      000188                        671 00342$:
      000188 40 E3            [24]  672 	jc	00121$
                                    673 ;	digit_nn.c:68: for (j = 0; j < NH; j++) acc[j] = B1[j];
      00018A 7F 00            [12]  674 	mov	r7,#0x00
      00018C                        675 00123$:
      00018C EF               [12]  676 	mov	a,r7
      00018D 2F               [12]  677 	add	a,r7
      00018E 24 46            [12]  678 	add	a, #_acc
      000190 F9               [12]  679 	mov	r1,a
      000191 EF               [12]  680 	mov	a,r7
      000192 75 F0 02         [24]  681 	mov	b,#0x02
      000195 A4               [48]  682 	mul	ab
      000196 24 EE            [12]  683 	add	a, #_B1
      000198 F5 82            [12]  684 	mov	dpl,a
      00019A 74 03            [12]  685 	mov	a,#(_B1 >> 8)
      00019C 35 F0            [12]  686 	addc	a, b
      00019E F5 83            [12]  687 	mov	dph,a
      0001A0 E4               [12]  688 	clr	a
      0001A1 93               [24]  689 	movc	a,@a+dptr
      0001A2 FD               [12]  690 	mov	r5,a
      0001A3 A3               [24]  691 	inc	dptr
      0001A4 E4               [12]  692 	clr	a
      0001A5 93               [24]  693 	movc	a,@a+dptr
      0001A6 FE               [12]  694 	mov	r6,a
      0001A7 A7 05            [24]  695 	mov	@r1,ar5
      0001A9 09               [12]  696 	inc	r1
      0001AA A7 06            [24]  697 	mov	@r1,ar6
      0001AC 19               [12]  698 	dec	r1
      0001AD 0F               [12]  699 	inc	r7
      0001AE BF 18 00         [24]  700 	cjne	r7,#0x18,00344$
      0001B1                        701 00344$:
      0001B1 40 D9            [24]  702 	jc	00123$
                                    703 ;	digit_nn.c:78: for (i = 0; i < 35; i++)
      0001B3 75 15 00         [24]  704 	mov	_main_i_10000_12,#0x00
      0001B6                        705 00127$:
                                    706 ;	digit_nn.c:79: if (pix[i])
      0001B6 E5 15            [12]  707 	mov	a,_main_i_10000_12
      0001B8 24 23            [12]  708 	add	a, #_pix
      0001BA F9               [12]  709 	mov	r1,a
      0001BB E7               [12]  710 	mov	a,@r1
      0001BC 60 42            [24]  711 	jz	00128$
                                    712 ;	digit_nn.c:80: for (j = 0; j < NH; j++) acc[j] += W1[i][j];
      0001BE E5 15            [12]  713 	mov	a,_main_i_10000_12
      0001C0 75 F0 18         [24]  714 	mov	b,#0x18
      0001C3 A4               [48]  715 	mul	ab
      0001C4 24 1E            [12]  716 	add	a, #_W1
      0001C6 FD               [12]  717 	mov	r5,a
      0001C7 74 04            [12]  718 	mov	a,#(_W1 >> 8)
      0001C9 35 F0            [12]  719 	addc	a, b
      0001CB FE               [12]  720 	mov	r6,a
      0001CC 75 16 00         [24]  721 	mov	_main_j_10000_12,#0x00
      0001CF                        722 00125$:
      0001CF E5 16            [12]  723 	mov	a,_main_j_10000_12
      0001D1 25 16            [12]  724 	add	a,_main_j_10000_12
      0001D3 24 46            [12]  725 	add	a, #_acc
      0001D5 F9               [12]  726 	mov	r1,a
      0001D6 87 02            [24]  727 	mov	ar2,@r1
      0001D8 09               [12]  728 	inc	r1
      0001D9 87 03            [24]  729 	mov	ar3,@r1
      0001DB 19               [12]  730 	dec	r1
      0001DC E5 16            [12]  731 	mov	a,_main_j_10000_12
      0001DE 2D               [12]  732 	add	a, r5
      0001DF F5 82            [12]  733 	mov	dpl,a
      0001E1 E4               [12]  734 	clr	a
      0001E2 3E               [12]  735 	addc	a, r6
      0001E3 F5 83            [12]  736 	mov	dph,a
      0001E5 E4               [12]  737 	clr	a
      0001E6 93               [24]  738 	movc	a,@a+dptr
      0001E7 FC               [12]  739 	mov	r4,a
      0001E8 33               [12]  740 	rlc	a
      0001E9 95 E0            [12]  741 	subb	a,acc
      0001EB FF               [12]  742 	mov	r7,a
      0001EC EC               [12]  743 	mov	a,r4
      0001ED 2A               [12]  744 	add	a, r2
      0001EE FA               [12]  745 	mov	r2,a
      0001EF EF               [12]  746 	mov	a,r7
      0001F0 3B               [12]  747 	addc	a, r3
      0001F1 FB               [12]  748 	mov	r3,a
      0001F2 A7 02            [24]  749 	mov	@r1,ar2
      0001F4 09               [12]  750 	inc	r1
      0001F5 A7 03            [24]  751 	mov	@r1,ar3
      0001F7 19               [12]  752 	dec	r1
      0001F8 05 16            [12]  753 	inc	_main_j_10000_12
      0001FA 74 E8            [12]  754 	mov	a,#0x100 - 0x18
      0001FC 25 16            [12]  755 	add	a,_main_j_10000_12
      0001FE 50 CF            [24]  756 	jnc	00125$
      000200                        757 00128$:
                                    758 ;	digit_nn.c:78: for (i = 0; i < 35; i++)
      000200 05 15            [12]  759 	inc	_main_i_10000_12
      000202 74 DD            [12]  760 	mov	a,#0x100 - 0x23
      000204 25 15            [12]  761 	add	a,_main_i_10000_12
      000206 50 AE            [24]  762 	jnc	00127$
                                    763 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      000208 7F 00            [12]  764 	mov	r7,#0x00
      00020A                        765 00129$:
                                    766 ;	digit_nn.c:84: a = acc[j];
      00020A EF               [12]  767 	mov	a,r7
      00020B 2F               [12]  768 	add	a,r7
      00020C 24 46            [12]  769 	add	a, #_acc
      00020E F9               [12]  770 	mov	r1,a
      00020F 87 05            [24]  771 	mov	ar5,@r1
      000211 09               [12]  772 	inc	r1
      000212 87 06            [24]  773 	mov	ar6,@r1
      000214 19               [12]  774 	dec	r1
                                    775 ;	digit_nn.c:85: if (a < 0) hid[j] = 0;
      000215 EE               [12]  776 	mov	a,r6
      000216 30 E7 08         [24]  777 	jnb	acc.7,00111$
      000219 EF               [12]  778 	mov	a,r7
      00021A 24 76            [12]  779 	add	a, #_hid
      00021C F8               [12]  780 	mov	r0,a
      00021D 76 00            [12]  781 	mov	@r0,#0x00
      00021F 80 23            [24]  782 	sjmp	00130$
      000221                        783 00111$:
                                    784 ;	digit_nn.c:86: else { a >>= SH1; hid[j] = a > 255 ? 255 : (unsigned char)a; }
      000221 EE               [12]  785 	mov	a,r6
      000222 A2 E7            [12]  786 	mov	c,acc.7
      000224 13               [12]  787 	rrc	a
      000225 CD               [12]  788 	xch	a,r5
      000226 13               [12]  789 	rrc	a
      000227 CD               [12]  790 	xch	a,r5
      000228 FE               [12]  791 	mov	r6,a
      000229 EF               [12]  792 	mov	a,r7
      00022A 24 76            [12]  793 	add	a, #_hid
      00022C F9               [12]  794 	mov	r1,a
      00022D C3               [12]  795 	clr	c
      00022E 74 FF            [12]  796 	mov	a,#0xff
      000230 9D               [12]  797 	subb	a,r5
      000231 74 80            [12]  798 	mov	a,#(0x00 ^ 0x80)
      000233 8E F0            [24]  799 	mov	b,r6
      000235 63 F0 80         [24]  800 	xrl	b,#0x80
      000238 95 F0            [12]  801 	subb	a,b
      00023A 50 04            [24]  802 	jnc	00143$
                                    803 ;	free result
      00023C 7C FF            [12]  804 	mov	r4,#0xff
      00023E 80 02            [24]  805 	sjmp	00144$
      000240                        806 00143$:
      000240 8D 04            [24]  807 	mov	ar4,r5
      000242                        808 00144$:
      000242 A7 04            [24]  809 	mov	@r1,ar4
      000244                        810 00130$:
                                    811 ;	digit_nn.c:83: for (j = 0; j < NH; j++) {
      000244 0F               [12]  812 	inc	r7
      000245 BF 18 00         [24]  813 	cjne	r7,#0x18,00351$
      000248                        814 00351$:
      000248 40 C0            [24]  815 	jc	00129$
                                    816 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      00024A 75 17 00         [24]  817 	mov	_main_k_10000_12,#0x00
      00024D                        818 00133$:
                                    819 ;	digit_nn.c:91: s = B2[k];
      00024D E5 17            [12]  820 	mov	a,_main_k_10000_12
      00024F 75 F0 04         [24]  821 	mov	b,#0x04
      000252 A4               [48]  822 	mul	ab
      000253 24 66            [12]  823 	add	a, #_B2
      000255 F5 82            [12]  824 	mov	dpl,a
      000257 74 07            [12]  825 	mov	a,#(_B2 >> 8)
      000259 35 F0            [12]  826 	addc	a, b
      00025B F5 83            [12]  827 	mov	dph,a
      00025D E4               [12]  828 	clr	a
      00025E 93               [24]  829 	movc	a,@a+dptr
      00025F F5 19            [12]  830 	mov	_main_s_10000_12,a
      000261 A3               [24]  831 	inc	dptr
      000262 E4               [12]  832 	clr	a
      000263 93               [24]  833 	movc	a,@a+dptr
      000264 F5 1A            [12]  834 	mov	(_main_s_10000_12 + 1),a
      000266 A3               [24]  835 	inc	dptr
      000267 E4               [12]  836 	clr	a
      000268 93               [24]  837 	movc	a,@a+dptr
      000269 F5 1B            [12]  838 	mov	(_main_s_10000_12 + 2),a
      00026B A3               [24]  839 	inc	dptr
      00026C E4               [12]  840 	clr	a
      00026D 93               [24]  841 	movc	a,@a+dptr
      00026E F5 1C            [12]  842 	mov	(_main_s_10000_12 + 3),a
                                    843 ;	digit_nn.c:102: for (j = 0; j < NH; j++)
      000270 E5 17            [12]  844 	mov	a,_main_k_10000_12
      000272 75 F0 18         [24]  845 	mov	b,#0x18
      000275 A4               [48]  846 	mul	ab
      000276 24 8E            [12]  847 	add	a, #_W2
      000278 FA               [12]  848 	mov	r2,a
      000279 74 07            [12]  849 	mov	a,#(_W2 >> 8)
      00027B 35 F0            [12]  850 	addc	a, b
      00027D FE               [12]  851 	mov	r6,a
      00027E 75 16 00         [24]  852 	mov	_main_j_10000_12,#0x00
      000281                        853 00131$:
                                    854 ;	digit_nn.c:106: s += (int)hid[j] * W2[k][j];
      000281 E5 16            [12]  855 	mov	a,_main_j_10000_12
      000283 24 76            [12]  856 	add	a, #_hid
      000285 F9               [12]  857 	mov	r1,a
      000286 87 04            [24]  858 	mov	ar4,@r1
      000288 7B 00            [12]  859 	mov	r3,#0x00
      00028A E5 16            [12]  860 	mov	a,_main_j_10000_12
      00028C 2A               [12]  861 	add	a, r2
      00028D F5 82            [12]  862 	mov	dpl,a
      00028F E4               [12]  863 	clr	a
      000290 3E               [12]  864 	addc	a, r6
      000291 F5 83            [12]  865 	mov	dph,a
      000293 E4               [12]  866 	clr	a
      000294 93               [24]  867 	movc	a,@a+dptr
      000295 F5 21            [12]  868 	mov	__mulint_PARM_2, a
      000297 33               [12]  869 	rlc	a
      000298 95 E0            [12]  870 	subb	a,acc
      00029A F5 22            [12]  871 	mov	(__mulint_PARM_2 + 1),a
      00029C 8C 82            [24]  872 	mov	dpl, r4
      00029E 8B 83            [24]  873 	mov	dph, r3
      0002A0 C0 06            [24]  874 	push	ar6
      0002A2 C0 02            [24]  875 	push	ar2
      0002A4 12 03 CD         [24]  876 	lcall	__mulint
      0002A7 AF 82            [24]  877 	mov	r7, dpl
      0002A9 AC 83            [24]  878 	mov	r4, dph
      0002AB D0 02            [24]  879 	pop	ar2
      0002AD D0 06            [24]  880 	pop	ar6
      0002AF 8F 03            [24]  881 	mov	ar3,r7
      0002B1 EC               [12]  882 	mov	a,r4
      0002B2 33               [12]  883 	rlc	a
      0002B3 95 E0            [12]  884 	subb	a,acc
      0002B5 FD               [12]  885 	mov	r5,a
      0002B6 FF               [12]  886 	mov	r7,a
      0002B7 EB               [12]  887 	mov	a,r3
      0002B8 25 19            [12]  888 	add	a, _main_s_10000_12
      0002BA F5 19            [12]  889 	mov	_main_s_10000_12,a
      0002BC EC               [12]  890 	mov	a,r4
      0002BD 35 1A            [12]  891 	addc	a, (_main_s_10000_12 + 1)
      0002BF F5 1A            [12]  892 	mov	(_main_s_10000_12 + 1),a
      0002C1 ED               [12]  893 	mov	a,r5
      0002C2 35 1B            [12]  894 	addc	a, (_main_s_10000_12 + 2)
      0002C4 F5 1B            [12]  895 	mov	(_main_s_10000_12 + 2),a
      0002C6 EF               [12]  896 	mov	a,r7
      0002C7 35 1C            [12]  897 	addc	a, (_main_s_10000_12 + 3)
      0002C9 F5 1C            [12]  898 	mov	(_main_s_10000_12 + 3),a
                                    899 ;	digit_nn.c:102: for (j = 0; j < NH; j++)
      0002CB 05 16            [12]  900 	inc	_main_j_10000_12
      0002CD 74 E8            [12]  901 	mov	a,#0x100 - 0x18
      0002CF 25 16            [12]  902 	add	a,_main_j_10000_12
      0002D1 50 AE            [24]  903 	jnc	00131$
                                    904 ;	digit_nn.c:109: score[k] = s;
      0002D3 E5 17            [12]  905 	mov	a,_main_k_10000_12
      0002D5 25 17            [12]  906 	add	a,_main_k_10000_12
      0002D7 25 E0            [12]  907 	add	a,acc
      0002D9 24 8E            [12]  908 	add	a, #_score
      0002DB F8               [12]  909 	mov	r0,a
      0002DC A6 19            [24]  910 	mov	@r0,_main_s_10000_12
      0002DE 08               [12]  911 	inc	r0
      0002DF A6 1A            [24]  912 	mov	@r0,(_main_s_10000_12 + 1)
      0002E1 08               [12]  913 	inc	r0
      0002E2 A6 1B            [24]  914 	mov	@r0,(_main_s_10000_12 + 2)
      0002E4 08               [12]  915 	inc	r0
      0002E5 A6 1C            [24]  916 	mov	@r0,(_main_s_10000_12 + 3)
                                    917 ;	digit_nn.c:90: for (k = 0; k < 10; k++) {
      0002E7 05 17            [12]  918 	inc	_main_k_10000_12
      0002E9 74 F6            [12]  919 	mov	a,#0x100 - 0x0a
      0002EB 25 17            [12]  920 	add	a,_main_k_10000_12
      0002ED 40 03            [24]  921 	jc	00354$
      0002EF 02 02 4D         [24]  922 	ljmp	00133$
      0002F2                        923 00354$:
                                    924 ;	digit_nn.c:113: best = 0;
      0002F2 7F 00            [12]  925 	mov	r7,#0x00
                                    926 ;	digit_nn.c:114: for (k = 1; k < 10; k++) if (score[k] > score[best]) best = k;
      0002F4 75 18 01         [24]  927 	mov	_main_best_10000_12,#0x01
      0002F7                        928 00135$:
      0002F7 E5 18            [12]  929 	mov	a,_main_best_10000_12
      0002F9 25 18            [12]  930 	add	a,_main_best_10000_12
      0002FB 25 E0            [12]  931 	add	a,acc
      0002FD 24 8E            [12]  932 	add	a, #_score
      0002FF F9               [12]  933 	mov	r1,a
      000300 87 1D            [24]  934 	mov	_main_sloc0_1_0,@r1
      000302 09               [12]  935 	inc	r1
      000303 87 1E            [24]  936 	mov	(_main_sloc0_1_0 + 1),@r1
      000305 09               [12]  937 	inc	r1
      000306 87 1F            [24]  938 	mov	(_main_sloc0_1_0 + 2),@r1
      000308 09               [12]  939 	inc	r1
      000309 87 20            [24]  940 	mov	(_main_sloc0_1_0 + 3),@r1
      00030B 19               [12]  941 	dec	r1
      00030C 19               [12]  942 	dec	r1
      00030D 19               [12]  943 	dec	r1
      00030E EF               [12]  944 	mov	a,r7
      00030F 2F               [12]  945 	add	a,r7
      000310 25 E0            [12]  946 	add	a,acc
      000312 24 8E            [12]  947 	add	a, #_score
      000314 F9               [12]  948 	mov	r1,a
      000315 C0 07            [24]  949 	push	ar7
      000317 87 04            [24]  950 	mov	ar4,@r1
      000319 09               [12]  951 	inc	r1
      00031A 87 05            [24]  952 	mov	ar5,@r1
      00031C 09               [12]  953 	inc	r1
      00031D 87 06            [24]  954 	mov	ar6,@r1
      00031F 09               [12]  955 	inc	r1
      000320 87 07            [24]  956 	mov	ar7,@r1
      000322 19               [12]  957 	dec	r1
      000323 19               [12]  958 	dec	r1
      000324 19               [12]  959 	dec	r1
      000325 C3               [12]  960 	clr	c
      000326 EC               [12]  961 	mov	a,r4
      000327 95 1D            [12]  962 	subb	a,_main_sloc0_1_0
      000329 ED               [12]  963 	mov	a,r5
      00032A 95 1E            [12]  964 	subb	a,(_main_sloc0_1_0 + 1)
      00032C EE               [12]  965 	mov	a,r6
      00032D 95 1F            [12]  966 	subb	a,(_main_sloc0_1_0 + 2)
      00032F EF               [12]  967 	mov	a,r7
      000330 64 80            [12]  968 	xrl	a,#0x80
      000332 85 20 F0         [24]  969 	mov	b,(_main_sloc0_1_0 + 3)
      000335 63 F0 80         [24]  970 	xrl	b,#0x80
      000338 95 F0            [12]  971 	subb	a,b
      00033A D0 07            [24]  972 	pop	ar7
      00033C 50 02            [24]  973 	jnc	00136$
                                    974 ;	free result
      00033E AF 18            [24]  975 	mov	r7,_main_best_10000_12
      000340                        976 00136$:
      000340 05 18            [12]  977 	inc	_main_best_10000_12
      000342 74 F6            [12]  978 	mov	a,#0x100 - 0x0a
      000344 25 18            [12]  979 	add	a,_main_best_10000_12
      000346 50 AF            [24]  980 	jnc	00135$
                                    981 ;	digit_nn.c:116: dbuf[2] = 0xFF;
      000348 75 12 FF         [24]  982 	mov	(_dbuf + 0x0002),#0xff
                                    983 ;	digit_nn.c:117: dbuf[3] = segs[best];
      00034B EF               [12]  984 	mov	a,r7
      00034C 90 08 82         [24]  985 	mov	dptr,#_segs
      00034F 93               [24]  986 	movc	a,@a+dptr
      000350 F5 13            [12]  987 	mov	(_dbuf + 0x0003), a
                                    988 ;	digit_nn.c:118: putc_('=');
      000352 75 82 3D         [24]  989 	mov	dpl, #0x3d
      000355 C0 07            [24]  990 	push	ar7
      000357 12 00 E7         [24]  991 	lcall	_putc_
      00035A D0 07            [24]  992 	pop	ar7
                                    993 ;	digit_nn.c:119: putc_('0' + best);
      00035C 74 30            [12]  994 	mov	a,#0x30
      00035E 2F               [12]  995 	add	a, r7
      00035F F5 82            [12]  996 	mov	dpl,a
      000361 12 00 E7         [24]  997 	lcall	_putc_
                                    998 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      000364 7F 00            [12]  999 	mov	r7,#0x00
      000366                       1000 00137$:
                                   1001 ;	digit_nn.c:121: u = (unsigned long)score[k];
      000366 EF               [12] 1002 	mov	a,r7
      000367 2F               [12] 1003 	add	a,r7
      000368 25 E0            [12] 1004 	add	a,acc
      00036A 24 8E            [12] 1005 	add	a, #_score
      00036C F9               [12] 1006 	mov	r1,a
      00036D 87 03            [24] 1007 	mov	ar3,@r1
      00036F 09               [12] 1008 	inc	r1
      000370 87 04            [24] 1009 	mov	ar4,@r1
      000372 09               [12] 1010 	inc	r1
      000373 87 05            [24] 1011 	mov	ar5,@r1
      000375 09               [12] 1012 	inc	r1
      000376 87 06            [24] 1013 	mov	ar6,@r1
      000378 19               [12] 1014 	dec	r1
      000379 19               [12] 1015 	dec	r1
      00037A 19               [12] 1016 	dec	r1
                                   1017 ;	digit_nn.c:122: putc_(' ');
      00037B 75 82 20         [24] 1018 	mov	dpl, #0x20
      00037E C0 07            [24] 1019 	push	ar7
      000380 C0 06            [24] 1020 	push	ar6
      000382 C0 05            [24] 1021 	push	ar5
      000384 C0 04            [24] 1022 	push	ar4
      000386 C0 03            [24] 1023 	push	ar3
      000388 12 00 E7         [24] 1024 	lcall	_putc_
      00038B D0 03            [24] 1025 	pop	ar3
      00038D D0 04            [24] 1026 	pop	ar4
      00038F D0 05            [24] 1027 	pop	ar5
                                   1028 ;	digit_nn.c:123: puthex((unsigned char)(u >> 16));
      000391 8D 82            [24] 1029 	mov	dpl,r5
      000393 C0 05            [24] 1030 	push	ar5
      000395 C0 04            [24] 1031 	push	ar4
      000397 C0 03            [24] 1032 	push	ar3
      000399 12 00 F0         [24] 1033 	lcall	_puthex
      00039C D0 03            [24] 1034 	pop	ar3
      00039E D0 04            [24] 1035 	pop	ar4
                                   1036 ;	digit_nn.c:124: puthex((unsigned char)(u >> 8));
      0003A0 8C 82            [24] 1037 	mov	dpl,r4
      0003A2 C0 04            [24] 1038 	push	ar4
      0003A4 C0 03            [24] 1039 	push	ar3
      0003A6 12 00 F0         [24] 1040 	lcall	_puthex
      0003A9 D0 03            [24] 1041 	pop	ar3
      0003AB D0 04            [24] 1042 	pop	ar4
      0003AD D0 05            [24] 1043 	pop	ar5
      0003AF D0 06            [24] 1044 	pop	ar6
                                   1045 ;	digit_nn.c:125: puthex((unsigned char)u);
      0003B1 8B 82            [24] 1046 	mov	dpl,r3
      0003B3 12 00 F0         [24] 1047 	lcall	_puthex
      0003B6 D0 07            [24] 1048 	pop	ar7
                                   1049 ;	digit_nn.c:120: for (k = 0; k < 10; k++) {
      0003B8 0F               [12] 1050 	inc	r7
      0003B9 BF 0A 00         [24] 1051 	cjne	r7,#0x0a,00357$
      0003BC                       1052 00357$:
      0003BC 40 A8            [24] 1053 	jc	00137$
                                   1054 ;	digit_nn.c:127: putc_('\r');
      0003BE 75 82 0D         [24] 1055 	mov	dpl, #0x0d
      0003C1 12 00 E7         [24] 1056 	lcall	_putc_
                                   1057 ;	digit_nn.c:128: putc_('\n');
      0003C4 75 82 0A         [24] 1058 	mov	dpl, #0x0a
      0003C7 12 00 E7         [24] 1059 	lcall	_putc_
                                   1060 ;	digit_nn.c:130: }
      0003CA 02 01 63         [24] 1061 	ljmp	00101$
                                   1062 	.area CSEG    (CODE)
                                   1063 	.area CONST   (CODE)
                                   1064 	.area CONST   (CODE)
      0003EE                       1065 _B1:
      0003EE BB FF                 1066 	.byte #0xbb, #0xff	; -69
      0003F0 62 00                 1067 	.byte #0x62, #0x00	;  98
      0003F2 D8 FF                 1068 	.byte #0xd8, #0xff	; -40
      0003F4 9D FF                 1069 	.byte #0x9d, #0xff	; -99
      0003F6 F0 FF                 1070 	.byte #0xf0, #0xff	; -16
      0003F8 F7 FF                 1071 	.byte #0xf7, #0xff	; -9
      0003FA 25 00                 1072 	.byte #0x25, #0x00	;  37
      0003FC 2B 00                 1073 	.byte #0x2b, #0x00	;  43
      0003FE F7 FF                 1074 	.byte #0xf7, #0xff	; -9
      000400 CF FF                 1075 	.byte #0xcf, #0xff	; -49
      000402 18 00                 1076 	.byte #0x18, #0x00	;  24
      000404 E9 FF                 1077 	.byte #0xe9, #0xff	; -23
      000406 BB FF                 1078 	.byte #0xbb, #0xff	; -69
      000408 28 00                 1079 	.byte #0x28, #0x00	;  40
      00040A FD FF                 1080 	.byte #0xfd, #0xff	; -3
      00040C 39 00                 1081 	.byte #0x39, #0x00	;  57
      00040E F2 FF                 1082 	.byte #0xf2, #0xff	; -14
      000410 D3 FF                 1083 	.byte #0xd3, #0xff	; -45
      000412 BD FF                 1084 	.byte #0xbd, #0xff	; -67
      000414 E2 FF                 1085 	.byte #0xe2, #0xff	; -30
      000416 DA FF                 1086 	.byte #0xda, #0xff	; -38
      000418 CE FF                 1087 	.byte #0xce, #0xff	; -50
      00041A 01 00                 1088 	.byte #0x01, #0x00	;  1
      00041C 92 FF                 1089 	.byte #0x92, #0xff	; -110
                                   1090 	.area CSEG    (CODE)
                                   1091 	.area CONST   (CODE)
      00041E                       1092 _W1:
      00041E F0                    1093 	.db #0xf0	; -16
      00041F F9                    1094 	.db #0xf9	; -7
      000420 F6                    1095 	.db #0xf6	; -10
      000421 DB                    1096 	.db #0xdb	; -37
      000422 F9                    1097 	.db #0xf9	; -7
      000423 0A                    1098 	.db #0x0a	;  10
      000424 21                    1099 	.db #0x21	;  33
      000425 0C                    1100 	.db #0x0c	;  12
      000426 61                    1101 	.db #0x61	;  97	'a'
      000427 11                    1102 	.db #0x11	;  17
      000428 0C                    1103 	.db #0x0c	;  12
      000429 BC                    1104 	.db #0xbc	; -68
      00042A 00                    1105 	.db #0x00	;  0
      00042B EF                    1106 	.db #0xef	; -17
      00042C 00                    1107 	.db #0x00	;  0
      00042D 0D                    1108 	.db #0x0d	;  13
      00042E EB                    1109 	.db #0xeb	; -21
      00042F 00                    1110 	.db #0x00	;  0
      000430 1B                    1111 	.db #0x1b	;  27
      000431 47                    1112 	.db #0x47	;  71	'G'
      000432 04                    1113 	.db #0x04	;  4
      000433 EE                    1114 	.db #0xee	; -18
      000434 4B                    1115 	.db #0x4b	;  75	'K'
      000435 D7                    1116 	.db #0xd7	; -41
      000436 DE                    1117 	.db #0xde	; -34
      000437 06                    1118 	.db #0x06	;  6
      000438 ED                    1119 	.db #0xed	; -19
      000439 04                    1120 	.db #0x04	;  4
      00043A CE                    1121 	.db #0xce	; -50
      00043B E9                    1122 	.db #0xe9	; -23
      00043C 4F                    1123 	.db #0x4f	;  79	'O'
      00043D EE                    1124 	.db #0xee	; -18
      00043E 62                    1125 	.db #0x62	;  98	'b'
      00043F 3D                    1126 	.db #0x3d	;  61
      000440 0B                    1127 	.db #0x0b	;  11
      000441 C7                    1128 	.db #0xc7	; -57
      000442 F5                    1129 	.db #0xf5	; -11
      000443 E8                    1130 	.db #0xe8	; -24
      000444 00                    1131 	.db #0x00	;  0
      000445 07                    1132 	.db #0x07	;  7
      000446 DE                    1133 	.db #0xde	; -34
      000447 EC                    1134 	.db #0xec	; -20
      000448 1E                    1135 	.db #0x1e	;  30
      000449 47                    1136 	.db #0x47	;  71	'G'
      00044A EA                    1137 	.db #0xea	; -22
      00044B 00                    1138 	.db #0x00	;  0
      00044C 26                    1139 	.db #0x26	;  38
      00044D F7                    1140 	.db #0xf7	; -9
      00044E EF                    1141 	.db #0xef	; -17
      00044F DA                    1142 	.db #0xda	; -38
      000450 0F                    1143 	.db #0x0f	;  15
      000451 F6                    1144 	.db #0xf6	; -10
      000452 E5                    1145 	.db #0xe5	; -27
      000453 1A                    1146 	.db #0x1a	;  26
      000454 D1                    1147 	.db #0xd1	; -47
      000455 00                    1148 	.db #0x00	;  0
      000456 49                    1149 	.db #0x49	;  73	'I'
      000457 E2                    1150 	.db #0xe2	; -30
      000458 DB                    1151 	.db #0xdb	; -37
      000459 B9                    1152 	.db #0xb9	; -71
      00045A FF                    1153 	.db #0xff	; -1
      00045B DA                    1154 	.db #0xda	; -38
      00045C 00                    1155 	.db #0x00	;  0
      00045D B9                    1156 	.db #0xb9	; -71
      00045E E4                    1157 	.db #0xe4	; -28
      00045F FD                    1158 	.db #0xfd	; -3
      000460 F6                    1159 	.db #0xf6	; -10
      000461 56                    1160 	.db #0x56	;  86	'V'
      000462 EA                    1161 	.db #0xea	; -22
      000463 FC                    1162 	.db #0xfc	; -4
      000464 25                    1163 	.db #0x25	;  37
      000465 36                    1164 	.db #0x36	;  54	'6'
      000466 55                    1165 	.db #0x55	;  85	'U'
      000467 F4                    1166 	.db #0xf4	; -12
      000468 FC                    1167 	.db #0xfc	; -4
      000469 2B                    1168 	.db #0x2b	;  43
      00046A F8                    1169 	.db #0xf8	; -8
      00046B 0A                    1170 	.db #0x0a	;  10
      00046C FD                    1171 	.db #0xfd	; -3
      00046D CF                    1172 	.db #0xcf	; -49
      00046E 66                    1173 	.db #0x66	;  102	'f'
      00046F FB                    1174 	.db #0xfb	; -5
      000470 F6                    1175 	.db #0xf6	; -10
      000471 BF                    1176 	.db #0xbf	; -65
      000472 EE                    1177 	.db #0xee	; -18
      000473 E9                    1178 	.db #0xe9	; -23
      000474 00                    1179 	.db #0x00	;  0
      000475 FB                    1180 	.db #0xfb	; -5
      000476 F1                    1181 	.db #0xf1	; -15
      000477 11                    1182 	.db #0x11	;  17
      000478 EF                    1183 	.db #0xef	; -17
      000479 46                    1184 	.db #0x46	;  70	'F'
      00047A EA                    1185 	.db #0xea	; -22
      00047B 22                    1186 	.db #0x22	;  34
      00047C 07                    1187 	.db #0x07	;  7
      00047D EF                    1188 	.db #0xef	; -17
      00047E D3                    1189 	.db #0xd3	; -45
      00047F F2                    1190 	.db #0xf2	; -14
      000480 F4                    1191 	.db #0xf4	; -12
      000481 E5                    1192 	.db #0xe5	; -27
      000482 02                    1193 	.db #0x02	;  2
      000483 09                    1194 	.db #0x09	;  9
      000484 02                    1195 	.db #0x02	;  2
      000485 0A                    1196 	.db #0x0a	;  10
      000486 2C                    1197 	.db #0x2c	;  44
      000487 FC                    1198 	.db #0xfc	; -4
      000488 F0                    1199 	.db #0xf0	; -16
      000489 C9                    1200 	.db #0xc9	; -55
      00048A F8                    1201 	.db #0xf8	; -8
      00048B E4                    1202 	.db #0xe4	; -28
      00048C 00                    1203 	.db #0x00	;  0
      00048D EC                    1204 	.db #0xec	; -20
      00048E F3                    1205 	.db #0xf3	; -13
      00048F EB                    1206 	.db #0xeb	; -21
      000490 F6                    1207 	.db #0xf6	; -10
      000491 04                    1208 	.db #0x04	;  4
      000492 07                    1209 	.db #0x07	;  7
      000493 E5                    1210 	.db #0xe5	; -27
      000494 1B                    1211 	.db #0x1b	;  27
      000495 DA                    1212 	.db #0xda	; -38
      000496 F8                    1213 	.db #0xf8	; -8
      000497 27                    1214 	.db #0x27	;  39
      000498 01                    1215 	.db #0x01	;  1
      000499 40                    1216 	.db #0x40	;  64
      00049A 16                    1217 	.db #0x16	;  22
      00049B 13                    1218 	.db #0x13	;  19
      00049C 37                    1219 	.db #0x37	;  55	'7'
      00049D 01                    1220 	.db #0x01	;  1
      00049E 1F                    1221 	.db #0x1f	;  31
      00049F FA                    1222 	.db #0xfa	; -6
      0004A0 1B                    1223 	.db #0x1b	;  27
      0004A1 76                    1224 	.db #0x76	;  118	'v'
      0004A2 F4                    1225 	.db #0xf4	; -12
      0004A3 02                    1226 	.db #0x02	;  2
      0004A4 00                    1227 	.db #0x00	;  0
      0004A5 0B                    1228 	.db #0x0b	;  11
      0004A6 F3                    1229 	.db #0xf3	; -13
      0004A7 F6                    1230 	.db #0xf6	; -10
      0004A8 EE                    1231 	.db #0xee	; -18
      0004A9 1D                    1232 	.db #0x1d	;  29
      0004AA 0F                    1233 	.db #0x0f	;  15
      0004AB 05                    1234 	.db #0x05	;  5
      0004AC 3F                    1235 	.db #0x3f	;  63
      0004AD EF                    1236 	.db #0xef	; -17
      0004AE E6                    1237 	.db #0xe6	; -26
      0004AF 05                    1238 	.db #0x05	;  5
      0004B0 FE                    1239 	.db #0xfe	; -2
      0004B1 2B                    1240 	.db #0x2b	;  43
      0004B2 2A                    1241 	.db #0x2a	;  42
      0004B3 00                    1242 	.db #0x00	;  0
      0004B4 4C                    1243 	.db #0x4c	;  76	'L'
      0004B5 F5                    1244 	.db #0xf5	; -11
      0004B6 FE                    1245 	.db #0xfe	; -2
      0004B7 14                    1246 	.db #0x14	;  20
      0004B8 DD                    1247 	.db #0xdd	; -35
      0004B9 40                    1248 	.db #0x40	;  64
      0004BA E9                    1249 	.db #0xe9	; -23
      0004BB F1                    1250 	.db #0xf1	; -15
      0004BC 00                    1251 	.db #0x00	;  0
      0004BD F2                    1252 	.db #0xf2	; -14
      0004BE EA                    1253 	.db #0xea	; -22
      0004BF 06                    1254 	.db #0x06	;  6
      0004C0 1C                    1255 	.db #0x1c	;  28
      0004C1 1E                    1256 	.db #0x1e	;  30
      0004C2 FC                    1257 	.db #0xfc	; -4
      0004C3 EA                    1258 	.db #0xea	; -22
      0004C4 24                    1259 	.db #0x24	;  36
      0004C5 F8                    1260 	.db #0xf8	; -8
      0004C6 EF                    1261 	.db #0xef	; -17
      0004C7 FA                    1262 	.db #0xfa	; -6
      0004C8 F6                    1263 	.db #0xf6	; -10
      0004C9 40                    1264 	.db #0x40	;  64
      0004CA 54                    1265 	.db #0x54	;  84	'T'
      0004CB 29                    1266 	.db #0x29	;  41
      0004CC 9C                    1267 	.db #0x9c	; -100
      0004CD 0E                    1268 	.db #0x0e	;  14
      0004CE 08                    1269 	.db #0x08	;  8
      0004CF 09                    1270 	.db #0x09	;  9
      0004D0 EF                    1271 	.db #0xef	; -17
      0004D1 1D                    1272 	.db #0x1d	;  29
      0004D2 0C                    1273 	.db #0x0c	;  12
      0004D3 FA                    1274 	.db #0xfa	; -6
      0004D4 00                    1275 	.db #0x00	;  0
      0004D5 E9                    1276 	.db #0xe9	; -23
      0004D6 EA                    1277 	.db #0xea	; -22
      0004D7 00                    1278 	.db #0x00	;  0
      0004D8 00                    1279 	.db #0x00	;  0
      0004D9 11                    1280 	.db #0x11	;  17
      0004DA FD                    1281 	.db #0xfd	; -3
      0004DB D0                    1282 	.db #0xd0	; -48
      0004DC 20                    1283 	.db #0x20	;  32
      0004DD 46                    1284 	.db #0x46	;  70	'F'
      0004DE 69                    1285 	.db #0x69	;  105	'i'
      0004DF FC                    1286 	.db #0xfc	; -4
      0004E0 0F                    1287 	.db #0x0f	;  15
      0004E1 33                    1288 	.db #0x33	;  51	'3'
      0004E2 5E                    1289 	.db #0x5e	;  94
      0004E3 14                    1290 	.db #0x14	;  20
      0004E4 02                    1291 	.db #0x02	;  2
      0004E5 FF                    1292 	.db #0xff	; -1
      0004E6 33                    1293 	.db #0x33	;  51	'3'
      0004E7 00                    1294 	.db #0x00	;  0
      0004E8 0B                    1295 	.db #0x0b	;  11
      0004E9 FD                    1296 	.db #0xfd	; -3
      0004EA F9                    1297 	.db #0xf9	; -7
      0004EB 08                    1298 	.db #0x08	;  8
      0004EC 00                    1299 	.db #0x00	;  0
      0004ED F4                    1300 	.db #0xf4	; -12
      0004EE EE                    1301 	.db #0xee	; -18
      0004EF 13                    1302 	.db #0x13	;  19
      0004F0 62                    1303 	.db #0x62	;  98	'b'
      0004F1 0F                    1304 	.db #0x0f	;  15
      0004F2 FF                    1305 	.db #0xff	; -1
      0004F3 D7                    1306 	.db #0xd7	; -41
      0004F4 21                    1307 	.db #0x21	;  33
      0004F5 0A                    1308 	.db #0x0a	;  10
      0004F6 DA                    1309 	.db #0xda	; -38
      0004F7 F7                    1310 	.db #0xf7	; -9
      0004F8 EB                    1311 	.db #0xeb	; -21
      0004F9 27                    1312 	.db #0x27	;  39
      0004FA 40                    1313 	.db #0x40	;  64
      0004FB 23                    1314 	.db #0x23	;  35
      0004FC 0E                    1315 	.db #0x0e	;  14
      0004FD 0E                    1316 	.db #0x0e	;  14
      0004FE 35                    1317 	.db #0x35	;  53	'5'
      0004FF 07                    1318 	.db #0x07	;  7
      000500 F2                    1319 	.db #0xf2	; -14
      000501 03                    1320 	.db #0x03	;  3
      000502 FB                    1321 	.db #0xfb	; -5
      000503 17                    1322 	.db #0x17	;  23
      000504 00                    1323 	.db #0x00	;  0
      000505 FE                    1324 	.db #0xfe	; -2
      000506 F0                    1325 	.db #0xf0	; -16
      000507 06                    1326 	.db #0x06	;  6
      000508 15                    1327 	.db #0x15	;  21
      000509 EC                    1328 	.db #0xec	; -20
      00050A 06                    1329 	.db #0x06	;  6
      00050B 61                    1330 	.db #0x61	;  97	'a'
      00050C 15                    1331 	.db #0x15	;  21
      00050D DA                    1332 	.db #0xda	; -38
      00050E E6                    1333 	.db #0xe6	; -26
      00050F D3                    1334 	.db #0xd3	; -45
      000510 03                    1335 	.db #0x03	;  3
      000511 E3                    1336 	.db #0xe3	; -29
      000512 ED                    1337 	.db #0xed	; -19
      000513 01                    1338 	.db #0x01	;  1
      000514 1F                    1339 	.db #0x1f	;  31
      000515 E0                    1340 	.db #0xe0	; -32
      000516 B7                    1341 	.db #0xb7	; -73
      000517 EF                    1342 	.db #0xef	; -17
      000518 4A                    1343 	.db #0x4a	;  74	'J'
      000519 D7                    1344 	.db #0xd7	; -41
      00051A AA                    1345 	.db #0xaa	; -86
      00051B 07                    1346 	.db #0x07	;  7
      00051C 00                    1347 	.db #0x00	;  0
      00051D 0A                    1348 	.db #0x0a	;  10
      00051E EC                    1349 	.db #0xec	; -20
      00051F 00                    1350 	.db #0x00	;  0
      000520 47                    1351 	.db #0x47	;  71	'G'
      000521 EA                    1352 	.db #0xea	; -22
      000522 04                    1353 	.db #0x04	;  4
      000523 F5                    1354 	.db #0xf5	; -11
      000524 1F                    1355 	.db #0x1f	;  31
      000525 F2                    1356 	.db #0xf2	; -14
      000526 FA                    1357 	.db #0xfa	; -6
      000527 E6                    1358 	.db #0xe6	; -26
      000528 09                    1359 	.db #0x09	;  9
      000529 1B                    1360 	.db #0x1b	;  27
      00052A E5                    1361 	.db #0xe5	; -27
      00052B 0F                    1362 	.db #0x0f	;  15
      00052C 1C                    1363 	.db #0x1c	;  28
      00052D FE                    1364 	.db #0xfe	; -2
      00052E CA                    1365 	.db #0xca	; -54
      00052F 50                    1366 	.db #0x50	;  80	'P'
      000530 BA                    1367 	.db #0xba	; -70
      000531 FF                    1368 	.db #0xff	; -1
      000532 E6                    1369 	.db #0xe6	; -26
      000533 C9                    1370 	.db #0xc9	; -55
      000534 00                    1371 	.db #0x00	;  0
      000535 06                    1372 	.db #0x06	;  6
      000536 F0                    1373 	.db #0xf0	; -16
      000537 1E                    1374 	.db #0x1e	;  30
      000538 01                    1375 	.db #0x01	;  1
      000539 1B                    1376 	.db #0x1b	;  27
      00053A 1E                    1377 	.db #0x1e	;  30
      00053B 07                    1378 	.db #0x07	;  7
      00053C 30                    1379 	.db #0x30	;  48	'0'
      00053D E8                    1380 	.db #0xe8	; -24
      00053E E5                    1381 	.db #0xe5	; -27
      00053F E8                    1382 	.db #0xe8	; -24
      000540 EF                    1383 	.db #0xef	; -17
      000541 25                    1384 	.db #0x25	;  37
      000542 E0                    1385 	.db #0xe0	; -32
      000543 12                    1386 	.db #0x12	;  18
      000544 9E                    1387 	.db #0x9e	; -98
      000545 05                    1388 	.db #0x05	;  5
      000546 D7                    1389 	.db #0xd7	; -41
      000547 1B                    1390 	.db #0x1b	;  27
      000548 F9                    1391 	.db #0xf9	; -7
      000549 08                    1392 	.db #0x08	;  8
      00054A EF                    1393 	.db #0xef	; -17
      00054B C6                    1394 	.db #0xc6	; -58
      00054C 00                    1395 	.db #0x00	;  0
      00054D F6                    1396 	.db #0xf6	; -10
      00054E EF                    1397 	.db #0xef	; -17
      00054F 03                    1398 	.db #0x03	;  3
      000550 E5                    1399 	.db #0xe5	; -27
      000551 0A                    1400 	.db #0x0a	;  10
      000552 29                    1401 	.db #0x29	;  41
      000553 DD                    1402 	.db #0xdd	; -35
      000554 11                    1403 	.db #0x11	;  17
      000555 48                    1404 	.db #0x48	;  72	'H'
      000556 47                    1405 	.db #0x47	;  71	'G'
      000557 EE                    1406 	.db #0xee	; -18
      000558 1B                    1407 	.db #0x1b	;  27
      000559 05                    1408 	.db #0x05	;  5
      00055A BB                    1409 	.db #0xbb	; -69
      00055B F7                    1410 	.db #0xf7	; -9
      00055C E9                    1411 	.db #0xe9	; -23
      00055D 0E                    1412 	.db #0x0e	;  14
      00055E E2                    1413 	.db #0xe2	; -30
      00055F FF                    1414 	.db #0xff	; -1
      000560 00                    1415 	.db #0x00	;  0
      000561 0B                    1416 	.db #0x0b	;  11
      000562 E3                    1417 	.db #0xe3	; -29
      000563 BD                    1418 	.db #0xbd	; -67
      000564 00                    1419 	.db #0x00	;  0
      000565 E3                    1420 	.db #0xe3	; -29
      000566 F2                    1421 	.db #0xf2	; -14
      000567 09                    1422 	.db #0x09	;  9
      000568 21                    1423 	.db #0x21	;  33
      000569 06                    1424 	.db #0x06	;  6
      00056A 2B                    1425 	.db #0x2b	;  43
      00056B CA                    1426 	.db #0xca	; -54
      00056C 03                    1427 	.db #0x03	;  3
      00056D E4                    1428 	.db #0xe4	; -28
      00056E CB                    1429 	.db #0xcb	; -53
      00056F 0F                    1430 	.db #0x0f	;  15
      000570 A8                    1431 	.db #0xa8	; -88
      000571 21                    1432 	.db #0x21	;  33
      000572 A0                    1433 	.db #0xa0	; -96
      000573 05                    1434 	.db #0x05	;  5
      000574 FD                    1435 	.db #0xfd	; -3
      000575 15                    1436 	.db #0x15	;  21
      000576 0A                    1437 	.db #0x0a	;  10
      000577 F4                    1438 	.db #0xf4	; -12
      000578 07                    1439 	.db #0x07	;  7
      000579 40                    1440 	.db #0x40	;  64
      00057A DD                    1441 	.db #0xdd	; -35
      00057B D9                    1442 	.db #0xd9	; -39
      00057C 00                    1443 	.db #0x00	;  0
      00057D 05                    1444 	.db #0x05	;  5
      00057E E6                    1445 	.db #0xe6	; -26
      00057F 13                    1446 	.db #0x13	;  19
      000580 E4                    1447 	.db #0xe4	; -28
      000581 0F                    1448 	.db #0x0f	;  15
      000582 FD                    1449 	.db #0xfd	; -3
      000583 3B                    1450 	.db #0x3b	;  59
      000584 17                    1451 	.db #0x17	;  23
      000585 EA                    1452 	.db #0xea	; -22
      000586 0B                    1453 	.db #0x0b	;  11
      000587 DF                    1454 	.db #0xdf	; -33
      000588 F8                    1455 	.db #0xf8	; -8
      000589 3F                    1456 	.db #0x3f	;  63
      00058A E9                    1457 	.db #0xe9	; -23
      00058B 07                    1458 	.db #0x07	;  7
      00058C 1D                    1459 	.db #0x1d	;  29
      00058D E8                    1460 	.db #0xe8	; -24
      00058E 08                    1461 	.db #0x08	;  8
      00058F 47                    1462 	.db #0x47	;  71	'G'
      000590 49                    1463 	.db #0x49	;  73	'I'
      000591 05                    1464 	.db #0x05	;  5
      000592 D0                    1465 	.db #0xd0	; -48
      000593 1B                    1466 	.db #0x1b	;  27
      000594 00                    1467 	.db #0x00	;  0
      000595 E2                    1468 	.db #0xe2	; -30
      000596 03                    1469 	.db #0x03	;  3
      000597 C5                    1470 	.db #0xc5	; -59
      000598 FF                    1471 	.db #0xff	; -1
      000599 F5                    1472 	.db #0xf5	; -11
      00059A E1                    1473 	.db #0xe1	; -31
      00059B 18                    1474 	.db #0x18	;  24
      00059C C5                    1475 	.db #0xc5	; -59
      00059D 1C                    1476 	.db #0x1c	;  28
      00059E 0C                    1477 	.db #0x0c	;  12
      00059F F5                    1478 	.db #0xf5	; -11
      0005A0 0C                    1479 	.db #0x0c	;  12
      0005A1 3B                    1480 	.db #0x3b	;  59
      0005A2 EE                    1481 	.db #0xee	; -18
      0005A3 19                    1482 	.db #0x19	;  25
      0005A4 16                    1483 	.db #0x16	;  22
      0005A5 07                    1484 	.db #0x07	;  7
      0005A6 17                    1485 	.db #0x17	;  23
      0005A7 37                    1486 	.db #0x37	;  55	'7'
      0005A8 A9                    1487 	.db #0xa9	; -87
      0005A9 F9                    1488 	.db #0xf9	; -7
      0005AA F7                    1489 	.db #0xf7	; -9
      0005AB 42                    1490 	.db #0x42	;  66	'B'
      0005AC 00                    1491 	.db #0x00	;  0
      0005AD 0A                    1492 	.db #0x0a	;  10
      0005AE 23                    1493 	.db #0x23	;  35
      0005AF 16                    1494 	.db #0x16	;  22
      0005B0 EF                    1495 	.db #0xef	; -17
      0005B1 07                    1496 	.db #0x07	;  7
      0005B2 B1                    1497 	.db #0xb1	; -79
      0005B3 F1                    1498 	.db #0xf1	; -15
      0005B4 ED                    1499 	.db #0xed	; -19
      0005B5 DD                    1500 	.db #0xdd	; -35
      0005B6 EA                    1501 	.db #0xea	; -22
      0005B7 EF                    1502 	.db #0xef	; -17
      0005B8 E7                    1503 	.db #0xe7	; -25
      0005B9 07                    1504 	.db #0x07	;  7
      0005BA FF                    1505 	.db #0xff	; -1
      0005BB 27                    1506 	.db #0x27	;  39
      0005BC B6                    1507 	.db #0xb6	; -74
      0005BD FA                    1508 	.db #0xfa	; -6
      0005BE FD                    1509 	.db #0xfd	; -3
      0005BF CD                    1510 	.db #0xcd	; -51
      0005C0 2B                    1511 	.db #0x2b	;  43
      0005C1 E6                    1512 	.db #0xe6	; -26
      0005C2 EB                    1513 	.db #0xeb	; -21
      0005C3 3E                    1514 	.db #0x3e	;  62
      0005C4 00                    1515 	.db #0x00	;  0
      0005C5 19                    1516 	.db #0x19	;  25
      0005C6 12                    1517 	.db #0x12	;  18
      0005C7 31                    1518 	.db #0x31	;  49	'1'
      0005C8 31                    1519 	.db #0x31	;  49	'1'
      0005C9 2D                    1520 	.db #0x2d	;  45
      0005CA BA                    1521 	.db #0xba	; -70
      0005CB F1                    1522 	.db #0xf1	; -15
      0005CC F9                    1523 	.db #0xf9	; -7
      0005CD 41                    1524 	.db #0x41	;  65	'A'
      0005CE 39                    1525 	.db #0x39	;  57	'9'
      0005CF FB                    1526 	.db #0xfb	; -5
      0005D0 49                    1527 	.db #0x49	;  73	'I'
      0005D1 FA                    1528 	.db #0xfa	; -6
      0005D2 F0                    1529 	.db #0xf0	; -16
      0005D3 01                    1530 	.db #0x01	;  1
      0005D4 05                    1531 	.db #0x05	;  5
      0005D5 ED                    1532 	.db #0xed	; -19
      0005D6 F8                    1533 	.db #0xf8	; -8
      0005D7 F7                    1534 	.db #0xf7	; -9
      0005D8 F5                    1535 	.db #0xf5	; -11
      0005D9 12                    1536 	.db #0x12	;  18
      0005DA EF                    1537 	.db #0xef	; -17
      0005DB 20                    1538 	.db #0x20	;  32
      0005DC 00                    1539 	.db #0x00	;  0
      0005DD D7                    1540 	.db #0xd7	; -41
      0005DE E0                    1541 	.db #0xe0	; -32
      0005DF 01                    1542 	.db #0x01	;  1
      0005E0 21                    1543 	.db #0x21	;  33
      0005E1 44                    1544 	.db #0x44	;  68	'D'
      0005E2 A3                    1545 	.db #0xa3	; -93
      0005E3 F2                    1546 	.db #0xf2	; -14
      0005E4 1E                    1547 	.db #0x1e	;  30
      0005E5 E8                    1548 	.db #0xe8	; -24
      0005E6 D2                    1549 	.db #0xd2	; -46
      0005E7 FA                    1550 	.db #0xfa	; -6
      0005E8 81                    1551 	.db #0x81	; -127
      0005E9 37                    1552 	.db #0x37	;  55	'7'
      0005EA F9                    1553 	.db #0xf9	; -7
      0005EB F4                    1554 	.db #0xf4	; -12
      0005EC FE                    1555 	.db #0xfe	; -2
      0005ED 18                    1556 	.db #0x18	;  24
      0005EE D4                    1557 	.db #0xd4	; -44
      0005EF 0D                    1558 	.db #0x0d	;  13
      0005F0 0B                    1559 	.db #0x0b	;  11
      0005F1 16                    1560 	.db #0x16	;  22
      0005F2 EA                    1561 	.db #0xea	; -22
      0005F3 D7                    1562 	.db #0xd7	; -41
      0005F4 00                    1563 	.db #0x00	;  0
      0005F5 E4                    1564 	.db #0xe4	; -28
      0005F6 C5                    1565 	.db #0xc5	; -59
      0005F7 02                    1566 	.db #0x02	;  2
      0005F8 17                    1567 	.db #0x17	;  23
      0005F9 2E                    1568 	.db #0x2e	;  46
      0005FA F0                    1569 	.db #0xf0	; -16
      0005FB 5F                    1570 	.db #0x5f	;  95
      0005FC 13                    1571 	.db #0x13	;  19
      0005FD E8                    1572 	.db #0xe8	; -24
      0005FE 20                    1573 	.db #0x20	;  32
      0005FF 0A                    1574 	.db #0x0a	;  10
      000600 04                    1575 	.db #0x04	;  4
      000601 2A                    1576 	.db #0x2a	;  42
      000602 01                    1577 	.db #0x01	;  1
      000603 29                    1578 	.db #0x29	;  41
      000604 1D                    1579 	.db #0x1d	;  29
      000605 F7                    1580 	.db #0xf7	; -9
      000606 24                    1581 	.db #0x24	;  36
      000607 10                    1582 	.db #0x10	;  16
      000608 4A                    1583 	.db #0x4a	;  74	'J'
      000609 1C                    1584 	.db #0x1c	;  28
      00060A 29                    1585 	.db #0x29	;  41
      00060B F5                    1586 	.db #0xf5	; -11
      00060C 00                    1587 	.db #0x00	;  0
      00060D EB                    1588 	.db #0xeb	; -21
      00060E D3                    1589 	.db #0xd3	; -45
      00060F 97                    1590 	.db #0x97	; -105
      000610 0E                    1591 	.db #0x0e	;  14
      000611 F3                    1592 	.db #0xf3	; -13
      000612 1F                    1593 	.db #0x1f	;  31
      000613 F6                    1594 	.db #0xf6	; -10
      000614 B9                    1595 	.db #0xb9	; -71
      000615 19                    1596 	.db #0x19	;  25
      000616 0D                    1597 	.db #0x0d	;  13
      000617 F0                    1598 	.db #0xf0	; -16
      000618 01                    1599 	.db #0x01	;  1
      000619 42                    1600 	.db #0x42	;  66	'B'
      00061A 0A                    1601 	.db #0x0a	;  10
      00061B F7                    1602 	.db #0xf7	; -9
      00061C 10                    1603 	.db #0x10	;  16
      00061D 12                    1604 	.db #0x12	;  18
      00061E 02                    1605 	.db #0x02	;  2
      00061F E0                    1606 	.db #0xe0	; -32
      000620 BF                    1607 	.db #0xbf	; -65
      000621 F9                    1608 	.db #0xf9	; -7
      000622 48                    1609 	.db #0x48	;  72	'H'
      000623 05                    1610 	.db #0x05	;  5
      000624 00                    1611 	.db #0x00	;  0
      000625 F5                    1612 	.db #0xf5	; -11
      000626 EF                    1613 	.db #0xef	; -17
      000627 0D                    1614 	.db #0x0d	;  13
      000628 08                    1615 	.db #0x08	;  8
      000629 B5                    1616 	.db #0xb5	; -75
      00062A 4F                    1617 	.db #0x4f	;  79	'O'
      00062B F8                    1618 	.db #0xf8	; -8
      00062C 92                    1619 	.db #0x92	; -110
      00062D E8                    1620 	.db #0xe8	; -24
      00062E D8                    1621 	.db #0xd8	; -40
      00062F ED                    1622 	.db #0xed	; -19
      000630 F6                    1623 	.db #0xf6	; -10
      000631 22                    1624 	.db #0x22	;  34
      000632 12                    1625 	.db #0x12	;  18
      000633 2A                    1626 	.db #0x2a	;  42
      000634 EF                    1627 	.db #0xef	; -17
      000635 CA                    1628 	.db #0xca	; -54
      000636 02                    1629 	.db #0x02	;  2
      000637 F5                    1630 	.db #0xf5	; -11
      000638 2A                    1631 	.db #0x2a	;  42
      000639 08                    1632 	.db #0x08	;  8
      00063A 1A                    1633 	.db #0x1a	;  26
      00063B 10                    1634 	.db #0x10	;  16
      00063C 00                    1635 	.db #0x00	;  0
      00063D 3F                    1636 	.db #0x3f	;  63
      00063E ED                    1637 	.db #0xed	; -19
      00063F 30                    1638 	.db #0x30	;  48	'0'
      000640 1D                    1639 	.db #0x1d	;  29
      000641 F2                    1640 	.db #0xf2	; -14
      000642 52                    1641 	.db #0x52	;  82	'R'
      000643 13                    1642 	.db #0x13	;  19
      000644 DB                    1643 	.db #0xdb	; -37
      000645 38                    1644 	.db #0x38	;  56	'8'
      000646 35                    1645 	.db #0x35	;  53	'5'
      000647 C8                    1646 	.db #0xc8	; -56
      000648 3A                    1647 	.db #0x3a	;  58
      000649 08                    1648 	.db #0x08	;  8
      00064A 14                    1649 	.db #0x14	;  20
      00064B 38                    1650 	.db #0x38	;  56	'8'
      00064C 11                    1651 	.db #0x11	;  17
      00064D B9                    1652 	.db #0xb9	; -71
      00064E 17                    1653 	.db #0x17	;  23
      00064F FA                    1654 	.db #0xfa	; -6
      000650 EE                    1655 	.db #0xee	; -18
      000651 18                    1656 	.db #0x18	;  24
      000652 16                    1657 	.db #0x16	;  22
      000653 19                    1658 	.db #0x19	;  25
      000654 00                    1659 	.db #0x00	;  0
      000655 F3                    1660 	.db #0xf3	; -13
      000656 E5                    1661 	.db #0xe5	; -27
      000657 E6                    1662 	.db #0xe6	; -26
      000658 00                    1663 	.db #0x00	;  0
      000659 FE                    1664 	.db #0xfe	; -2
      00065A 3E                    1665 	.db #0x3e	;  62
      00065B 14                    1666 	.db #0x14	;  20
      00065C F2                    1667 	.db #0xf2	; -14
      00065D ED                    1668 	.db #0xed	; -19
      00065E F5                    1669 	.db #0xf5	; -11
      00065F C8                    1670 	.db #0xc8	; -56
      000660 AD                    1671 	.db #0xad	; -83
      000661 13                    1672 	.db #0x13	;  19
      000662 0C                    1673 	.db #0x0c	;  12
      000663 17                    1674 	.db #0x17	;  23
      000664 0E                    1675 	.db #0x0e	;  14
      000665 10                    1676 	.db #0x10	;  16
      000666 03                    1677 	.db #0x03	;  3
      000667 E9                    1678 	.db #0xe9	; -23
      000668 04                    1679 	.db #0x04	;  4
      000669 FA                    1680 	.db #0xfa	; -6
      00066A 06                    1681 	.db #0x06	;  6
      00066B 13                    1682 	.db #0x13	;  19
      00066C 00                    1683 	.db #0x00	;  0
      00066D E5                    1684 	.db #0xe5	; -27
      00066E 1C                    1685 	.db #0x1c	;  28
      00066F 10                    1686 	.db #0x10	;  16
      000670 3F                    1687 	.db #0x3f	;  63
      000671 2A                    1688 	.db #0x2a	;  42
      000672 F4                    1689 	.db #0xf4	; -12
      000673 1A                    1690 	.db #0x1a	;  26
      000674 F5                    1691 	.db #0xf5	; -11
      000675 D2                    1692 	.db #0xd2	; -46
      000676 FE                    1693 	.db #0xfe	; -2
      000677 79                    1694 	.db #0x79	;  121	'y'
      000678 FA                    1695 	.db #0xfa	; -6
      000679 FA                    1696 	.db #0xfa	; -6
      00067A 07                    1697 	.db #0x07	;  7
      00067B BE                    1698 	.db #0xbe	; -66
      00067C 0B                    1699 	.db #0x0b	;  11
      00067D EC                    1700 	.db #0xec	; -20
      00067E 00                    1701 	.db #0x00	;  0
      00067F D2                    1702 	.db #0xd2	; -46
      000680 45                    1703 	.db #0x45	;  69	'E'
      000681 12                    1704 	.db #0x12	;  18
      000682 76                    1705 	.db #0x76	;  118	'v'
      000683 09                    1706 	.db #0x09	;  9
      000684 00                    1707 	.db #0x00	;  0
      000685 EF                    1708 	.db #0xef	; -17
      000686 11                    1709 	.db #0x11	;  17
      000687 A4                    1710 	.db #0xa4	; -92
      000688 19                    1711 	.db #0x19	;  25
      000689 01                    1712 	.db #0x01	;  1
      00068A F5                    1713 	.db #0xf5	; -11
      00068B FA                    1714 	.db #0xfa	; -6
      00068C FD                    1715 	.db #0xfd	; -3
      00068D F2                    1716 	.db #0xf2	; -14
      00068E FF                    1717 	.db #0xff	; -1
      00068F 4B                    1718 	.db #0x4b	;  75	'K'
      000690 01                    1719 	.db #0x01	;  1
      000691 1D                    1720 	.db #0x1d	;  29
      000692 07                    1721 	.db #0x07	;  7
      000693 E4                    1722 	.db #0xe4	; -28
      000694 1D                    1723 	.db #0x1d	;  29
      000695 38                    1724 	.db #0x38	;  56	'8'
      000696 0C                    1725 	.db #0x0c	;  12
      000697 09                    1726 	.db #0x09	;  9
      000698 DC                    1727 	.db #0xdc	; -36
      000699 F4                    1728 	.db #0xf4	; -12
      00069A 39                    1729 	.db #0x39	;  57	'9'
      00069B FE                    1730 	.db #0xfe	; -2
      00069C 00                    1731 	.db #0x00	;  0
      00069D 29                    1732 	.db #0x29	;  41
      00069E 0E                    1733 	.db #0x0e	;  14
      00069F 37                    1734 	.db #0x37	;  55	'7'
      0006A0 2B                    1735 	.db #0x2b	;  43
      0006A1 2F                    1736 	.db #0x2f	;  47
      0006A2 F1                    1737 	.db #0xf1	; -15
      0006A3 E9                    1738 	.db #0xe9	; -23
      0006A4 02                    1739 	.db #0x02	;  2
      0006A5 E2                    1740 	.db #0xe2	; -30
      0006A6 C6                    1741 	.db #0xc6	; -58
      0006A7 3F                    1742 	.db #0x3f	;  63
      0006A8 F7                    1743 	.db #0xf7	; -9
      0006A9 01                    1744 	.db #0x01	;  1
      0006AA 1A                    1745 	.db #0x1a	;  26
      0006AB 01                    1746 	.db #0x01	;  1
      0006AC FC                    1747 	.db #0xfc	; -4
      0006AD AF                    1748 	.db #0xaf	; -81
      0006AE FE                    1749 	.db #0xfe	; -2
      0006AF CE                    1750 	.db #0xce	; -50
      0006B0 24                    1751 	.db #0x24	;  36
      0006B1 09                    1752 	.db #0x09	;  9
      0006B2 49                    1753 	.db #0x49	;  73	'I'
      0006B3 27                    1754 	.db #0x27	;  39
      0006B4 00                    1755 	.db #0x00	;  0
      0006B5 49                    1756 	.db #0x49	;  73	'I'
      0006B6 34                    1757 	.db #0x34	;  52	'4'
      0006B7 29                    1758 	.db #0x29	;  41
      0006B8 21                    1759 	.db #0x21	;  33
      0006B9 F1                    1760 	.db #0xf1	; -15
      0006BA F4                    1761 	.db #0xf4	; -12
      0006BB FB                    1762 	.db #0xfb	; -5
      0006BC FF                    1763 	.db #0xff	; -1
      0006BD 2F                    1764 	.db #0x2f	;  47
      0006BE 2D                    1765 	.db #0x2d	;  45
      0006BF 12                    1766 	.db #0x12	;  18
      0006C0 2F                    1767 	.db #0x2f	;  47
      0006C1 1D                    1768 	.db #0x1d	;  29
      0006C2 15                    1769 	.db #0x15	;  21
      0006C3 03                    1770 	.db #0x03	;  3
      0006C4 02                    1771 	.db #0x02	;  2
      0006C5 C4                    1772 	.db #0xc4	; -60
      0006C6 0D                    1773 	.db #0x0d	;  13
      0006C7 CF                    1774 	.db #0xcf	; -49
      0006C8 F7                    1775 	.db #0xf7	; -9
      0006C9 29                    1776 	.db #0x29	;  41
      0006CA 2B                    1777 	.db #0x2b	;  43
      0006CB 2B                    1778 	.db #0x2b	;  43
      0006CC 00                    1779 	.db #0x00	;  0
      0006CD D1                    1780 	.db #0xd1	; -47
      0006CE 33                    1781 	.db #0x33	;  51	'3'
      0006CF CB                    1782 	.db #0xcb	; -53
      0006D0 F0                    1783 	.db #0xf0	; -16
      0006D1 E7                    1784 	.db #0xe7	; -25
      0006D2 03                    1785 	.db #0x03	;  3
      0006D3 02                    1786 	.db #0x02	;  2
      0006D4 E4                    1787 	.db #0xe4	; -28
      0006D5 FE                    1788 	.db #0xfe	; -2
      0006D6 F9                    1789 	.db #0xf9	; -7
      0006D7 11                    1790 	.db #0x11	;  17
      0006D8 C8                    1791 	.db #0xc8	; -56
      0006D9 32                    1792 	.db #0x32	;  50	'2'
      0006DA 14                    1793 	.db #0x14	;  20
      0006DB 1A                    1794 	.db #0x1a	;  26
      0006DC FA                    1795 	.db #0xfa	; -6
      0006DD 2C                    1796 	.db #0x2c	;  44
      0006DE 10                    1797 	.db #0x10	;  16
      0006DF D7                    1798 	.db #0xd7	; -41
      0006E0 03                    1799 	.db #0x03	;  3
      0006E1 27                    1800 	.db #0x27	;  39
      0006E2 3C                    1801 	.db #0x3c	;  60
      0006E3 4A                    1802 	.db #0x4a	;  74	'J'
      0006E4 00                    1803 	.db #0x00	;  0
      0006E5 C4                    1804 	.db #0xc4	; -60
      0006E6 6B                    1805 	.db #0x6b	;  107	'k'
      0006E7 E7                    1806 	.db #0xe7	; -25
      0006E8 08                    1807 	.db #0x08	;  8
      0006E9 EA                    1808 	.db #0xea	; -22
      0006EA 11                    1809 	.db #0x11	;  17
      0006EB 29                    1810 	.db #0x29	;  41
      0006EC D9                    1811 	.db #0xd9	; -39
      0006ED D7                    1812 	.db #0xd7	; -41
      0006EE EB                    1813 	.db #0xeb	; -21
      0006EF 35                    1814 	.db #0x35	;  53	'5'
      0006F0 FA                    1815 	.db #0xfa	; -6
      0006F1 00                    1816 	.db #0x00	;  0
      0006F2 EF                    1817 	.db #0xef	; -17
      0006F3 EE                    1818 	.db #0xee	; -18
      0006F4 10                    1819 	.db #0x10	;  16
      0006F5 CE                    1820 	.db #0xce	; -50
      0006F6 E6                    1821 	.db #0xe6	; -26
      0006F7 02                    1822 	.db #0x02	;  2
      0006F8 08                    1823 	.db #0x08	;  8
      0006F9 07                    1824 	.db #0x07	;  7
      0006FA 01                    1825 	.db #0x01	;  1
      0006FB F1                    1826 	.db #0xf1	; -15
      0006FC 00                    1827 	.db #0x00	;  0
      0006FD 05                    1828 	.db #0x05	;  5
      0006FE 0D                    1829 	.db #0x0d	;  13
      0006FF DA                    1830 	.db #0xda	; -38
      000700 0C                    1831 	.db #0x0c	;  12
      000701 F6                    1832 	.db #0xf6	; -10
      000702 FD                    1833 	.db #0xfd	; -3
      000703 EF                    1834 	.db #0xef	; -17
      000704 00                    1835 	.db #0x00	;  0
      000705 DA                    1836 	.db #0xda	; -38
      000706 F7                    1837 	.db #0xf7	; -9
      000707 38                    1838 	.db #0x38	;  56	'8'
      000708 FB                    1839 	.db #0xfb	; -5
      000709 03                    1840 	.db #0x03	;  3
      00070A FB                    1841 	.db #0xfb	; -5
      00070B C8                    1842 	.db #0xc8	; -56
      00070C 00                    1843 	.db #0x00	;  0
      00070D 54                    1844 	.db #0x54	;  84	'T'
      00070E C8                    1845 	.db #0xc8	; -56
      00070F D6                    1846 	.db #0xd6	; -42
      000710 12                    1847 	.db #0x12	;  18
      000711 F4                    1848 	.db #0xf4	; -12
      000712 19                    1849 	.db #0x19	;  25
      000713 24                    1850 	.db #0x24	;  36
      000714 00                    1851 	.db #0x00	;  0
      000715 13                    1852 	.db #0x13	;  19
      000716 61                    1853 	.db #0x61	;  97	'a'
      000717 30                    1854 	.db #0x30	;  48	'0'
      000718 5B                    1855 	.db #0x5b	;  91
      000719 F1                    1856 	.db #0xf1	; -15
      00071A 16                    1857 	.db #0x16	;  22
      00071B F1                    1858 	.db #0xf1	; -15
      00071C D9                    1859 	.db #0xd9	; -39
      00071D F0                    1860 	.db #0xf0	; -16
      00071E DB                    1861 	.db #0xdb	; -37
      00071F 3B                    1862 	.db #0x3b	;  59
      000720 1A                    1863 	.db #0x1a	;  26
      000721 00                    1864 	.db #0x00	;  0
      000722 E9                    1865 	.db #0xe9	; -23
      000723 A0                    1866 	.db #0xa0	; -96
      000724 01                    1867 	.db #0x01	;  1
      000725 B1                    1868 	.db #0xb1	; -79
      000726 DB                    1869 	.db #0xdb	; -37
      000727 FB                    1870 	.db #0xfb	; -5
      000728 FF                    1871 	.db #0xff	; -1
      000729 02                    1872 	.db #0x02	;  2
      00072A 37                    1873 	.db #0x37	;  55	'7'
      00072B 1D                    1874 	.db #0x1d	;  29
      00072C 00                    1875 	.db #0x00	;  0
      00072D F2                    1876 	.db #0xf2	; -14
      00072E 3F                    1877 	.db #0x3f	;  63
      00072F 19                    1878 	.db #0x19	;  25
      000730 13                    1879 	.db #0x13	;  19
      000731 F4                    1880 	.db #0xf4	; -12
      000732 0E                    1881 	.db #0x0e	;  14
      000733 0C                    1882 	.db #0x0c	;  12
      000734 EC                    1883 	.db #0xec	; -20
      000735 21                    1884 	.db #0x21	;  33
      000736 26                    1885 	.db #0x26	;  38
      000737 39                    1886 	.db #0x39	;  57	'9'
      000738 E1                    1887 	.db #0xe1	; -31
      000739 29                    1888 	.db #0x29	;  41
      00073A FA                    1889 	.db #0xfa	; -6
      00073B A1                    1890 	.db #0xa1	; -95
      00073C E6                    1891 	.db #0xe6	; -26
      00073D D9                    1892 	.db #0xd9	; -39
      00073E E2                    1893 	.db #0xe2	; -30
      00073F EF                    1894 	.db #0xef	; -17
      000740 0A                    1895 	.db #0x0a	;  10
      000741 22                    1896 	.db #0x22	;  34
      000742 42                    1897 	.db #0x42	;  66	'B'
      000743 18                    1898 	.db #0x18	;  24
      000744 00                    1899 	.db #0x00	;  0
      000745 AE                    1900 	.db #0xae	; -82
      000746 46                    1901 	.db #0x46	;  70	'F'
      000747 F0                    1902 	.db #0xf0	; -16
      000748 F7                    1903 	.db #0xf7	; -9
      000749 E0                    1904 	.db #0xe0	; -32
      00074A 16                    1905 	.db #0x16	;  22
      00074B 0E                    1906 	.db #0x0e	;  14
      00074C E1                    1907 	.db #0xe1	; -31
      00074D 05                    1908 	.db #0x05	;  5
      00074E F2                    1909 	.db #0xf2	; -14
      00074F 46                    1910 	.db #0x46	;  70	'F'
      000750 00                    1911 	.db #0x00	;  0
      000751 1A                    1912 	.db #0x1a	;  26
      000752 F1                    1913 	.db #0xf1	; -15
      000753 AE                    1914 	.db #0xae	; -82
      000754 FB                    1915 	.db #0xfb	; -5
      000755 32                    1916 	.db #0x32	;  50	'2'
      000756 ED                    1917 	.db #0xed	; -19
      000757 EA                    1918 	.db #0xea	; -22
      000758 F5                    1919 	.db #0xf5	; -11
      000759 EE                    1920 	.db #0xee	; -18
      00075A 1C                    1921 	.db #0x1c	;  28
      00075B 2D                    1922 	.db #0x2d	;  45
      00075C 00                    1923 	.db #0x00	;  0
      00075D E5                    1924 	.db #0xe5	; -27
      00075E 1E                    1925 	.db #0x1e	;  30
      00075F F1                    1926 	.db #0xf1	; -15
      000760 FD                    1927 	.db #0xfd	; -3
      000761 E4                    1928 	.db #0xe4	; -28
      000762 FE                    1929 	.db #0xfe	; -2
      000763 E8                    1930 	.db #0xe8	; -24
      000764 EA                    1931 	.db #0xea	; -22
      000765 DB                    1932 	.db #0xdb	; -37
                                   1933 	.area CSEG    (CODE)
                                   1934 	.area CONST   (CODE)
      000766                       1935 _B2:
      000766 14 FE FF FF           1936 	.byte #0x14, #0xfe, #0xff, #0xff	; -492
      00076A 50 0B 00 00           1937 	.byte #0x50, #0x0b, #0x00, #0x00	;  2896
      00076E C8 02 00 00           1938 	.byte #0xc8, #0x02, #0x00, #0x00	;  712
      000772 91 08 00 00           1939 	.byte #0x91, #0x08, #0x00, #0x00	;  2193
      000776 72 F3 FF FF           1940 	.byte #0x72, #0xf3, #0xff, #0xff	; -3214
      00077A 6F 06 00 00           1941 	.byte #0x6f, #0x06, #0x00, #0x00	;  1647
      00077E 31 F7 FF FF           1942 	.byte #0x31, #0xf7, #0xff, #0xff	; -2255
      000782 8B 0F 00 00           1943 	.byte #0x8b, #0x0f, #0x00, #0x00	;  3979
      000786 1D EE FF FF           1944 	.byte #0x1d, #0xee, #0xff, #0xff	; -4579
      00078A 45 01 00 00           1945 	.byte #0x45, #0x01, #0x00, #0x00	;  325
                                   1946 	.area CSEG    (CODE)
                                   1947 	.area CONST   (CODE)
      00078E                       1948 _W2:
      00078E DF                    1949 	.db #0xdf	; -33
      00078F DA                    1950 	.db #0xda	; -38
      000790 4A                    1951 	.db #0x4a	;  74	'J'
      000791 3C                    1952 	.db #0x3c	;  60
      000792 CB                    1953 	.db #0xcb	; -53
      000793 19                    1954 	.db #0x19	;  25
      000794 FF                    1955 	.db #0xff	; -1
      000795 E9                    1956 	.db #0xe9	; -23
      000796 EE                    1957 	.db #0xee	; -18
      000797 ED                    1958 	.db #0xed	; -19
      000798 3A                    1959 	.db #0x3a	;  58
      000799 E3                    1960 	.db #0xe3	; -29
      00079A 45                    1961 	.db #0x45	;  69	'E'
      00079B B9                    1962 	.db #0xb9	; -71
      00079C 00                    1963 	.db #0x00	;  0
      00079D F2                    1964 	.db #0xf2	; -14
      00079E 24                    1965 	.db #0x24	;  36
      00079F 07                    1966 	.db #0x07	;  7
      0007A0 1B                    1967 	.db #0x1b	;  27
      0007A1 CF                    1968 	.db #0xcf	; -49
      0007A2 81                    1969 	.db #0x81	; -127
      0007A3 14                    1970 	.db #0x14	;  20
      0007A4 0F                    1971 	.db #0x0f	;  15
      0007A5 E7                    1972 	.db #0xe7	; -25
      0007A6 6F                    1973 	.db #0x6f	;  111	'o'
      0007A7 2C                    1974 	.db #0x2c	;  44
      0007A8 C6                    1975 	.db #0xc6	; -58
      0007A9 B2                    1976 	.db #0xb2	; -78
      0007AA 35                    1977 	.db #0x35	;  53	'5'
      0007AB 22                    1978 	.db #0x22	;  34
      0007AC 4B                    1979 	.db #0x4b	;  75	'K'
      0007AD 41                    1980 	.db #0x41	;  65	'A'
      0007AE D5                    1981 	.db #0xd5	; -43
      0007AF 09                    1982 	.db #0x09	;  9
      0007B0 0A                    1983 	.db #0x0a	;  10
      0007B1 D6                    1984 	.db #0xd6	; -42
      0007B2 DB                    1985 	.db #0xdb	; -37
      0007B3 FA                    1986 	.db #0xfa	; -6
      0007B4 00                    1987 	.db #0x00	;  0
      0007B5 D7                    1988 	.db #0xd7	; -41
      0007B6 09                    1989 	.db #0x09	;  9
      0007B7 2D                    1990 	.db #0x2d	;  45
      0007B8 AD                    1991 	.db #0xad	; -83
      0007B9 CD                    1992 	.db #0xcd	; -51
      0007BA F5                    1993 	.db #0xf5	; -11
      0007BB 3B                    1994 	.db #0x3b	;  59
      0007BC 04                    1995 	.db #0x04	;  4
      0007BD 5C                    1996 	.db #0x5c	;  92
      0007BE F0                    1997 	.db #0xf0	; -16
      0007BF 7B                    1998 	.db #0x7b	;  123
      0007C0 B9                    1999 	.db #0xb9	; -71
      0007C1 DF                    2000 	.db #0xdf	; -33
      0007C2 EF                    2001 	.db #0xef	; -17
      0007C3 30                    2002 	.db #0x30	;  48	'0'
      0007C4 C2                    2003 	.db #0xc2	; -62
      0007C5 B5                    2004 	.db #0xb5	; -75
      0007C6 38                    2005 	.db #0x38	;  56	'8'
      0007C7 47                    2006 	.db #0x47	;  71	'G'
      0007C8 C2                    2007 	.db #0xc2	; -62
      0007C9 FA                    2008 	.db #0xfa	; -6
      0007CA D9                    2009 	.db #0xd9	; -39
      0007CB 02                    2010 	.db #0x02	;  2
      0007CC 00                    2011 	.db #0x00	;  0
      0007CD B3                    2012 	.db #0xb3	; -77
      0007CE B6                    2013 	.db #0xb6	; -74
      0007CF 17                    2014 	.db #0x17	;  23
      0007D0 2A                    2015 	.db #0x2a	;  42
      0007D1 C9                    2016 	.db #0xc9	; -55
      0007D2 0E                    2017 	.db #0x0e	;  14
      0007D3 F5                    2018 	.db #0xf5	; -11
      0007D4 C4                    2019 	.db #0xc4	; -60
      0007D5 F7                    2020 	.db #0xf7	; -9
      0007D6 D1                    2021 	.db #0xd1	; -47
      0007D7 15                    2022 	.db #0x15	;  21
      0007D8 06                    2023 	.db #0x06	;  6
      0007D9 D5                    2024 	.db #0xd5	; -43
      0007DA 16                    2025 	.db #0x16	;  22
      0007DB E3                    2026 	.db #0xe3	; -29
      0007DC B8                    2027 	.db #0xb8	; -72
      0007DD DC                    2028 	.db #0xdc	; -36
      0007DE 2E                    2029 	.db #0x2e	;  46
      0007DF 23                    2030 	.db #0x23	;  35
      0007E0 A8                    2031 	.db #0xa8	; -88
      0007E1 37                    2032 	.db #0x37	;  55	'7'
      0007E2 DC                    2033 	.db #0xdc	; -36
      0007E3 EF                    2034 	.db #0xef	; -17
      0007E4 00                    2035 	.db #0x00	;  0
      0007E5 2E                    2036 	.db #0x2e	;  46
      0007E6 14                    2037 	.db #0x14	;  20
      0007E7 B5                    2038 	.db #0xb5	; -75
      0007E8 3D                    2039 	.db #0x3d	;  61
      0007E9 1B                    2040 	.db #0x1b	;  27
      0007EA 1A                    2041 	.db #0x1a	;  26
      0007EB 11                    2042 	.db #0x11	;  17
      0007EC C6                    2043 	.db #0xc6	; -58
      0007ED FE                    2044 	.db #0xfe	; -2
      0007EE 5B                    2045 	.db #0x5b	;  91
      0007EF E9                    2046 	.db #0xe9	; -23
      0007F0 B3                    2047 	.db #0xb3	; -77
      0007F1 F3                    2048 	.db #0xf3	; -13
      0007F2 C9                    2049 	.db #0xc9	; -55
      0007F3 18                    2050 	.db #0x18	;  24
      0007F4 29                    2051 	.db #0x29	;  41
      0007F5 46                    2052 	.db #0x46	;  70	'F'
      0007F6 AB                    2053 	.db #0xab	; -85
      0007F7 0E                    2054 	.db #0x0e	;  14
      0007F8 00                    2055 	.db #0x00	;  0
      0007F9 E3                    2056 	.db #0xe3	; -29
      0007FA 38                    2057 	.db #0x38	;  56	'8'
      0007FB 58                    2058 	.db #0x58	;  88	'X'
      0007FC 00                    2059 	.db #0x00	;  0
      0007FD F8                    2060 	.db #0xf8	; -8
      0007FE B8                    2061 	.db #0xb8	; -72
      0007FF EB                    2062 	.db #0xeb	; -21
      000800 DC                    2063 	.db #0xdc	; -36
      000801 07                    2064 	.db #0x07	;  7
      000802 1E                    2065 	.db #0x1e	;  30
      000803 13                    2066 	.db #0x13	;  19
      000804 40                    2067 	.db #0x40	;  64
      000805 3E                    2068 	.db #0x3e	;  62
      000806 A7                    2069 	.db #0xa7	; -89
      000807 E5                    2070 	.db #0xe5	; -27
      000808 21                    2071 	.db #0x21	;  33
      000809 12                    2072 	.db #0x12	;  18
      00080A 4B                    2073 	.db #0x4b	;  75	'K'
      00080B D8                    2074 	.db #0xd8	; -40
      00080C 00                    2075 	.db #0x00	;  0
      00080D D9                    2076 	.db #0xd9	; -39
      00080E F5                    2077 	.db #0xf5	; -11
      00080F AA                    2078 	.db #0xaa	; -86
      000810 01                    2079 	.db #0x01	;  1
      000811 F1                    2080 	.db #0xf1	; -15
      000812 CB                    2081 	.db #0xcb	; -53
      000813 F1                    2082 	.db #0xf1	; -15
      000814 00                    2083 	.db #0x00	;  0
      000815 29                    2084 	.db #0x29	;  41
      000816 51                    2085 	.db #0x51	;  81	'Q'
      000817 C8                    2086 	.db #0xc8	; -56
      000818 ED                    2087 	.db #0xed	; -19
      000819 34                    2088 	.db #0x34	;  52	'4'
      00081A 1F                    2089 	.db #0x1f	;  31
      00081B AB                    2090 	.db #0xab	; -85
      00081C 04                    2091 	.db #0x04	;  4
      00081D AE                    2092 	.db #0xae	; -82
      00081E E7                    2093 	.db #0xe7	; -25
      00081F EA                    2094 	.db #0xea	; -22
      000820 EE                    2095 	.db #0xee	; -18
      000821 18                    2096 	.db #0x18	;  24
      000822 13                    2097 	.db #0x13	;  19
      000823 2A                    2098 	.db #0x2a	;  42
      000824 32                    2099 	.db #0x32	;  50	'2'
      000825 DD                    2100 	.db #0xdd	; -35
      000826 A9                    2101 	.db #0xa9	; -87
      000827 EE                    2102 	.db #0xee	; -18
      000828 38                    2103 	.db #0x38	;  56	'8'
      000829 BA                    2104 	.db #0xba	; -70
      00082A 38                    2105 	.db #0x38	;  56	'8'
      00082B 19                    2106 	.db #0x19	;  25
      00082C 00                    2107 	.db #0x00	;  0
      00082D DF                    2108 	.db #0xdf	; -33
      00082E 0E                    2109 	.db #0x0e	;  14
      00082F 06                    2110 	.db #0x06	;  6
      000830 D3                    2111 	.db #0xd3	; -45
      000831 40                    2112 	.db #0x40	;  64
      000832 09                    2113 	.db #0x09	;  9
      000833 AA                    2114 	.db #0xaa	; -86
      000834 D8                    2115 	.db #0xd8	; -40
      000835 BC                    2116 	.db #0xbc	; -68
      000836 FA                    2117 	.db #0xfa	; -6
      000837 EF                    2118 	.db #0xef	; -17
      000838 18                    2119 	.db #0x18	;  24
      000839 B0                    2120 	.db #0xb0	; -80
      00083A 3B                    2121 	.db #0x3b	;  59
      00083B 9C                    2122 	.db #0x9c	; -100
      00083C BB                    2123 	.db #0xbb	; -69
      00083D 4F                    2124 	.db #0x4f	;  79	'O'
      00083E 70                    2125 	.db #0x70	;  112	'p'
      00083F 18                    2126 	.db #0x18	;  24
      000840 F2                    2127 	.db #0xf2	; -14
      000841 6E                    2128 	.db #0x6e	;  110	'n'
      000842 B8                    2129 	.db #0xb8	; -72
      000843 D1                    2130 	.db #0xd1	; -47
      000844 00                    2131 	.db #0x00	;  0
      000845 16                    2132 	.db #0x16	;  22
      000846 D5                    2133 	.db #0xd5	; -43
      000847 3E                    2134 	.db #0x3e	;  62
      000848 06                    2135 	.db #0x06	;  6
      000849 C1                    2136 	.db #0xc1	; -63
      00084A FA                    2137 	.db #0xfa	; -6
      00084B 18                    2138 	.db #0x18	;  24
      00084C 17                    2139 	.db #0x17	;  23
      00084D 25                    2140 	.db #0x25	;  37
      00084E EC                    2141 	.db #0xec	; -20
      00084F 00                    2142 	.db #0x00	;  0
      000850 2C                    2143 	.db #0x2c	;  44
      000851 27                    2144 	.db #0x27	;  39
      000852 DA                    2145 	.db #0xda	; -38
      000853 15                    2146 	.db #0x15	;  21
      000854 ED                    2147 	.db #0xed	; -19
      000855 E4                    2148 	.db #0xe4	; -28
      000856 E7                    2149 	.db #0xe7	; -25
      000857 0B                    2150 	.db #0x0b	;  11
      000858 1B                    2151 	.db #0x1b	;  27
      000859 E2                    2152 	.db #0xe2	; -30
      00085A 1A                    2153 	.db #0x1a	;  26
      00085B 02                    2154 	.db #0x02	;  2
      00085C 00                    2155 	.db #0x00	;  0
      00085D F0                    2156 	.db #0xf0	; -16
      00085E FB                    2157 	.db #0xfb	; -5
      00085F 01                    2158 	.db #0x01	;  1
      000860 14                    2159 	.db #0x14	;  20
      000861 0C                    2160 	.db #0x0c	;  12
      000862 F4                    2161 	.db #0xf4	; -12
      000863 0C                    2162 	.db #0x0c	;  12
      000864 F1                    2163 	.db #0xf1	; -15
      000865 EF                    2164 	.db #0xef	; -17
      000866 E3                    2165 	.db #0xe3	; -29
      000867 C5                    2166 	.db #0xc5	; -59
      000868 30                    2167 	.db #0x30	;  48	'0'
      000869 20                    2168 	.db #0x20	;  32
      00086A DD                    2169 	.db #0xdd	; -35
      00086B CD                    2170 	.db #0xcd	; -51
      00086C DD                    2171 	.db #0xdd	; -35
      00086D 02                    2172 	.db #0x02	;  2
      00086E F8                    2173 	.db #0xf8	; -8
      00086F CF                    2174 	.db #0xcf	; -49
      000870 EA                    2175 	.db #0xea	; -22
      000871 10                    2176 	.db #0x10	;  16
      000872 D4                    2177 	.db #0xd4	; -44
      000873 21                    2178 	.db #0x21	;  33
      000874 00                    2179 	.db #0x00	;  0
      000875 36                    2180 	.db #0x36	;  54	'6'
      000876 0A                    2181 	.db #0x0a	;  10
      000877 D0                    2182 	.db #0xd0	; -48
      000878 18                    2183 	.db #0x18	;  24
      000879 06                    2184 	.db #0x06	;  6
      00087A 11                    2185 	.db #0x11	;  17
      00087B 0A                    2186 	.db #0x0a	;  10
      00087C 3B                    2187 	.db #0x3b	;  59
      00087D FE                    2188 	.db #0xfe	; -2
                                   2189 	.area CSEG    (CODE)
                                   2190 	.area CONST   (CODE)
      00087E                       2191 _dsel:
      00087E F7                    2192 	.db #0xf7	; 247
      00087F EF                    2193 	.db #0xef	; 239
      000880 DF                    2194 	.db #0xdf	; 223
      000881 BF                    2195 	.db #0xbf	; 191
                                   2196 	.area CSEG    (CODE)
                                   2197 	.area CONST   (CODE)
      000882                       2198 _segs:
      000882 C0                    2199 	.db #0xc0	; 192
      000883 F9                    2200 	.db #0xf9	; 249
      000884 A4                    2201 	.db #0xa4	; 164
      000885 B0                    2202 	.db #0xb0	; 176
      000886 99                    2203 	.db #0x99	; 153
      000887 92                    2204 	.db #0x92	; 146
      000888 82                    2205 	.db #0x82	; 130
      000889 F8                    2206 	.db #0xf8	; 248
      00088A 80                    2207 	.db #0x80	; 128
      00088B 90                    2208 	.db #0x90	; 144
                                   2209 	.area CSEG    (CODE)
                                   2210 	.area CONST   (CODE)
      00088C                       2211 _hexd:
      00088C 30 31 32 33 34 35 36  2212 	.ascii "0123456789ABCDEF"
             37 38 39 41 42 43 44
             45 46
      00089C 00                    2213 	.db 0x00
                                   2214 	.area CSEG    (CODE)
                                   2215 	.area CONST   (CODE)
      00089D                       2216 ___str_0:
      00089D 4E 4E 20 52 45 41 44  2217 	.ascii "NN READY"
             59
      0008A5 0D                    2218 	.db 0x0d
      0008A6 0A                    2219 	.db 0x0a
      0008A7 00                    2220 	.db 0x00
                                   2221 	.area CSEG    (CODE)
                                   2222 	.area XINIT   (CODE)
                                   2223 	.area CABS    (ABS,CODE)
