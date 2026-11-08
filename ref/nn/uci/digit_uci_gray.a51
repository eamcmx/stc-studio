; Digit reader on the UCI handwritten digits (8 x 8, 16 grey levels): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     24              ; hidden neurons
SH1     EQU     5               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      094H,0FFH,0ADH,0FFH,0B5H,0FFH,0ADH,001H,025H,000H,0A2H,0FFH,048H,001H,0ABH,0FEH
        DB      0DAH,0FFH,093H,000H,0B9H,0FFH,03CH,001H,07DH,0FFH,09DH,001H,0D2H,0FFH,0C0H,0FFH
        DB      059H,000H,0A3H,0FFH,05AH,001H,068H,0FFH,0B6H,0FFH,0B2H,0FFH,07EH,000H,068H,0FFH
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,0F4H,0F4H,0E1H,0FCH,0E7H,015H,008H,000H,005H,020H,00AH,000H,000H
        DB      020H,000H,0F0H,0F3H,00CH,000H,00BH,008H
        DB      000H,000H,000H,0EDH,02EH,006H,0E6H,0FFH,0D3H,012H,000H,031H,0FDH,041H,000H,000H
        DB      0E7H,000H,015H,0F8H,0CFH,000H,022H,008H
        DB      000H,000H,000H,0EBH,008H,003H,0E3H,013H,009H,014H,000H,0FDH,021H,034H,000H,000H
        DB      02EH,000H,0FEH,000H,010H,000H,015H,01FH
        DB      000H,000H,000H,0EFH,00EH,0FEH,040H,014H,0FAH,022H,000H,008H,009H,015H,000H,000H
        DB      00FH,000H,0F0H,0F0H,0EDH,000H,01DH,02FH
        DB      000H,000H,000H,0D7H,031H,0DEH,03DH,02AH,0E7H,027H,000H,00BH,0DBH,01EH,000H,000H
        DB      0F6H,000H,001H,01BH,00EH,000H,01CH,052H
        DB      000H,000H,000H,0CCH,01EH,0E9H,0FFH,01BH,0DEH,028H,000H,028H,0C6H,020H,000H,000H
        DB      0F1H,000H,0E5H,00FH,0E9H,000H,02BH,009H
        DB      000H,000H,000H,0EEH,0FCH,0EDH,004H,0F8H,0D6H,00CH,000H,00CH,0EEH,014H,000H,000H
        DB      0D3H,000H,004H,013H,0F9H,000H,01BH,0FDH
        DB      000H,000H,000H,0FAH,0FCH,0F2H,016H,0EDH,002H,005H,000H,0FBH,004H,000H,000H,000H
        DB      010H,000H,000H,0FCH,00FH,000H,0FEH,0FDH
        DB      000H,000H,000H,0E0H,021H,0F3H,02EH,0FFH,0F1H,00FH,000H,010H,021H,01CH,000H,000H
        DB      01FH,000H,0EDH,0E4H,001H,000H,018H,027H
        DB      000H,000H,000H,0C8H,012H,0E7H,0F6H,0F4H,012H,028H,000H,02AH,01FH,02EH,000H,000H
        DB      01DH,000H,0EEH,0EFH,012H,000H,020H,013H
        DB      000H,000H,000H,0F2H,00BH,0EFH,003H,006H,0D7H,03BH,000H,020H,0F9H,02BH,000H,000H
        DB      001H,000H,0E3H,002H,0D2H,000H,028H,0F9H
        DB      000H,000H,000H,0FDH,005H,0FFH,0EEH,02EH,0F7H,04EH,000H,0FDH,016H,006H,000H,000H
        DB      0F2H,000H,0C9H,00BH,0E0H,000H,048H,041H
        DB      000H,000H,000H,0E1H,019H,0F8H,000H,01BH,005H,032H,000H,0F7H,000H,01CH,000H,000H
        DB      018H,000H,003H,014H,01CH,000H,004H,01CH
        DB      000H,000H,000H,01BH,0CEH,015H,0FFH,005H,02FH,0EDH,000H,00FH,0CDH,0F0H,000H,000H
        DB      019H,000H,02CH,0FDH,0F3H,000H,0EFH,0EFH
        DB      000H,000H,000H,0F2H,0F5H,0EAH,001H,0FCH,0F5H,004H,000H,012H,0F5H,001H,000H,000H
        DB      007H,000H,001H,0E1H,0F7H,000H,01DH,010H
        DB      000H,000H,000H,0FFH,0FFH,0FEH,004H,0FEH,001H,001H,000H,0FFH,001H,002H,000H,000H
        DB      002H,000H,000H,0FFH,002H,000H,0FFH,0FFH
        DB      000H,000H,000H,004H,0E9H,0F3H,001H,0E9H,02EH,0EDH,000H,00DH,008H,0E7H,000H,000H
        DB      0F0H,000H,01FH,033H,01FH,000H,0E2H,00AH
        DB      000H,000H,000H,004H,033H,014H,0C4H,0F1H,0FAH,0F4H,000H,0F7H,0DBH,023H,000H,000H
        DB      001H,000H,017H,025H,025H,000H,0C1H,0D5H
        DB      000H,000H,000H,022H,0E0H,037H,0D8H,041H,0ECH,0E9H,000H,0DCH,0EEH,0E9H,000H,000H
        DB      0EDH,000H,032H,02DH,0EFH,000H,081H,010H
        DB      000H,000H,000H,025H,0D8H,033H,0E3H,038H,017H,0F3H,000H,0F1H,034H,0EAH,000H,000H
        DB      001H,000H,0FDH,01BH,0D2H,000H,0DCH,03AH
        DB      000H,000H,000H,021H,0D3H,000H,0A4H,0DDH,03DH,01FH,000H,0EEH,02CH,02EH,000H,000H
        DB      04FH,000H,0F3H,0E3H,01DH,000H,0F1H,0FEH
        DB      000H,000H,000H,006H,0D1H,00DH,097H,014H,040H,00CH,000H,0F6H,014H,0F4H,000H,000H
        DB      039H,000H,0DCH,0DFH,009H,000H,021H,0F5H
        DB      000H,000H,000H,0F6H,0FEH,0FCH,000H,00BH,0FAH,009H,000H,0FBH,0FEH,009H,000H,000H
        DB      011H,000H,0F3H,0F6H,0FCH,000H,002H,00BH
        DB      000H,000H,000H,000H,000H,000H,000H,001H,000H,000H,000H,000H,000H,0FFH,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,019H,0F4H,0F0H,0F8H,0D7H,00FH,003H,000H,014H,012H,007H,000H,000H
        DB      0D4H,000H,003H,0EFH,003H,000H,0C7H,0EBH
        DB      000H,000H,000H,01CH,02EH,0FAH,0DAH,00DH,0D6H,015H,000H,0FCH,0D7H,027H,000H,000H
        DB      0F3H,000H,01DH,002H,0FFH,000H,0ADH,0E7H
        DB      000H,000H,000H,007H,0E9H,0F0H,0EFH,0F3H,0F1H,0DEH,000H,0EAH,005H,009H,000H,000H
        DB      006H,000H,063H,009H,02CH,000H,0F1H,00EH
        DB      000H,000H,000H,00EH,0E4H,009H,00EH,01BH,007H,0E2H,000H,017H,023H,017H,000H,000H
        DB      01DH,000H,001H,0FAH,013H,000H,020H,02FH
        DB      000H,000H,000H,00FH,010H,018H,09FH,005H,0E8H,017H,000H,0EEH,0EFH,032H,000H,000H
        DB      010H,000H,0F9H,0F3H,0E5H,000H,0F7H,00EH
        DB      000H,000H,000H,03EH,00EH,01EH,091H,0C9H,0E0H,0FDH,000H,0D6H,0FDH,030H,000H,000H
        DB      0E2H,000H,00CH,0EBH,0DEH,000H,008H,0E4H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,00AH,017H,01BH,012H,00DH,0D2H,004H,000H,0FAH,0FAH,012H,000H,000H
        DB      0ECH,000H,0FAH,0CDH,0E6H,000H,0EBH,0EBH
        DB      000H,000H,000H,02FH,00CH,001H,00AH,0F6H,0FEH,0FFH,000H,0D7H,0ECH,0FDH,000H,000H
        DB      0F6H,000H,010H,0E8H,0FDH,000H,0FDH,00AH
        DB      000H,000H,000H,002H,00AH,0DFH,01CH,013H,0F7H,0F7H,000H,0E6H,0FBH,017H,000H,000H
        DB      024H,000H,024H,0EEH,051H,000H,015H,028H
        DB      000H,000H,000H,027H,0F0H,0FDH,009H,0F9H,003H,0D6H,000H,0FAH,02AH,017H,000H,000H
        DB      00DH,000H,019H,0F2H,002H,000H,032H,01DH
        DB      000H,000H,000H,03AH,0DCH,01FH,01CH,019H,002H,0CCH,000H,0D4H,0FBH,0EEH,000H,000H
        DB      0FBH,000H,0F2H,0DDH,0D1H,000H,0F0H,02AH
        DB      000H,000H,000H,049H,0F2H,002H,025H,0D1H,0D7H,000H,000H,0F8H,0D3H,011H,000H,000H
        DB      0C4H,000H,00EH,0CBH,0CDH,000H,000H,0F7H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,0FFH,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,001H,000H,0FFH,000H,000H,000H
        DB      000H,000H,000H,044H,0F7H,003H,00DH,0A9H,0FCH,0D5H,000H,0BCH,001H,0F8H,000H,000H
        DB      013H,000H,02EH,0E9H,0F9H,000H,0FDH,0F9H
        DB      000H,000H,000H,052H,02FH,0E2H,019H,0C0H,04AH,0E7H,000H,0A7H,02BH,0BBH,000H,000H
        DB      0E9H,000H,0D9H,038H,03EH,000H,025H,0D2H
        DB      000H,000H,000H,051H,02FH,01EH,0F7H,0EFH,01AH,0C0H,000H,0C8H,005H,0DEH,000H,000H
        DB      0C9H,000H,00AH,048H,0E3H,000H,045H,0D0H
        DB      000H,000H,000H,039H,0C7H,00AH,0E8H,003H,0F4H,0D9H,000H,0C6H,0F4H,0F6H,000H,000H
        DB      0FBH,000H,043H,0F6H,0FEH,000H,011H,02BH
        DB      000H,000H,000H,026H,0EAH,0E2H,03AH,0F8H,011H,002H,000H,0F0H,0F3H,0EDH,000H,000H
        DB      002H,000H,00BH,0E9H,00CH,000H,0DCH,018H
        DB      000H,000H,000H,011H,0F5H,0C7H,056H,0F9H,0F3H,003H,000H,0FDH,0E6H,0E5H,000H,000H
        DB      0EBH,000H,0D3H,0EBH,027H,000H,0E1H,02CH
        DB      000H,000H,000H,0FDH,003H,0FDH,007H,004H,0FBH,001H,000H,002H,0FDH,000H,000H,000H
        DB      0FFH,000H,0FDH,0FFH,004H,000H,001H,0FEH
        DB      000H,000H,000H,000H,000H,002H,000H,0FFH,000H,000H,000H,003H,000H,000H,000H,000H
        DB      0FFH,000H,000H,000H,0FCH,000H,000H,0FFH
        DB      000H,000H,000H,0F2H,0FEH,017H,00CH,0DAH,013H,0FDH,000H,014H,026H,0E4H,000H,000H
        DB      003H,000H,033H,020H,0D6H,000H,0E3H,00CH
        DB      000H,000H,000H,0F2H,00FH,00EH,00FH,0ECH,010H,019H,000H,019H,00AH,0FAH,000H,000H
        DB      00FH,000H,001H,00EH,01CH,000H,0EBH,0F7H
        DB      000H,000H,000H,010H,0FCH,014H,01BH,0F7H,01DH,00CH,000H,02BH,017H,0E0H,000H,000H
        DB      0ECH,000H,0EFH,005H,0F2H,000H,005H,0E5H
        DB      000H,000H,000H,003H,018H,007H,0F0H,006H,033H,018H,000H,022H,0FFH,0C0H,000H,000H
        DB      0C7H,000H,016H,036H,0FDH,000H,008H,0BEH
        DB      000H,000H,000H,0FCH,0E1H,0D9H,041H,0F0H,041H,01EH,000H,03BH,0FCH,0BFH,000H,000H
        DB      0F6H,000H,0F2H,0F4H,02CH,000H,011H,0E7H
        DB      000H,000H,000H,0FCH,0FDH,014H,0FBH,030H,0F6H,0E3H,000H,00FH,0FDH,000H,000H,000H
        DB      003H,000H,0ECH,030H,00DH,000H,0E4H,010H
        DB      000H,000H,000H,005H,000H,004H,0FAH,00BH,0FDH,0FFH,000H,0FDH,0FBH,0FAH,000H,000H
        DB      0F5H,000H,003H,009H,002H,000H,006H,0F6H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,001H,000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,0FAH,0EFH,005H,0FAH,00CH,017H,001H,000H,02CH,014H,0EBH,000H,000H
        DB      0FCH,000H,0F8H,0FAH,0D5H,000H,001H,00BH
        DB      000H,000H,000H,0EBH,0ECH,002H,009H,0FFH,01BH,0FEH,000H,039H,02AH,0F8H,000H,000H
        DB      00EH,000H,025H,0F6H,0EEH,000H,013H,010H
        DB      000H,000H,000H,0B9H,022H,0E7H,014H,02CH,014H,03AH,000H,032H,017H,007H,000H,000H
        DB      00FH,000H,0E6H,010H,039H,0FFH,005H,008H
        DB      000H,000H,000H,005H,00FH,010H,02DH,021H,023H,015H,000H,0F9H,0F6H,0D3H,000H,000H
        DB      017H,000H,001H,01CH,01CH,0FFH,0E8H,0ECH
        DB      000H,000H,000H,026H,003H,02CH,022H,02EH,012H,0CCH,000H,00EH,00DH,0DDH,000H,000H
        DB      0EBH,000H,0EAH,01FH,011H,000H,01BH,0D9H
        DB      000H,000H,000H,0E5H,003H,022H,0F1H,020H,0FDH,0ECH,000H,025H,012H,00CH,000H,000H
        DB      003H,000H,0FAH,035H,003H,000H,03BH,0D1H
        DB      000H,000H,000H,016H,0FCH,018H,0DFH,00EH,00CH,0E7H,000H,0E5H,00BH,0F2H,000H,000H
        DB      0FDH,000H,01AH,01DH,0F9H,000H,010H,0E1H
