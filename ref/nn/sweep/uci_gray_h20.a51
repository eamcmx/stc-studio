; SWEEP BUILD (nn/study.py), H = 20. Digit reader on the UCI handwritten digits (8 x 8, 16 grey levels): a 64-24-10 neural network on the STC89C52RC.
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
NH      EQU     20              ; hidden neurons
SH1     EQU     6               ; hidden values are (sum >> SH1), 0 to 255

B1:
        DB      047H,002H,046H,001H,0C6H,0FFH,047H,0FEH,0C4H,002H,09FH,0FFH,061H,000H,049H,000H
        DB      049H,0FDH,0EAH,002H,0A1H,0FFH,0C6H,001H,0A9H,0FFH,050H,0FFH,0D7H,002H,058H,002H
        DB      0E2H,001H,0B5H,0FFH,0A4H,0FFH,04DH,0FEH
W1:
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      007H,031H,000H,0FFH,0E9H,000H,010H,005H,000H,018H,000H,02CH,000H,0F8H,003H,0FAH
        DB      014H,000H,000H,0E5H
        DB      0EDH,0D4H,000H,01BH,012H,0F3H,016H,00CH,014H,012H,000H,0DEH,000H,018H,04EH,0C9H
        DB      03FH,000H,000H,030H
        DB      0F4H,024H,000H,0ECH,0FFH,019H,023H,015H,0E7H,0F5H,000H,015H,000H,043H,00AH,0E7H
        DB      047H,000H,000H,013H
        DB      00DH,0FBH,000H,0E5H,0FAH,0F8H,00CH,036H,0ECH,0FBH,000H,005H,000H,0FBH,034H,0EBH
        DB      0F4H,000H,000H,005H
        DB      0F4H,0D5H,000H,0E8H,014H,0CEH,027H,04EH,0D0H,0EEH,000H,0F3H,000H,032H,038H,0E4H
        DB      0B0H,000H,000H,025H
        DB      00FH,0DCH,000H,0D0H,011H,0DBH,00DH,026H,0EFH,004H,000H,0B1H,000H,022H,038H,0DAH
        DB      0D7H,000H,000H,03DH
        DB      00FH,0DDH,000H,0C4H,023H,0EEH,0F6H,0F7H,0EBH,023H,000H,0CFH,000H,003H,022H,0FDH
        DB      0F8H,000H,000H,02AH
        DB      00AH,012H,000H,0D6H,007H,0F1H,006H,001H,0D2H,014H,000H,029H,000H,0F9H,000H,00AH
        DB      000H,000H,000H,0E4H
        DB      0FEH,009H,000H,0E2H,0F5H,0ECH,01AH,02EH,0D8H,029H,000H,0FFH,000H,02FH,034H,0DEH
        DB      00FH,000H,000H,0DFH
        DB      016H,024H,000H,0EFH,0DBH,0F4H,039H,038H,0DBH,028H,000H,00EH,000H,021H,031H,0E5H
        DB      04DH,000H,000H,018H
        DB      0F9H,0E7H,000H,0D3H,008H,0F0H,023H,00EH,0FBH,02BH,000H,0D7H,000H,00DH,041H,0C6H
        DB      00FH,000H,000H,01FH
        DB      00AH,0F6H,000H,0EFH,0F4H,0F9H,05FH,021H,00BH,01AH,000H,0E6H,000H,011H,01EH,098H
        DB      0D9H,000H,000H,0F4H
        DB      0F6H,008H,000H,014H,024H,0ECH,035H,01FH,0E7H,001H,000H,008H,000H,041H,0FEH,007H
        DB      022H,000H,000H,015H
        DB      0E2H,022H,000H,025H,0EBH,028H,0F8H,0DEH,018H,01FH,000H,0FFH,000H,008H,0FDH,04CH
        DB      017H,000H,000H,0BEH
        DB      007H,00FH,000H,0ECH,0DAH,0F6H,00CH,00EH,0E2H,028H,000H,0F1H,000H,0FCH,027H,00AH
        DB      0F7H,000H,000H,00BH
        DB      000H,001H,000H,0FEH,001H,0FFH,000H,000H,0FDH,001H,000H,002H,000H,000H,001H,001H
        DB      002H,000H,000H,0FFH
        DB      0E1H,012H,000H,02CH,003H,015H,00DH,004H,010H,02BH,000H,024H,000H,02EH,0D0H,033H
        DB      0DFH,000H,000H,002H
        DB      0F3H,000H,000H,0CBH,056H,019H,004H,0DCH,000H,0F1H,000H,0F4H,000H,02AH,0D8H,061H
        DB      02FH,000H,000H,01EH
        DB      0A1H,0DAH,000H,012H,00FH,019H,0F2H,003H,04CH,089H,000H,0EBH,000H,02FH,0CEH,03DH
        DB      0DAH,000H,000H,023H
        DB      0E8H,0FEH,000H,03CH,0C9H,021H,029H,003H,043H,0C8H,000H,0FFH,000H,023H,0DEH,0EFH
        DB      013H,000H,000H,0EFH
        DB      017H,059H,000H,03DH,0F8H,026H,060H,0D9H,0E2H,008H,000H,039H,000H,034H,0E9H,0FFH
        DB      05AH,000H,000H,0B9H
        DB      004H,07DH,000H,018H,0BEH,01FH,041H,009H,0ECH,052H,000H,015H,000H,01AH,0E5H,0F8H
        DB      029H,000H,000H,0ACH
        DB      003H,00DH,000H,0ECH,0F7H,0FBH,017H,014H,0EDH,007H,000H,000H,000H,00FH,00BH,0F3H
        DB      000H,000H,000H,0FFH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      010H,00EH,000H,02EH,020H,0E9H,009H,0E9H,02EH,0E5H,000H,009H,000H,0CBH,00FH,023H
        DB      011H,000H,000H,0E5H
        DB      0FFH,0E5H,000H,0D9H,066H,0FCH,01BH,0F5H,0FFH,092H,000H,0F8H,000H,0FCH,020H,015H
        DB      00DH,000H,000H,03EH
        DB      0D6H,003H,000H,0F8H,024H,035H,0CBH,0EBH,0FFH,0F1H,000H,043H,000H,00DH,02EH,04FH
        DB      0FDH,000H,000H,021H
        DB      00BH,01EH,000H,017H,0CFH,028H,0E0H,040H,014H,0DDH,000H,011H,000H,02CH,023H,011H
        DB      005H,000H,000H,0EAH
        DB      0E7H,001H,000H,014H,015H,031H,034H,0D0H,0F5H,0CAH,000H,0E9H,000H,048H,0F8H,0D2H
        DB      018H,000H,000H,0F6H
        DB      00DH,0EFH,000H,0F4H,064H,038H,0FCH,087H,00AH,0F0H,000H,0DEH,000H,0F3H,023H,0E8H
        DB      01AH,000H,000H,018H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      000H,0C8H,000H,0E0H,028H,0E7H,0F1H,00BH,006H,0D4H,000H,0B6H,000H,0F4H,02DH,0F6H
        DB      0CFH,000H,000H,0EAH
        DB      003H,016H,000H,0E9H,025H,032H,0FDH,0D8H,004H,00AH,000H,003H,000H,0F1H,008H,000H
        DB      0EBH,000H,000H,00AH
        DB      0F8H,013H,000H,006H,019H,016H,0F2H,02BH,0B9H,0F0H,000H,031H,000H,02FH,02CH,033H
        DB      0B5H,000H,000H,018H
        DB      01FH,012H,000H,03AH,0E2H,038H,0CCH,00DH,00CH,016H,000H,011H,000H,033H,02FH,006H
        DB      000H,000H,000H,0D5H
        DB      00DH,0E9H,000H,050H,0F7H,03FH,0FAH,0F1H,02CH,0DEH,000H,0F7H,000H,0FDH,042H,000H
        DB      0CCH,000H,000H,0BDH
        DB      00CH,0ACH,000H,025H,026H,001H,0F3H,0C1H,019H,0C3H,000H,001H,000H,0C8H,032H,0F1H
        DB      0BAH,000H,000H,0F2H
        DB      000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0FFH,0FFH,000H,000H,001H,000H,000H,0FFH,000H,000H,000H,000H,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0E9H,0FCH,000H,0FFH,037H,04BH,0BDH,099H,0F9H,001H,000H,027H,000H,0E4H,005H,014H
        DB      0BAH,000H,000H,0D6H
        DB      057H,06EH,000H,0CBH,02BH,032H,0CFH,0C1H,0DFH,02DH,000H,014H,000H,0BFH,081H,006H
        DB      0C0H,000H,000H,036H
        DB      05BH,024H,000H,004H,032H,055H,0ABH,0CFH,026H,03BH,000H,0D6H,000H,0F5H,0C5H,0FAH
        DB      0DFH,000H,000H,03FH
        DB      0E9H,0EFH,000H,039H,0F9H,05BH,0E2H,0ECH,02EH,00BH,000H,01DH,000H,030H,01DH,027H
        DB      0BBH,000H,000H,0E2H
        DB      00CH,009H,000H,01DH,012H,0EFH,012H,008H,0FBH,000H,000H,03BH,000H,0E5H,01CH,03AH
        DB      0DAH,000H,000H,0BCH
        DB      028H,0E0H,000H,0E5H,0FBH,0D3H,004H,03FH,0DCH,001H,000H,01CH,000H,0CCH,00AH,018H
        DB      0B7H,000H,000H,0CCH
        DB      008H,0FDH,000H,0FAH,004H,0F7H,000H,007H,0F8H,000H,000H,000H,000H,0F7H,000H,002H
        DB      001H,000H,000H,0FEH
        DB      0FFH,0FFH,000H,000H,000H,0FFH,000H,0FFH,004H,003H,000H,0FDH,000H,0FEH,000H,0FFH
        DB      002H,000H,000H,0FFH
        DB      0A8H,0F9H,000H,0EFH,0FEH,00FH,004H,0BEH,036H,04FH,000H,019H,000H,0F4H,0D3H,006H
        DB      010H,000H,000H,0FBH
        DB      005H,019H,000H,0EEH,0F3H,0E8H,013H,0F4H,0DCH,0EEH,000H,01EH,000H,0DDH,0D5H,021H
        DB      012H,000H,000H,030H
        DB      035H,006H,000H,0FCH,0E5H,0FEH,0FAH,006H,042H,024H,000H,0E4H,000H,0C7H,0E4H,013H
        DB      01EH,000H,000H,017H
        DB      003H,0E7H,000H,00DH,017H,0E5H,014H,0FDH,05AH,03CH,000H,0DCH,000H,0CAH,0B3H,027H
        DB      0E7H,000H,000H,021H
        DB      021H,01BH,000H,032H,0E2H,0E3H,037H,031H,00CH,02EH,000H,010H,000H,0ACH,0E0H,01CH
        DB      0F3H,000H,000H,0E7H
        DB      0EAH,0DDH,000H,00AH,02BH,0F6H,0F7H,024H,01AH,013H,000H,0EBH,000H,01BH,0CCH,02AH
        DB      007H,000H,000H,0EDH
        DB      015H,002H,000H,0F2H,000H,0EAH,0FEH,00DH,0F8H,01DH,000H,0FAH,000H,0EBH,0F5H,0FFH
        DB      002H,000H,000H,0FBH
        DB      000H,000H,000H,000H,000H,000H,000H,000H,001H,001H,000H,0FFH,000H,000H,000H,000H
        DB      000H,000H,000H,000H
        DB      0E8H,007H,000H,020H,0DEH,0F9H,010H,002H,04BH,024H,000H,0EEH,000H,0ECH,003H,0FCH
        DB      018H,000H,000H,0F4H
        DB      0DBH,00DH,000H,040H,0E3H,0EBH,017H,03DH,025H,00EH,000H,01DH,000H,0F4H,037H,005H
        DB      031H,000H,000H,01FH
        DB      018H,014H,000H,0B3H,0FFH,0BDH,044H,061H,0D3H,00AH,000H,014H,000H,021H,0EEH,01BH
        DB      027H,000H,000H,042H
        DB      0FFH,00BH,000H,004H,0F6H,0F1H,00FH,02FH,003H,0EEH,000H,0E9H,000H,003H,0AFH,052H
        DB      0E7H,000H,000H,011H
        DB      01DH,00CH,000H,055H,006H,0FDH,0D6H,02BH,006H,036H,000H,0C5H,000H,0E8H,0D0H,00CH
        DB      01FH,000H,000H,0DFH
        DB      0F9H,015H,000H,023H,01EH,006H,0DDH,022H,029H,022H,000H,0D5H,000H,014H,0B6H,0FDH
        DB      01EH,000H,000H,03AH
        DB      004H,012H,000H,026H,0FDH,026H,0E3H,0F5H,027H,010H,000H,0EDH,000H,013H,0DFH,0FBH
        DB      0E1H,000H,000H,022H
