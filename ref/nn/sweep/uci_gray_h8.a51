; SWEEP BUILD (nn/study.py), H = 8. Digit reader on the UCI handwritten digits (8 x 8, 16 grey levels): a 64-24-10 neural network on the STC89C52RC.
; Made by nn/train_uci.py from ref/nn/digit_nn.a51 (same code, 64 inputs, new memory map). Do not edit by hand.
; The page sends D and 64 characters (hex digits 0-F, the grey level), row by row from the top left; the board answers "=", the
; digit and its 10 scores in hex, and shows the digit. Serial: 19200 baud. Board: as in digit_nn.a51.

PIX     EQU     30H             ; NIN bytes: the pixels                    (30H-6FH)
ACC1    EQU     70H             ; NH x 16-bit sums of the hidden layer    (70H-9FH)
HID     EQU     ACC1+2*NH       ; NH hidden values, 0 to 255               (A0H-B7H; above 7FH only @R0/@R1 reach)
SCORE   EQU     HID+NH          ; 10 x 24-bit scores, low byte first       (B8H-D5H)
DBUF    EQU     2CH             ; 4 segment patterns, digit 1 to digit 4
DIGI    EQU     2BH             ; the digit the display is showing now (0-3)

        ORG     0000H
        LJMP    MAIN
        ORG     000BH
        LJMP    T0ISR

        ORG     0030H
MAIN:   MOV     SP,#0D7H        ; stack from D8H, in the upper 128 bytes of the 8052's RAM
        MOV     DBUF,#0ABH      ; "nn--" until the first digit arrives
        MOV     DBUF+1,#0ABH
        MOV     DBUF+2,#0BFH
        MOV     DBUF+3,#0BFH
        MOV     DIGI,#0
        MOV     TMOD,#22H       ; Timer 1: baud rate, Timer 0: display, both 8-bit auto-reload
        MOV     TH1,#0FDH
        MOV     TL1,#0FDH
        ORL     PCON,#80H       ; SMOD = 1: 19200 baud
        MOV     SCON,#50H       ; mode 1, receiver on
        MOV     TH0,#0          ; Timer 0 overflows every 256 machine cycles
        MOV     TL0,#0
        SETB    TR1
        SETB    TR0
        SETB    ET0
        SETB    EA
        MOV     DPTR,#HELLO
        ACALL   PUTS

; ---- wait for D, then read 35 pixels
WAITD:  ACALL   GETC
        CJNE    A,#'D',WAITD
        MOV     R0,#PIX
        MOV     R2,#NIN
RDPIX:  ACALL   GETC            ; a hex digit, 0-9 or A-F
        CLR     C
        SUBB    A,#'0'
        CJNE    A,#10,HEX1
HEX1:   JC      HEX2            ; 0-9
        SUBB    A,#7            ; A-F become 10-15
HEX2:   MOV     @R0,A
        INC     R0
        DJNZ    R2,RDPIX

; ---- layer 1: start every sum at its bias
        MOV     DPTR,#B1
        MOV     R0,#ACC1
        MOV     R2,#2*NH
L1B:    CLR     A
        MOVC    A,@A+DPTR
        MOV     @R0,A
        INC     DPTR
        INC     R0
        DJNZ    R2,L1B
; for every pixel, add pixel x weight to the NH sums (the 0/1 inputs are not used)
        MOV     DPTR,#W1
        MOV     R1,#PIX
        MOV     R3,#NIN
L1P:    MOV     R0,#ACC1
        MOV     R4,#0
L1J:    MOV     A,R4
        MOVC    A,@A+DPTR       ; the weight, -128 to 127
        JB      ACC.7,L1NEG
        MOV     B,@R1           ; the pixel, 0 or 1
        MUL     AB              ; pixel x weight
        ADD     A,@R0
        MOV     @R0,A
        INC     R0
        MOV     A,B
        ADDC    A,@R0
        MOV     @R0,A
        SJMP    L1HI
L1NEG:  CPL     A               ; a negative weight: pixel x its size, subtracted
        INC     A
        MOV     B,@R1
        MUL     AB
        XCH     A,@R0           ; A = the sum, @R0 = the product (low bytes)
        CLR     C
        SUBB    A,@R0
        MOV     @R0,A
        INC     R0
        MOV     A,@R0
        SUBB    A,B
        MOV     @R0,A
L1HI:   INC     R0
        INC     R4
        CJNE    R4,#NH,L1J
L1NEXT: MOV     A,DPL           ; on to the next pixel's row
        ADD     A,#NH
        MOV     DPL,A
        JNC     L1N2
        INC     DPH
L1N2:   INC     R1
        DJNZ    R3,L1P

