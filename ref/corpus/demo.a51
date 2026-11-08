;=======================================================================
; STC89C52RC board demo: four games with sound and light
;
; Power on: a light runs along the LEDs while the buzzer slides up and
; down, the display scrolls HELLO to a short tune, then the menu shows
;
;       P   E   5   r        (one letter above each button)
;      S5  S4  S3  S2
;
;   S5  P  Binary piano  the four buttons are the bits 8 4 2 1 of a
;                        number; the display shows the bits, the
;                        buzzer plays note number 1..15 of the scale
;   S4  E  Echo          the board plays a growing tune of four notes,
;                        you play it back (memory game, 20 rounds)
;   S3  5  Song          Ode to Joy, the LEDs bounce with the music
;   S2  r  Reaction      wait for Go, press any button, the display
;                        shows your reaction time in milliseconds
;
; Leave the menu alone for 12 s and the board plays the song by itself.
;
; Board wiring (TSI STC89C52RC board):
;   P0.0-P0.7  segments a-g, dp (lit by 0) and LEDs D1-D8 (lit by 0)
;   P1.3-P1.6  digit enables, left to right (digit on at 0)
;   P3.5-P3.2  buttons S5, S4, S3, S2 (a pressed button reads 0)
;   P3.6       buzzer LS1 (it sounds while the pin toggles)
; Clock 11.0592 MHz, 12 clocks per machine cycle: 1 cycle = 1.085 us
;
; How it works:
;   Timer 0 (high priority) flips P3.6 every half period of the note.
;   Timer 1 interrupts every 1 ms. It lights one digit per interrupt
;   (all four every 4 ms), counts milliseconds, runs the wait timer
;   and plays tunes in the background, so the main program can scroll
;   text or move lights while music plays.
;=======================================================================

;--------------------------- RAM ---------------------------------------
; bit flags in 20H
LEDMODE BIT     00H             ; 1: digits off, P0 shows LEDPAT on the LEDs
PLAYING BIT     01H             ; 1: Timer 1 is playing a tune
LEGATO  BIT     02H             ; 1: this note runs into the next (no gap)
DLYRUN  BIT     03H             ; 1: the millisecond wait timer is running
NZFLAG  BIT     04H             ; used by SHOWDEC to blank leading zeros

DISP    EQU     30H             ; 30H-33H segment codes of digits 1-4
LEDPAT  EQU     34H             ; LED pattern for LEDMODE (0 = LED on)
NOTEH   EQU     35H             ; Timer 0 reload for the note now playing
NOTEL   EQU     36H
TICKL   EQU     37H             ; milliseconds since power on (16 bits)
TICKH   EQU     38H
DLYL    EQU     39H             ; wait timer, counts down in ms
DLYH    EQU     3AH
SONGL   EQU     3BH             ; where the tune player is in the tune
SONGH   EQU     3CH
PRE     EQU     3DH             ; 10 ms prescaler for the tune player
NOTECNT EQU     3EH             ; 10 ms steps left of the current note
CURNOTE EQU     3FH             ; note sounding now (0 = silence)
RND     EQU     40H             ; random number generator state
LEN     EQU     41H             ; Echo: length of the tune
CNT     EQU     42H             ; Echo: notes left to play or check
PADV    EQU     43H             ; Echo: button the player pressed
PN      EQU     44H             ; Piano: number held on the buttons
LEVEL   EQU     45H             ; Song: height of the LED bar
TSTL    EQU     46H             ; Reaction: time of Go (16 bits)
TSTH    EQU     47H
SEQ     EQU     48H             ; Echo: the tune, 48H-5BH (20 steps)
MAXLEN  EQU     20
; stack 60H-7FH (SP starts at 5FH)

BUZ     BIT     P3.6

;--------------------------- constants ---------------------------------
T1RL    EQU     0FC6DH          ; 1 ms: 65536-922 cycles, +7 for the reload delay

; 7-segment codes (a = bit 0 ... g = bit 6, dp = bit 7, a 0 lights it)
SG_0    EQU     0C0H
SG_1    EQU     0F9H
SG_2    EQU     0A4H
SG_3    EQU     0B0H
SG_4    EQU     099H
SG_5    EQU     092H
SG_6    EQU     082H
SG_7    EQU     0F8H
SG_8    EQU     080H
SG_9    EQU     090H
SG_A    EQU     088H
SG_UC   EQU     0C6H            ; C
SG_LC   EQU     0A7H            ; c
SG_LD   EQU     0A1H            ; d
SG_E    EQU     086H
SG_G    EQU     0C2H
SG_H    EQU     089H
SG_I    EQU     0F9H
SG_J    EQU     0E1H
SG_L    EQU     0C7H
SG_LN   EQU     0ABH            ; n
SG_LO   EQU     0A3H            ; o
SG_O    EQU     0C0H
SG_P    EQU     08CH
SG_LR   EQU     0AFH            ; r
SG_S    EQU     092H
SG_LT   EQU     087H            ; t
SG_U    EQU     0C1H
SG_LY   EQU     091H            ; y
SG_DASH EQU     0BFH
SG_SP   EQU     0FFH            ; blank

