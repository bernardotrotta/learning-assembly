section data   
    Frase: db 'Ciao', 0
    N: dw 4
    Vett: db 2, 19, -1, 0

section text
..start:
    mov ax, data
    mov ds, ax
    push Frase
    mov ax, [N]             ; Stack lavora solo a 16 bit
    push ax
    push Vett
    call OscuraCaratteri
Fine:
    MOV DX, Frase   ; DX punta all’inizio della stringa
    MOV AH, 09h            ; funzione 09h di DOS
    INT 21h                ; chiama DOS
    mov ah, 04ch
    int 21h
OscuraCaratteri:
    push bp
    mov bp, sp
    mov si, [bp + 8]        ; Indirizzo di frase    
    xor bl, bl              ; Preparo il contatore per la lunghezza
    xor dx, dx              ; Preparo il contatore per gli indici errati
    cld
LunghezzaStringa:
    lodsb
    cmp al, 0
    je FineLunghezzaStringa
    inc bl                  ; Lunghezza della stringa
    jmp LunghezzaStringa
FineLunghezzaStringa:
    mov cx, [bp + 6]
    mov si, [bp + 4]
Verifica:
    DEC cx
    JZ FineStringa
    lodsb
    cmp al, bl              ; Verifico se l'indice è maggiore della stringa
    jg IndiceErrato
    cmp al, 0               ; Veridico se minore della stringa
    jl IndiceErrato
    jmp Sotituisci

IndiceErrato:
    inc dx
    jmp Verifica
Sotituisci:
    push si
    mov si, [bp + 8]
    add si, ax
    mov BYTE[si], 2ah           ; *
    pop si
    jmp Verifica
FineStringa:
    RET