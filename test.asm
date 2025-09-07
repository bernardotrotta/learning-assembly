; SCASB – Scan String Byte
; Confronta AL con [ES:DI], aggiorna DI. Utile per cercare un carattere

section data
    buffer: db 'ciao mondo$', 0
section text
..start:
    mov ax, data
    mov es, ax
    mov di, buffer
    mov al, 'o'
    mov cx, 20

    cld
    repne scasb
fine:
    mov ah, 04ch
    int 21h