; note numbers (the tune data uses these; 0 = rest, +LEG = no gap)
N_C5    EQU     1
N_D5    EQU     2
N_E5    EQU     3
N_F5    EQU     4
N_G5    EQU     5
N_A5    EQU     6
N_B5    EQU     7
N_C6    EQU     8
N_D6    EQU     9
N_E6    EQU     10
N_F6    EQU     11
N_G6    EQU     12
N_A6    EQU     13
N_B6    EQU     14
N_C7    EQU     15
N_D7    EQU     16
N_E7    EQU     17
N_F7    EQU     18
N_G7    EQU     19
N_A7    EQU     20
N_B7    EQU     21
N_C8    EQU     22
N_LOW   EQU     23
LEG     EQU     80H

;--------------------------- vectors -----------------------------------
        ORG     0000H
        LJMP    START

        ORG     000BH           ; Timer 0: one half period of the note is over
        MOV     TH0,NOTEH       ; reload first, so the next half period is exact
        MOV     TL0,NOTEL
        CPL     BUZ             ; flip the buzzer pin
        RETI                    ; (runs into 0013H: INT1 is not used)

        ORG     001BH           ; Timer 1: every millisecond
        LJMP    T1_ISR

;--------------------------- start -------------------------------------
        ORG     0030H
START:  MOV     SP,#5FH
        MOV     P0,#0FFH        ; segments and LEDs off
        MOV     P1,#0FFH        ; digits off
        SETB    BUZ             ; buzzer transistor off
        MOV     R0,#20H         ; clear the flags and variables 20H-5FH
CLRRAM: MOV     @R0,#0
        INC     R0
        CJNE    R0,#60H,CLRRAM
        ACALL   BLANK
        MOV     LEDPAT,#0FFH
        MOV     RND,#5AH
        MOV     TMOD,#11H       ; Timer 0 and Timer 1 in mode 1 (16 bits)
        MOV     TH1,#HIGH(T1RL)
        MOV     TL1,#LOW(T1RL)
        SETB    TR1
        MOV     IP,#02H         ; PT0: the tone interrupt may interrupt Timer 1
        MOV     IE,#8AH         ; EA + ET1 + ET0

; intro 1: a light runs along the LEDs and follows the pitch
        SETB    LEDMODE
        MOV     DPTR,#T_SWEEP
        ACALL   PLAY
IN_L:   MOV     A,CURNOTE       ; notes C6 (8) .. C8 (22) -> LED 0..7
        CLR     C
        SUBB    A,#N_C6
        JC      IN_W            ; silence: keep the last LED
        CLR     C
        RRC     A               ; (note - 8) / 2
        MOV     DPTR,#ONEHOT
        MOVC    A,@A+DPTR
        MOV     LEDPAT,A
IN_W:   JB      PLAYING,IN_L
        MOV     LEDPAT,#0FFH
        CLR     LEDMODE

; intro 2: HELLO scrolls in while a tune plays, then the menu legend
        MOV     DPTR,#T_HELLO
        ACALL   PLAY
        MOV     DPTR,#M_HELLO
        MOV     A,#20           ; 200 ms per step
        ACALL   SCROLL
        JC      MENU            ; a button skips the intro
        ACALL   WAITSONG
        MOV     DPTR,#M_LEGEND
        MOV     A,#18           ; 180 ms per step
        ACALL   SCROLL

;--------------------------- menu --------------------------------------
MENU:   ACALL   STOPSONG
        CLR     LEDMODE
        MOV     DPTR,#M_MENU
        ACALL   SHOW4           ; P E 5 r
        MOV     R5,#240         ; 240 x 50 ms = 12 s
        ACALL   WAITKEY
        JNC     MN_IDLE
        PUSH    ACC
        MOV     DPTR,#T_CLICK
        ACALL   PLAY
        ACALL   WAITREL
        ACALL   WAITSONG
        POP     ACC
        RL      A               ; each AJMP below takes 2 bytes
        MOV     DPTR,#MN_JMP
        JMP     @A+DPTR
MN_JMP: AJMP    PIANO           ; S5
        AJMP    ECHO            ; S4
        AJMP    SONG            ; S3
        AJMP    REACT           ; S2
MN_IDLE:AJMP    SONG            ; nobody there: play the song

