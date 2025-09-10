; 18 giugno 2025
section data
Vett1: dw -1, 3, -2, 0, -10, 8, 17, -3
Vett2: dw 5, -6, 0, 3, 6, -8, 11, 6
Vett3: resw 8
N: db 8
; Vett3: 5, -8, -10, -6, -7, 8, 11, -8
section text
..start:
    mov ax, data
    mov ds, ax

    push Vett1     
    push Vett2
    push Vett3
    xor ax, ax
    mov al, [N]
    push ax

    call FondiVettori

fine:
    mov ah, 4ch
    int 21h

FondiVettori:
    push bp
    mov bp, sp
    xor si, si
    xor di, di

    mov si, [bp + 10]   ; Vett1
    mov di, [bp + 8]    ; Vett2
    ; mov di, [bp + 6]  ; Vett3
    mov cx, [bp + 4]    ; N
    add di, cx          ; di punta all'ultimo elemento di Vett2
    add di, cx
    sub di, 2

    CicloSomma:
        cmp cx, 0
        je StampaVettore

        xor ax, ax          ; Preparo AX per il primo elemento della somma
        xor bx, bx          ; Preparo BX per il secondo elemento della somma

        mov ax, [si]        ; AX = SI-esimo elemento di Vett1
        mov bx, [di]        ; BX = DI-esimo elemento di Vett1

        test cx, 1
        jz SommaElementi
        jnz SottraiElementi

        SommaElementi:
            add ax, bx          ; AX = AX+BX
            jmp MemorizzaElemento

        SottraiElementi:
            sub ax, bx          ; AX = AX-BX
            jmp MemorizzaElemento

        MemorizzaElemento:
            push si             ; Memorizzo il puntatore del Vett1 per usarlo con Vett2
            add si, [bp + 6]    ; Ora si punta al primo elemento di Vett3
            mov [si], ax        ; Metto la somma nel SI esimo elemento di Vett3
            pop si              ; Estraggo il vecchio SI 
    
            add si, 2
            sub di, 2
            dec cx
            jmp CicloSomma
    
StampaVettore:
    mov si, [bp + 6]
    mov cx, [bp + 4]
    CicloStampa:
        cmp cx, 0               ; Confronto il contatore CX finché non arriva a zero
        je FineCiclo            ; Il contatore è 0, smetto di eseguire
        
        xor ax, ax              ; Pulisco AX
        xor dx, dx              ; Pulisco DX
        xor bx, bx              ; Pulisco BX

        mov ax, [si]            ; Prelevo il primo numero dalla memoria
        or ax, ax               ; Controllo se il numero è negativo
        js StampaSegno
        jns StampaNumero

        StampaSegno:
            push ax             ; Carico AX nello stack perché devo sovrascrivere AH per inserire la funzione di stampa
            mov dl, 2dh     
            mov ah, 02h
            int 21h
            pop ax              ; Riprendo AX
            neg ax              ; Nego AX per lavorare sulle cifre senza segno 
            jmp StampaNumero
        StampaNumero:
            xor dx, dx
            mov bx, 00Ah        ; Preparo BX per fare la divisione per 0
            div bx              ; Divido per 10, il quoziente finisce in AX, il resto finisce in DX
            
                                ; Ora in AX c'è il quoziente
                                ; Ora in DX c'è il resto
            xor bx, bx
            mov bx, dx
            

            mov ah, 00h
            add al , '0'
            mov dl, al
            mov ah, 02h
            int 21h

            mov bh, 00h
            add bl, '0'
            mov dl, bl
            mov ah, 02h
            int 21h

            mov dl, ' '
            mov ah, 02h
            int 21h

            add si, 2
            dec cx
            jmp CicloStampa
FineCiclo:
    pop bp
    RET




    
   


        