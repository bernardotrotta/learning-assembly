CPU 8086
SECTION data
    a: dw 0005h
    b: dw 0003h
    c: dw 0001h

SECTION text
..start:
    mov ax, data
    mov ds, ax

    mov ax, [a]
    push ax
    mov ax, [b]
    push ax
    mov ax, [c]
    push ax

    call Sum
    add sp, 6           ; Must be 6, 2*n (3 in this case)
    mov ax, 4c00h
    int 21h

Sum: 
    push bp
    mov bp, sp
    sub sp, 2

    mov ax, [bp+4]
    add ax, [bp+6]
    mov [bp-2], ax
    mov ax, [bp+8]
    mov bx, [bp-2]
    add ax, bx

    add sp, 2
.fine:
    pop bp
    ret
