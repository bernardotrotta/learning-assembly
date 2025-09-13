section data
Vett: db 1, 22, 12, 7, 11
N: db 5
Err: db 0Dh, 0Ah, 'Non valido', 0Dh, 0Ah, '$'
section text
..start:
    mov ax, data
    mov ds, ax
    xor ax, ax

    push Vett
    mov ax, [N]
    push ax
    push Err

LeggiCarattere:
    mov ah, 01h
    int 21h
    cmp al, 1bh
    je fine
    xor ah, ah
    push ax 
    call ControllaCarattere
    jmp LeggiCarattere

ControllaCarattere:
    push bp
    mov bp, sp
    mov al, [bp + 4]
    mov si, [bp + 10]
    mov cx, [bp + 8]
    xor ch, ch 
    
    cmp al, 60h
    jg ControllaMinuscola
    cmp al, 40h
    jg ControllaMaiuscola
    jmp CarattereErrato

ControllaMinuscola:
    cmp al, 7ah
    jg CarattereErrato
    sub al, 60h
    jmp ControllaVettore
    jmp FineLoop

ControllaMaiuscola:
    cmp al, 5ah
    jg CarattereErrato
    sub al, 40h
    jmp ControllaVettore
    jmp FineLoop

CarattereErrato:
    mov dx, [bp + 6]
    mov ah, 09h
    int 21h

ControllaVettore:
    cmp al, [si]
    je Incrementa
    inc si
    loop ControllaVettore
    jmp Decrementa
    jmp FineLoop

Incrementa:
    inc bx
    jmp FineLoop
Decrementa:
    dec bx

FineLoop:
    pop bp
    ret 2

fine:
    mov ah, 04ch
    int 21h
