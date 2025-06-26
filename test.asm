CPU 8086
SECTION data
    char: db 'A'


SECTION text
..start:
    mov ax, data
    mov ds, ax
    mov ax, char
    push ax
    call StampaChar
    add sp, 2
    mov ax, 4c00h
    int 21h

StampaChar: 
    push bp
    mov bp, sp
    mov ah, 02h
    mov bx, [bp+4]
    mov dx, [bx]
    int 21h
.fine:
    pop bp
    ret
