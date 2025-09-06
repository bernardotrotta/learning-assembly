CPU 8086
SECTION data
Numero DB 134
Stringa resb 6

..start:
	mov ax, data
	mov ds, ax
	mov ax, Stringa
	push ax
	mov ax, [Numero]
	push ax
	; Salto all'inizio del programma
	call	ConvertiDecimale
	add sp, 4
	mov ax, Stringa
	push ax
	call ScriviStringa
	; Fine programma
	mov	ax,4c00h
	int	21h
; Converte un numero a 16 bit in decimale senza gli zeri iniziali.
; In input riceve un intero a 16 bit passato sullo stack
; e il puntatore alla stringa che deve ricevere il carattere.
; ConvertiDecimale (int16 iNumero, char *szStringa);
ConvertiDecimale:
	push	bp
	mov	bp,sp
	; Alloco una stringa da 5 caratteri sullo stack
	sub	sp,5

	; Uso si come indice nella stringa.
	xor	si,si
	mov	ax,[bp+4]		; Carico in un registro il numero
	mov	bx,10			; Preparo il divisore
	; Inizio dividendo per 10 per calcolare la cifra meno significativa
CD_AltroNumero:
	dec	si
	xor	dx,dx
	div	bx
	add	dl,30h			; converto in codice ASCII -> '0'
	mov	[bp+si],dl		; salvo il carattere
	cmp	ax,0
	jne	CD_AltroNumero

	; Copio i caratteri nella stringa destinazione

	mov	di,[bp+6]	; di è l'indice per la stringa destinazione
CD_AltroCarattere:
	mov	dl,[bp+si]
	mov	[di],dl
	inc	di
	inc	si
	jnz	CD_AltroCarattere

	mov	byte [di],00h	     ; Terminatore per la stringa destinazione

	mov	sp,bp			; Libero la memoria dallo stack
	pop	bp
	ret

	; Scrive una stringa ASCIIZ (classica NULL terminated stile C)
; In input riceve l'indirizzo della stringa come parametro sullo stack.
ScriviStringa:
        push    bp
        mov     bp,sp
        mov     ah,02h          ; Function 02h (2) - Character Output
        mov     bx,[bp+4]       ; Leggo l'indirizzo della stringa
.AltroCarattere:
        mov     dl,[bx]
        cmp     dl,0
        je      .Fine
        int     21h
        inc     bx
        jmp     .AltroCarattere
.Fine:
        pop     bp
        ret
; ScriviStringa
