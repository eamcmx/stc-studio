 ORG 0
 USING 0
 PUSH AR7
 USING 3
 PUSH AR7
 MOV A,AR0+1
 DB 'a,b', "c;d"   ; comma and semicolon inside strings
 DB 1 , 2,3
 DW $, $+1
 ORG $+2
 DB 7
 ORG F2
F2 EQU 20H
 DB 8
 DS F3
F3 EQU 2
 DB 9
X: DS 0
 DB X
Y:
Z: DB 1
 MOV A,#Z
 MOV A,#Y
 CJNE A,#16,$+3
 NOP
lbl: lbl2: NOP
 DB 1,
 DB ,1
 DW
 DS
 ORG
 USING
 DBIT 1
 END
