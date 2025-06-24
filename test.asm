CPU 8086
SECTION data
    str: db "Hello$", 0

SECTION text
..start:
    mov ax, data
    mov ds, ax
    mov si, str
    xor di, str
    xor cl, cl

loop_string:
    mov al, [si]
    cmp al, 24h
    je got_length
    inc si
    inc cl              ; String's length
    jmp loop_string

got_length:
    dec si

move_pointer:
    mov al, [si]     ; Tip: keep track of the string's memory address to calculate the endpoint
    mov bl, [di]
    mov [di], al
    mov [si], bl          ; String's memory address         
    cmp di, si
    je print_string
    dec si
    inc di
    jmp move_pointer

print_string: 
    mov ah, 09h
    mov dx, str
    int 21h
fine:
    mov ah, 4ch
    int 21h
