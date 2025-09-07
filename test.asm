; Convertire tutti i caratteri di una stringa in maiuscolo
; Poi creare la versione per minuscolo immagino si sommi 40
cpu 8086
section data
str: db '!!CiaoMcFratm7$', 0

section text
..start:
    mov ax, data
    mov ds, ax
    mov si, str
controlla:
    mov bl, [si]
    ; controllo $
    cmp bl, 24h
    je stampa
    ; controllo lettera a
    cmp bl, 61h
    jl avanti
    ; controllo lettera z
    cmp bl, 7ah
    jg avanti
converti:
    sub bl, 20h
    mov [si], bl
avanti:
    inc si
    jne controlla
stampa:
    mov ah, 09h
    mov dx, str
    int 21h 
fine:
    mov ah, 04ch
    int 21h