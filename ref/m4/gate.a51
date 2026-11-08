; STC Studio gate, 7 Nov 2026: shows StC1 and counts the last digit
        ORG 0
        MOV R3,#0
LOOP:   MOV R4,#200
SHOW:   MOV R2,#0
NEXT:   MOV A,R2
        MOV DPTR,#SEG
        MOVC A,@A+DPTR
        CJNE R2,#3,PUT
        MOV A,R3
        MOV DPTR,#NUM
        MOVC A,@A+DPTR
PUT:    MOV P0,A
        MOV A,R2
        MOV DPTR,#DIG
        MOVC A,@A+DPTR
        MOV P1,A
        MOV R7,#250
WAIT:   DJNZ R7,WAIT
        MOV P1,#0FFH
        INC R2
        CJNE R2,#4,NEXT
        DJNZ R4,SHOW
        INC R3
        CJNE R3,#10,LOOP
        MOV R3,#0
        SJMP LOOP
SEG:    DB 92H,87H,0C6H
DIG:    DB 0F7H,0EFH,0DFH,0BFH
NUM:    DB 0C0H,0F9H,0A4H,0B0H,99H,92H,82H,0F8H,80H,90H
        END
