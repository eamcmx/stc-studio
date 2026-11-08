; Digit reader on the UCI handwritten digits (8 x 8, squares on or off): a 64-24-10 neural network on the STC89C52RC.
; Made by nn/train_uci.py from ref/nn/digit_nn.a51 (same code, 64 inputs, new memory map). Do not edit by hand.
; The page sends D and 64 characters (1 for a dark square, 0 for a light one), row by row from the top left; the board answers "=", the
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
RDPIX:  ACALL   GETC
        CJNE    A,#'1',DARK
        MOV     @R0,#1
        SJMP    NEXTPX
DARK:   MOV     @R0,#0
NEXTPX: INC     R0
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
; for every lit pixel, add its row of NH weights to the NH sums
        MOV     DPTR,#W1
        MOV     R1,#PIX
        MOV     R3,#NIN
L1P:    MOV     A,@R1
        JZ      L1NEXT
        MOV     R0,#ACC1
        MOV     R4,#0
L1J:    MOV     A,R4
        MOVC    A,@A+DPTR       ; the weight, -128 to 127
        MOV     R5,A
        ADD     A,@R0           ; low byte of the sum
        MOV     @R0,A
        INC     R0
        MOV     A,R5
        JB      ACC.7,L1NEG
        CLR     A               ; a positive weight adds 00H to the high byte, with the carry
        SJMP    L1HI
