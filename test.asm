CPU 8086
SECTION data
    A: RESB 1
    B: RESB 1

SECTION text
..start:
    MOV AX, data
    MOV DS, AX

    MOV AH, 00h     
    INT 16h         

    MOV [A], AL

    MOV DL, AL      ; DL contains what should be printed  
    MOV AH, 02h     ; Set functions 02h for INT 21h
    INT 21h

    MOV DL, 0Dh
    ; MOV AH, 02h
    INT 21h

    MOV DL, 0Ah     ; Line feed
    ; MOV AH, 02h
    INT 21h      

    MOV AH, 00h     ; Read keyboard input
    INT 16h

    MOV [B], AL

    MOV DL, AL
    MOV AH, 02h
    INT 21h

    MOV DL, 0Dh     ; Carriage Return
    ; MOV AH, 02h   ; Not necessary since AH hasn't changed yet
    INT 21h

    MOV DL, 0Ah     ; Line feed
    ; MOV AH, 02h   
    INT 21h         

    MOV AL, [A]
    MOV BL, [B]
    ADD AL, BL

    SUB AL, '0'     ; From ASCII to int

    MOV DL, AL
    MOV AH, 02h
    INT 21h


fine:
    MOV AX,4c00h
	INT	21h