;======================= mode 1: binary piano ==========================
; The buttons S5 S4 S3 S2 are the bits 8 4 2 1 of a number n. Hold one
; or more: the display shows the four bits and the buzzer plays note n
; of the scale (1 = C6 ... 8 = C7 ... 15 = C8). 10 s idle: back to menu.
PIANO:  MOV     DPTR,#M_PIANO
        MOV     A,#20
        ACALL   SCROLL
        ACALL   WAITREL
        MOV     PN,#0
        CLR     A
        ACALL   P_SHOW          ; 0000
PI_W:   MOV     R5,#200         ; 10 s
        ACALL   WAITKEY
        JNC     PI_X
PI_H:   ACALL   KEYS            ; A = n (bit 3 = S5 ... bit 0 = S2)
        JZ      PI_R
        CJNE    A,PN,PI_N
        SJMP    PI_D
PI_N:   MOV     PN,A            ; the number changed: show it, play it
        ACALL   P_SHOW
PI_D:   MOV     A,#1
        ACALL   WAITA           ; look again in 10 ms
        SJMP    PI_H
PI_R:   MOV     PN,#0           ; all buttons up
        CLR     A
        ACALL   P_SHOW
        MOV     A,#2
        ACALL   WAITA           ; release bounce
        SJMP    PI_W
PI_X:   AJMP    MENU

; show n (A = 0..15) as four bits and play note n + 7 (0 = silence)
P_SHOW: MOV     R2,A
        SWAP    A               ; bit 3 of n to bit 7
        MOV     R0,#DISP
        MOV     R3,#4
PS_L:   RLC     A               ; next bit, S5 first, into C
        PUSH    ACC
        MOV     A,#SG_0
        JNC     PS_Z
        MOV     A,#SG_1
PS_Z:   MOV     @R0,A
        INC     R0
        POP     ACC
        DJNZ    R3,PS_L
        MOV     A,R2
        JZ      PS_OFF
        ADD     A,#N_C6-1       ; n = 1 is C6
        AJMP    TONE
PS_OFF: AJMP    TONE_OFF

;========================= mode 2: Echo ================================
; The board plays a tune of 1, 2, 3 ... notes. Each button has its own
; note and lights its own digit: S5 C6, S4 E6, S3 G6, S2 C7. Play the
; tune back; every round adds one note and the board plays faster.
ECHO:   MOV     DPTR,#M_ECHO
        MOV     A,#20
        ACALL   SCROLL
        ACALL   WAITREL
        MOV     A,TICKL         ; seed the random numbers from the time
        XRL     A,RND
        JNZ     EC_S
        INC     A
EC_S:   MOV     RND,A
        MOV     LEN,#0
EC_RND: ACALL   RAND            ; add one random step to the tune
        XRL     A,TICKL         ; mix in the player's timing
        ANL     A,#03H
        PUSH    ACC
        MOV     A,LEN
        ADD     A,#SEQ
        MOV     R0,A
        POP     ACC
        MOV     @R0,A
        INC     LEN
        MOV     DISP+0,#SG_LR   ; show the round: r 05
        MOV     DISP+1,#SG_SP
        MOV     A,LEN
        ACALL   SHOW2
        MOV     A,#70
        ACALL   WAITA
        ACALL   BLANK
        MOV     A,#25
        ACALL   WAITA
        MOV     R1,#SEQ         ; the board plays the tune
        MOV     CNT,LEN
EC_P:   MOV     A,@R1
        ACALL   PAD_ON
        MOV     A,LEN           ; note time = 420 - 20 x LEN ms, at least 160
        RL      A
        MOV     B,A
        MOV     A,#42
        CLR     C
        SUBB    A,B
        JC      EC_MIN
        CJNE    A,#16,$+3       ; C = 1 when A < 16
        JNC     EC_T
EC_MIN: MOV     A,#16
EC_T:   ACALL   WAITA
        ACALL   PAD_OFF
        MOV     A,#8
        ACALL   WAITA
        INC     R1
        DJNZ    CNT,EC_P
        MOV     R1,#SEQ         ; now the player
        MOV     CNT,LEN
EC_I:   MOV     R5,#60          ; 3 s for each press
        ACALL   WAITKEY
        JNC     EC_FAIL         ; too slow
        MOV     PADV,A
        ACALL   PAD_ON
        MOV     A,#15
        ACALL   WAITA           ; sound at least 150 ms
EC_H:   ACALL   KEYS
        JNZ     EC_H            ; until the button is let go
        ACALL   PAD_OFF
        MOV     A,#2
        ACALL   WAITA
        MOV     A,PADV
        XRL     A,@R1
        JNZ     EC_FAIL         ; wrong button
        INC     R1
        DJNZ    CNT,EC_I
        MOV     A,#20           ; round complete
        ACALL   WAITA
        MOV     DPTR,#T_OK
        ACALL   PLAY
        ACALL   WAITSONG
        MOV     A,#30
        ACALL   WAITA
        MOV     A,LEN
        CJNE    A,#MAXLEN,EC_MORE
        MOV     DPTR,#T_WIN     ; all 20 rounds
        ACALL   PLAY
        MOV     DPTR,#M_SUPER
        MOV     A,#20
        ACALL   SCROLL
        ACALL   WAITSONG
        MOV     A,LEN
        SJMP    EC_SC
