;=======================================================================
; STC89C52RC board demo 2: light and games, without a sound
;
; Power on: a light with a fading tail runs up and down the LEDs, all
; eight LEDs breathe once, a snake runs round the edge of the display,
; HELLO AGAIN scrolls past, then the names of the four modes, and the
; menu stays on the display with one letter above each button:
;
;       C   r   L   P
;      S5  S4  S3  S2
;
;   S5  C  Chrono   stopwatch in hundredths of a second. S5 starts and
;                   stops it, S4 freezes the display while it runs
;                   (a split time) or sets it to zero when stopped,
;                   S2 goes back to the menu
;   S4  r  Race     three lanes: the top, middle and bottom segments.
;                   Your car blinks on the left digit, the other cars
;                   come from the right. S5 steers up, S4 down. Every
;                   car you pass makes the road a little faster
;   S3  L  Lights   five LED effects with 16 brightness levels: comet,
;                   breathing, stars, wave, bouncing ball. S3 shows the
;                   next effect, any other button goes to the menu
;   S2  P  Pong     for two players. The ball runs along the LEDs; S5
;                   hits it back when it is on D1, S2 when it is on D8.
;                   First to 5 points
;
; Leave the menu alone for 12 s and the light show runs once by itself,
; then the menu comes back: the board can run unattended on a desk.
;
; Board wiring (TSI STC89C52RC board):
;   P0.0-P0.7  segments a-g, dp (lit by 0) and LEDs D1-D8 (lit by 0)
;   P1.3-P1.6  digit enables, left to right (digit on at 0)
;   P3.5-P3.2  buttons S5, S4, S3, S2 (a pressed button reads 0)
;   P3.6       buzzer: this program never touches it
; Clock 11.0592 MHz, 12 clocks per machine cycle: 921 600 cycles a second
;
; How it works:
;   Timer 2, the third timer of the 8052, reloads itself in hardware
;   every 1152 cycles, which is exactly 1.25 ms. Its interrupt lights
;   the next digit, and every eighth one (10 ms) marks a new frame for
;   the main program and counts the stopwatch.
;   Timer 0 makes the LED brightness. In LED mode it switches P0
;   between five bit patterns that last 1, 2, 4, 8 and 16 time units
;   (binary code modulation), so each LED can be lit for 0 to 31 of
;   the 31 units, about 620 times a second.
;   The LEDs and the segments share P0, so the board shows either the
;   digits or the LEDs, never both at once.
;=======================================================================

; the 8052's Timer 2 registers (A51 knows only the 8051 ones)
T2CON   DATA    0C8H
RCAP2L  DATA    0CAH
RCAP2H  DATA    0CBH
TL2     DATA    0CCH
TH2     DATA    0CDH
TF2     BIT     0CFH            ; T2CON.7: Timer 2 overflowed
TR2     BIT     0CAH            ; T2CON.2: Timer 2 runs
ET2     BIT     0ADH            ; IE.5: Timer 2 interrupt enable

;--------------------------- RAM ---------------------------------------
; 08H-0FH  register bank 1, used by the Timer 2 interrupt
;          (R0 pointer, R6 ticks left in the frame, R7 digit 0-3)
; 10H-17H  register bank 2, used by the Timer 0 interrupt
;          (R0 the next PWM slot, R7 slots left in the PWM frame)
; bit flags in 20H
LEDMODE BIT     00H             ; 1: digits off, Timer 0 drives the LEDs
FRAME   BIT     01H             ; set by Timer 2 every 10 ms
SWRUN   BIT     02H             ; 1: the stopwatch is counting
SPLIT   BIT     03H             ; 1: the stopwatch display is frozen
NZFLAG  BIT     04H             ; used by SHOWDEC to blank leading zeros
ATTRACT BIT     05H             ; 1: nobody chose the light show, play one round

FRL     EQU     21H             ; 10 ms frames since power on (16 bits)
FRH     EQU     22H
SWC     EQU     23H             ; stopwatch: hundredths, packed BCD 00-99
SWS     EQU     24H             ;            seconds, packed BCD 00-59
SWM     EQU     25H             ;            minutes 0-9
LPC     EQU     26H             ; the time on the display (a copy)
LPS     EQU     27H
LPM     EQU     28H
KRAW    EQU     29H             ; the buttons at the last look
KDEB    EQU     2AH             ; the buttons after debouncing
KTMP    EQU     2BH
RND     EQU     2CH             ; random number generator state
EFF     EQU     2DH             ; the light effect now running, 0-4
FXT     EQU     2EH             ; 20 ms frames since the effect started
BEST    EQU     2FH             ; Race: best score since power on
DISP    EQU     30H             ; 30H-33H segment codes of digits 1-4
BRI     EQU     34H             ; 34H-3BH brightness of D1-D8, 0-15
PB      EQU     3CH             ; 3CH-40H the five bit patterns being built
SL      EQU     41H             ; 41H-52H nine PWM slots: P0 pattern, next TH0
POS     EQU     53H             ; Lights, Pong: an LED, 0 (D1) to 7 (D8)
DIRN    EQU     54H             ;   its direction: 0 towards D8, 1 towards D1
BY      EQU     55H             ; Lights: ball height in 1/32 of an LED
BV      EQU     56H             ;   ball speed in 1/32 LED per frame (signed)
STEPT   EQU     57H             ; Race, Pong: 10 ms frames per step
STEPC   EQU     58H             ;   frames left in this step
LANE    EQU     59H             ; Race: your lane, 0 top, 1 middle, 2 bottom
SCORE   EQU     5AH             ;   cars passed
GAP     EQU     5BH             ;   empty digits before the next car
SCL     EQU     5AH             ; Pong: points of the D1 player (SCORE)
SCR     EQU     5BH             ;   points of the D8 player (GAP)
ROAD    EQU     5CH             ; Race: 5CH-5FH lanes taken in digits 1-4
; stack 60H-7FH (SP starts at 5FH)

