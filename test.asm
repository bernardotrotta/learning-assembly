CPU 8086
SECTION data
    str: db "Ciao mondo!$", 0

SECTION text
..start:
    mov ax, data
    mov ds, ax
    mov si, 0
loop_string:
    mov ah, [str+si]
    cmp ah, 24h
    je fine
    inc si                  ; Expected value: 11 -> 0Bh
    jmp loop_string
fine:
    mov ah, 4ch
    int 21h