EC_MORE:AJMP    EC_RND          ; (too far for CJNE)
EC_FAIL:ACALL   PAD_OFF
        MOV     DPTR,#T_LOSE
        ACALL   PLAY
        MOV     DPTR,#M_LOST
        ACALL   SHOW4           ; LoSt
        ACALL   WAITSONG
        MOV     A,#50
        ACALL   WAITA
        MOV     A,LEN
        DEC     A               ; rounds completed
EC_SC:  MOV     DISP+0,#SG_S    ; score: Sc07
        MOV     DISP+1,#SG_LC
        ACALL   SHOW2
        ACALL   WAITREL
        MOV     R5,#100         ; a button within 5 s: play again
        ACALL   WAITKEY
        JNC     EC_X
        ACALL   WAITREL
        AJMP    ECHO
EC_X:   AJMP    MENU

; A = button 0..3 (0 = S5): light its digit, play its note
PAD_ON: ACALL   BLANK
        PUSH    ACC
        ADD     A,#DISP
        MOV     R0,A
        POP     ACC
        PUSH    ACC
        MOV     DPTR,#PADSEG
        MOVC    A,@A+DPTR
        MOV     @R0,A
        POP     ACC
        MOV     DPTR,#PADNOTE
        MOVC    A,@A+DPTR
        AJMP    TONE
PAD_OFF:ACALL   TONE_OFF
BLANK:  MOV     DISP+0,#SG_SP
        MOV     DISP+1,#SG_SP
        MOV     DISP+2,#SG_SP
        MOV     DISP+3,#SG_SP
        RET

;========================= mode 3: Song ================================
; Ode to Joy (Beethoven). The digits go dark and the LEDs become a bar
; that jumps with each note and falls back between notes. A button stops.
SONG:   MOV     DPTR,#M_ODE
        MOV     A,#20
        ACALL   SCROLL
        ACALL   WAITREL
        MOV     DPTR,#T_ODE
        ACALL   PLAY
        MOV     LEVEL,#0
        SETB    LEDMODE
SO_L:   MOV     A,CURNOTE       ; bar height: G5 = 1 ... G6 = 8, silence = 0
        JZ      SO_T
        CLR     C
        SUBB    A,#N_G5-1
        JNC     SO_HI
        MOV     A,#1
SO_HI:  CJNE    A,#9,$+3        ; C = 1 when A < 9
        JC      SO_T
        MOV     A,#8
SO_T:   CJNE    A,LEVEL,$+3     ; C = 1 when the note is lower than the bar
        JNC     SO_SET          ; higher or equal: jump up
        MOV     A,LEVEL         ; lower: the bar falls one LED
        DEC     A
SO_SET: MOV     LEVEL,A
        MOV     DPTR,#BARS
        MOVC    A,@A+DPTR
        MOV     LEDPAT,A
        ACALL   KEYS
        JNZ     SO_STOP
        MOV     A,#3
        ACALL   WAITA           ; 30 ms per frame
        JB      PLAYING,SO_L
        SJMP    SO_END
SO_STOP:ACALL   STOPSONG
        ACALL   WAITREL
SO_END: MOV     LEDPAT,#0FFH
        CLR     LEDMODE
        AJMP    MENU

;======================= mode 4: Reaction ==============================
; ---- , then after a random 1.5-4.5 s the display says Go and beeps.
; Press any button: the display shows the time in ms. Pressing before
; Go is a false start (Err). Any button: again; 5 s idle: menu.
REACT:  MOV     DPTR,#M_REACT
        MOV     A,#20
        ACALL   SCROLL
        ACALL   WAITREL
        MOV     A,TICKL
        XRL     A,RND
        JNZ     RE_S
        INC     A
RE_S:   MOV     RND,A
RE_GO:  MOV     DPTR,#M_DASH
        ACALL   SHOW4           ; ----
        ACALL   RAND            ; wait 1500 + 12 x (0..255) ms
        MOV     B,#12
        MUL     AB
        ADD     A,#LOW(1500)
        MOV     R7,A
        MOV     A,B
        ADDC    A,#HIGH(1500)
        MOV     R6,A
        ACALL   STARTMS
RE_W:   ACALL   KEYS
        JNZ     RE_FALSE        ; pressed too early
        JB      DLYRUN,RE_W
        CLR     ET1             ; Go: note the time
        MOV     TSTL,TICKL
        MOV     TSTH,TICKH
        SETB    ET1
        MOV     DPTR,#M_GO
        ACALL   SHOW4
        MOV     DPTR,#T_GO
        ACALL   PLAY
