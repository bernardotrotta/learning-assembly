CPU 8086
SECTION data
stringa: db 'Buona Pasqua',0
mirror: resb 100 

SECTION text
..start:
	mov ax, data
	mov ds, ax
	mov es, ax
	mov si, stringa
	mov di, mirror
Ciclo:	lodsb		; scorro fino a trovare lo spazio
	cmp al,' '
	je Ciclo2
	cmp al, 0
	jne Ciclo
Ciclo2:	lodsb		; copio nella stringa destinazione
	cmp al, 0
	je ricomincia
	stosb
	jmp Ciclo2
ricomincia: mov al, ' '
	stosb		; metto lo spazio in mirror
	mov si, stringa 	; mi riposiziono all'inizio di stringa
Ciclo3:	lodsb
	cmp al, ' '
	je Fine
	stosb
	jmp Ciclo3
Fine:	mov al, 0
	stosb 		; metto il terminatore in mirror
	mov si, mirror	; mi riposiziono all'inizio di mirror per stamparla
	mov	ah,0eh
	mov	bx,0000h
Stampa:	lodsb
	cmp al, 0
	je fineStampa
	int	10h
	jmp Stampa
fineStampa:
	mov ax, 4c00h
	int 21h
