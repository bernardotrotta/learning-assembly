CPU 8086
SECTION data
    A: DB 2
    B: DB 3

SECTION text
..start:
    MOV AX, data
    MOV DS, AX
    MOV AL, 0
    MOV CL, 0
    ; ADD AL, 01h   ; Replaced by INC
    
sum: 
    INC CL
    ADD AL, [A]
    CALL print
    CMP CL, [B]      ; Replace BL with B?
    JNE sum
    CALL fine
    
fine:
    MOV AX,4c00h
	INT	21h

print: 
    PUSH AX         ; "AL" should be pushed to the stack. This will prevent it from being altered by INT 21h.

    ADD AL, '0'     ; To print the ASCII char

    MOV AH, 02h

    MOV DL, AL
    INT 21h

    ; MOV DL, 2Ch     ; Comma
    ; INT 21h

    MOV DL, 20h     ; SP     
    INT 21h

    POP AX

    RET 