CPU 8086
SECTION data
N: DB 255

SECTION text
..start:
    MOV AX, data
    MOV DS, AX
    MOV AL, [N]
    MOV CX, 03h
convert:
    MOV BL, 0Ah
    XOR AH, AH
    DIV BL
    PUSH AX
    LOOP convert
    MOV CX, 03h
print_bytes:
    POP AX
    ADD AH, '0'
    MOV DL, AH
    MOV AH, 02h
    INT 21h
    LOOP print_bytes
fine:
    MOV AX, 4C00h
    INT 21h