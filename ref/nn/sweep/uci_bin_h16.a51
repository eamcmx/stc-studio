; SWEEP BUILD (nn/study.py), H = 16. Digit reader on the UCI handwritten digits (8 x 8, squares on or off): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     16              ; hidden neurons
SH1     EQU     2               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      014H,000H,0F9H,0FFH,005H,000H,041H,000H,0E0H,0FFH,013H,000H,01FH,000H,010H,000H
        DB      01AH,000H,01AH,000H,0F8H,0FFH,0E7H,0FFH,011H,000H,015H,000H,0E2H,0FFH,00CH,000H
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,001H,0FFH,000H,0FEH,000H,001H,000H,000H,0FEH,000H,000H,001H,000H
        DB      011H,000H,0F9H,030H,0EBH,002H,020H,0E2H,0ECH,0EEH,004H,0EDH,0FDH,000H,006H,003H
        DB      01CH,000H,00AH,028H,0F1H,0F6H,002H,00BH,01CH,0FDH,027H,015H,0EFH,00DH,007H,00BH
        DB      02FH,000H,0EBH,00DH,0EAH,0EBH,004H,016H,011H,0E8H,045H,001H,021H,0FFH,01AH,044H
        DB      045H,000H,0D0H,0FFH,0FEH,0F3H,026H,0E6H,045H,0D0H,022H,00AH,0E8H,00EH,0FDH,025H
        DB      004H,000H,0FCH,027H,009H,0D6H,034H,011H,04AH,0D0H,015H,0D0H,0EAH,0F3H,0C1H,0D3H
        DB      0DDH,000H,010H,031H,0DAH,048H,02DH,00CH,02FH,0FBH,0DEH,0F4H,01DH,00FH,0CDH,013H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      016H,000H,0E2H,03AH,000H,0F0H,02DH,005H,047H,043H,006H,0EDH,00EH,0F6H,013H,0E0H
        DB      01EH,000H,0E0H,02FH,01EH,0D6H,04BH,0F5H,0FCH,0FAH,008H,021H,00BH,00FH,00EH,0E3H
        DB      003H,000H,013H,039H,01FH,0DDH,02CH,019H,015H,0DAH,01CH,0EFH,008H,009H,0E7H,01BH
        DB      0F1H,000H,0E0H,01EH,036H,0E7H,0EDH,00DH,02EH,0E7H,02BH,01FH,00CH,002H,037H,0D0H
        DB      028H,000H,0F2H,01CH,0FBH,001H,000H,00CH,000H,0B5H,019H,022H,0D0H,035H,014H,0F6H
        DB      00EH,000H,01DH,0FEH,011H,006H,0FBH,030H,0F4H,01BH,0FFH,0B7H,0DBH,0F6H,0F2H,0A7H
        DB      016H,000H,0E7H,026H,0F0H,0DCH,0FFH,0F3H,032H,0F9H,01BH,002H,005H,01EH,008H,0FFH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0C6H,000H,017H,03CH,02DH,004H,024H,033H,0E3H,01FH,015H,02BH,0DCH,02CH,0FFH,0FEH
        DB      014H,000H,04EH,010H,0EEH,04EH,0FFH,006H,0EFH,0FCH,003H,036H,0D4H,0EAH,0C0H,026H
        DB      0D5H,000H,063H,0C4H,0F8H,009H,0F0H,0FAH,0E3H,0E7H,029H,002H,00CH,0BDH,0E0H,028H
        DB      0FAH,000H,01AH,0EFH,00FH,0D6H,006H,0EEH,0C1H,0F0H,034H,005H,0E2H,0CBH,053H,0BFH
        DB      0F3H,000H,039H,006H,005H,015H,0DCH,0FEH,0F2H,0F2H,0F9H,033H,0E6H,06FH,031H,09CH
        DB      01CH,000H,017H,0F1H,0EBH,0CFH,00CH,011H,0FAH,01EH,00AH,01AH,01DH,040H,026H,0CFH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      011H,000H,004H,002H,0FAH,0F8H,0F1H,0EBH,0F1H,00EH,0F3H,0F7H,0FDH,0F5H,0EDH,005H
        DB      0EBH,000H,02FH,022H,0F4H,035H,0E9H,0FEH,02AH,003H,012H,028H,01CH,0D0H,0F4H,026H
        DB      01EH,000H,011H,0EEH,0DCH,049H,0F2H,016H,0C4H,0E6H,03BH,0DDH,002H,0DEH,0E4H,0E2H
        DB      005H,001H,00EH,00FH,00AH,0E7H,0E8H,036H,0F0H,017H,014H,0D3H,0EEH,014H,00EH,0E8H
        DB      0FCH,000H,025H,007H,0C7H,030H,00BH,00CH,0E7H,00CH,0D9H,008H,0D6H,02BH,036H,0B9H
        DB      0B7H,000H,00EH,02AH,0FEH,01EH,0FCH,007H,032H,0EFH,0AFH,0EDH,002H,023H,005H,0CAH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0DFH,000H,007H,01AH,004H,018H,0E5H,00AH,00DH,0ECH,0EFH,0FCH,03EH,010H,0FCH,023H
        DB      0F5H,000H,004H,0EEH,0ECH,02BH,0A0H,0F8H,00DH,0E3H,0E7H,014H,02FH,031H,01FH,0E2H
        DB      012H,000H,0ECH,029H,025H,02EH,0C2H,021H,031H,027H,026H,005H,0E2H,0EEH,00FH,001H
        DB      0E9H,000H,0F0H,009H,010H,0F4H,0F4H,053H,000H,046H,01EH,0C1H,0E0H,00EH,028H,008H
        DB      0D7H,0FFH,0EBH,01BH,0E7H,026H,0D6H,0E6H,006H,012H,0F6H,0D6H,025H,0F6H,03DH,0F4H
        DB      0F8H,000H,0EBH,005H,0D2H,012H,0DFH,0D8H,02DH,0E2H,015H,0D0H,044H,024H,0E4H,026H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0E7H,000H,018H,0E6H,0C8H,017H,000H,00BH,0FAH,012H,0DDH,0CDH,03EH,00EH,0F3H,003H
        DB      0E9H,000H,0BBH,08BH,02FH,04EH,0CAH,045H,003H,013H,081H,040H,00FH,054H,0C2H,029H
        DB      0ACH,000H,01AH,0CCH,053H,03DH,0FDH,06DH,006H,0F5H,0C9H,00BH,03CH,0DFH,0F6H,0EAH
        DB      0FAH,000H,013H,0FDH,009H,020H,0BCH,041H,0DFH,0F2H,00DH,0DDH,018H,0E8H,01BH,014H
        DB      014H,000H,020H,008H,000H,0F7H,0B7H,0C1H,0ECH,041H,032H,0F4H,02FH,0ECH,007H,0FAH
        DB      050H,000H,0E1H,0A8H,0E2H,032H,0E6H,0ABH,03BH,009H,027H,0D4H,0DEH,00FH,008H,03AH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      032H,000H,0E7H,015H,0EDH,0EAH,03FH,00FH,000H,0DBH,0EEH,0FCH,03FH,0E6H,01AH,0B6H
        DB      009H,000H,0DCH,0E4H,0F2H,0E1H,0FEH,024H,00EH,010H,0EDH,01EH,0E7H,003H,0F4H,0F7H
        DB      0CCH,000H,006H,0EBH,013H,0F1H,02AH,00FH,025H,046H,00AH,006H,010H,0F6H,0D6H,023H
        DB      000H,000H,013H,0E8H,032H,00FH,026H,0DDH,0EDH,0EDH,0EDH,031H,049H,0F0H,0FCH,0F1H
        DB      014H,000H,0DAH,0D7H,04EH,0F8H,01FH,0E6H,007H,03CH,0E5H,029H,036H,004H,0FBH,015H
        DB      013H,000H,0FCH,0F9H,0F9H,000H,040H,0F8H,010H,016H,00AH,00FH,0D3H,003H,020H,017H
        DB      004H,000H,0F6H,000H,00CH,0FCH,000H,0FDH,00AH,004H,0FDH,00AH,0F2H,000H,000H,00FH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0F1H,000H,00AH,030H,009H,0E0H,038H,002H,0D0H,021H,024H,00FH,0EEH,0EFH,015H,0F0H
        DB      033H,000H,003H,02BH,012H,0E4H,02AH,0ECH,0F1H,0FDH,021H,046H,0EEH,00BH,0D3H,026H
        DB      01CH,000H,01AH,0A9H,02AH,019H,0FAH,0E4H,0ECH,00FH,0F9H,01EH,0E5H,001H,0C3H,01DH
        DB      0E4H,000H,01CH,0C5H,000H,0FAH,03DH,027H,01BH,059H,0D5H,0F7H,0EBH,0DFH,018H,01BH
        DB      0EBH,000H,012H,093H,005H,0F6H,032H,04CH,025H,02CH,007H,033H,012H,0FCH,0E6H,0FDH
        DB      0EAH,000H,010H,0E6H,020H,004H,0F6H,013H,0EEH,0E7H,008H,000H,006H,027H,0DEH,029H
