CPU 8086
SECTION data
    A: DB 6, 4, 7, 8, 3, 9, 0, 5, 1, 2 ; 45
    I: DW 10
SECTION text
..start:
    MOV AX, data
    MOV DS, AX

    MOV SI, 0
    MOV AL, [A]
    CALL sum_byte_array
    CALL fine

fine:
    MOV AX,4c00h
	INT	21h

sum_byte_array:
    CALL print_number
    CALL print_space
    INC SI
    ADD AL, [A+SI]
    CMP SI, [I]
    JNE sum_byte_array
    RET

print_byte_array:
    CALL print_number
    CALL print_space
    INC SI
    MOV AL, [A+SI]
    CMP SI, [I]
    JNE print_byte_array
    RET

print_number:
    PUSH AX
    ADD AL, '0'
    MOV DL, AL
    MOV AH, 02h 
    INT 21h
    POP AX
    RET 

print_space:
    MOV DL, 20h
    MOV AH, 02h 
    INT 21h
    RET 