;--------------------------- constants ---------------------------------
T2RL    EQU     0FB80H          ; 65536 - 1152: Timer 2 overflows every 1.25 ms

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
SG_LB   EQU     083H            ; b
SG_UC   EQU     0C6H            ; C
SG_E    EQU     086H
SG_G    EQU     0C2H
SG_H    EQU     089H
SG_I    EQU     0CFH            ; I on the left (1 is on the right)
SG_L    EQU     0C7H
SG_LN   EQU     0ABH            ; n
SG_LO   EQU     0A3H            ; o
SG_O    EQU     0C0H
SG_P    EQU     08CH
SG_LR   EQU     0AFH            ; r
SG_S    EQU     092H
SG_LT   EQU     087H            ; t
SG_DASH EQU     0BFH
SG_SP   EQU     0FFH            ; blank

;--------------------------- vectors -----------------------------------
        ORG     0000H
        LJMP    START

; Timer 0: the next PWM slot begins. Timer 0 runs in mode 2, where it
; reloads TL0 from TH0 by itself, so a slot lasts exactly 256 - TH0
; cycles however late this interrupt starts. (The code runs on over
; 0013H and 001BH: INT1 and Timer 1 are not used.)
        ORG     000BH
        PUSH    PSW
        MOV     PSW,#10H        ; register bank 2
        MOV     P0,@R0          ; this slot's LED pattern
        INC     R0
        MOV     TH0,@R0         ; the length of the slot after this one
        INC     R0
        DJNZ    R7,T0_X
        MOV     R0,#SL          ; all nine slots done: the frame starts again
        MOV     R7,#9
T0_X:   POP     PSW
        RETI

        ORG     002BH           ; Timer 2: every 1.25 ms
        LJMP    T2_ISR

;--------------------------- start -------------------------------------
        ORG     0030H
START:  MOV     SP,#5FH
        MOV     P0,#0FFH        ; segments and LEDs off
        MOV     P1,#0FFH        ; digits off
        MOV     R0,#08H         ; clear the register banks, flags and
CLRRAM: MOV     @R0,#0          ; variables, 08H-5FH
        INC     R0
        CJNE    R0,#60H,CLRRAM
        ACALL   BLANK
        MOV     RND,#5AH
        MOV     R0,#SL          ; PWM slots: every LED off, and each
        MOV     DPTR,#SLTH      ; slot's reload for the slot after it
        MOV     R2,#0
ST_SL:  MOV     @R0,#0FFH
        INC     R0
        MOV     A,R2
        MOVC    A,@A+DPTR
        MOV     @R0,A
        INC     R0
        INC     R2
        CJNE    R2,#9,ST_SL
        MOV     10H,#SL         ; bank 2 R0: the first slot
        MOV     17H,#9          ; bank 2 R7: nine slots in a frame
        MOV     0EH,#8          ; bank 1 R6: eight ticks make 10 ms
        MOV     TMOD,#02H       ; Timer 0: 8-bit auto-reload (mode 2)
        MOV     TH0,#0D0H
        MOV     TL0,#0D0H
        MOV     T2CON,#00H      ; Timer 2: 16-bit auto-reload from RCAP2
        MOV     RCAP2H,#HIGH(T2RL)
        MOV     RCAP2L,#LOW(T2RL)
        MOV     TH2,#HIGH(T2RL)
        MOV     TL2,#LOW(T2RL)
        SETB    TR2
        MOV     IP,#02H         ; PT0: a PWM slot may interrupt Timer 2
        MOV     IE,#0A2H        ; EA + ET2 + ET0

; intro 1: a light with a tail runs up and down the LEDs, then they breathe
        ACALL   LEDON
        CLR     A               ; effect 0, the comet, for 2.2 s
        MOV     R5,#110
        ACALL   RUNFX
        JC      MENU            ; a button skips the intro
        MOV     A,#1            ; effect 1, one breath (1.28 s)
        MOV     R5,#64
        ACALL   RUNFX
        JC      MENU
        ACALL   LEDOFF
; intro 2: a snake runs three times round the display, then the greeting
        MOV     R5,#36
        ACALL   CHASE
        MOV     DPTR,#M_HELLO
        MOV     A,#20           ; 200 ms per step
        ACALL   SCROLL
        JC      MENU
        MOV     DPTR,#M_LEGEND
        MOV     A,#18           ; 180 ms per step
        ACALL   SCROLL

;--------------------------- menu --------------------------------------
MENU:   ACALL   LEDOFF
        CLR     SWRUN
        MOV     DPTR,#M_MENU
        ACALL   SHOW4           ; C r L P
        ACALL   KEYCLR
        MOV     R5,#120         ; 12 s
        ACALL   WAITNEW
        JNC     MN_IDL          ; nobody there
        JB      ACC.3,MN_C      ; the leftmost button pressed wins
        JB      ACC.2,MN_R
        JB      ACC.1,MN_L
        AJMP    PONG
