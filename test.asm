section data   
    Frase: db 'Buonasera', 0
    N: dw 4
    Vett: db 2, 19, -1, 0
section text
..start:
    mov ax, data
    mov ds, ax
    push Frase
    mov ax, [N]
    push ax
    push Vett
    call OscuraCaratteri
    mov si, 0
    jmp StampaStringa
StampaStringa:
    mov dl, [si]
    cmp dl, 0
    je fine
    mov ah, 02h
    int 21h
    inc si
    jmp StampaStringa


OscuraCaratteri:
    push bp
    mov bp, sp

    mov di, [bp + 4]   ; indirizzo vettore indici
    mov cx, [bp + 6]   ; numero indici
    mov si, [bp + 8]   ; indirizzo stringa
    xor bl, bl
LunghezzaStringa:
    mov dl, [si]
    cmp dl, 0
    je VerificaIndici
    inc si
    inc bl              ; Lunghezza Stringa
    jmp LunghezzaStringa    
VerificaIndici:
    mov dl, [di]
    cmp dl, 0           ; È un indice più piccolo dello 0?
    jl IndiceErrato
    cmp dl, bl          ; È un indice più grande della lunghezza della riga?
    jg IndiceErrato
    mov si, [bp + 8]
    xor dh, dh
    add si, dx
    mov BYTE[si], 2ah 
    jmp ProssimoCarattere
ProssimoCarattere:
    inc di
    dec cl
    jnz VerificaIndici
    mov sp, bp
    pop bp
    RET 6
IndiceErrato:
    inc al
    jmp ProssimoCarattere 
    

fine:
    mov ah, 04ch
    int 21h