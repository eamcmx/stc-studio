; SWEEP BUILD (nn/study.py), H = 12. Digit reader on the UCI handwritten digits (8 x 8, squares on or off): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     12              ; hidden neurons
SH1     EQU     2               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      02CH,000H,034H,000H,0FBH,0FFH,0FDH,0FFH,0CEH,0FFH,000H,000H,026H,000H,0FAH,0FFH
        DB      062H,000H,044H,000H,0D4H,0FFH,0F6H,0FFH
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      006H,030H,0F2H,0EFH,010H,0DFH,012H,000H,010H,00BH,0C6H,0DEH
        DB      0D7H,032H,023H,00EH,0F9H,002H,0F0H,000H,0F3H,01FH,017H,015H
        DB      00FH,040H,055H,0F7H,01CH,00CH,0E1H,000H,0FFH,013H,001H,02DH
        DB      01EH,065H,044H,037H,0FFH,0E7H,0F9H,000H,0EFH,032H,0FCH,033H
        DB      0F0H,049H,0FFH,0E3H,0BDH,0C7H,003H,000H,0F5H,059H,0FDH,022H
        DB      0B4H,0DAH,034H,007H,0AFH,0D6H,040H,000H,010H,017H,0DFH,017H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      00EH,04DH,0F0H,009H,0E6H,004H,0E1H,000H,045H,028H,0FFH,0F1H
        DB      023H,040H,0ECH,021H,0FFH,0DCH,0FEH,000H,0E9H,02EH,0FFH,0EFH
        DB      0EEH,017H,02EH,0F7H,0E4H,0CBH,0FCH,000H,0F7H,036H,0FCH,0F1H
        DB      000H,01EH,00FH,02BH,01DH,0CEH,0BAH,000H,0D7H,0F7H,001H,04BH
        DB      018H,034H,009H,02CH,01BH,0D1H,011H,000H,0EEH,0FEH,012H,054H
        DB      02DH,0E3H,0CCH,0E3H,014H,040H,01DH,000H,009H,011H,005H,028H
        DB      0F0H,045H,0FDH,0F7H,00EH,0F8H,0CCH,000H,0E4H,01CH,003H,00CH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      01AH,023H,007H,000H,021H,0FAH,008H,000H,03AH,006H,05EH,01BH
        DB      0B1H,015H,00EH,011H,0DFH,025H,07FH,000H,009H,0EEH,025H,0F9H
        DB      08EH,0C3H,015H,0A5H,012H,0EBH,042H,000H,0C3H,0E6H,005H,0E5H
        DB      010H,00EH,0D6H,0CAH,05EH,0D3H,0EEH,000H,0AEH,004H,029H,019H
        DB      0E1H,0F4H,082H,040H,053H,015H,01AH,000H,0E3H,0FFH,0F5H,039H
        DB      024H,017H,090H,035H,03CH,021H,008H,000H,023H,022H,03FH,006H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0EDH,008H,0F8H,0F6H,002H,02BH,010H,000H,0FFH,025H,009H,0F4H
        DB      09DH,0E3H,013H,00CH,0EDH,00CH,01DH,000H,01FH,0F1H,0E0H,0E6H
        DB      0DCH,0FCH,0ECH,095H,0F4H,037H,027H,000H,01BH,0E0H,003H,022H
        DB      0F5H,00EH,0E4H,0E5H,018H,03AH,0E3H,000H,0FCH,0FFH,022H,039H
        DB      0D8H,0EEH,0B1H,006H,020H,027H,032H,000H,013H,026H,005H,01DH
        DB      0A7H,09EH,0AFH,02DH,0D4H,0FCH,0F6H,000H,064H,01BH,0EBH,0FCH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0F7H,0AEH,04DH,00EH,001H,000H,009H,000H,029H,008H,0D9H,0F2H
        DB      01FH,0CAH,0EDH,028H,01FH,0F7H,00CH,000H,036H,0C2H,0ECH,03DH
        DB      001H,00BH,01AH,01FH,0FBH,03FH,0D6H,000H,001H,0E7H,00EH,00EH
        DB      013H,0D5H,00BH,0E0H,005H,03EH,0CCH,000H,04AH,00FH,055H,026H
        DB      019H,0F8H,0EFH,0E4H,050H,008H,0FDH,000H,057H,0F3H,0D1H,015H
        DB      0F5H,00FH,031H,004H,00AH,005H,0FBH,000H,043H,00DH,0A0H,02AH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      011H,0B1H,0C7H,0D3H,0F0H,024H,035H,000H,06DH,019H,0E0H,02FH
        DB      03FH,0A4H,0F8H,072H,0ADH,000H,040H,000H,00EH,092H,034H,00EH
        DB      05DH,09FH,015H,0F8H,0E7H,0B7H,057H,000H,057H,0A9H,05DH,031H
        DB      01BH,0E9H,00DH,0C7H,025H,019H,00BH,000H,01DH,0D7H,012H,044H
        DB      008H,01FH,0F5H,009H,046H,03CH,0F7H,000H,017H,0D2H,0CFH,0F0H
        DB      01AH,020H,034H,050H,029H,03CH,000H,000H,002H,0EEH,0CEH,027H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      04BH,034H,0B3H,0D4H,015H,0B9H,03FH,000H,039H,0E6H,0EFH,00AH
        DB      00FH,000H,008H,03CH,0D2H,00CH,0F3H,000H,0CCH,004H,013H,002H
        DB      0FFH,0D3H,0F9H,013H,0E7H,002H,0EBH,000H,0FEH,007H,0F2H,0CDH
        DB      01CH,00FH,011H,002H,01FH,0C1H,036H,000H,0F8H,0F9H,02BH,0E7H
        DB      041H,0F5H,010H,01DH,0F5H,00EH,0F7H,000H,0D3H,0DFH,01AH,0A7H
        DB      01CH,00FH,00CH,002H,01DH,023H,021H,000H,012H,034H,03CH,0C3H
        DB      001H,0FDH,008H,009H,003H,000H,0FEH,000H,0FCH,002H,002H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      0FEH,00AH,0DFH,0E5H,0FFH,0FDH,0FDH,000H,0E6H,03DH,00EH,007H
        DB      007H,071H,01BH,023H,0DDH,0E9H,018H,000H,0B1H,021H,00BH,0F2H
        DB      029H,0FFH,01FH,039H,002H,057H,025H,000H,0DAH,0FEH,047H,0E6H
        DB      0F1H,0DAH,006H,01AH,0FCH,035H,009H,000H,0E7H,042H,04FH,0C7H
        DB      015H,0BCH,0EEH,019H,0B1H,02DH,017H,000H,0F3H,023H,05EH,0BDH
        DB      001H,0ECH,01BH,00BH,0E1H,0FDH,001H,000H,003H,00DH,00DH,0E3H