MN_C:   AJMP    CHRONO
MN_R:   AJMP    RACE
MN_IDL: SETB    ATTRACT         ; one round of the light show, then the menu
        SJMP    MN_GO
MN_L:   CLR     ATTRACT         ; chosen: the effects go round until a button
MN_GO:  AJMP    LIGHTS

;========================= mode 1: Chrono ==============================
; A stopwatch. Timer 2 counts the time in packed BCD (the instruction
; DA A turns a binary sum back into two decimal digits), so showing it
; needs no division. Under a minute the display reads ss.hh, from one
; minute m.ss.h, up to 9.59.9.
CHRONO: MOV     DPTR,#M_CHRONO
        MOV     A,#16
        ACALL   SCROLL
CR_Z:   CLR     SWRUN           ; stopped at zero
        CLR     SPLIT
        CLR     A
        MOV     SWC,A
        MOV     SWS,A
        MOV     SWM,A
CR_L:   MOV     A,#1
        ACALL   WAITF           ; every 10 ms:
        JB      SPLIT,CR_K
        CLR     ET2             ; take the time in one piece (Timer 2 may
        MOV     LPC,SWC         ; not count between these three moves)
        MOV     LPS,SWS
        MOV     LPM,SWM
        SETB    ET2
        ACALL   SWSHOW
CR_K:   ACALL   NEWKEYS
        JZ      CR_L
        JB      ACC.0,CR_X      ; S2: back to the menu
        JNB     ACC.3,CR_4
        CPL     SWRUN           ; S5: start or stop
        CLR     SPLIT
        SJMP    CR_L
CR_4:   JNB     ACC.2,CR_L
        JNB     SWRUN,CR_Z      ; S4 when stopped: back to zero
        CPL     SPLIT           ; S4 when running: freeze or free the display
        SJMP    CR_L
CR_X:   AJMP    MENU

; SWSHOW: the time in LPM, LPS, LPC on the display
SWSHOW: MOV     DPTR,#DIGSEG
        MOV     A,LPM
        JNZ     SW_M
        MOV     A,LPS           ; under a minute: ss.hh
        SWAP    A
        ANL     A,#0FH
        JNZ     SW_T
        MOV     DISP+0,#SG_SP   ; no leading zero
        SJMP    SW_U
SW_T:   MOVC    A,@A+DPTR
        MOV     DISP+0,A
SW_U:   MOV     A,LPS
        ACALL   SEGLO
        ANL     A,#7FH          ; the decimal point after the seconds
        MOV     DISP+1,A
        MOV     A,LPC
        ACALL   SEGHI
        MOV     DISP+2,A
        MOV     A,LPC
        ACALL   SEGLO
        MOV     DISP+3,A
        RET
SW_M:   ACALL   SEGLO           ; from one minute: m.ss.h
        ANL     A,#7FH
        MOV     DISP+0,A
        MOV     A,LPS
        ACALL   SEGHI
        MOV     DISP+1,A
        MOV     A,LPS
        ACALL   SEGLO
        ANL     A,#7FH
        MOV     DISP+2,A
        MOV     A,LPC
        ACALL   SEGHI
        MOV     DISP+3,A
        RET
; SEGHI, SEGLO: the segment code of the high or low BCD digit of A
; (DPTR = DIGSEG)
SEGHI:  SWAP    A
SEGLO:  ANL     A,#0FH
        MOVC    A,@A+DPTR
        RET

;========================== mode 2: Race ===============================
; The road has three lanes, the top, middle and bottom segments of each
; digit. Your car blinks in the left digit; the cars ahead come in from
; the right one digit per step. S5 steers up, S4 down. Each car you pass
; scores a point and takes 10 ms off the step, from 300 ms down to 120.
RACE:   MOV     DPTR,#M_RACE
        MOV     A,#16
        ACALL   SCROLL
RA_GO:  MOV     A,FRL           ; seed the random numbers from the time
        XRL     A,RND
        JNZ     RA_S
        INC     A
RA_S:   MOV     RND,A
        MOV     R5,#3           ; 3, 2, 1 in your car's digit
RA_CD:  ACALL   BLANK
        MOV     A,R5
        MOV     DPTR,#DIGSEG
        MOVC    A,@A+DPTR
        MOV     DISP+0,A
        MOV     A,#50
        ACALL   WAITF
        DJNZ    R5,RA_CD
        CLR     A               ; an empty road
        MOV     ROAD+0,A
        MOV     ROAD+1,A
        MOV     ROAD+2,A
        MOV     ROAD+3,A
        MOV     SCORE,A
        MOV     LANE,#1         ; start in the middle lane
        MOV     GAP,#2
        MOV     STEPT,#30       ; 300 ms per step
        MOV     STEPC,#30
        ACALL   KEYCLR
RA_F:   ACALL   RA_DRAW         ; every 10 ms:
        MOV     A,#1
        ACALL   WAITF
        ACALL   NEWKEYS
        MOV     R4,A
        JNB     ACC.3,RA_D      ; S5: one lane up
        MOV     A,LANE
        JZ      RA_D
        DEC     LANE
RA_D:   MOV     A,R4
        JNB     ACC.2,RA_H      ; S4: one lane down
        MOV     A,LANE
        CJNE    A,#2,RA_DN
        SJMP    RA_H
