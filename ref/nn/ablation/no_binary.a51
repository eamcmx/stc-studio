; ABLATION VARIANT no_binary: every square multiplied by its weight (made by nn/ablation.py from ref/nn/digit_nn.a51)
; Digit reader: a small neural network on the STC89C52RC board.
;
; Draw a digit on the 5x7 grid in STC Studio's Digit pad (or type it in the Serial tab) and the board says which
; digit it is. The page sends the letter D and then 35 characters, 1 for a lit pixel and 0 for a dark one, row by
; row from the top left. The board answers with "=", the digit and its 10 scores in hex, and shows the digit on
; the display.
;
; The network: 35 inputs -> 24 hidden neurons (ReLU) -> 10 outputs, one for each digit.
;   hidden j = max(0, B1[j] + sum of W1[i][j] over the lit pixels i) >> SH1, at most 255
;   score  k = B2[k] + sum over j of hidden j * W2[k][j]
;   the digit is the k with the largest score
; The weights were trained in Python (nn/train_digits.py) and rounded to 8-bit whole numbers; the script writes
; the tables at the end of this file, with NH (the number of hidden neurons) and SH1. One reading takes about 20 ms.
;
; Board: segments and LEDs on P0 (lit by 0), digits 1-4 on P1.3-P1.6 (on at 0), 11.0592 MHz, 12T.
; Serial: 19200 baud, 8 data bits, no parity (Timer 1 auto-reload FDH with SMOD = 1).

PIX     EQU     30H             ; 35 bytes: the pixels, 0 or 1             (30H-52H)
ACC1    EQU     53H             ; NH x 16-bit sums of the hidden layer    (53H-82H for NH = 24)
HID     EQU     ACC1+2*NH       ; NH hidden values, 0 to 255               (83H-9AH; above 7FH only @R0/@R1 reach)
SCORE   EQU     HID+NH          ; 10 x 24-bit scores, low byte first       (9BH-B8H)
DBUF    EQU     2CH             ; 4 segment patterns, digit 1 to digit 4
DIGI    EQU     2BH             ; the digit the display is showing now (0-3)

        ORG     0000H
        LJMP    MAIN
        ORG     000BH
        LJMP    T0ISR

        ORG     0030H
MAIN:   MOV     SP,#0BFH        ; stack from C0H, in the upper 128 bytes of the 8052's RAM
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
        MOV     R2,#35
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
; for every pixel, add pixel x weight to the NH sums (the 0/1 inputs are not used)
        MOV     DPTR,#W1
        MOV     R1,#PIX
        MOV     R3,#35
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

; ---- WEIGHTS START (written by nn/train_digits.py, do not edit by hand)
NH      EQU     24              ; hidden neurons
SH1     EQU     1               ; hidden values are (sum >> SH1), 0 to 255

; B1: one 16-bit bias for each hidden neuron, low byte first
B1:
        DB      0BBH,0FFH,062H,000H,0D8H,0FFH,09DH,0FFH,0F0H,0FFH,0F7H,0FFH,025H,000H,02BH,000H
        DB      0F7H,0FFH,0CFH,0FFH,018H,000H,0E9H,0FFH,0BBH,0FFH,028H,000H,0FDH,0FFH,039H,000H
        DB      0F2H,0FFH,0D3H,0FFH,0BDH,0FFH,0E2H,0FFH,0DAH,0FFH,0CEH,0FFH,001H,000H,092H,0FFH
