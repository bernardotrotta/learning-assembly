section data
n: dw 2
section text
..start:
    mov ax, data
    mov ds, ax

    xor ax, ax
    xor dx, dx
    mov ax, [n]     ; Ci sarà il quoziente
    neg ax

    mov bx, 10
    div bx
                    ; Dx avrà il resto

    push dx
    push ax

    xor ax, ax
    xor dx, dx

    pop ax
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h

    jmp fine
fine:
    mov ah, 04Ch
    int 21h 