; ---- ReLU and scaling: hidden = 0 for a negative sum, else sum >> SH1, at most 255
        MOV     R0,#ACC1
        MOV     R1,#HID
        MOV     R2,#NH
RL1:    MOV     A,@R0
        MOV     R6,A            ; low byte
        INC     R0
        MOV     A,@R0
        MOV     R7,A            ; high byte
        INC     R0
        JB      ACC.7,RZERO
        MOV     R5,#SH1
RSH:    MOV     A,R5
        JZ      RSAT
        CLR     C
        MOV     A,R7
        RRC     A
        MOV     R7,A
        MOV     A,R6
        RRC     A
        MOV     R6,A
        DEC     R5
        SJMP    RSH
RSAT:   MOV     A,R7
        JZ      RLOW
        MOV     A,#0FFH         ; too big for a byte: 255
        SJMP    RSTORE
RLOW:   MOV     A,R6
        SJMP    RSTORE
RZERO:  CLR     A
RSTORE: MOV     @R1,A
        INC     R1
        DJNZ    R2,RL1

; ---- layer 2: score k = bias + sum of hidden j * weight, 24 bits in R7:R6:R5
        MOV     DPTR,#W2        ; each row: 3 bytes of bias, then NH weights
        MOV     R1,#SCORE
        MOV     R3,#10
L2K:    CLR     A
        MOVC    A,@A+DPTR
        MOV     R5,A
        MOV     A,#1
        MOVC    A,@A+DPTR
        MOV     R6,A
        MOV     A,#2
        MOVC    A,@A+DPTR
        MOV     R7,A
        MOV     R0,#HID
        MOV     R2,#3
L2J:    MOV     A,R2
        MOVC    A,@A+DPTR       ; the weight
        JB      ACC.7,L2NEG
        MOV     B,@R0
        MUL     AB              ; hidden * weight: B = high byte, A = low byte
        ADD     A,R5
        MOV     R5,A
        MOV     A,B
        ADDC    A,R6
        MOV     R6,A
        CLR     A
        ADDC    A,R7
        MOV     R7,A
        SJMP    L2NEXT
L2NEG:  CPL     A               ; a negative weight: multiply by its size and subtract
        INC     A
        MOV     B,@R0
        MUL     AB
        XCH     A,R5            ; A = the score's low byte, R5 = the product's low byte
        CLR     C
        SUBB    A,R5
        MOV     R5,A
        MOV     A,R6
        SUBB    A,B
        MOV     R6,A
        MOV     A,R7
        SUBB    A,#0
        MOV     R7,A
L2NEXT: INC     R0
        INC     R2
        CJNE    R2,#NH+3,L2J
        MOV     A,R5            ; keep the score
        MOV     @R1,A
        INC     R1
        MOV     A,R6
        MOV     @R1,A
        INC     R1
        MOV     A,R7
        MOV     @R1,A
        INC     R1
        MOV     A,DPL           ; on to the next digit's row
        ADD     A,#NH+3
        MOV     DPL,A
        JNC     L2N2
        INC     DPH
L2N2:   DJNZ    R3,L2K

; ---- the largest score: compare with the sign bit flipped, so that unsigned order is signed order
        MOV     R1,#SCORE
        MOV     A,@R1
        MOV     R5,A
        INC     R1
        MOV     A,@R1
        MOV     R6,A
        INC     R1
        MOV     A,@R1
        XRL     A,#80H
        MOV     R7,A            ; R7:R6:R5 = the best so far
        INC     R1
        MOV     R4,#0           ; its digit
        MOV     R3,#1
AMAX:   CLR     C               ; best - score: a borrow means this score is larger
        MOV     A,R5
        SUBB    A,@R1
        INC     R1
        MOV     A,R6
        SUBB    A,@R1
        INC     R1
        MOV     A,@R1
        XRL     A,#80H
        MOV     B,A
        MOV     A,R7
        SUBB    A,B
        JNC     AMNEXT
        DEC     R1              ; a new best
        DEC     R1
        MOV     A,@R1
        MOV     R5,A
        INC     R1
        MOV     A,@R1
        MOV     R6,A
        INC     R1
        MOV     A,@R1
        XRL     A,#80H
        MOV     R7,A
        MOV     A,R3
        MOV     R4,A
AMNEXT: INC     R1
        INC     R3
        CJNE    R3,#10,AMAX

; ---- show it ("nn 7") and send "=7" and the 10 scores
        MOV     A,R4
        MOV     DPTR,#SEGS
        MOVC    A,@A+DPTR
        MOV     DBUF+3,A
        MOV     DBUF+2,#0FFH
        MOV     A,#'='
        ACALL   PUTC
        MOV     A,R4
        ADD     A,#'0'
        ACALL   PUTC
        MOV     R1,#SCORE+2     ; the high byte of score 0
        MOV     R3,#10