; W1: one row of NH weights (8-bit, signed) for each of the 35 pixels
W1:
        DB      0F0H,0F9H,0F6H,0DBH,0F9H,00AH,021H,00CH,061H,011H,00CH,0BCH,000H,0EFH,000H,00DH
        DB      0EBH,000H,01BH,047H,004H,0EEH,04BH,0D7H
        DB      0DEH,006H,0EDH,004H,0CEH,0E9H,04FH,0EEH,062H,03DH,00BH,0C7H,0F5H,0E8H,000H,007H
        DB      0DEH,0ECH,01EH,047H,0EAH,000H,026H,0F7H
        DB      0EFH,0DAH,00FH,0F6H,0E5H,01AH,0D1H,000H,049H,0E2H,0DBH,0B9H,0FFH,0DAH,000H,0B9H
        DB      0E4H,0FDH,0F6H,056H,0EAH,0FCH,025H,036H
        DB      055H,0F4H,0FCH,02BH,0F8H,00AH,0FDH,0CFH,066H,0FBH,0F6H,0BFH,0EEH,0E9H,000H,0FBH
        DB      0F1H,011H,0EFH,046H,0EAH,022H,007H,0EFH
        DB      0D3H,0F2H,0F4H,0E5H,002H,009H,002H,00AH,02CH,0FCH,0F0H,0C9H,0F8H,0E4H,000H,0ECH
        DB      0F3H,0EBH,0F6H,004H,007H,0E5H,01BH,0DAH
        DB      0F8H,027H,001H,040H,016H,013H,037H,001H,01FH,0FAH,01BH,076H,0F4H,002H,000H,00BH
        DB      0F3H,0F6H,0EEH,01DH,00FH,005H,03FH,0EFH
        DB      0E6H,005H,0FEH,02BH,02AH,000H,04CH,0F5H,0FEH,014H,0DDH,040H,0E9H,0F1H,000H,0F2H
        DB      0EAH,006H,01CH,01EH,0FCH,0EAH,024H,0F8H
        DB      0EFH,0FAH,0F6H,040H,054H,029H,09CH,00EH,008H,009H,0EFH,01DH,00CH,0FAH,000H,0E9H
        DB      0EAH,000H,000H,011H,0FDH,0D0H,020H,046H
        DB      069H,0FCH,00FH,033H,05EH,014H,002H,0FFH,033H,000H,00BH,0FDH,0F9H,008H,000H,0F4H
        DB      0EEH,013H,062H,00FH,0FFH,0D7H,021H,00AH
        DB      0DAH,0F7H,0EBH,027H,040H,023H,00EH,00EH,035H,007H,0F2H,003H,0FBH,017H,000H,0FEH
        DB      0F0H,006H,015H,0ECH,006H,061H,015H,0DAH
        DB      0E6H,0D3H,003H,0E3H,0EDH,001H,01FH,0E0H,0B7H,0EFH,04AH,0D7H,0AAH,007H,000H,00AH
        DB      0ECH,000H,047H,0EAH,004H,0F5H,01FH,0F2H
        DB      0FAH,0E6H,009H,01BH,0E5H,00FH,01CH,0FEH,0CAH,050H,0BAH,0FFH,0E6H,0C9H,000H,006H
        DB      0F0H,01EH,001H,01BH,01EH,007H,030H,0E8H
        DB      0E5H,0E8H,0EFH,025H,0E0H,012H,09EH,005H,0D7H,01BH,0F9H,008H,0EFH,0C6H,000H,0F6H
        DB      0EFH,003H,0E5H,00AH,029H,0DDH,011H,048H
        DB      047H,0EEH,01BH,005H,0BBH,0F7H,0E9H,00EH,0E2H,0FFH,000H,00BH,0E3H,0BDH,000H,0E3H
        DB      0F2H,009H,021H,006H,02BH,0CAH,003H,0E4H
        DB      0CBH,00FH,0A8H,021H,0A0H,005H,0FDH,015H,00AH,0F4H,007H,040H,0DDH,0D9H,000H,005H
        DB      0E6H,013H,0E4H,00FH,0FDH,03BH,017H,0EAH
        DB      00BH,0DFH,0F8H,03FH,0E9H,007H,01DH,0E8H,008H,047H,049H,005H,0D0H,01BH,000H,0E2H
        DB      003H,0C5H,0FFH,0F5H,0E1H,018H,0C5H,01CH
        DB      00CH,0F5H,00CH,03BH,0EEH,019H,016H,007H,017H,037H,0A9H,0F9H,0F7H,042H,000H,00AH
        DB      023H,016H,0EFH,007H,0B1H,0F1H,0EDH,0DDH
        DB      0EAH,0EFH,0E7H,007H,0FFH,027H,0B6H,0FAH,0FDH,0CDH,02BH,0E6H,0EBH,03EH,000H,019H
        DB      012H,031H,031H,02DH,0BAH,0F1H,0F9H,041H
        DB      039H,0FBH,049H,0FAH,0F0H,001H,005H,0EDH,0F8H,0F7H,0F5H,012H,0EFH,020H,000H,0D7H
        DB      0E0H,001H,021H,044H,0A3H,0F2H,01EH,0E8H
        DB      0D2H,0FAH,081H,037H,0F9H,0F4H,0FEH,018H,0D4H,00DH,00BH,016H,0EAH,0D7H,000H,0E4H
        DB      0C5H,002H,017H,02EH,0F0H,05FH,013H,0E8H
        DB      020H,00AH,004H,02AH,001H,029H,01DH,0F7H,024H,010H,04AH,01CH,029H,0F5H,000H,0EBH
        DB      0D3H,097H,00EH,0F3H,01FH,0F6H,0B9H,019H
        DB      00DH,0F0H,001H,042H,00AH,0F7H,010H,012H,002H,0E0H,0BFH,0F9H,048H,005H,000H,0F5H
        DB      0EFH,00DH,008H,0B5H,04FH,0F8H,092H,0E8H
        DB      0D8H,0EDH,0F6H,022H,012H,02AH,0EFH,0CAH,002H,0F5H,02AH,008H,01AH,010H,000H,03FH
        DB      0EDH,030H,01DH,0F2H,052H,013H,0DBH,038H
        DB      035H,0C8H,03AH,008H,014H,038H,011H,0B9H,017H,0FAH,0EEH,018H,016H,019H,000H,0F3H
        DB      0E5H,0E6H,000H,0FEH,03EH,014H,0F2H,0EDH
        DB      0F5H,0C8H,0ADH,013H,00CH,017H,00EH,010H,003H,0E9H,004H,0FAH,006H,013H,000H,0E5H
        DB      01CH,010H,03FH,02AH,0F4H,01AH,0F5H,0D2H
        DB      0FEH,079H,0FAH,0FAH,007H,0BEH,00BH,0ECH,000H,0D2H,045H,012H,076H,009H,000H,0EFH
        DB      011H,0A4H,019H,001H,0F5H,0FAH,0FDH,0F2H
        DB      0FFH,04BH,001H,01DH,007H,0E4H,01DH,038H,00CH,009H,0DCH,0F4H,039H,0FEH,000H,029H
        DB      00EH,037H,02BH,02FH,0F1H,0E9H,002H,0E2H
        DB      0C6H,03FH,0F7H,001H,01AH,001H,0FCH,0AFH,0FEH,0CEH,024H,009H,049H,027H,000H,049H
        DB      034H,029H,021H,0F1H,0F4H,0FBH,0FFH,02FH
        DB      02DH,012H,02FH,01DH,015H,003H,002H,0C4H,00DH,0CFH,0F7H,029H,02BH,02BH,000H,0D1H
        DB      033H,0CBH,0F0H,0E7H,003H,002H,0E4H,0FEH
        DB      0F9H,011H,0C8H,032H,014H,01AH,0FAH,02CH,010H,0D7H,003H,027H,03CH,04AH,000H,0C4H
        DB      06BH,0E7H,008H,0EAH,011H,029H,0D9H,0D7H
        DB      0EBH,035H,0FAH,000H,0EFH,0EEH,010H,0CEH,0E6H,002H,008H,007H,001H,0F1H,000H,005H
        DB      00DH,0DAH,00CH,0F6H,0FDH,0EFH,000H,0DAH
        DB      0F7H,038H,0FBH,003H,0FBH,0C8H,000H,054H,0C8H,0D6H,012H,0F4H,019H,024H,000H,013H
        DB      061H,030H,05BH,0F1H,016H,0F1H,0D9H,0F0H
        DB      0DBH,03BH,01AH,000H,0E9H,0A0H,001H,0B1H,0DBH,0FBH,0FFH,002H,037H,01DH,000H,0F2H
        DB      03FH,019H,013H,0F4H,00EH,00CH,0ECH,021H
        DB      026H,039H,0E1H,029H,0FAH,0A1H,0E6H,0D9H,0E2H,0EFH,00AH,022H,042H,018H,000H,0AEH
        DB      046H,0F0H,0F7H,0E0H,016H,00EH,0E1H,005H
        DB      0F2H,046H,000H,01AH,0F1H,0AEH,0FBH,032H,0EDH,0EAH,0F5H,0EEH,01CH,02DH,000H,0E5H
        DB      01EH,0F1H,0FDH,0E4H,0FEH,0E8H,0EAH,0DBH
