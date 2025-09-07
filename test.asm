; LODSB – Load String Byte
; Carica il byte in [DS:SI] dentro AL e aggiorna SI.

section data
    str: db 'Bernardo$', 0
section text
..start:
    mov ax, data
    mov ds, ax
    mov si, str
    cld ; serve ad impostare la direzione dell'incremento degli indici DI e SI
next_char:
    lodsb
    cmp al, 24h
    je fine
    jmp next_char
fine:
    mov ah, 04ch
    int 21h