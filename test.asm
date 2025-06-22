CPU 8086
SECTION data
    A: DB 2
    B: DB 3

SECTION text
..start:
    MOV AX, data
    MOV DS, AX

    MOV AL, [A]
    MOV BL, [B]
    MOV CL, 0
    ; ADD AL, 01h     ; Replaced by INC
    
sum: 
    INC CL
    ADD AL, [A]
    CALL print
    CMP CL, BL
    JNE sum
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