CPU 8086
SECTION data
    A: DB 0
    B: DB 9

SECTION text
..start:
    MOV AX, data
    MOV DS, AX

    MOV AL, [A]
    MOV BL, [B]
    ; ADD AL, 01h     ; Replaced by INC
    
increment: 
    INC AL
    CALL print
    CMP AL, BL
    JNE increment
    CALL fine
    
fine:
    MOV AX,4c00h
	INT	21h

print: 
    ADD AL, '0'     ; To print the ASCII char
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    SUB AL, '0'
    RET