RA_DN:  INC     LANE
RA_H:   ACALL   RA_HIT          ; steered into a car?
        JC      RA_X
        DJNZ    STEPC,RA_F
        MOV     STEPC,STEPT     ; time to move the road one digit left
        MOV     A,ROAD+0
        JZ      RA_SH
        INC     SCORE           ; the cars beside you are now behind you
        MOV     A,STEPT
        CJNE    A,#12,RA_FS
        SJMP    RA_SH
RA_FS:  DEC     STEPT           ; and the road gets faster
RA_SH:  MOV     ROAD+0,ROAD+1
        MOV     ROAD+1,ROAD+2
        MOV     ROAD+2,ROAD+3
        ACALL   RA_NEW
        MOV     ROAD+3,A
        ACALL   RA_HIT          ; did a car run into you?
        JNC     RA_F
; crash: the whole display flashes, and with it every LED
RA_X:   MOV     R5,#4
RX_L:   CLR     A               ; all segments and points on
        ACALL   FILL
        MOV     A,#12
        ACALL   WAITF
        ACALL   RA_DRAW
        MOV     A,#12
        ACALL   WAITF
        DJNZ    R5,RX_L
        MOV     A,BEST
        CLR     C
        SUBB    A,SCORE         ; C = 1 when SCORE > BEST
        JNC     RX_W
        MOV     BEST,SCORE
        MOV     R5,#3
RX_B:   MOV     DPTR,#M_BEST    ; a new best: bESt flashes three times
        ACALL   SHOW4
        MOV     A,#40
        ACALL   WAITF
        ACALL   BLANK
        MOV     A,#15
        ACALL   WAITF
        DJNZ    R5,RX_B
RX_W:   MOV     R6,#0           ; the score stays for 5 s:
        MOV     R7,SCORE        ; S4 races again, any other button or
        ACALL   SHOWDEC         ; no button goes to the menu
        ACALL   KEYCLR
        MOV     R5,#50
        ACALL   WAITNEW
        JNC     RX_M
        JNB     ACC.2,RX_M
        AJMP    RA_GO
RX_M:   AJMP    MENU

; RA_DRAW: the road on the display, and your car while it blinks on
RA_DRAW:MOV     R0,#DISP
        MOV     R1,#ROAD
        MOV     DPTR,#LANESEG
RD_L:   MOV     A,@R1
        MOVC    A,@A+DPTR
        MOV     @R0,A
        INC     R0
        INC     R1
        CJNE    R0,#DISP+4,RD_L
        MOV     A,FRL           ; the car is dark for 80 ms of every 320
        ANL     A,#18H
        CJNE    A,#18H,RD_CAR
        RET
RD_CAR: MOV     A,LANE
        MOV     DPTR,#LANEBIT
        MOVC    A,@A+DPTR
        MOV     DPTR,#LANESEG
        MOVC    A,@A+DPTR
        ANL     DISP+0,A
        RET

; RA_HIT: C = 1 when a car is in your lane in your digit
RA_HIT: MOV     A,LANE
        MOV     DPTR,#LANEBIT
        MOVC    A,@A+DPTR
        ANL     A,ROAD+0
        ADD     A,#0FFH         ; carry unless A was 0
        RET

; RA_NEW: A = the lanes taken in the new right-hand digit
RA_NEW: MOV     A,GAP
        JZ      RN_CAR
        DEC     GAP             ; an empty stretch of road
        CLR     A
        RET
RN_CAR: ACALL   RAND
        MOV     B,#3
        DIV     AB              ; B = a lane, 0-2
        MOV     A,B
        MOV     DPTR,#LANEBIT
        MOVC    A,@A+DPTR
        MOV     R2,A            ; one car in that lane
        MOV     GAP,#1
        MOV     A,SCORE
        CJNE    A,#10,$+3       ; C = 1 while SCORE < 10
        JC      RN_X
        MOV     A,RND
        JNB     ACC.0,RN_X      ; from 10 points on, half the time:
        MOV     A,R2
        XRL     A,#07H          ; two cars, only that lane is free,
        MOV     R2,A
        MOV     GAP,#2          ; and more room after them
RN_X:   MOV     A,R2
        RET

;========================= mode 3: Lights ==============================
; Five effects, 5 s each, round and round. S3 shows the next one at
; once, any other button goes back to the menu. When the menu started
; the show by itself, one round of the five is enough.
LIGHTS: MOV     DPTR,#M_LIGHTS
        MOV     A,#16
        ACALL   SCROLL
        ACALL   LEDON
        MOV     EFF,#0
LS_N:   MOV     A,EFF
        MOV     R5,#250         ; 250 frames of 20 ms
        ACALL   RUNFX
        JNC     LS_NX           ; time is up: the next effect
        JNB     ACC.1,LS_X      ; S3: the next effect, others: menu
LS_NX:  INC     EFF
        MOV     A,EFF
        CJNE    A,#5,LS_N
        MOV     EFF,#0
        JB      ATTRACT,LS_X
        SJMP    LS_N
LS_X:   AJMP    MENU

; RUNFX: light effect A for R5 frames of 20 ms. Out: C = 0 when the
; time is up; C = 1 and A = the new presses when a button cut it short.
RUNFX:  MOV     EFF,A
        ACALL   FXINIT
RF_L:   MOV     A,#2
        ACALL   WAITF
        ACALL   NEWKEYS
        JNZ     RF_K
        ACALL   FX_DO           ; the new brightness of every LED
        ACALL   SHOWLED         ; handed to Timer 0
        INC     FXT
        DJNZ    R5,RF_L
        CLR     C
        RET
