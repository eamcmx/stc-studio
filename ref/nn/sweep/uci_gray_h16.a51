; SWEEP BUILD (nn/study.py), H = 16. Digit reader on the UCI handwritten digits (8 x 8, 16 grey levels): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     16              ; hidden neurons
SH1     EQU     6               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      0EFH,000H,0ADH,0FFH,04BH,0FFH,08EH,002H,0ACH,0FFH,0A3H,001H,0B5H,0FFH,04DH,001H
        DB      0E1H,001H,061H,001H,09DH,0FEH,044H,0FFH,0B6H,0FFH,00DH,001H,07AH,0FFH,0F2H,000H
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      027H,000H,0E0H,004H,003H,0D5H,000H,007H,003H,018H,005H,00EH,000H,02EH,000H,0C5H
        DB      0EFH,000H,020H,057H,00BH,0EAH,000H,01BH,02BH,002H,016H,0E0H,000H,0EAH,000H,0DFH
        DB      01DH,000H,002H,010H,0F5H,0ECH,000H,020H,00DH,0F3H,030H,019H,000H,01CH,000H,0DBH
        DB      015H,000H,0E1H,01FH,0F0H,0E0H,000H,005H,01CH,00FH,02AH,0F4H,000H,0F6H,000H,014H
        DB      00AH,000H,0CCH,021H,02CH,0F2H,000H,016H,020H,0CCH,066H,006H,000H,0E2H,000H,03BH
        DB      000H,000H,0E1H,02DH,038H,0CEH,000H,013H,03EH,0F3H,043H,008H,000H,0E6H,000H,01AH
        DB      0F2H,000H,0DFH,049H,02FH,0FBH,000H,006H,024H,0DBH,0F8H,0F1H,000H,0D2H,000H,037H
        DB      033H,000H,0DFH,000H,0F1H,004H,000H,0FAH,0FEH,0F6H,0F0H,00DH,000H,015H,000H,0F6H
        DB      026H,000H,0D2H,046H,0EEH,0C9H,000H,00AH,037H,0FCH,024H,011H,000H,016H,000H,0E1H
        DB      040H,000H,0EBH,037H,01EH,0CDH,000H,00CH,013H,010H,023H,01BH,000H,02BH,000H,0DBH
        DB      0EFH,000H,0EDH,054H,029H,0D2H,000H,011H,038H,0EDH,014H,0EEH,000H,014H,000H,004H
        DB      0F0H,000H,0F1H,0F6H,02DH,0C6H,000H,0CAH,031H,0FAH,049H,002H,000H,01CH,000H,0EFH
        DB      012H,000H,008H,01CH,009H,0FBH,000H,0F6H,0FCH,0CCH,029H,033H,000H,006H,000H,0FFH
        DB      00EH,000H,040H,0F8H,0DDH,011H,000H,004H,0D6H,033H,0F5H,0F5H,000H,0FDH,000H,0EDH
        DB      020H,000H,0DCH,023H,000H,0EBH,000H,0EDH,0F0H,016H,018H,0E0H,000H,0FDH,000H,021H
        DB      003H,000H,0FEH,0FFH,0FFH,001H,000H,000H,000H,0FFH,0FFH,001H,000H,001H,000H,0FFH
        DB      017H,000H,015H,0EDH,01CH,020H,000H,008H,0BFH,00CH,00DH,038H,000H,0FFH,000H,003H
        DB      008H,000H,042H,012H,008H,04EH,000H,00BH,0F6H,0B8H,0DEH,02FH,000H,0F7H,000H,00FH
        DB      0D9H,000H,06DH,0DBH,0EAH,036H,000H,0E8H,0D0H,0C6H,041H,011H,000H,0C3H,000H,023H
        DB      0DBH,000H,03EH,0E1H,0F1H,0FDH,000H,002H,0D7H,015H,04BH,00AH,000H,0F6H,000H,0ECH
        DB      03EH,000H,021H,010H,0DBH,01BH,000H,0DAH,0E0H,00FH,0F7H,022H,000H,061H,000H,0A3H
        DB      029H,000H,010H,0C2H,0F8H,0DCH,000H,0F4H,0F2H,062H,008H,00FH,000H,05CH,000H,098H
        DB      00AH,000H,0F2H,003H,0EFH,0EAH,000H,0FDH,008H,0F1H,01CH,006H,000H,01AH,000H,0ECH
        DB      0FEH,000H,001H,0FEH,000H,000H,000H,001H,0FFH,000H,001H,000H,000H,000H,000H,0FFH
        DB      006H,000H,004H,01AH,004H,00BH,000H,0E7H,0FEH,00BH,0E2H,009H,000H,011H,000H,018H
        DB      003H,000H,038H,037H,00AH,03DH,000H,0F3H,010H,0C3H,0EAH,0F9H,000H,0ECH,000H,007H
        DB      028H,000H,011H,014H,0D6H,051H,000H,02BH,0CBH,0F8H,00DH,0E8H,000H,0DDH,000H,0FBH
        DB      00DH,000H,001H,009H,0D4H,0EFH,000H,033H,0FEH,038H,02FH,004H,000H,01DH,000H,000H
        DB      0E4H,000H,03CH,010H,0F1H,019H,000H,0FDH,018H,0D5H,024H,009H,000H,01EH,000H,0D6H
        DB      0C4H,000H,027H,035H,020H,034H,000H,01BH,000H,0DAH,0D1H,0CCH,000H,00EH,000H,0DBH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0DBH,000H,016H,023H,0E4H,01DH,000H,0EDH,037H,0E3H,0E5H,0E1H,000H,0FCH,000H,025H
        DB      0EEH,000H,009H,0FBH,0F5H,03BH,000H,013H,000H,0F3H,0F0H,0EAH,000H,01CH,000H,0F0H
        DB      01FH,000H,0BDH,014H,0DDH,034H,000H,018H,0E9H,0EAH,03DH,00BH,000H,009H,000H,013H
        DB      0F6H,000H,0E5H,008H,0E4H,006H,000H,048H,004H,032H,00EH,0F1H,000H,01DH,000H,0EDH
        DB      0CDH,000H,021H,001H,0CEH,024H,000H,000H,0FCH,02DH,033H,0CFH,000H,023H,000H,005H
        DB      0C2H,000H,00EH,014H,0FBH,03BH,000H,0D5H,0F4H,008H,0EAH,09DH,000H,003H,000H,01DH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,001H,000H,000H,000H,000H,000H,000H,000H,000H,0FFH,000H,000H,000H,000H
        DB      013H,000H,023H,0DBH,0CDH,04DH,000H,03CH,0D2H,00BH,0C3H,0BAH,000H,033H,000H,0E2H
        DB      0E1H,000H,0CCH,081H,03BH,041H,000H,062H,008H,007H,098H,032H,000H,05DH,000H,023H
        DB      0A7H,000H,008H,0BFH,04BH,042H,000H,065H,006H,02DH,0C8H,007H,000H,0F2H,000H,013H
        DB      0E7H,000H,022H,0EFH,0C8H,040H,000H,030H,0CCH,032H,026H,0E6H,000H,0F0H,000H,006H
        DB      029H,000H,000H,00CH,0EBH,021H,000H,0D2H,0EDH,021H,00EH,002H,000H,015H,000H,023H
        DB      02DH,000H,0B8H,0D9H,0DFH,008H,000H,0C2H,00EH,00BH,005H,0EBH,000H,004H,000H,04AH
        DB      001H,000H,0F5H,000H,000H,0FDH,000H,000H,005H,0FFH,0FFH,003H,000H,000H,000H,007H
        DB      000H,000H,003H,000H,000H,000H,000H,000H,001H,001H,0FFH,0FFH,000H,0FEH,000H,0FFH
        DB      04FH,000H,04AH,0FAH,006H,006H,000H,02FH,0FBH,025H,0ECH,0F2H,000H,0B2H,000H,0C8H
        DB      031H,000H,0FBH,0F2H,0FEH,014H,000H,014H,006H,0F8H,0E6H,01CH,000H,00EH,000H,014H
        DB      0E9H,000H,0FDH,0EBH,019H,0F5H,000H,006H,022H,03EH,0DDH,00FH,000H,0FFH,000H,0FFH
        DB      0F2H,000H,014H,0DCH,05AH,005H,000H,0E3H,0FAH,021H,0D3H,023H,000H,0D9H,000H,02AH
        DB      029H,000H,0DEH,0D6H,022H,0F1H,000H,0B2H,0FAH,042H,0F9H,02CH,000H,012H,000H,030H
        DB      0FAH,000H,013H,0E1H,0DBH,001H,000H,003H,012H,0F3H,000H,029H,000H,0CDH,000H,00DH
        DB      0F8H,000H,0F1H,0FFH,00AH,0F8H,000H,002H,011H,005H,0FCH,00AH,000H,007H,000H,008H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      006H,000H,02AH,005H,017H,0CAH,000H,0EEH,006H,044H,00FH,0F2H,000H,0DBH,000H,0DFH
        DB      02EH,000H,007H,021H,01CH,0E2H,000H,0E5H,0FBH,044H,02AH,002H,000H,0E3H,000H,0F7H
        DB      042H,000H,0E0H,00AH,032H,0D7H,000H,002H,027H,0E4H,03AH,056H,000H,003H,000H,01BH
        DB      015H,000H,00AH,0ABH,018H,015H,000H,0E1H,002H,0EAH,002H,039H,000H,008H,000H,020H
        DB      0DEH,000H,009H,0A8H,0F2H,0F1H,000H,0F5H,039H,027H,0E9H,017H,000H,0F1H,000H,032H
        DB      0D9H,000H,010H,0D1H,00FH,0ECH,000H,026H,015H,00CH,0F7H,046H,000H,0D6H,000H,0EFH
        DB      0C0H,000H,01AH,0EEH,018H,00BH,000H,022H,0F3H,008H,000H,013H,000H,0FAH,000H,0F7H