; W2: one row for each digit 0-9: 24-bit bias (low byte first), then NH weights
W2:
        DB      014H,0FEH,0FFH,0DFH,0DAH,04AH,03CH,0CBH,019H,0FFH,0E9H,0EEH,0EDH,03AH,0E3H,045H,0B9H,000H,0F2H,024H,007H,01BH,0CFH,081H,014H,00FH,0E7H
        DB      050H,00BH,000H,06FH,02CH,0C6H,0B2H,035H,022H,04BH,041H,0D5H,009H,00AH,0D6H,0DBH,0FAH,000H,0D7H,009H,02DH,0ADH,0CDH,0F5H,03BH,004H,05CH
        DB      0C8H,002H,000H,0F0H,07BH,0B9H,0DFH,0EFH,030H,0C2H,0B5H,038H,047H,0C2H,0FAH,0D9H,002H,000H,0B3H,0B6H,017H,02AH,0C9H,00EH,0F5H,0C4H,0F7H
        DB      091H,008H,000H,0D1H,015H,006H,0D5H,016H,0E3H,0B8H,0DCH,02EH,023H,0A8H,037H,0DCH,0EFH,000H,02EH,014H,0B5H,03DH,01BH,01AH,011H,0C6H,0FEH
        DB      072H,0F3H,0FFH,05BH,0E9H,0B3H,0F3H,0C9H,018H,029H,046H,0ABH,00EH,000H,0E3H,038H,058H,000H,0F8H,0B8H,0EBH,0DCH,007H,01EH,013H,040H,03EH
        DB      06FH,006H,000H,0A7H,0E5H,021H,012H,04BH,0D8H,000H,0D9H,0F5H,0AAH,001H,0F1H,0CBH,0F1H,000H,029H,051H,0C8H,0EDH,034H,01FH,0ABH,004H,0AEH
        DB      031H,0F7H,0FFH,0E7H,0EAH,0EEH,018H,013H,02AH,032H,0DDH,0A9H,0EEH,038H,0BAH,038H,019H,000H,0DFH,00EH,006H,0D3H,040H,009H,0AAH,0D8H,0BCH
        DB      08BH,00FH,000H,0FAH,0EFH,018H,0B0H,03BH,09CH,0BBH,04FH,070H,018H,0F2H,06EH,0B8H,0D1H,000H,016H,0D5H,03EH,006H,0C1H,0FAH,018H,017H,025H
        DB      01DH,0EEH,0FFH,0ECH,000H,02CH,027H,0DAH,015H,0EDH,0E4H,0E7H,00BH,01BH,0E2H,01AH,002H,000H,0F0H,0FBH,001H,014H,00CH,0F4H,00CH,0F1H,0EFH
        DB      045H,001H,000H,0E3H,0C5H,030H,020H,0DDH,0CDH,0DDH,002H,0F8H,0CFH,0EAH,010H,0D4H,021H,000H,036H,00AH,0D0H,018H,006H,011H,00AH,03BH,0FEH
; ---- WEIGHTS END
        END