RF_K:   SETB    C
        RET

; FX_DO: one 20 ms frame of effect EFF (each effect leaves R5 alone)
FX_DO:  MOV     A,EFF
        RL      A               ; each AJMP takes 2 bytes
        MOV     DPTR,#FX_TAB
        JMP     @A+DPTR
FX_TAB: AJMP    FX_COMET
        AJMP    FX_BREATH
        AJMP    FX_STARS
        AJMP    FX_WAVE
        AJMP    FX_BALL

; comet: the head moves one LED every 40 ms and bounces at the ends;
; the LEDs behind it fade two levels a frame
FX_COMET:
        MOV     R2,#2
        ACALL   FADE
        MOV     A,FXT
        JNB     ACC.0,CO_D      ; move on every second frame (frame 0 shows D1)
        MOV     A,DIRN
        JNZ     CO_UP
        INC     POS             ; towards D8
        MOV     A,POS
        CJNE    A,#7,CO_D
        MOV     DIRN,#1
        SJMP    CO_D
CO_UP:  DEC     POS             ; towards D1
        MOV     A,POS
        JNZ     CO_D
        MOV     DIRN,#0
CO_D:   MOV     A,POS
        AJMP    LIGHT

; breathing: all LEDs up from 0 to 15 and down again in 64 frames
FX_BREATH:
        MOV     A,FXT
        ANL     A,#3FH
        JNB     ACC.5,BR_S      ; frames 0-31 go up
        CPL     A               ; frames 32-63 go down: 63 - frame
        ANL     A,#1FH
BR_S:   CLR     C
        RRC     A               ; 0-31 -> 0-15
        MOV     R0,#BRI
BR_L:   MOV     @R0,A
        INC     R0
        CJNE    R0,#BRI+8,BR_L
        RET

; stars: in one frame of four (on average) a random LED flashes up;
; every LED fades one level each 40 ms
FX_STARS:
        MOV     A,FXT
        JB      ACC.0,ST_N
        MOV     R2,#1
        ACALL   FADE
ST_N:   ACALL   RAND
        MOV     B,A
        ANL     A,#18H
        JNZ     ST_X
        MOV     A,B
        ANL     A,#07H
        AJMP    LIGHT
ST_X:   RET

; wave: a sine wave runs down the LEDs, one LED every 80 ms; LED n is
; two table steps behind LED n-1, so the eight LEDs hold one wavelength
FX_WAVE:MOV     A,FXT
        CLR     C
        RRC     A
        MOV     R2,A            ; the phase of D1
        MOV     R0,#BRI
        MOV     DPTR,#SINE
WA_L:   MOV     A,R2
        ANL     A,#0FH
        MOVC    A,@A+DPTR
        MOV     @R0,A
        DEC     R2
        DEC     R2
        INC     R0
        CJNE    R0,#BRI+8,WA_L
        RET

; bouncing ball: gravity takes 1/32 LED per frame off the speed, the
; height changes by the speed; at the floor (D8) the ball keeps 3/4 of
; its speed. When it bounces too low a new ball drops from D1.
FX_BALL:MOV     R2,#3
        ACALL   FADE            ; a short trail
        DEC     BV              ; gravity
        MOV     A,BV
        JNB     ACC.7,BA_UP     ; speed >= 0: on the way up
        ADD     A,BY            ; falling: height + speed; no carry means
        JC      BA_Y            ; the ball went through the floor
        MOV     A,BV            ; bounce:
        CPL     A
        INC     A               ; the impact speed, positive
        MOV     R2,A
        CLR     C
        RRC     A
        CLR     C
        RRC     A               ; a quarter of it
        XCH     A,R2
        CLR     C
        SUBB    A,R2            ; three quarters of the speed, upwards
        CJNE    A,#4,$+3        ; C = 1 when it is below 4
        JC      BA_NEW
        MOV     BV,A
        CLR     A               ; height 0: on the floor
        SJMP    BA_Y
BA_NEW: MOV     BV,#0           ; a new ball at the top
        MOV     A,#224
        SJMP    BA_Y
BA_UP:  ADD     A,BY
BA_Y:   MOV     BY,A
        SWAP    A               ; height / 32 = 0-7 LEDs above the floor
        RR      A
        ANL     A,#07H
        XRL     A,#07H          ; D8 is the floor: LED = 7 - height
        AJMP    LIGHT

; FXINIT: all LEDs dark and every effect at its start
FXINIT: ACALL   CLRBRI
        CLR     A
        MOV     FXT,A
        MOV     POS,A
        MOV     DIRN,A
        MOV     BV,A
        MOV     BY,#224         ; the ball starts at the top (D1)
        RET

;========================== mode 4: Pong ===============================
; Two players. The ball runs along the LEDs with a fading tail. S5 hits
; it back when it is on D1, S2 when it is on D8; pressing while the ball
; is still on its way to you is a miss. Each return takes 20 ms off the
; step, from 280 ms down to 80. First to 5 points wins.
PONG:   MOV     DPTR,#M_PONG
        MOV     A,#16
        ACALL   SCROLL
        MOV     SCL,#0
        MOV     SCR,#0
        MOV     POS,#0          ; the first serve starts at D1
        MOV     DIRN,#0