RE_K:   ACALL   ELAPSED         ; R6:R7 = ms since Go
        ACALL   KEYS
        JNZ     RE_HIT
        MOV     A,R6            ; 2000 ms or more: too slow
        CJNE    A,#HIGH(2000),RE_C
        MOV     A,R7
        CJNE    A,#LOW(2000),RE_C
RE_C:   JC      RE_K
        MOV     DPTR,#M_LATE
        ACALL   SHOW4           ; LAtE
        MOV     DPTR,#T_LOSE
        ACALL   PLAY
        SJMP    RE_NEXT
RE_HIT: MOV     TSTL,R7         ; keep the result (SHOWDEC uses R6:R7)
        MOV     TSTH,R6
        ACALL   SHOWDEC         ; e.g.  256
        MOV     DPTR,#T_OK
        MOV     A,TSTH          ; under 250 ms: fanfare
        JNZ     RE_PLY
        MOV     A,TSTL
        CLR     C
        SUBB    A,#250
        JNC     RE_PLY
        MOV     DPTR,#T_WIN
RE_PLY: ACALL   PLAY
        SJMP    RE_NEXT
RE_FALSE:
        MOV     DPTR,#M_ERR
        ACALL   SHOW4           ; Err
        MOV     DPTR,#T_BUZZ
        ACALL   PLAY
RE_NEXT:ACALL   WAITSONG
        ACALL   WAITREL
        MOV     R5,#100         ; 5 s
        ACALL   WAITKEY
        JNC     RE_X
        ACALL   WAITREL
        SJMP    RE_GO
RE_X:   AJMP    MENU

; ELAPSED: R6:R7 = milliseconds since Go
ELAPSED:CLR     ET1
        CLR     C
        MOV     A,TICKL
        SUBB    A,TSTL
        MOV     R7,A
        MOV     A,TICKH
        SUBB    A,TSTH
        MOV     R6,A
        SETB    ET1
        RET

;========================= helpers =====================================
; KEYS: A = buttons now down, 1 = pressed: bit 3 = S5 ... bit 0 = S2
KEYS:   MOV     A,P3
        CPL     A
        RR      A
        RR      A
        ANL     A,#0FH
        RET

; WAITKEY: wait for a press. R5 = time limit in 50 ms steps (0 = none).
; Out: C = 1, A = button 0..3 (0 = S5, the left one); C = 0: time is up.
WAITKEY:
WK_U:   MOV     R4,#5
WK_P:   ACALL   KEYS
        JNZ     WK_HIT
        MOV     A,#1
        ACALL   WAITA           ; 10 ms
        DJNZ    R4,WK_P
        MOV     A,R5
        JZ      WK_U            ; no limit
        DJNZ    R5,WK_U
        CLR     C
        RET
WK_HIT: MOV     A,#2
        ACALL   WAITA           ; 20 ms, then look again (bounce)
        ACALL   KEYS
        JZ      WK_U
        JB      ACC.3,WK_0      ; the leftmost button pressed wins
        JB      ACC.2,WK_1
        JB      ACC.1,WK_2
        MOV     A,#3
        SETB    C
        RET
WK_0:   CLR     A
        SETB    C
        RET
WK_1:   MOV     A,#1
        SETB    C
        RET
WK_2:   MOV     A,#2
        SETB    C
        RET

; WAITREL: wait until every button is up (and stays up for 20 ms)
WAITREL:ACALL   KEYS
        JNZ     WAITREL
        MOV     A,#2
        ACALL   WAITA
        ACALL   KEYS
        JNZ     WAITREL
        RET

; WAITA: wait A x 10 ms (A = 1..255). Uses R6, R7, B.
WAITA:  MOV     B,#10
        MUL     AB
        MOV     R7,A
        MOV     R6,B
; WAITMS: wait R6:R7 ms (R6 = high byte)
WAITMS: ACALL   STARTMS
WM_L:   JB      DLYRUN,WM_L
        RET
; STARTMS: start the wait timer with R6:R7 ms and return at once;
; DLYRUN goes to 0 when the time is up
STARTMS:MOV     A,R7
        ORL     A,R6
        JZ      SM_X            ; 0 ms: nothing to wait for
        CLR     ET1             ; Timer 1 must not count while we write
        MOV     DLYL,R7
        MOV     DLYH,R6
        SETB    DLYRUN
        SETB    ET1
SM_X:   RET

; TONE: play note A (1..23) until told otherwise; A = 0 means silence
TONE:   JZ      TONE_OFF
        DEC     A
        RL      A               ; 2 bytes per note in the table
        MOV     DPTR,#NOTES
        PUSH    ACC
        MOVC    A,@A+DPTR
        MOV     NOTEH,A
        POP     ACC
        INC     A
        MOVC    A,@A+DPTR
        MOV     NOTEL,A
        CLR     TR0
        MOV     TH0,NOTEH
        MOV     TL0,NOTEL
        SETB    TR0
        RET
