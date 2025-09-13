section data
    Filename: db 'fprova', 0
    Stringa: db 10, 'Buongiorno'
    N: resb 1
    handle: resw 1

section text
..start:
    mov ax, data
    mov ds, ax

    mov ah, 3ch
    mov cx, 00h
    mov dx, Filename
    int 21h
    
    jc fine
    mov [handle], ax

    mov ah, 40h
    mov dx, Stringa+1       ; Offset della stsringa
    mov bx, [handle]        ; Filehandle
    xor ch, ch              ; CX=0000
    mov cl, [Stringa]       ; CX=000A
    int 21h                     
    mov [N], ax

    mov ah, 3eh
    mov bx, [handle]
    int 21h

fine:
mov ax,4ch
int 21h