PG_SV:  ACALL   PG_SHOW         ; the score for 1.5 s
        MOV     STEPT,#28       ; 280 ms per LED
        MOV     STEPC,#28
        ACALL   CLRBRI
        ACALL   KEYCLR
        ACALL   LEDON
PG_F:   MOV     R2,#1           ; every 10 ms: the tail fades a level,
        ACALL   FADE
        MOV     A,POS           ; the ball is at full brightness
        ACALL   LIGHT
        ACALL   SHOWLED
        MOV     A,#1
        ACALL   WAITF
        ACALL   NEWKEYS
        MOV     R4,A
        JNB     ACC.3,PG_B      ; S5: the D1 player hits
        MOV     A,DIRN
        JZ      PG_B            ; the ball is going away: no effect
        MOV     A,POS
        JNZ     PG_TOP          ; too early: a miss
        MOV     DIRN,#0         ; a return, towards D8
        ACALL   PG_HIT
PG_B:   MOV     A,R4
        JNB     ACC.0,PG_MV     ; S2: the D8 player hits
        MOV     A,DIRN
        JNZ     PG_MV
        MOV     A,POS
        CJNE    A,#7,PG_BOT     ; too early: a miss
        MOV     DIRN,#1         ; a return, towards D1
        ACALL   PG_HIT
PG_MV:  DJNZ    STEPC,PG_F
        MOV     STEPC,STEPT     ; time for the ball to move one LED
        MOV     A,DIRN
        JNZ     PG_UP
        MOV     A,POS
        CJNE    A,#7,PG_DN
        SJMP    PG_BOT          ; it left D8: the D8 player missed
PG_DN:  INC     POS
        SJMP    PG_F
PG_UP:  MOV     A,POS
        JZ      PG_TOP          ; it left D1: the D1 player missed
        DEC     POS
        SJMP    PG_F
PG_TOP: INC     SCR             ; a point for D8, and D1 serves
        MOV     POS,#0
        MOV     DIRN,#0
        SJMP    PG_PT
PG_BOT: INC     SCL             ; a point for D1, and D8 serves
        MOV     POS,#7
        MOV     DIRN,#1
PG_PT:  MOV     A,SCL
        CJNE    A,#5,PG_P2
        SJMP    PG_WIN
PG_P2:  MOV     A,SCR
        CJNE    A,#5,PG_SV
PG_WIN: ACALL   PG_SHOW         ; the final score, then the winner's
        ACALL   LEDON           ; half of the LEDs flashes five times
        MOV     R5,#5
PW_L:   ACALL   CLRBRI
        MOV     R0,#BRI         ; D1-D4 for the D1 player
        MOV     A,SCL
        CJNE    A,#5,PW_8
        SJMP    PW_S
PW_8:   MOV     R0,#BRI+4       ; D5-D8 for the D8 player
PW_S:   MOV     R2,#4
PW_F:   MOV     @R0,#15
        INC     R0
        DJNZ    R2,PW_F
        ACALL   SHOWLED
        MOV     A,#25
        ACALL   WAITF
        ACALL   CLRBRI
        ACALL   SHOWLED
        MOV     A,#25
        ACALL   WAITF
        DJNZ    R5,PW_L
        AJMP    MENU

; PG_HIT: a return makes the ball faster
PG_HIT: MOV     A,STEPT
        CLR     C
        SUBB    A,#2
        CJNE    A,#8,$+3        ; C = 1 below 8
        JNC     PH_S
        MOV     A,#8
PH_S:   MOV     STEPT,A
        MOV     STEPC,A
        RET

; PG_SHOW: the score as 3--1 on the display for 1.5 s
PG_SHOW:ACALL   LEDOFF
        MOV     DPTR,#DIGSEG
        MOV     A,SCL
        MOVC    A,@A+DPTR
        MOV     DISP+0,A
        MOV     DISP+1,#SG_DASH
        MOV     DISP+2,#SG_DASH
        MOV     A,SCR
        MOVC    A,@A+DPTR
        MOV     DISP+3,A
        MOV     A,#150
        AJMP    WAITF

;========================= LED brightness ==============================
; LEDON: digits off, Timer 0 drives the LEDs. LEDOFF: back to the digits.
LEDON:  SETB    LEDMODE
        MOV     P1,#0FFH
        SETB    TR0
        RET
LEDOFF: CLR     TR0
        CLR     TF0             ; no slot may start after this
        CLR     LEDMODE
        RET

; CLRBRI: every LED at brightness 0
CLRBRI: MOV     R0,#BRI
CB_L:   MOV     @R0,#0
        INC     R0
        CJNE    R0,#BRI+8,CB_L
        RET

; LIGHT: LED A (0 = D1 ... 7 = D8) at full brightness
LIGHT:  ADD     A,#BRI
        MOV     R0,A
        MOV     @R0,#15
        RET

; FADE: every LED R2 levels darker, but not below 0
FADE:   MOV     R0,#BRI
FD_L:   MOV     A,@R0
        CLR     C
        SUBB    A,R2
        JNC     FD_S
        CLR     A
FD_S:   MOV     @R0,A
        INC     R0
        CJNE    R0,#BRI+8,FD_L
        RET

; SHOWLED: turn the brightness of D1-D8 (BRI, 0-15) into the five bit
; patterns Timer 0 shows. Level n is lit for GAMMA(n) of 31 units; the
; eye sees brightness roughly as the square root of the time lit, so
; GAMMA grows about as n squared. Pattern k holds bit k of each LED's
; GAMMA value, inverted because an LED lights at 0. The patterns are
; built in PB first, so Timer 0 never shows a half-built frame.
SHOWLED:MOV     R0,#BRI+7       ; D8 first: after eight shifts it is bit 7
        MOV     DPTR,#GAMMA
