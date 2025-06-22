CPU 8086
SECTION data
    A: DB 2
    B: DB 4

SECTION text
..start:
    MOV AX, data
    MOV DS, AX
    MOV AL, [A]
    MOV BL, [B]
    MOV CL, AL
    MOV AL, BL
    MOV BL, CL

fine:
    MOV AX,4c00h
	INT	21h