L1NEG:  MOV     A,#0FFH         ; a negative one adds FFH
L1HI:   ADDC    A,@R0
        MOV     @R0,A
        INC     R0
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
NH      EQU     24              ; hidden neurons
SH1     EQU     1               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      0F6H,0FFH,0E4H,0FFH,0FCH,0FFH,013H,000H,0EFH,0FFH,00EH,000H,012H,000H,0FEH,0FFH
        DB      0F2H,0FFH,01FH,000H,0FBH,0FFH,01AH,000H,0F3H,0FFH,0F6H,0FFH,015H,000H,00CH,000H
        DB      002H,000H,0FAH,0FFH,015H,000H,0ECH,0FFH,0DDH,0FFH,0FBH,0FFH,012H,000H,00BH,000H
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,0FFH,000H,000H,0FFH,000H,000H,000H,000H
        DB      000H,000H,000H,0FFH,0FFH,000H,000H,001H
        DB      000H,006H,000H,0E8H,015H,00AH,01EH,009H,0EEH,019H,000H,0FBH,0FAH,0F4H,0E8H,0F9H
        DB      00DH,000H,018H,0F8H,0DEH,000H,008H,0E8H
        DB      000H,003H,000H,0F2H,0FBH,0F6H,0FEH,00BH,0FBH,01EH,000H,0E5H,00EH,0D8H,0EEH,00EH
        DB      029H,000H,0FCH,004H,00AH,000H,01AH,00EH
        DB      000H,004H,000H,0FDH,0EFH,0FDH,025H,012H,0F9H,021H,000H,011H,003H,003H,029H,0F0H
        DB      0FCH,000H,0FAH,004H,0ECH,000H,00CH,02FH
        DB      000H,0F0H,000H,0DEH,01AH,0F1H,017H,0FFH,0EBH,032H,000H,01DH,0F6H,035H,016H,0F1H
        DB      0EBH,000H,001H,000H,012H,000H,02BH,022H
        DB      000H,0F4H,000H,0DEH,004H,001H,012H,00FH,0F8H,019H,000H,013H,0D3H,028H,0EBH,01DH
        DB      0E9H,000H,006H,000H,0EFH,000H,035H,001H
        DB      000H,0FCH,000H,002H,0FFH,0F8H,0F1H,0F6H,0F0H,00AH,000H,0FEH,0E8H,0F3H,019H,00DH
        DB      0F7H,000H,007H,019H,0F6H,000H,011H,0F2H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,02BH,000H,0EAH,019H,0E9H,00CH,0E0H,0FDH,01DH,000H,01CH,01CH,014H,002H,0FDH
        DB      034H,000H,0EFH,0D3H,0DAH,000H,02FH,004H
        DB      000H,0CDH,000H,0CDH,008H,0E8H,01DH,001H,00CH,027H,000H,00AH,019H,0DEH,0E3H,015H
        DB      012H,000H,0E9H,0E8H,005H,000H,01BH,001H
        DB      000H,0E2H,000H,0F2H,0E9H,0FEH,002H,005H,0E6H,025H,000H,01BH,0FCH,005H,003H,016H
        DB      00CH,000H,0FAH,00CH,0F1H,000H,015H,0F1H
        DB      000H,008H,000H,013H,008H,0ECH,0F0H,0FAH,003H,01FH,000H,00EH,018H,0BEH,0DAH,0EEH
        DB      0FCH,000H,0EEH,008H,008H,000H,048H,042H
        DB      000H,019H,000H,000H,01BH,0F0H,0ECH,01AH,00FH,029H,000H,000H,011H,00AH,0E4H,009H
        DB      0FCH,000H,004H,018H,01FH,000H,022H,02BH
        DB      000H,0FEH,000H,014H,0E4H,021H,0FBH,0EDH,0FEH,0E9H,000H,0F7H,0EEH,020H,0F5H,008H
        DB      0FAH,000H,01FH,019H,0E7H,000H,008H,01DH
        DB      000H,000H,000H,002H,0FFH,0F9H,0FAH,004H,000H,003H,000H,0FAH,0FFH,008H,0F8H,003H
        DB      000H,000H,0F3H,000H,0FEH,000H,008H,006H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,015H,000H,007H,021H,00BH,001H,00EH,01EH,0D9H,000H,027H,029H,02CH,0EDH,0FFH
        DB      00BH,000H,00CH,016H,009H,000H,00FH,00CH
        DB      000H,0ECH,000H,0F5H,046H,01BH,0D2H,0EEH,0F6H,00CH,000H,0ECH,0E5H,007H,01CH,00EH
        DB      026H,001H,015H,02CH,02EH,000H,0BAH,0DAH
        DB      000H,01FH,000H,00FH,0C0H,030H,0CAH,02DH,0DCH,002H,000H,0E4H,0D1H,014H,00DH,0EEH
        DB      0EFH,000H,00CH,042H,0FCH,000H,0D0H,0DFH
        DB      000H,022H,000H,01AH,0DFH,007H,014H,03CH,018H,0F2H,000H,0E8H,024H,0CCH,0CBH,00DH
        DB      0F5H,000H,0F2H,01CH,0E0H,000H,0D6H,031H
        DB      000H,0C9H,000H,02AH,00EH,0E8H,0C9H,010H,02DH,01CH,000H,0E2H,027H,0F6H,0CCH,011H
        DB      03EH,000H,0F3H,008H,011H,000H,0E2H,016H
        DB      000H,0EDH,000H,006H,0F1H,01EH,007H,010H,011H,007H,000H,0FEH,01EH,001H,0CAH,015H
        DB      023H,000H,0E8H,0FCH,005H,000H,0FBH,007H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,00AH,000H,002H,0FBH,00CH,009H,006H,0F8H,00EH,000H,003H,000H,0FCH,0EDH,0FEH
        DB      001H,000H,013H,0E1H,009H,000H,0F8H,0DEH
        DB      000H,0FEH,000H,00FH,06CH,00CH,007H,0FAH,0E5H,0FBH,000H,0F2H,0EAH,007H,003H,000H
        DB      0E2H,000H,01CH,011H,009H,000H,0E7H,0E8H
        DB      000H,0FFH,000H,0F7H,0FAH,0FBH,0F6H,0F5H,0E7H,0ECH,000H,0CEH,0F3H,01EH,000H,0FEH
        DB      009H,000H,05DH,00AH,010H,000H,0ECH,017H
        DB      000H,0D5H,000H,004H,005H,0F3H,003H,0FEH,002H,0E8H,000H,0F9H,015H,0DBH,007H,00CH
        DB      025H,000H,002H,0F9H,00EH,000H,006H,02EH
        DB      000H,0C3H,000H,023H,0EFH,0F1H,0DCH,0EFH,001H,005H,000H,0C7H,0F4H,02AH,0F3H,01DH
        DB      013H,000H,006H,0FBH,0E7H,000H,0E2H,014H
        DB      000H,0E8H,000H,032H,001H,0F7H,0D8H,0C8H,0EFH,018H,000H,0CEH,017H,016H,0FAH,038H
        DB      014H,000H,0F4H,0EFH,0E0H,000H,00EH,0CDH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,0F1H,000H,023H,0F3H,006H,017H,0FAH,0E9H,008H,000H,014H,0F3H,0F3H,01BH,0F4H
        DB      0EFH,000H,000H,0FDH,0E9H,000H,0FAH,0DFH
        DB      000H,00DH,000H,03DH,00BH,019H,0FEH,0EAH,0FFH,0F9H,000H,0E8H,0F4H,005H,002H,0E6H
        DB      0F0H,000H,000H,0F8H,002H,000H,004H,00BH
        DB      000H,0E6H,000H,00BH,030H,0FFH,029H,0E8H,003H,0DBH,000H,00BH,013H,012H,007H,0DFH
        DB      00FH,000H,00DH,0F7H,03DH,000H,01EH,013H
        DB      000H,03EH,000H,01EH,0F6H,01AH,01CH,000H,0F4H,0CCH,000H,00AH,02CH,0FFH,005H,015H
        DB      005H,000H,008H,000H,005H,000H,01CH,02CH
        DB      000H,02CH,000H,032H,0FAH,014H,023H,008H,0FEH,0F4H,000H,0E1H,0F0H,006H,011H,0EDH
        DB      0E0H,000H,003H,0E0H,0C8H,000H,013H,01FH
        DB      000H,0E6H,000H,015H,0F9H,0DEH,005H,0F3H,0D9H,02DH,000H,0F9H,0F5H,02DH,023H,0FEH
        DB      0F7H,000H,0FDH,0DEH,0CAH,000H,0F2H,005H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,015H,000H,01FH,0FFH,011H,0F3H,0CCH,0FAH,0F9H,000H,0F9H,0FBH,005H,010H,0FEH
        DB      00AH,000H,025H,0E9H,0D9H,000H,0F3H,001H
        DB      000H,023H,000H,047H,0AAH,0D8H,0EDH,09BH,035H,0E0H,000H,000H,006H,00FH,03EH,002H
        DB      0E7H,000H,0E9H,033H,03EH,000H,0F2H,0DFH
        DB      000H,0ECH,000H,02BH,01DH,001H,0B5H,0D0H,024H,0B5H,000H,022H,014H,00EH,026H,007H
        DB      0DDH,000H,014H,037H,0F7H,000H,011H,0F1H
        DB      000H,00FH,000H,037H,0D5H,003H,0C7H,018H,0FAH,0E1H,000H,00AH,0E8H,026H,035H,0E8H
        DB      007H,000H,023H,0E5H,013H,000H,0F6H,01AH
        DB      000H,01BH,000H,02FH,003H,00AH,00EH,017H,007H,00DH,000H,0F4H,0F7H,000H,0F4H,0C3H
        DB      00CH,000H,018H,0DFH,000H,000H,0F2H,011H
        DB      000H,0FEH,000H,00BH,006H,0EAH,024H,018H,0FEH,00EH,000H,0F0H,0EDH,025H,027H,081H
        DB      00DH,000H,0EEH,0F6H,0FEH,000H,002H,022H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,0FEH,000H,0F3H,0EFH,014H,0F8H,0DDH,021H,021H,000H,01EH,016H,0FFH,0F5H,0FEH
        DB      0E8H,000H,02DH,0EAH,0CDH,000H,0F7H,0F6H
        DB      000H,006H,000H,0F1H,0E8H,008H,015H,0F3H,00FH,01BH,000H,005H,00FH,00AH,009H,022H
        DB      00AH,000H,0E8H,017H,018H,000H,011H,002H
        DB      000H,01BH,000H,0F9H,0F6H,01DH,01BH,0FFH,005H,001H,000H,005H,0FEH,0E8H,0F4H,022H
        DB      0E3H,000H,0DCH,007H,0F6H,000H,0F2H,0EDH
        DB      000H,0CBH,000H,000H,004H,00EH,0FEH,014H,02CH,00CH,000H,013H,014H,00CH,002H,0E9H
        DB      0EBH,000H,014H,010H,0FAH,000H,000H,0D3H
        DB      000H,019H,000H,0F4H,000H,0F2H,024H,00DH,046H,00BH,000H,033H,015H,0E1H,01EH,003H
        DB      0EDH,000H,0ECH,0F7H,02EH,000H,0E1H,0DBH
        DB      000H,023H,000H,0EFH,007H,007H,0ECH,03EH,0FDH,0E0H,000H,020H,004H,0F7H,015H,003H
        DB      004H,000H,0DEH,0F6H,001H,000H,027H,0F7H
        DB      000H,000H,000H,0FFH,000H,0FFH,000H,002H,000H,000H,000H,001H,000H,000H,001H,000H
        DB      000H,000H,0FBH,001H,005H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,0F5H,000H,0EBH,0E4H,0FDH,015H,00FH,005H,003H,000H,00EH,01AH,0EAH,0E0H,013H
        DB      010H,000H,007H,013H,0EAH,000H,0FFH,00EH
        DB      000H,0F3H,000H,0C1H,003H,0E6H,00CH,00DH,014H,038H,000H,020H,014H,0EBH,0FFH,0FCH
        DB      01CH,0FFH,002H,0FEH,01FH,0FFH,008H,007H
        DB      000H,000H,000H,013H,0ECH,00DH,016H,005H,025H,0E4H,000H,029H,005H,025H,01EH,0D4H
        DB      0F9H,000H,007H,02CH,023H,0FFH,0DEH,0F1H
        DB      000H,029H,000H,008H,0F9H,01EH,0FAH,031H,01BH,0EEH,000H,0FBH,016H,0C3H,01AH,035H
        DB      004H,000H,0F4H,0F6H,017H,000H,0FEH,0E1H
        DB      000H,015H,000H,0EAH,0E6H,022H,0B6H,020H,00FH,0DBH,000H,0FCH,00AH,007H,01CH,035H
        DB      0F1H,000H,0E1H,006H,00EH,000H,00EH,0BAH
        DB      000H,005H,000H,0EEH,0F7H,006H,0E3H,00DH,009H,0FBH,000H,0F8H,003H,000H,003H,0FDH
        DB      0E4H,000H,019H,015H,007H,000H,007H,0E8H
