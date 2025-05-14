CPU 8086
SECTION data
    A: DB 5h
    B: DB 3h
    C: DB 2h
    D: RESB 1

SECTION text
..start:
    MOV AX, data
    MOV DS, AX

    MOV AL, [A]
    ADD AL, [B]
    ADD AL, [C]
    MOV [D], AL

fine:
    MOV AX,4c00h
	INT	21h