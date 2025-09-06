CPU 8086

SECTION data
; Definisco le stringhe
Stringa1:	db "Questa e' la prima stringa e",0
Stringa2:	db " deve essere concatenata a questa",0
Stringa3:	times 255 db 0
..start:
	mov ax, data
	mov ds, ax
	; Salto all'inizio del programma
	call	_main
	; Fine programma
	mov	ax,4c00h
	int	21h
; Funzione principale
_main:
	push	bp
	mov	bp,sp
	mov	ax,Stringa2
	push	ax
	mov	ax,Stringa1
	push	ax
	mov	ax,Stringa3
	push	ax
	call	ConcatenaStringhe
	add	sp,6
	mov	ax,Stringa3
	push	ax
	call	ScriviStringa
	add	sp,2
Fine:
	
	pop	bp
	ret

	; Concatena szSorg1 e szSorg2 e le copia in szDest.
; void ConcatenaStringhe (char *szDest, char *szSorg1, char *szSorg2);
ConcatenaStringhe:
	push	bp
	mov	bp,sp
	; Copio il contenuto di szSorg1 in szDest
	mov	di,[bp+4]	; Leggo l'indirizzo della stringa di destinazione
	mov	si,[bp+6]	; Leggo l'indirizzo della prima stringa sorgente
	mov	bx,[bp+8]	; Leggo l'indirizzo della seconda stringa sorgente
.AltroCarattere:
	mov	al,[si]
	cmp	al,0
	je	.AltraStringa
	mov	[di],al
	inc	si
	inc	di
	jmp	.AltroCarattere
	; Copio il contenuto di szSorg2 in szDest
.AltraStringa:
	mov	al,[bx]
	mov	[di],al
	inc	bx
	inc	di
	cmp	al,0
	jne	.AltraStringa
	pop	bp
	ret
; ConcatenaStringhe

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
