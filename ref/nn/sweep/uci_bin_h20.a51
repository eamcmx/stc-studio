; SWEEP BUILD (nn/study.py), H = 20. Digit reader on the UCI handwritten digits (8 x 8, squares on or off): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     20              ; hidden neurons
SH1     EQU     2               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      0D3H,0FFH,000H,000H,0FDH,0FFH,004H,000H,02DH,000H,0E1H,0FFH,025H,000H,0FDH,0FFH
        DB      0D0H,0FFH,039H,000H,004H,000H,01BH,000H,0FAH,0FFH,0FEH,0FFH,04BH,000H,004H,000H
        DB      02DH,000H,0FAH,0FFH,0F9H,0FFH,0FAH,0FFH
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0F6H,0ECH,000H,0F6H,023H,0D7H,021H,0F9H,0D9H,0EEH,0C8H,0EFH,000H,0E0H,030H,005H
        DB      005H,000H,000H,000H
        DB      01AH,024H,000H,0D9H,007H,00BH,01BH,01EH,0FAH,0E4H,001H,017H,000H,01DH,024H,0E2H
        DB      028H,000H,000H,000H
        DB      0FEH,0E9H,000H,001H,000H,0F2H,0F8H,03EH,003H,0FEH,0F4H,010H,000H,00FH,045H,0EEH
        DB      0F1H,000H,000H,000H
        DB      006H,0F1H,000H,0FEH,019H,0D7H,00BH,043H,0D0H,00FH,039H,0FAH,000H,0F8H,03AH,0B3H
        DB      0CDH,000H,000H,000H
        DB      03EH,0ADH,000H,0DBH,005H,0D0H,017H,00FH,0FEH,01EH,0E7H,0C4H,000H,01FH,039H,0C5H
        DB      00CH,000H,000H,000H
        DB      003H,001H,000H,0EBH,03AH,0F1H,0E7H,0F2H,015H,01FH,0EEH,0E5H,000H,001H,00AH,0F9H
        DB      007H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0D6H,02CH,000H,0F1H,014H,0BCH,03AH,00AH,087H,056H,007H,0E9H,000H,0FFH,018H,0F9H
        DB      0F3H,000H,000H,000H
        DB      026H,01BH,000H,0FEH,0E4H,0DCH,025H,03DH,006H,03AH,0F9H,0F4H,000H,0EEH,015H,0CAH
        DB      042H,000H,000H,000H
        DB      0F9H,0E6H,000H,0E2H,007H,0F0H,00CH,001H,010H,027H,004H,0CEH,000H,0FCH,041H,0D5H
        DB      003H,000H,000H,000H
        DB      047H,023H,000H,014H,0F9H,015H,02DH,006H,001H,02EH,0F3H,01DH,000H,0FDH,04CH,0B3H
        DB      0EDH,000H,000H,000H
        DB      010H,028H,000H,00AH,0F4H,004H,000H,00CH,015H,0F5H,00AH,011H,000H,020H,008H,0A6H
        DB      0FBH,000H,000H,000H
        DB      02CH,0E5H,000H,017H,0E6H,0F2H,0FAH,0E9H,006H,0F4H,0D5H,029H,000H,021H,0F5H,03FH
        DB      04AH,000H,000H,000H
        DB      00CH,009H,000H,0EEH,0E7H,0EDH,026H,0E7H,000H,0FDH,0EFH,0FDH,000H,010H,021H,0D7H
        DB      001H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0DCH,035H,000H,013H,0EDH,023H,018H,0EBH,007H,03AH,0CDH,003H,000H,025H,0EBH,0E9H
        DB      0F8H,000H,000H,000H
        DB      0F1H,0D8H,000H,0D1H,077H,000H,012H,0FEH,00EH,000H,0F0H,00BH,000H,044H,09EH,007H
        DB      036H,000H,000H,000H
        DB      0E6H,0C0H,000H,0E5H,02EH,026H,0F3H,00EH,054H,0A7H,005H,0D3H,000H,025H,0EAH,047H
        DB      0E0H,000H,000H,000H
        DB      0F4H,025H,000H,038H,0CDH,01EH,02EH,01AH,037H,0DEH,0A3H,0FDH,000H,00EH,012H,0FAH
        DB      011H,000H,000H,000H
        DB      008H,05FH,000H,050H,0FEH,038H,046H,0C3H,019H,0DCH,006H,01AH,000H,017H,0F0H,0C6H
        DB      05CH,000H,000H,000H
        DB      0DBH,073H,000H,051H,0DDH,007H,03BH,0F1H,0F9H,003H,019H,0F5H,000H,024H,0F5H,0DEH
        DB      026H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0CCH,004H,000H,0FEH,012H,021H,008H,028H,0F6H,0FDH,029H,0FCH,000H,0E4H,013H,009H
        DB      003H,000H,000H,000H
        DB      00DH,0DFH,000H,0EAH,062H,004H,005H,024H,001H,0A0H,00CH,0EAH,000H,004H,010H,023H
        DB      01CH,001H,000H,000H
        DB      0EFH,0E0H,000H,0D3H,022H,02AH,0EDH,01CH,017H,0D1H,0A5H,029H,000H,03BH,009H,014H
        DB      012H,000H,000H,000H
        DB      000H,026H,000H,01FH,0EBH,0F4H,0CEH,015H,0EEH,0D5H,0D0H,01CH,000H,021H,00EH,0FBH
        DB      030H,000H,000H,000H
        DB      0E6H,01AH,000H,024H,01DH,03BH,002H,0BBH,000H,0CEH,023H,007H,000H,013H,017H,0F6H
        DB      02AH,000H,000H,000H
        DB      015H,02CH,000H,027H,05AH,0FBH,0FCH,081H,0C7H,012H,0FAH,0EEH,000H,0C5H,01CH,006H
        DB      01CH,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      02EH,0E8H,000H,0D0H,026H,0FAH,0EEH,0E3H,006H,0D3H,0BCH,0D8H,000H,0DAH,00DH,047H
        DB      0B1H,000H,000H,000H
        DB      01AH,009H,000H,0BCH,024H,035H,01DH,0B8H,005H,017H,027H,021H,000H,00EH,01CH,037H
        DB      0D8H,0FFH,000H,000H
        DB      00FH,016H,000H,0BCH,0FEH,034H,0E4H,032H,0DEH,000H,048H,025H,000H,039H,000H,01BH
        DB      0D9H,000H,000H,000H
        DB      0E9H,02CH,000H,049H,0CEH,044H,0A7H,025H,0F5H,018H,023H,015H,000H,022H,042H,022H
        DB      02DH,000H,000H,000H
        DB      01CH,0E7H,000H,02AH,011H,005H,0FAH,0DEH,0D7H,0E1H,0DAH,0F2H,000H,0DCH,04AH,02EH
        DB      0C8H,0FFH,000H,000H
        DB      0DAH,0CDH,000H,0D9H,02BH,0C5H,011H,0DDH,0D4H,0FCH,008H,017H,000H,0E5H,04DH,00DH
        DB      0E5H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0D7H,0ECH,000H,0FDH,03DH,018H,0DFH,0B8H,0D7H,0FFH,007H,0F1H,000H,0EBH,019H,040H
        DB      0DDH,000H,000H,000H
        DB      06AH,05EH,000H,0ADH,038H,00CH,0C0H,0C7H,0E1H,01BH,041H,030H,000H,0BEH,093H,035H
        DB      0BAH,000H,000H,000H
        DB      02CH,039H,000H,0CAH,038H,044H,0B4H,0D6H,044H,03FH,0CFH,0CCH,000H,0E4H,0E5H,04CH
        DB      0C4H,000H,000H,000H
        DB      0CDH,0F5H,000H,0FAH,014H,04FH,0F4H,0FCH,00BH,01EH,0DFH,030H,000H,03FH,00CH,052H
        DB      0D6H,0FFH,000H,000H
        DB      0E6H,0E8H,000H,006H,006H,01CH,05CH,0FEH,0E4H,0E9H,0F5H,040H,000H,007H,01AH,046H
        DB      0DAH,000H,000H,000H
        DB      001H,0EFH,000H,01EH,010H,0F4H,01BH,026H,094H,0F5H,05BH,035H,000H,01CH,015H,0C5H
        DB      0AAH,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0ADH,022H,000H,000H,0E9H,0DEH,046H,0CFH,0FCH,076H,0AAH,009H,000H,0C6H,009H,0FBH
        DB      0D1H,000H,000H,000H
        DB      022H,02BH,000H,0B3H,0EAH,0FAH,0EBH,0FDH,013H,01EH,020H,01CH,000H,004H,0F3H,0EEH
        DB      007H,000H,000H,000H
        DB      030H,015H,000H,0B6H,0F4H,0EDH,0D8H,006H,036H,0E9H,024H,0E0H,000H,0FBH,019H,039H
        DB      00EH,000H,000H,000H
        DB      0D1H,0FEH,000H,021H,008H,0DBH,029H,0ECH,02BH,033H,0E2H,0E6H,000H,0DBH,0D8H,0FFH
        DB      0C0H,000H,000H,000H
        DB      006H,02EH,000H,02CH,0EDH,0F5H,034H,040H,01AH,03AH,021H,013H,000H,0A5H,0CBH,036H
        DB      0F0H,000H,000H,000H
        DB      0DDH,00DH,000H,03EH,004H,0F8H,0F9H,02CH,007H,014H,01AH,0E6H,000H,0FAH,0FDH,007H
        DB      005H,000H,000H,000H
        DB      010H,004H,000H,000H,0FCH,0F2H,0FEH,019H,000H,007H,022H,0FEH,000H,0FDH,000H,0FCH
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      014H,019H,000H,0FFH,0F0H,0F3H,021H,044H,022H,00EH,0BDH,0D8H,000H,012H,012H,013H
        DB      035H,000H,000H,000H
        DB      02AH,012H,000H,0C3H,01AH,0BBH,01EH,05EH,01EH,015H,0D7H,00DH,000H,003H,0F4H,0CFH
        DB      0FFH,000H,000H,000H
        DB      00EH,0F4H,000H,005H,0F9H,004H,000H,01EH,039H,0EAH,041H,00AH,000H,002H,0A0H,02DH
        DB      0E5H,000H,000H,000H
        DB      0D8H,01FH,000H,052H,0E7H,035H,0ECH,018H,026H,01DH,05AH,0D8H,000H,0FCH,0DDH,03DH
        DB      024H,000H,000H,000H
        DB      0E3H,02CH,000H,0DCH,0F7H,016H,0CFH,014H,058H,016H,011H,0C7H,000H,003H,0C9H,037H
        DB      020H,000H,000H,000H
        DB      0F9H,006H,000H,099H,0E9H,031H,0FAH,0F5H,031H,0DEH,0D9H,0E3H,000H,00EH,0F7H,017H
        DB      0D1H,000H,000H,000H