W2:
        DB      05CH,002H,000H,000H,0FDH,000H,032H,019H,0D3H,0E6H,09BH,034H,050H,000H,0DBH,0F8H,004H,0EDH,0D2H,0DCH,000H,0C7H,006H,012H,000H,0DBH,081H
        DB      078H,0FEH,0FFH,000H,0C5H,000H,014H,0A4H,01FH,08FH,02AH,006H,0B6H,000H,001H,004H,091H,0F5H,0E3H,0B8H,000H,00FH,03DH,012H,000H,0D7H,01DH
        DB      04FH,000H,000H,000H,0ADH,000H,0BBH,0CAH,019H,0EAH,0F9H,041H,001H,000H,030H,038H,025H,0D6H,048H,0EBH,000H,0CDH,012H,0E2H,000H,024H,0BDH
        DB      02BH,0FEH,0FFH,000H,009H,000H,0C6H,095H,0FCH,03FH,01AH,004H,008H,000H,02AH,00DH,01DH,0C8H,09BH,003H,000H,00BH,0B0H,0FAH,000H,0FEH,02EH
        DB      076H,003H,000H,000H,02AH,000H,036H,012H,01FH,0C1H,092H,0FCH,0D6H,000H,0F2H,0DEH,0EAH,02DH,050H,033H,000H,041H,0E1H,0A4H,000H,0A1H,0F7H
        DB      06DH,000H,000H,000H,0D1H,000H,0ABH,03CH,0EDH,01FH,021H,0BCH,03CH,000H,037H,0BAH,0CEH,01CH,0DFH,0E4H,000H,030H,00DH,0CEH,000H,024H,0F4H
        DB      04EH,000H,000H,000H,038H,000H,00DH,0E1H,0FAH,027H,0CBH,006H,0D3H,000H,013H,0D4H,0E9H,048H,0BEH,0D4H,000H,0CBH,0FEH,035H,000H,0F8H,0B2H
        DB      08BH,0FFH,0FFH,000H,003H,000H,021H,008H,0BCH,0F6H,0C0H,0C4H,0EEH,000H,0E1H,009H,007H,0EEH,025H,0FAH,000H,0D7H,0D4H,0A4H,000H,055H,047H
        DB      027H,0FEH,0FFH,000H,056H,000H,0EEH,00AH,0DBH,0E2H,0D9H,019H,0EAH,000H,0D4H,00FH,01CH,0FDH,0F2H,014H,000H,00AH,01FH,035H,001H,0F3H,009H
        DB      0E6H,0FFH,0FFH,000H,0B6H,000H,0E7H,044H,017H,0F7H,021H,0DAH,017H,000H,0A2H,003H,051H,0C5H,0FDH,039H,000H,0F7H,0E0H,0F8H,000H,0E1H,01CH
        END