TONE_OFF:
        CLR     TR0
        CLR     TF0
        SETB    BUZ             ; leave the transistor off
        RET

; PLAY: play the tune at DPTR in the background (pairs: note, 10 ms
; steps; a step count of 0 ends the tune)
PLAY:   CLR     ET1
        MOV     SONGL,DPL
        MOV     SONGH,DPH
        MOV     PRE,#1
        MOV     NOTECNT,#1      ; the next Timer 1 tick starts note 1
        SETB    PLAYING
        SETB    ET1
        RET
WAITSONG:
        JB      PLAYING,WAITSONG
        RET
STOPSONG:
        CLR     ET1
        CLR     PLAYING
        MOV     CURNOTE,#0
        SETB    ET1
        AJMP    TONE_OFF

; SCROLL: move a message (segment codes ending with 00H, DPTR) from
; right to left, A x 10 ms per step. Out: C = 1 if a button cut it short.
SCROLL: MOV     R3,A
SC_F:   MOV     R0,#DISP
        MOV     R2,#0
SC_C:   MOV     A,R2
        MOVC    A,@A+DPTR
        JZ      SC_END          ; the end came into the window
        MOV     @R0,A
        INC     R0
        INC     R2
        CJNE    R2,#4,SC_C
        MOV     A,R3
        MOV     B,#10
        MUL     AB
        MOV     R7,A
        MOV     R6,B
        ACALL   STARTMS
SC_W:   ACALL   KEYS
        JNZ     SC_KEY
        JB      DLYRUN,SC_W
        INC     DPTR
        SJMP    SC_F
SC_END: CLR     C
        RET
SC_KEY: SETB    C
        RET

; SHOW4: copy 4 segment codes from DPTR to the display
SHOW4:  MOV     R0,#DISP
        MOV     R2,#0
S4_L:   MOV     A,R2
        MOVC    A,@A+DPTR
        MOV     @R0,A
        INC     R0
        INC     R2
        CJNE    R2,#4,S4_L
        RET

; SHOW2: A = 0..99 on digits 3 and 4 (with a leading 0)
SHOW2:  MOV     B,#10
        DIV     AB              ; A = tens, B = units
        MOV     DPTR,#DIGSEG
        MOVC    A,@A+DPTR
        MOV     DISP+2,A
        MOV     A,B
        MOVC    A,@A+DPTR
        MOV     DISP+3,A
        RET

; SHOWDEC: R6:R7 (0..9999) in decimal on all four digits, no leading zeros
SHOWDEC:CLR     NZFLAG
        MOV     R0,#DISP
        MOV     R2,#HIGH(1000)
        MOV     R3,#LOW(1000)
        ACALL   SD_DIG
        MOV     R2,#0
        MOV     R3,#100
        ACALL   SD_DIG
        MOV     R2,#0
        MOV     R3,#10
        ACALL   SD_DIG
        SETB    NZFLAG          ; the units digit is always shown
        MOV     A,R7
        SJMP    SD_PUT
SD_DIG: MOV     R4,#0           ; A = how many times R2:R3 fits into R6:R7
SD_SUB: CLR     C
        MOV     A,R7
        SUBB    A,R3
        MOV     B,A
        MOV     A,R6
        SUBB    A,R2
        JC      SD_CNT
        MOV     R6,A
        MOV     R7,B
        INC     R4
        SJMP    SD_SUB
SD_CNT: MOV     A,R4
SD_PUT: JNZ     SD_NZ
        JB      NZFLAG,SD_SEG
        MOV     @R0,#SG_SP      ; leading zero: blank
        INC     R0
        RET
SD_NZ:  SETB    NZFLAG
SD_SEG: MOV     DPTR,#DIGSEG
        MOVC    A,@A+DPTR
        MOV     @R0,A
        INC     R0
        RET

; RAND: next number of an 8-bit shift register generator (255 states)
RAND:   MOV     A,RND
        CLR     C
        RRC     A
        JNC     RD_X
        XRL     A,#0B8H
RD_X:   MOV     RND,A
        RET

;===================== Timer 1 interrupt: every 1 ms ===================
T1_ISR: MOV     TH1,#HIGH(T1RL) ; reload first
        MOV     TL1,#LOW(T1RL)
        PUSH    PSW
        PUSH    ACC
        MOV     PSW,#08H        ; register bank 1 (R0, R6, R7 of the ISR)
        INC     TICKL           ; milliseconds since power on
        MOV     A,TICKL
        JNZ     T1_DLY
        INC     TICKH
T1_DLY: JNB     DLYRUN,T1_MUS   ; wait timer
        MOV     A,DLYL
        JNZ     T1_DL
        DEC     DLYH