W2:
        DB      07EH,0FFH,0FFH,0F9H,000H,010H,003H,048H,00CH,000H,0A4H,009H,0F0H,0B1H,006H,000H,047H,000H,0F5H
        DB      091H,0FEH,0FFH,0A8H,000H,02FH,081H,013H,00FH,000H,026H,0D0H,0FFH,027H,005H,000H,0DAH,000H,0FAH
        DB      035H,000H,000H,00AH,000H,000H,0C5H,043H,0A0H,000H,00CH,02FH,031H,0D9H,039H,000H,0E1H,000H,0D0H
        DB      08CH,000H,000H,03EH,000H,0B9H,0FAH,0ECH,0C8H,000H,0B4H,0F4H,03DH,026H,0ECH,000H,0F1H,000H,013H
        DB      01BH,000H,000H,0E3H,000H,049H,031H,0D4H,04BH,000H,016H,0CAH,016H,0B6H,0B3H,000H,0D0H,000H,01DH
        DB      04EH,000H,000H,01AH,000H,0E2H,052H,027H,0DBH,000H,0BEH,043H,0A4H,00CH,005H,000H,093H,000H,036H
        DB      036H,000H,000H,0E6H,000H,0B4H,0C2H,0F4H,018H,000H,00CH,00BH,015H,0AFH,0FAH,000H,005H,000H,056H
        DB      0DEH,000H,000H,0C0H,000H,0B0H,03AH,0EEH,0D2H,000H,01DH,02CH,00FH,01AH,0ACH,000H,03DH,000H,0E6H
        DB      014H,000H,000H,02BH,000H,0E0H,0C2H,0F0H,017H,000H,017H,0CBH,0E6H,000H,025H,000H,00CH,000H,0E0H
        DB      029H,000H,000H,01DH,000H,01AH,00CH,090H,0E8H,000H,0E1H,00FH,0C7H,024H,007H,000H,018H,000H,0B4H
        END
