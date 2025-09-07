; MOVSB – Move String Byte
; Copia un byte da [DS:SI] a [ES:DI].

section data
    src: db 'Hello$', 0
    dest: resb 20
section text
..start:
    mov ax, data
    mov ds, ax

    mov es, ax  ; Sposto nell'extra segment l'indirizzo di dati
    mov si, src ; Sposto in SI l'indirizzo di inizio stringa
    mov cx, 6   ; Sposto in cx il numero di caratteri da spostare H e l l o $

    cld         ; Clear Direction Flag (SI e DI si decrementano)
    rep movsb   ; Copia cx byte (in questo caso 6) da src a dests

fine:
    mov ah, 04ch
    int 21h