T1_DL:  DEC     DLYL
        MOV     A,DLYL
        ORL     A,DLYH
        JNZ     T1_MUS
        CLR     DLYRUN
T1_MUS: JNB     PLAYING,T1_DSP  ; tune player, every 10 ms
        DJNZ    PRE,T1_DSP
        MOV     PRE,#10
        DJNZ    NOTECNT,T1_GAP
        PUSH    DPL             ; next note
        PUSH    DPH
        MOV     DPL,SONGL
        MOV     DPH,SONGH
        CLR     A
        MOVC    A,@A+DPTR       ; note
        MOV     R6,A
        INC     DPTR
        CLR     A
        MOVC    A,@A+DPTR       ; length in 10 ms steps
        INC     DPTR
        MOV     SONGL,DPL
        MOV     SONGH,DPH
        JZ      T1_END
        MOV     NOTECNT,A
        MOV     A,R6
        MOV     C,ACC.7
        MOV     LEGATO,C
        ANL     A,#7FH
        MOV     CURNOTE,A
        ACALL   TONE
        SJMP    T1_POP
T1_END: CLR     PLAYING         ; end of the tune
        MOV     CURNOTE,#0
        ACALL   TONE_OFF
T1_POP: POP     DPH
        POP     DPL
        SJMP    T1_DSP
T1_GAP: MOV     A,NOTECNT       ; 20 ms before the next note: a short gap,
        CJNE    A,#2,T1_DSP     ; so that repeated notes sound separate
        JB      LEGATO,T1_DSP
        MOV     CURNOTE,#0
        ACALL   TONE_OFF
T1_DSP: MOV     P1,#0FFH        ; display: all digits off first (no ghosts)
        JB      LEDMODE,T1_LED
        INC     R7              ; next digit 0..3
        MOV     A,R7
        ANL     A,#03H
        MOV     R7,A
        ADD     A,#DISP
        MOV     R0,A
        MOV     P0,@R0          ; its segments
        MOV     A,R7
        ADD     A,#T1_TAB-T1_PC
        MOVC    A,@A+PC         ; its enable bit
T1_PC:  MOV     P1,A
        SJMP    T1_X
T1_TAB: DB      0F7H,0EFH,0DFH,0BFH     ; P1.3, P1.4, P1.5, P1.6 low
T1_LED: MOV     P0,LEDPAT       ; LED mode: digits stay off
T1_X:   POP     ACC
        POP     PSW
        RETI

;=========================== tables ====================================
NOTES:  DW      0FC96H          ;  1 C5   523 Hz  (65536 - 460800/f + 7)
        DW      0FCF6H          ;  2 D5   587
        DW      0FD4CH          ;  3 E5   659
        DW      0FD73H          ;  4 F5   698
        DW      0FDBBH          ;  5 G5   784
        DW      0FDFBH          ;  6 A5   880
        DW      0FE34H          ;  7 B5   988
        DW      0FE4FH          ;  8 C6  1047
        DW      0FE7FH          ;  9 D6  1175
        DW      0FEAAH          ; 10 E6  1319
        DW      0FEBDH          ; 11 F6  1397
        DW      0FEE1H          ; 12 G6  1568
        DW      0FF01H          ; 13 A6  1760
        DW      0FF1EH          ; 14 B6  1976
        DW      0FF2BH          ; 15 C7  2093
        DW      0FF43H          ; 16 D7  2349
        DW      0FF58H          ; 17 E7  2637
        DW      0FF62H          ; 18 F7  2794
        DW      0FF74H          ; 19 G7  3136
        DW      0FF84H          ; 20 A7  3520
        DW      0FF92H          ; 21 B7  3951
        DW      0FF99H          ; 22 C8  4186
        DW      0F407H          ; 23 low buzz 150 Hz

DIGSEG: DB      SG_0,SG_1,SG_2,SG_3,SG_4,SG_5,SG_6,SG_7,SG_8,SG_9
ONEHOT: DB      0FEH,0FDH,0FBH,0F7H,0EFH,0DFH,0BFH,07FH ; one LED, D1..D8
BARS:   DB      0FFH,0FEH,0FCH,0F8H,0F0H,0E0H,0C0H,080H,000H ; 0..8 LEDs
PADSEG: DB      SG_UC,SG_E,SG_G,SG_UC AND 7FH   ; C E G C. above S5 S4 S3 S2
PADNOTE:DB      N_C6,N_E6,N_G6,N_C7

