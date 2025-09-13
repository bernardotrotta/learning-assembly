section data
Stringa: db 20, "Ma che caldo fa oggi"
Vett: resb 256
N: resb 1

section text
..start:
    mov ax, data
    mov ds, ax

    push Stringa
    push Vett
    push N

    LeggiCarattere:
        xor ax, ax
        mov ah, 01h
        int 21h
        cmp al, 01bh
        je Stampa
        xor ah, ah
        push ax
        call TrovaCarattere
        jmp LeggiCarattere

    Stampa:
        mov si, Vett
        mov ah, 0eh
        mov cl, [N]
        mov ch, 0
        StampaVettore:
            lodsb
            add al, '0'
            int 10h

            loop StampaVettore

            

        LunghezzaVettore:
        mov al, [N]
        lodsb
        add al, '0'
        mov ah, 0eh
        int 10h

    
    fine:
        mov ah, 04ch
        int 21h

TrovaCarattere:
    push bp
    mov bp, sp
    
    mov si, [bp + 10]       ; Stringa
    mov di, [bp + 8]        ; Vettore
    mov dh, [bp + 4]        ; Carattere

    LunghezzaStringa:
        lodsb
        mov cl, al
        mov ch, 0
        
        push cx             ; LunghezzaStringa

        CicloStringa:
            lodsb
            cmp al, dh
            je ValorePresente
            loop CicloStringa
            pop cx
            jmp FineTrovaCarattere

    ValorePresente:
        mov si, [bp + 6]
        mov al, [si]        ; Contiene il valore di N
        mov ah, 0
        CalcoloPosizione:
            pop bx
            sub bx, cx
        add di, ax
        mov [di], bx
        inc al
        mov [si], al        
        jmp FineTrovaCarattere

FineTrovaCarattere:
    pop bp
    ret 2
        
            