; CMPSB – Compare String Byte
; Confronta [DS:SI] e [ES:DI], aggiorna entrambi i puntatori.

section data
    str1 db 'abc$', 0
    str2 db 'abc$', 0

section text
..start:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov si, str1
    mov di, str2
    mov cx, 3

    cld
    repe cmpsb   ; confronta i due array
    ; se CX=0 → stringhe uguali