SH_L:   MOV     A,@R0
        ANL     A,#0FH
        MOVC    A,@A+DPTR       ; 0-31 units lit
        CPL     A               ; 0 = lit
        MOV     R2,A
        MOV     R1,#PB
        MOV     R3,#5
SH_B:   MOV     A,R2
        RRC     A               ; the next bit into C
        MOV     R2,A
        MOV     A,@R1
        RLC     A               ; and into pattern k
        MOV     @R1,A
        INC     R1
        DJNZ    R3,SH_B
        DEC     R0
        CJNE    R0,#BRI-1,SH_L
        MOV     SL+0,PB+0       ; slot 0: 1 unit  (48 cycles)
        MOV     SL+2,PB+1       ; slot 1: 2 units
        MOV     SL+4,PB+2       ; slot 2: 4 units
        MOV     SL+6,PB+3       ; slots 3-4: 8 units
        MOV     SL+8,PB+3
        MOV     SL+10,PB+4      ; slots 5-8: 16 units
        MOV     SL+12,PB+4
        MOV     SL+14,PB+4
        MOV     SL+16,PB+4
        RET

;========================= display helpers =============================
; CHASE: a snake of four segments runs clockwise round the edge of the
; display, R5 steps of 30 ms
CHASE:  MOV     POS,#3          ; the head
CH_L:   ACALL   BLANK
        MOV     A,POS
        MOV     R2,A
        MOV     R3,#4           ; the head and three behind it
CH_S:   MOV     A,R2
        RL      A               ; 2 bytes per place on the ring
        MOV     DPTR,#RING
        PUSH    ACC
        MOVC    A,@A+DPTR       ; the digit, 0-3
        ADD     A,#DISP
        MOV     R0,A
        POP     ACC
        INC     A
        MOVC    A,@A+DPTR       ; the segment (0 = lit)
        ANL     A,@R0
        MOV     @R0,A
        DEC     R2              ; one place back
        CJNE    R2,#0FFH,CH_B
        MOV     R2,#11
CH_B:   DJNZ    R3,CH_S
        MOV     A,#3
        ACALL   WAITF
        INC     POS
        MOV     A,POS
        CJNE    A,#12,CH_N
        MOV     POS,#0
CH_N:   DJNZ    R5,CH_L
        RET

; SCROLL: move a message (segment codes ending with 00H, DPTR) from
; right to left, A x 10 ms per step. Out: C = 1 if a button cut it short.
SCROLL: MOV     R3,A
        ACALL   KEYCLR          ; a button still held does not count
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
        MOV     R4,A
SC_W:   MOV     A,#1
        ACALL   WAITF
        ACALL   NEWKEYS
        JNZ     SC_KEY
        DJNZ    R4,SC_W
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

; BLANK: all four digits dark. FILL: segment code A on all four digits.
BLANK:  MOV     A,#SG_SP
FILL:   MOV     R0,#DISP
FI_L:   MOV     @R0,A
        INC     R0
        CJNE    R0,#DISP+4,FI_L
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

;========================= buttons and time ============================
; KEYS: A = buttons down now, 1 = pressed: bit 3 = S5 ... bit 0 = S2
KEYS:   MOV     A,P3
        CPL     A
        RR      A
        RR      A
        ANL     A,#0FH
        RET

; NEWKEYS: call once a frame. A = the buttons pressed since the last
; call. A button only changes state when two looks in a row agree,
; so contact bounce shorter than a frame is ignored. Uses A, B.
NEWKEYS:ACALL   KEYS
        MOV     B,A             ; B = the buttons now
        XRL     A,KRAW          ; 1 = changed since the last look
        MOV     KRAW,B
        MOV     KTMP,A
        CPL     A               ; 1 = the same twice running
        ANL     A,B             ; ... and down
        XCH     A,KTMP
        ANL     A,KDEB          ; a changing button keeps its old state
        ORL     A,KTMP          ; A = the new debounced state
        MOV     B,A
        XRL     A,KDEB          ; the buttons whose state changed
        ANL     A,B             ; ... to pressed
        MOV     KDEB,B
        RET

; KEYCLR: take the buttons as they are now, so one still held from the
; last screen does not count as a new press
KEYCLR: ACALL   KEYS
        MOV     KRAW,A
        MOV     KDEB,A
        RET

; WAITNEW: wait for a press, at most R5 x 100 ms.
; Out: C = 1 and A = the new presses, or C = 0 when the time is up.
WAITNEW:MOV     R4,#10
WN_L:   MOV     A,#1
        ACALL   WAITF
        ACALL   NEWKEYS
        JNZ     WN_K
        DJNZ    R4,WN_L
        DJNZ    R5,WAITNEW
        CLR     C
        RET
WN_K:   SETB    C
        RET

; WAITF: wait for the A-th start of a 10 ms frame (A = 1..255). Uses A.
WAITF:  CLR     FRAME
WF_L:   JNB     FRAME,WF_L
        CLR     FRAME
        DJNZ    ACC,WF_L
        RET

; RAND: next number of an 8-bit shift register generator (255 states)
RAND:   MOV     A,RND
        CLR     C
        RRC     A
        JNC     RD_X
        XRL     A,#0B8H