W2:
        DB      0DDH,0FFH,0FFH,032H,00EH,000H,0C3H,027H,002H,043H,0B2H,004H,0F5H,03CH,0F6H,000H,0A5H,0C9H,0CEH,0B9H,000H,000H,000H
        DB      059H,0FDH,0FFH,01CH,002H,000H,07FH,0EEH,02CH,0D3H,0FFH,045H,0C2H,09AH,0F3H,000H,01AH,0D5H,009H,0A7H,000H,000H,000H
        DB      04FH,001H,000H,0F2H,044H,000H,0D1H,0DDH,0D2H,000H,008H,02AH,030H,0F9H,0A1H,000H,0CFH,0E2H,0E3H,018H,000H,000H,000H
        DB      046H,000H,000H,0E4H,0F7H,000H,001H,09EH,0D1H,01BH,031H,0E3H,0FBH,0EFH,01BH,000H,0F5H,023H,000H,0F4H,000H,000H,000H
        DB      039H,002H,000H,0CEH,0E3H,000H,0F5H,023H,01DH,0D5H,09DH,0E9H,0E8H,0BDH,004H,000H,0F6H,0FAH,042H,05EH,000H,000H,000H
        DB      0DCH,000H,000H,0E3H,0A3H,000H,0ADH,022H,099H,004H,030H,003H,03DH,01EH,0DFH,000H,001H,01FH,0AFH,0FBH,000H,000H,000H
        DB      004H,0FFH,0FFH,016H,0F6H,000H,017H,00EH,0DEH,0C3H,00AH,0EAH,00DH,049H,0FAH,000H,0E7H,0C1H,030H,09EH,000H,000H,000H
        DB      0FAH,0FEH,0FFH,024H,011H,000H,00FH,0CEH,00EH,0D3H,0C8H,0ACH,016H,0BAH,0EBH,000H,00AH,057H,0E0H,005H,000H,000H,000H
        DB      03DH,000H,000H,006H,025H,000H,0BBH,00BH,00DH,0EFH,00BH,0FFH,0F7H,0EDH,01CH,000H,015H,0C5H,0E1H,0E8H,000H,000H,000H
        DB      016H,000H,000H,0ABH,002H,000H,0F5H,000H,0F7H,027H,0FDH,0F2H,081H,019H,0F5H,000H,022H,017H,0BAH,01AH,000H,000H,000H
        END
