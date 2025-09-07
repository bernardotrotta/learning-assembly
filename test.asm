; STOSB – Store String Byte
; Scrive in memoria il contenuto di AL all’indirizzo [ES:DI] e poi incrementa/decrementa DI.

section data
buffer: resb 20
section text
..start:
    mov ax, data
    mov ds, ax
    mov di, buffer
    mov al, 'A'
    mov cx, 10
    cld
    rep stosb   ; Riempie buffer con 10 caratteri A

fine:
    mov ah, 04ch
    int 21h