; messages: segment codes, 00H ends a scrolling message
M_HELLO:DB      SG_SP,SG_SP,SG_SP,SG_H,SG_E,SG_L,SG_L,SG_O,SG_SP,SG_SP,SG_SP,SG_SP,0
M_LEGEND:
        DB      SG_SP,SG_SP,SG_SP,SG_P,SG_I,SG_A,SG_LN,SG_LO,SG_SP,SG_DASH,SG_SP
        DB      SG_E,SG_UC,SG_H,SG_O,SG_SP,SG_DASH,SG_SP
        DB      SG_S,SG_O,SG_LN,SG_G,SG_SP,SG_DASH,SG_SP
        DB      SG_LR,SG_E,SG_A,SG_LC,SG_LT,SG_SP,SG_SP,SG_SP,0
M_PIANO:DB      SG_SP,SG_SP,SG_SP,SG_P,SG_I,SG_A,SG_LN,SG_LO,SG_SP,SG_SP,SG_SP,SG_SP,0
M_ECHO: DB      SG_SP,SG_SP,SG_SP,SG_E,SG_UC,SG_H,SG_O,SG_SP,SG_SP,SG_SP,SG_SP,0
M_ODE:  DB      SG_SP,SG_SP,SG_SP,SG_O,SG_LD,SG_E,SG_SP,SG_LT,SG_LO,SG_SP
        DB      SG_J,SG_O,SG_LY,SG_SP,SG_SP,SG_SP,SG_SP,0
M_REACT:DB      SG_SP,SG_SP,SG_SP,SG_LR,SG_E,SG_A,SG_LC,SG_LT,SG_SP,SG_SP,SG_SP,SG_SP,0
M_SUPER:DB      SG_SP,SG_SP,SG_SP,SG_S,SG_U,SG_P,SG_E,SG_LR,SG_SP,SG_SP,SG_SP,SG_SP,0
; 4-digit pictures
M_MENU: DB      SG_P,SG_E,SG_5,SG_LR
M_LOST: DB      SG_L,SG_LO,SG_S,SG_LT
M_DASH: DB      SG_DASH,SG_DASH,SG_DASH,SG_DASH
M_GO:   DB      SG_SP,SG_SP,SG_G,SG_LO
M_LATE: DB      SG_L,SG_A,SG_LT,SG_E
M_ERR:  DB      SG_SP,SG_E,SG_LR,SG_LR

; tunes: note, length in 10 ms steps ... 0,0
T_SWEEP:DB      N_C6+LEG,6,N_D6+LEG,6,N_E6+LEG,6,N_F6+LEG,6,N_G6+LEG,6
        DB      N_A6+LEG,6,N_B6+LEG,6,N_C7+LEG,6,N_D7+LEG,6,N_E7+LEG,6
        DB      N_F7+LEG,6,N_G7+LEG,6,N_A7+LEG,6,N_B7+LEG,6,N_C8+LEG,6
        DB      N_B7+LEG,6,N_A7+LEG,6,N_G7+LEG,6,N_F7+LEG,6,N_E7+LEG,6
        DB      N_D7+LEG,6,N_C7+LEG,6,N_B6+LEG,6,N_A6+LEG,6,N_G6+LEG,6
        DB      N_F6+LEG,6,N_E6+LEG,6,N_D6+LEG,6,N_C6,12,0,0
T_HELLO:DB      N_G6,14,N_C7,14,N_E7,14,N_G7,28,N_E7,14,N_G7,50,0,0
T_CLICK:DB      N_G7,5,0,0
T_OK:   DB      N_C7+LEG,7,N_E7+LEG,7,N_G7,14,0,0
T_WIN:  DB      N_C7,12,N_E7,12,N_G7,12,N_C8,30,N_G7,12,N_C8,60,0,0
T_LOSE: DB      N_G6,22,N_E6,22,N_C6,22,N_LOW,60,0,0
T_GO:   DB      N_C8,12,0,0
T_BUZZ: DB      N_LOW,45,0,0
T_ODE:  DB      N_E6,40,N_E6,40,N_F6,40,N_G6,40, N_G6,40,N_F6,40,N_E6,40,N_D6,40
        DB      N_C6,40,N_C6,40,N_D6,40,N_E6,40, N_E6,60,N_D6,20,N_D6,80
        DB      N_E6,40,N_E6,40,N_F6,40,N_G6,40, N_G6,40,N_F6,40,N_E6,40,N_D6,40
        DB      N_C6,40,N_C6,40,N_D6,40,N_E6,40, N_D6,60,N_C6,20,N_C6,80
        DB      N_D6,40,N_D6,40,N_E6,40,N_C6,40, N_D6,40,N_E6,20,N_F6,20,N_E6,40,N_C6,40
        DB      N_D6,40,N_E6,20,N_F6,20,N_E6,40,N_D6,40, N_C6,40,N_D6,40,N_G5,80
        DB      N_E6,40,N_E6,40,N_F6,40,N_G6,40, N_G6,40,N_F6,40,N_E6,40,N_D6,40
        DB      N_C6,40,N_C6,40,N_D6,40,N_E6,40, N_D6,60,N_C6,20,N_C6,80
        DB      0,0

        END