W2:
        DB      0C7H,0FFH,0FFH,0E1H,000H,006H,0FFH,01AH,008H,0E0H,0A5H,024H,0E0H,0B3H,03AH,00EH,036H,0F3H,0FFH
        DB      0E2H,0FEH,0FFH,0DBH,000H,01FH,081H,019H,00DH,0EEH,016H,0BFH,0DDH,016H,006H,0DCH,0D7H,03FH,01CH
        DB      0AFH,0FFH,0FFH,0E9H,000H,0F2H,0DDH,020H,0CFH,049H,00DH,004H,000H,0E4H,01CH,008H,00FH,0F7H,0C8H
        DB      06BH,000H,000H,02DH,000H,0C8H,007H,01BH,0B7H,0F8H,0D1H,0E9H,017H,023H,0E8H,002H,016H,00FH,006H
        DB      079H,000H,000H,0D5H,000H,022H,009H,0CBH,033H,00DH,010H,0D9H,013H,0D5H,0B6H,044H,000H,0F6H,0F7H
        DB      0B2H,000H,000H,01FH,000H,0F4H,03AH,0E5H,0F5H,02AH,0CEH,038H,0CCH,00EH,0FFH,002H,087H,0A0H,02CH
        DB      016H,0FFH,0FFH,0F6H,000H,0E2H,0CEH,017H,00FH,0B8H,0F8H,010H,032H,0C4H,0F7H,0EEH,0E4H,0F4H,04CH
        DB      0A4H,000H,000H,0D3H,000H,0BBH,028H,0EEH,0E3H,0F1H,01DH,02DH,0CFH,002H,0C2H,031H,025H,02FH,0CEH
        DB      090H,000H,000H,01FH,000H,0EEH,0E2H,00DH,00CH,0C2H,01AH,0E6H,01BH,003H,021H,0B7H,0FAH,0C9H,0E6H
        DB      034H,000H,000H,016H,000H,01BH,011H,0C8H,0F7H,0FDH,0E7H,01CH,008H,018H,002H,0D8H,004H,004H,0C8H
        END