W2:
        DB      02AH,002H,000H,000H,000H,000H,024H,00AH,0EDH,0DEH,0BBH,030H,047H,000H,0F7H,0E9H,0EFH,000H,000H,0E4H,000H,0C2H,0EFH,0FDH,000H,0CBH,0B3H
        DB      09BH,0FCH,0FFH,000H,000H,000H,00EH,012H,01FH,081H,031H,00EH,0D5H,000H,0C9H,0F9H,0B5H,000H,000H,0D0H,000H,00FH,033H,0F9H,000H,0F9H,020H
        DB      00BH,000H,000H,000H,000H,000H,0C2H,00AH,01CH,0F8H,0EDH,038H,000H,000H,03CH,032H,0DFH,000H,000H,0FEH,000H,0C5H,024H,0DEH,000H,03AH,0B5H
        DB      0E8H,0FDH,0FFH,000H,000H,000H,0D1H,09FH,0C3H,02CH,00CH,007H,00BH,000H,03AH,00BH,0D9H,000H,000H,010H,000H,00CH,0B7H,0F7H,000H,011H,026H
        DB      074H,004H,000H,000H,000H,000H,03AH,0E4H,032H,02BH,09FH,0E8H,0B7H,000H,014H,0D1H,02DH,000H,000H,0FFH,000H,056H,0FCH,0BFH,000H,0B9H,0EEH
        DB      0E3H,0FEH,0FFH,000H,000H,000H,0AAH,028H,006H,032H,01FH,0ACH,035H,000H,039H,0BDH,015H,000H,000H,0C5H,000H,010H,00DH,0EFH,000H,0EEH,005H
        DB      02AH,002H,000H,000H,000H,000H,01CH,020H,0F6H,036H,004H,00EH,0C3H,000H,0AEH,0E6H,0D2H,000H,000H,0D3H,000H,0DAH,007H,035H,000H,00DH,09BH
        DB      0D1H,0FEH,0FFH,000H,000H,000H,005H,000H,0D6H,001H,0CDH,0C1H,0F4H,000H,0E9H,004H,038H,000H,000H,0EAH,000H,0DBH,0D9H,0A8H,000H,05AH,039H
        DB      06BH,000H,000H,000H,000H,000H,0EDH,0F9H,0DAH,0EBH,0DFH,01EH,0F5H,000H,0A6H,013H,0F4H,000H,000H,01EH,000H,013H,01BH,040H,000H,0EDH,00BH
        DB      0E3H,0FEH,0FFH,000H,000H,000H,0E4H,0EFH,00CH,0B3H,018H,0E6H,008H,000H,0FCH,018H,025H,000H,000H,045H,000H,0F2H,0CEH,002H,000H,09CH,024H
        END