SEND:   MOV     A,#' '
        ACALL   PUTC
        MOV     A,@R1
        ACALL   PUTHEX
        DEC     R1
        MOV     A,@R1
        ACALL   PUTHEX
        DEC     R1
        MOV     A,@R1
        ACALL   PUTHEX
        MOV     A,R1
        ADD     A,#5            ; the high byte of the next score
        MOV     R1,A
        DJNZ    R3,SEND
        MOV     A,#13
        ACALL   PUTC
        MOV     A,#10
        ACALL   PUTC
        LJMP    WAITD

; ---- serial port
GETC:   JNB     RI,GETC
        MOV     A,SBUF
        CLR     RI
        RET
PUTC:   MOV     SBUF,A
        JNB     TI,$
        CLR     TI
        RET
PUTHEX: PUSH    ACC             ; two hex characters for A
        SWAP    A
        ACALL   NIBBLE
        POP     ACC
NIBBLE: ANL     A,#0FH
        CJNE    A,#10,NIB1
NIB1:   JC      NIB2            ; 0-9
        ADD     A,#7            ; A-F
NIB2:   ADD     A,#'0'
        ACALL   PUTC
        RET
PUTS:   CLR     A               ; the text at DPTR, up to a 0 byte
        MOVC    A,@A+DPTR
        JZ      PUTS9
        ACALL   PUTC
        INC     DPTR
        SJMP    PUTS
PUTS9:  RET

; ---- Timer 0, every 256 machine cycles: the next digit of the display (register bank 1)
T0ISR:  PUSH    PSW
        PUSH    ACC
        PUSH    DPL
        PUSH    DPH
        MOV     PSW,#08H
        MOV     P1,#0FFH        ; all digits off while the segments change
        MOV     A,DIGI
        INC     A
        ANL     A,#03H
        MOV     DIGI,A
        ADD     A,#DBUF
        MOV     R0,A
        MOV     P0,@R0
        MOV     A,DIGI
        MOV     DPTR,#DSEL
        MOVC    A,@A+DPTR
        MOV     P1,A
        POP     DPH
        POP     DPL
        POP     ACC
        POP     PSW
        RETI

DSEL:   DB      0F7H,0EFH,0DFH,0BFH            ; digit 1 to digit 4: P1.3 to P1.6 low
SEGS:   DB      0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
HELLO:  DB      'NN READY',13,10,0

