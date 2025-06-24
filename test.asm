CPU 8086
SECTION data
    str: db "Ciao mondo!$", 0

SECTION text
..start:
    mov ax, data
    mov ds, ax
    
    mov ah, 09h
    mov dx, str
    int 21h

fine:
    mov ah, 4ch
    int 21h