W2:
        DB      0FCH,0FFH,0FFH,025H,011H,000H,0D8H,01EH,0EDH,046H,0C1H,011H,0F6H,000H,0F7H,000H,0AAH,0DBH,0F1H,0FBH,000H,000H,0E9H
        DB      0F4H,0FDH,0FFH,0DCH,0FDH,000H,050H,0EBH,025H,0E7H,0FAH,03CH,0C4H,000H,0D3H,000H,020H,0B7H,0FAH,09CH,000H,000H,03EH
        DB      0A3H,000H,000H,004H,02AH,000H,0E3H,0D7H,0D6H,0FBH,011H,041H,049H,000H,0D8H,000H,0E8H,0C3H,0DEH,027H,000H,000H,008H
        DB      07CH,000H,000H,0EDH,0FDH,000H,006H,0A4H,0C8H,014H,032H,0F9H,00AH,000H,023H,000H,0E3H,025H,0FFH,0EDH,000H,000H,0DFH
        DB      064H,001H,000H,0DEH,0DDH,000H,013H,02DH,028H,0B8H,091H,02AH,005H,000H,0F8H,000H,0F2H,01CH,02BH,052H,000H,000H,0D7H
        DB      0E8H,0FFH,0FFH,0D9H,0A0H,000H,097H,015H,098H,015H,031H,0E8H,008H,000H,0D0H,000H,009H,029H,0F6H,006H,000H,000H,01CH
        DB      006H,001H,000H,041H,01AH,000H,017H,018H,0EAH,0AEH,010H,0ECH,0FDH,000H,0E8H,000H,0A3H,0E4H,01CH,0B7H,000H,000H,0F9H
        DB      006H,000H,000H,026H,0FFH,000H,0F9H,0F4H,020H,0F9H,0E9H,0CAH,00DH,000H,0FEH,000H,014H,052H,087H,0F0H,000H,000H,0E7H
        DB      067H,0FFH,0FFH,0F2H,027H,000H,0F6H,0FAH,002H,0F4H,0FBH,0D7H,0F3H,000H,031H,000H,010H,0CCH,012H,0ECH,000H,000H,0FEH
        DB      0C7H,0FFH,0FFH,0DBH,00FH,000H,0E9H,0F8H,0FCH,01DH,000H,0E6H,081H,000H,0F5H,000H,029H,008H,0F0H,030H,000H,000H,0A2H
        END
