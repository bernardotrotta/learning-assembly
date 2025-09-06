; 4. Contatore semplice
; Creare un loop che conta da 1 a 10 e visualizza ogni numero.

CPU 8086
section data
    string db 1
section text
    mov ax, data
    mov ds, ax

    mov cl, 0

    loop_start:
    mov ah, 02h
    mov dl, cl
    add dl, '0'
    int 21h
    inc cx
    cmp cx, 0Ah ; 10
    jne loop_start


    mov ah, 4ch
    int 21h

