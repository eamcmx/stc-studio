 ORG 0
 MOV A,#'AB'
 CJNE A,#'x',$
 MOV A,#';'
LONE: ; only a comment
L2: ORG 10H
 DB L2
HERE EQU $
 DB HERE
 DB 'A' + 1
 DB 'AB' + 1
 DB "AB" , 0
 DB 'A'+1,'B'
 MOV A,#HIGH $
 ORL A,#1 SHL 3
 MOV R0,#LOW(-1)
 MOV DPTR,#'AB'
 MOV DPTR,#L2+5
L3: END
