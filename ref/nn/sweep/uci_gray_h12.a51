; SWEEP BUILD (nn/study.py), H = 12. Digit reader on the UCI handwritten digits (8 x 8, 16 grey levels): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     12              ; hidden neurons
SH1     EQU     6               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      08BH,000H,0F5H,000H,050H,000H,05DH,001H,07DH,0FEH,04CH,000H,09DH,001H,0C7H,0FFH
        DB      0EBH,002H,073H,000H,0B6H,000H,0CCH,0FFH
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      002H,025H,0E2H,014H,0F7H,01AH,0D5H,000H,011H,0F7H,01EH,000H
        DB      0F0H,022H,029H,0C8H,0F0H,0D5H,013H,000H,02FH,03BH,008H,000H
        DB      0C5H,02EH,0EEH,0FEH,011H,016H,000H,000H,009H,02AH,032H,000H
        DB      0FDH,034H,032H,0FBH,00EH,019H,0E7H,000H,00DH,010H,004H,000H
        DB      0B7H,03CH,047H,0ECH,013H,0F6H,002H,000H,019H,0C7H,005H,000H
        DB      0D1H,04BH,046H,0CEH,0F9H,0A4H,0ECH,000H,001H,0DCH,0EDH,000H
        DB      001H,0FFH,05CH,0FCH,0E8H,0BCH,0F5H,000H,019H,009H,0FDH,000H
        DB      00DH,022H,0D8H,01DH,0DAH,022H,0F3H,000H,000H,000H,0FDH,000H
        DB      0E0H,045H,002H,003H,0FFH,010H,0DEH,000H,00DH,039H,017H,000H
        DB      0CAH,04AH,0F7H,017H,0E7H,0F5H,0E3H,000H,02CH,037H,008H,000H
        DB      0F1H,034H,034H,0F8H,001H,0C6H,0F1H,000H,02AH,017H,0F5H,000H
        DB      0F9H,030H,01CH,00DH,03BH,0C2H,0C9H,000H,0E4H,0F4H,013H,000H
        DB      097H,029H,0F2H,018H,010H,007H,0FBH,000H,006H,0FFH,003H,000H
        DB      002H,0EAH,0CBH,0F1H,008H,008H,00DH,000H,0F0H,015H,012H,000H
        DB      001H,017H,02EH,0F3H,0F1H,0DDH,0D1H,000H,00AH,01CH,0FAH,000H
        DB      000H,002H,0FEH,004H,0FEH,002H,0FFH,000H,002H,0FDH,0FFH,000H
        DB      0E9H,011H,0F5H,006H,0E2H,012H,02AH,000H,00AH,0F7H,044H,000H
        DB      0DAH,0F0H,0EBH,0F9H,0EEH,0F9H,068H,000H,031H,0EBH,0EFH,000H
        DB      022H,0ECH,0FBH,0C5H,045H,007H,07FH,000H,0C9H,0E6H,0F2H,000H
        DB      0EFH,0F4H,0DEH,0CCH,04BH,000H,00CH,000H,0BCH,013H,027H,000H
        DB      0B8H,00AH,08CH,037H,01DH,030H,0F4H,000H,01DH,019H,0FBH,000H
        DB      019H,01DH,0AAH,037H,017H,01EH,0CBH,000H,0DBH,020H,032H,000H
        DB      0F3H,00DH,0F6H,001H,002H,0F5H,0FEH,000H,01BH,00CH,0FDH,000H
        DB      000H,0FEH,0FFH,000H,001H,000H,000H,000H,0FFH,000H,001H,000H
        DB      04BH,0F7H,00DH,027H,016H,01CH,026H,000H,009H,0FDH,0F4H,000H
        DB      02EH,0F9H,00FH,008H,00EH,0DDH,05AH,000H,032H,0D9H,0B5H,000H
        DB      02CH,001H,0EDH,0CAH,0FCH,03BH,033H,000H,03DH,0F2H,014H,000H
        DB      0DFH,0FFH,0FFH,0E7H,020H,039H,0E1H,000H,00DH,027H,01CH,000H
        DB      0D7H,0FDH,0D0H,0EFH,03EH,0C7H,016H,000H,02BH,013H,009H,000H
        DB      016H,0D7H,000H,009H,012H,092H,011H,000H,052H,0FFH,0FFH,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      005H,0F5H,02BH,008H,025H,0FFH,00AH,000H,018H,00CH,0CFH,000H
        DB      005H,0DCH,0EDH,00BH,032H,0E6H,015H,000H,023H,0D9H,0E1H,000H
        DB      0D9H,00AH,003H,0F2H,012H,057H,0EFH,000H,030H,0D2H,004H,000H
        DB      0E2H,0E9H,0FBH,0EBH,010H,018H,0E1H,000H,037H,00AH,035H,000H
        DB      03BH,0DFH,0F3H,0E4H,05BH,0FFH,0FDH,000H,017H,000H,0F9H,000H
        DB      04EH,0D8H,03EH,0FEH,03DH,0D4H,00EH,000H,023H,0F1H,0BBH,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      001H,000H,000H,0FDH,001H,0FDH,002H,000H,000H,000H,000H,000H
        DB      056H,0C1H,0A4H,0F1H,0EFH,00BH,016H,000H,062H,0F7H,0FEH,000H
        DB      039H,0A7H,0D3H,076H,0D3H,00AH,002H,000H,0FAH,0A1H,04EH,000H
        DB      00DH,09BH,01AH,018H,0EEH,0B6H,020H,000H,003H,0C5H,062H,000H
        DB      01EH,0CCH,001H,0BDH,031H,01DH,00DH,000H,01DH,0E5H,025H,000H
        DB      053H,017H,009H,014H,02BH,03AH,007H,000H,0FAH,0D8H,0E5H,000H
        DB      021H,018H,03AH,029H,018H,04AH,0D0H,000H,019H,0D5H,0DFH,000H
        DB      0F8H,005H,015H,011H,0F8H,010H,0FAH,000H,0FCH,000H,0FAH,000H
        DB      001H,001H,001H,0FFH,0FDH,0F9H,0FFH,000H,000H,000H,001H,000H
        DB      01FH,02DH,0D8H,0B3H,0EBH,0CBH,01BH,000H,0FBH,0C9H,02CH,000H
        DB      01EH,01EH,001H,024H,0E0H,016H,025H,000H,0D2H,010H,00BH,000H
        DB      032H,0F9H,02CH,02BH,0E5H,0F9H,010H,000H,0D0H,02DH,023H,000H
        DB      054H,010H,026H,022H,0EBH,0CAH,032H,000H,0BBH,0CAH,02CH,000H
        DB      031H,028H,007H,03DH,0DDH,01DH,0DAH,000H,0B2H,007H,026H,000H
        DB      0E5H,00BH,010H,0DCH,0F9H,00CH,022H,000H,0F9H,007H,014H,000H
        DB      0E3H,0F2H,01AH,01CH,0F7H,00EH,004H,000H,0F2H,002H,002H,000H
        DB      000H,000H,000H,000H,0FFH,0FFH,000H,000H,000H,000H,000H,000H
        DB      01AH,019H,012H,0E0H,01BH,0F4H,0D9H,000H,0D9H,0F6H,016H,000H
        DB      00BH,02CH,01EH,0D7H,0E5H,00FH,0E9H,000H,0F2H,022H,028H,000H
        DB      0B3H,060H,020H,037H,0EDH,02DH,027H,000H,0D1H,031H,009H,000H
        DB      001H,020H,007H,026H,0FEH,019H,031H,000H,0C4H,0F0H,003H,000H
        DB      019H,0BAH,00DH,01BH,0E9H,00CH,01BH,000H,0BCH,035H,02AH,000H
        DB      0E9H,0EFH,000H,007H,0BEH,0FDH,022H,000H,0E4H,015H,035H,000H
        DB      0DDH,0C2H,001H,0FBH,0DBH,0E2H,02AH,000H,0FBH,0E4H,036H,000H
