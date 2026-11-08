; SWEEP BUILD (nn/study.py), H = 8. Digit reader on the UCI handwritten digits (8 x 8, squares on or off): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     8              ; hidden neurons
SH1     EQU     2               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      010H,000H,003H,000H,02BH,000H,01BH,000H,03EH,000H,0E6H,0FFH,0D5H,0FFH,017H,000H
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,001H,0FFH,0FFH,000H,0FEH,004H
        DB      0FCH,0EAH,027H,001H,02BH,0FFH,0EEH,00CH
        DB      002H,0E4H,008H,0FCH,022H,00DH,004H,026H
        DB      0E2H,02DH,006H,00AH,02DH,026H,0FCH,0F8H
        DB      0C0H,009H,0FCH,0C3H,02BH,00AH,017H,0EDH
        DB      0C4H,087H,048H,0F5H,042H,0FCH,0FAH,0E9H
        DB      0F4H,032H,040H,0EEH,0EAH,0D7H,008H,0D8H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      01BH,035H,0F7H,0D9H,03CH,0D9H,005H,017H
        DB      0F5H,0E0H,002H,0F4H,03DH,0EBH,005H,0FFH
        DB      004H,0E9H,021H,0FAH,01CH,0EBH,0F6H,0FEH
        DB      0CCH,0E9H,0DCH,0DAH,00DH,0E8H,00EH,01AH
        DB      0F2H,0FFH,00AH,0FBH,017H,017H,028H,01BH
        DB      015H,0EDH,003H,01FH,0F5H,0F6H,0F2H,00FH
        DB      0EBH,013H,0ECH,0EAH,023H,00CH,009H,032H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      006H,0DFH,006H,011H,007H,0F4H,026H,01EH
        DB      044H,0EBH,04AH,0F4H,0FCH,038H,024H,0E5H
        DB      0FCH,0EAH,030H,016H,0CFH,03AH,0F9H,0D9H
        DB      0E8H,0C5H,005H,043H,012H,030H,00AH,013H
        DB      057H,0C0H,00EH,012H,008H,001H,00EH,07FH
        DB      022H,0DCH,0F5H,02AH,014H,018H,006H,040H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      011H,0F0H,0F3H,0EBH,0FAH,0FDH,0F1H,0DBH
        DB      021H,0F8H,03AH,0F3H,0E3H,01AH,0E9H,0FAH
        DB      0E4H,027H,026H,019H,0F2H,038H,00FH,009H
        DB      0E9H,000H,00EH,02CH,00DH,00CH,01CH,021H
        DB      02DH,0E3H,03DH,015H,0EEH,0FFH,0F8H,03AH
        DB      035H,0FCH,021H,0FFH,0ECH,0BEH,0F2H,045H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      0E7H,0E6H,013H,004H,0C0H,0BBH,0DFH,0F8H
        DB      009H,0FCH,003H,0ECH,0C1H,0EDH,0E9H,021H
        DB      0F9H,006H,0EEH,00EH,011H,014H,015H,008H
        DB      0E4H,01FH,0FAH,032H,008H,00FH,020H,00DH
        DB      0FFH,016H,000H,022H,0F1H,0E4H,0CCH,005H
        DB      00CH,02BH,0FCH,0E8H,0F4H,0E9H,0C5H,0FEH
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      01EH,055H,013H,029H,0DDH,0E4H,0E8H,012H
        DB      03FH,023H,0AAH,0EFH,092H,0C9H,042H,0FEH
        DB      013H,01AH,012H,050H,0C6H,0D3H,045H,00AH
        DB      0E8H,03DH,0FAH,021H,0D6H,01BH,003H,00EH
        DB      00CH,031H,0DBH,0F2H,0EEH,03AH,0DEH,016H
        DB      010H,008H,0D6H,0EAH,000H,064H,0E2H,0F2H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      0DEH,020H,006H,0F3H,034H,0C2H,021H,013H
        DB      019H,0F7H,0F4H,0FCH,00FH,0F0H,01CH,008H
        DB      031H,0C0H,0FCH,011H,008H,0D4H,0EFH,0E0H
        DB      0F8H,01DH,0FEH,006H,0F9H,0FBH,00FH,0E2H
        DB      01FH,003H,0C6H,015H,025H,003H,01AH,0D6H
        DB      01DH,0ECH,00CH,024H,029H,015H,0FAH,0F8H
        DB      00BH,0FDH,0F2H,0FDH,001H,001H,004H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      0FFH,0BFH,00FH,014H,020H,0FDH,007H,0F5H
        DB      008H,00DH,0FAH,0E8H,047H,019H,02BH,0F8H
        DB      026H,01DH,0C9H,026H,0F8H,038H,017H,0EEH
        DB      039H,0EFH,00AH,03DH,002H,008H,00DH,0E6H
        DB      02AH,000H,009H,044H,002H,0ECH,034H,0D8H
        DB      0B3H,004H,00DH,051H,0DDH,009H,016H,0CDH
W2:
        DB      0D2H,000H,000H,04EH,0F2H,0F1H,0ADH,0D3H,0F1H,0FCH,00CH
        DB      004H,000H,000H,0DEH,0B2H,0FBH,02BH,0B7H,02CH,013H,0E9H
        DB      0DBH,0FEH,0FFH,005H,0B8H,0ECH,017H,025H,0C2H,013H,0C8H
        DB      0EEH,0FFH,0FFH,0C8H,0DEH,0C4H,0FBH,042H,018H,0D2H,0F5H
        DB      013H,0FEH,0FFH,00DH,057H,046H,020H,0BDH,0DEH,0C7H,0EBH
        DB      068H,002H,000H,0F3H,047H,03DH,0AFH,039H,01BH,0EBH,0A2H
        DB      0A9H,001H,000H,033H,00BH,0C7H,011H,0C8H,00CH,0FBH,081H
        DB      03FH,002H,000H,097H,029H,011H,003H,006H,08FH,0E0H,041H
        DB      069H,0FFH,0FFH,003H,0DCH,0F1H,0F2H,0E4H,024H,02FH,0FBH
        DB      05DH,0FEH,0FFH,0F3H,0DBH,018H,0E8H,00FH,027H,0DAH,00EH
        END
