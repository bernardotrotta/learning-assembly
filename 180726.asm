section data
DaIndovinare: db 7,3,8,0
Inserita: resb 4    ; 2,4,5,1
; Inserita: db 7,3,8,0
S1: db 34, "numeri giusti in posizione giusta"
S2: db 37, "numeri giusti in posizione sbagliata"
section text
..start:
    mov ax, data
    mov ds, ax

    mov si, DaIndovinare
    mov di, Inserita
    

    push DaIndovinare
    push Inserita

    

LeggiNumeri:
    mov cx, 4
    mov di, Inserita
    xor ax, ax
    mov ah, 01h
    ProssimoCarattere:
        int 21h             ; Prelevo numero
        sub al, '0'         ; Sottraggo lo zero ascii
        mov [di], al
        inc di
        loop ProssimoCarattere

    mov ah, 0eh
    mov al, 0Dh
    int 10h
    mov al, 0ah
    int 10h

VerificaDupliucato:
    
    mov si, Inserita
    mov dx, 4
    Outer: 
        mov al, [si]
        mov di, Inserita
        mov cx, 4
    Inner: 
    mov ah, [di]
    cmp ah, al
    je fine
    inc di
    loop Inner
    inc si
    cmp dx, 0
    je ConfrontaSequenze
    jmp Outer
    
    




call ConfrontaSequenze


xor ax, ax
xor dx, dx

mov si, S1
mov ch, bh
call Stampa

mov si, S2
mov ch, bl 
call Stampa

cmp bh, 4
jne LeggiNumeri

jmp fine

Stampa:
    add ch, '0'
    mov al, ch
    mov ah, 0Eh
    int 10h

    mov al, 20h
    mov ah, 0Eh
    int 10h

    lodsb              ; AL = lunghezza
    sub al, 1
    mov cl, al
    mov ch, 0          ; CX = lunghezza
    mov ah, 0Eh

Next:
    lodsb              ; AL = carattere
    int 10h            ; stampa AL
    loop Next
    mov al, 0Dh
    int 10h
    mov al, 0ah
    int 10h
    ret

fine:
    mov ah, 04ch
    int 21h
    
ConfrontaSequenze:
    push bp
    mov bp, sp

        ; DaIndovinare
    mov di, [bp + 4]    ; Inserita

    xor bx, bx
    mov dx, 4
    CicloEsterno:
        mov cx, 4
        mov ah, [di]
        mov si, [bp + 6]
    CicloInterno:
        mov al, [si]
        cmp ah, al
        jne NextChar
        cmp dx, cx
        jne PosizioneSbagliata
        jmp PosizioneGiusta
    
PosizioneSbagliata:
    inc bl
    jmp NextChar
PosizioneGiusta:
    inc bh
    jmp NextChar

NextChar: 
    inc si
    loop CicloInterno
    dec dx
    inc di 
    cmp dx, 0
    jne CicloEsterno
    pop bp
    ret
    