RD_X:   MOV     RND,A
        RET

;==================== Timer 2 interrupt: every 1.25 ms =================
; Timer 2 reloaded itself from RCAP2H:RCAP2L when it overflowed, so the
; ticks stay exactly 1152 cycles apart however late this code runs.
T2_ISR: PUSH    PSW
        PUSH    ACC
        CLR     TF2             ; Timer 2 does not clear its own flag
        MOV     PSW,#08H        ; register bank 1
        MOV     P1,#0FFH        ; all digits off first (no ghosts)
        JB      LEDMODE,T2_TK   ; LED mode: they stay off
        INC     R7              ; the next digit, 0-3
        MOV     A,R7
        ANL     A,#03H
        MOV     R7,A
        ADD     A,#DISP
        MOV     R0,A
        MOV     P0,@R0          ; its segments
        MOV     A,R7
        ADD     A,#T2_TAB-T2_PC
        MOVC    A,@A+PC         ; its enable bit
T2_PC:  MOV     P1,A
        SJMP    T2_TK
T2_TAB: DB      0F7H,0EFH,0DFH,0BFH     ; P1.3, P1.4, P1.5, P1.6 low
T2_TK:  DJNZ    R6,T2_X         ; every 8th tick (10 ms):
        MOV     R6,#8
        SETB    FRAME           ; a new frame for the main program
        INC     FRL
        MOV     A,FRL
        JNZ     T2_SW
        INC     FRH
T2_SW:  JNB     SWRUN,T2_X      ; and the stopwatch, in packed BCD
        MOV     A,SWC
        ADD     A,#1
        DA      A               ; 09H + 1 = 0AH becomes 10H
        MOV     SWC,A
        JNZ     T2_X            ; 99 + 1 gives 00: a new second
        MOV     A,SWS
        ADD     A,#1
        DA      A
        CJNE    A,#60H,T2_S
        CLR     A               ; 60 s: a new minute
        INC     SWM
        MOV     R0,SWM
        CJNE    R0,#10,T2_S
        MOV     SWM,#0          ; after 9.59.99 it starts from 0 again
T2_S:   MOV     SWS,A
T2_X:   POP     ACC
        POP     PSW
        RETI

;=========================== tables ====================================
DIGSEG: DB      SG_0,SG_1,SG_2,SG_3,SG_4,SG_5,SG_6,SG_7,SG_8,SG_9
; brightness level 0-15 -> units lit out of 31 (about 31 x (n/15)^2)
GAMMA:  DB      0,1,2,3,4,5,6,7,9,11,14,17,20,23,27,31
; one period of a sine wave, levels 0-15
SINE:   DB      8,10,13,14,15,14,13,10,8,5,2,1,0,1,2,5
; PWM slots: TH0 for the slot after each one (256 - its length in cycles)
SLTH:   DB      256-96,256-192,256-192,256-192,256-192,256-192,256-192,256-192,256-48
; Race: lanes taken (bit 0 top, 1 middle, 2 bottom) -> segments a, g, d
LANESEG:DB      0FFH,0FEH,0BFH,0BEH,0F7H,0F6H,0B7H,0B6H
LANEBIT:DB      01H,02H,04H
; the edge of the display, clockwise: digit, segment (0 = lit)
RING:   DB      0,0FEH, 1,0FEH, 2,0FEH, 3,0FEH, 3,0FDH, 3,0FBH
        DB      3,0F7H, 2,0F7H, 1,0F7H, 0,0F7H, 0,0EFH, 0,0DFH

; messages: segment codes, 00H ends a scrolling message
M_HELLO:DB      SG_SP,SG_SP,SG_SP,SG_H,SG_E,SG_L,SG_L,SG_O,SG_SP
        DB      SG_A,SG_G,SG_A,SG_I,SG_LN,SG_SP,SG_SP,SG_SP,SG_SP,0
M_LEGEND:
        DB      SG_SP,SG_SP,SG_SP,SG_UC,SG_H,SG_LR,SG_LO,SG_LN,SG_LO,SG_SP,SG_DASH,SG_SP
        DB      SG_LR,SG_A,SG_UC,SG_E,SG_SP,SG_DASH,SG_SP
        DB      SG_L,SG_I,SG_G,SG_H,SG_LT,SG_S,SG_SP,SG_DASH,SG_SP
        DB      SG_P,SG_LO,SG_LN,SG_G,SG_SP,SG_SP,SG_SP,0
M_CHRONO:
        DB      SG_SP,SG_SP,SG_SP,SG_UC,SG_H,SG_LR,SG_LO,SG_LN,SG_LO,SG_SP,SG_SP,SG_SP,SG_SP,0
M_RACE: DB      SG_SP,SG_SP,SG_SP,SG_LR,SG_A,SG_UC,SG_E,SG_SP,SG_SP,SG_SP,SG_SP,0
M_LIGHTS:
        DB      SG_SP,SG_SP,SG_SP,SG_L,SG_I,SG_G,SG_H,SG_LT,SG_S,SG_SP,SG_SP,SG_SP,SG_SP,0
M_PONG: DB      SG_SP,SG_SP,SG_SP,SG_P,SG_LO,SG_LN,SG_G,SG_SP,SG_SP,SG_SP,SG_SP,0
; 4-digit pictures
M_MENU: DB      SG_UC,SG_LR,SG_L,SG_P
M_BEST: DB      SG_LB,SG_E,SG_S,SG_LT

        END