; ---- WEIGHTS (written by nn/train_uci.py)
NIN     EQU     64              ; inputs
NH      EQU     8              ; hidden neurons
SH1     EQU     5               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      0D0H,0FFH,069H,0FFH,062H,002H,0DAH,000H,05EH,000H,04FH,0FFH,03BH,0FFH,027H,001H
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,0ABH,0EAH,024H,00CH,01DH,019H
        DB      000H,0FDH,037H,0EBH,014H,0D9H,0FCH,0FBH
        DB      000H,0F5H,0FBH,00AH,02DH,00FH,017H,01FH
        DB      000H,000H,007H,0F8H,021H,0FAH,0EAH,00EH
        DB      000H,0FEH,000H,0FAH,03EH,015H,0ECH,0ECH
        DB      000H,000H,01CH,0DDH,056H,0DAH,0F9H,0DDH
        DB      000H,000H,042H,0F7H,0F0H,0E0H,0C9H,0EAH
        DB      000H,000H,0DFH,0D9H,007H,019H,01FH,006H
        DB      000H,000H,0F2H,0D4H,039H,0F5H,008H,01CH
        DB      000H,0FBH,0E6H,0D8H,02DH,0FBH,013H,00AH
        DB      000H,0F9H,018H,0E5H,02EH,0D8H,00DH,001H
        DB      000H,0F8H,0EEH,0F9H,044H,0F1H,002H,02FH
        DB      000H,0F4H,009H,000H,02BH,021H,009H,0FFH
        DB      000H,0FDH,007H,018H,0D4H,0FEH,0F5H,011H
        DB      000H,000H,0EDH,001H,013H,007H,0A8H,026H
        DB      000H,000H,003H,0FDH,001H,003H,0FDH,000H
        DB      000H,000H,000H,016H,0FAH,010H,01CH,0F0H
        DB      000H,0F7H,031H,001H,0E2H,02EH,01DH,001H
        DB      000H,0F9H,051H,035H,006H,050H,0ECH,004H
        DB      000H,0F9H,020H,055H,026H,024H,01AH,02FH
        DB      000H,0F0H,0F1H,0F5H,0FCH,025H,042H,063H
        DB      000H,0FEH,0C6H,015H,016H,00BH,022H,034H
        DB      000H,000H,0F3H,0FDH,00EH,007H,0FFH,027H
        DB      000H,000H,000H,001H,000H,000H,000H,000H
        DB      000H,0FEH,003H,0F8H,0DAH,000H,0F3H,0FDH
        DB      000H,0F7H,034H,0F0H,0F8H,030H,0FEH,008H
        DB      000H,000H,02AH,021H,010H,019H,00CH,017H
        DB      000H,0F4H,0F4H,03BH,023H,004H,0F8H,01DH
        DB      000H,0F0H,02DH,0F9H,019H,004H,026H,01FH
        DB      000H,0FEH,035H,0DAH,0BAH,0D6H,024H,026H
        DB      000H,000H,000H,000H,0FFH,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,0FEH,012H,0E1H,0F9H,0FAH,0B8H,009H
        DB      000H,001H,01BH,0FAH,0EBH,0FBH,003H,012H
        DB      000H,0FBH,0F9H,017H,01CH,00EH,0EBH,007H
        DB      000H,0FAH,0FBH,027H,0FBH,0F0H,0FDH,004H
        DB      000H,000H,00FH,028H,0FCH,0F9H,0E4H,011H
        DB      000H,0FEH,018H,0EFH,0B1H,0D4H,0A9H,00EH
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,001H,000H,000H,0FFH,000H,000H
        DB      000H,004H,027H,00FH,0CBH,0C8H,041H,052H
        DB      000H,004H,0B9H,01BH,081H,023H,036H,0FDH
        DB      000H,0FCH,01BH,03CH,0C3H,0DCH,028H,0EEH
        DB      000H,003H,012H,03AH,0EFH,005H,0F4H,020H
        DB      000H,006H,0FEH,0ECH,0DEH,010H,0CFH,020H
        DB      000H,0FFH,0DCH,0E6H,0EBH,013H,0CCH,004H
        DB      000H,000H,0F3H,0F5H,006H,023H,0EEH,0E6H
        DB      000H,000H,010H,0FEH,0FBH,0EEH,003H,009H
        DB      000H,008H,00CH,0D7H,011H,0ABH,047H,01FH
        DB      000H,002H,0EDH,0F3H,0FDH,016H,003H,0E8H
        DB      000H,0FCH,0FCH,0F2H,0F3H,0DFH,001H,0E4H
        DB      000H,004H,0F9H,014H,0FEH,004H,018H,0CDH
        DB      000H,004H,0BDH,0FAH,007H,012H,007H,0DAH
        DB      000H,000H,00BH,0F1H,00BH,00EH,004H,0F4H
        DB      000H,000H,0EBH,0F6H,00DH,02EH,0EEH,0DBH
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,0CFH,001H,020H,002H,0F3H,006H
        DB      000H,0FDH,0EEH,01BH,01FH,004H,0FFH,0EFH
        DB      000H,0F6H,0E9H,0F0H,045H,03CH,019H,0D3H
        DB      000H,0FFH,0FBH,015H,007H,052H,009H,0F6H
        DB      000H,0FFH,001H,039H,004H,0EEH,006H,0F1H
        DB      000H,0FDH,0F4H,01FH,01AH,0EAH,03EH,0C2H
        DB      000H,000H,00FH,066H,0DDH,0CEH,017H,0BDH
W2:
        DB      02BH,005H,000H,000H,0FFH,0FCH,0B7H,0ABH,02CH,01DH,027H
        DB      021H,0F8H,0FFH,000H,0F6H,00FH,034H,0E4H,005H,0F0H,0EAH
        DB      0FCH,002H,000H,000H,001H,0C4H,0FBH,01FH,0EFH,047H,09EH
        DB      06FH,0FFH,0FFH,000H,0FFH,0B3H,0F7H,03FH,002H,0ACH,0FBH
        DB      0E9H,001H,000H,000H,014H,04BH,021H,09FH,0D7H,0F6H,004H
        DB      0B4H,000H,000H,000H,001H,044H,0A8H,03DH,00EH,0D6H,0A0H
        DB      058H,006H,000H,000H,0F9H,0F1H,02AH,099H,042H,0DDH,09DH
        DB      042H,003H,000H,000H,000H,0FCH,004H,01EH,081H,0EAH,034H
        DB      0B5H,000H,000H,000H,0FAH,0DCH,003H,0ECH,025H,01BH,0F2H
        DB      01DH,0FBH,0FFH,000H,000H,005H,0D1H,01EH,00FH,0F2H,012H
        END