W2:
        DB      0DCH,0FFH,0FFH,0E2H,0E3H,0E8H,058H,011H,0CBH,015H,000H,0F2H,0E2H,0D3H,0D7H
        DB      0A7H,0FEH,0FFH,0E5H,0B1H,01DH,0DAH,036H,0FCH,009H,000H,0ACH,0FEH,024H,01BH
        DB      0AEH,000H,000H,026H,0F7H,0BDH,009H,0D7H,0A4H,001H,000H,0D3H,037H,035H,0C7H
        DB      0BFH,000H,000H,026H,030H,007H,0D8H,017H,011H,0C7H,000H,0ADH,00DH,0E0H,0F1H
        DB      09EH,001H,000H,005H,0BEH,0F9H,0AEH,000H,016H,024H,000H,036H,00CH,0E4H,006H
        DB      025H,000H,000H,0ECH,02BH,03AH,0D7H,0E3H,0F1H,00DH,000H,008H,021H,0C2H,0F9H
        DB      0F4H,0FDH,0FFH,01CH,0BDH,03CH,018H,0C1H,025H,0FEH,000H,0FFH,0B1H,0F9H,0C4H
        DB      046H,000H,000H,0F8H,0EFH,0DEH,0F2H,0ECH,0CAH,092H,000H,040H,032H,0F0H,045H
        DB      0A7H,000H,000H,0EDH,00CH,0DDH,002H,0DFH,022H,001H,000H,0DAH,0AFH,020H,012H
        DB      0B9H,0FFH,0FFH,081H,01EH,0CAH,0FAH,015H,00DH,0F4H,000H,00BH,016H,0EBH,010H
        END