W2:
        DB      019H,0FFH,0FFH,025H,009H,0CCH,054H,0FAH,0ACH,0FEH,000H,0EDH,0F6H,0D8H,000H
        DB      07FH,0FFH,0FFH,0B4H,0B7H,011H,0C8H,032H,0EDH,022H,000H,0ABH,0C6H,024H,000H
        DB      069H,000H,000H,0FEH,00EH,0EDH,00EH,0A1H,0BAH,0E7H,000H,0ABH,02FH,03BH,000H
        DB      056H,0FFH,0FFH,035H,036H,00EH,0DFH,00DH,040H,0A3H,000H,0D0H,007H,0EFH,000H
        DB      088H,000H,000H,056H,0A3H,0D0H,0ADH,001H,0D8H,02BH,000H,03DH,04CH,0E3H,000H
        DB      076H,0FFH,0FFH,0ABH,035H,05FH,0D4H,0E3H,0D9H,012H,000H,0F4H,0FCH,0B9H,000H
        DB      0DCH,0FFH,0FFH,010H,090H,038H,03CH,0D4H,044H,0F7H,000H,002H,0DBH,0F7H,000H
        DB      013H,001H,000H,0FEH,0EEH,029H,0EBH,022H,0C5H,081H,000H,04CH,015H,01BH,000H
        DB      0D0H,000H,000H,0D2H,0FDH,0C2H,003H,0E5H,032H,007H,000H,0FCH,09FH,01DH,000H
        DB      0E3H,0FFH,0FFH,0B5H,01DH,0B8H,0E0H,01FH,007H,0FEH,000H,00CH,03AH,0D8H,000H
        END
