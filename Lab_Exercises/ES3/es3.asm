CPU 8086

SECTION data
CaratteriEsa     DB	'0123456789ABCDEF'
Numero resb 1

SECTION text

..start:
Leggi:	mov ax, data
		mov ds,ax	; faccio puntare DS alle variabili
		mov	ah,00h		; Questa è la funzione di lettura
		int	16h		; di un carattere

		cmp	al,1bh		; Il codice ASCII è 1B (ESC)? 
		je	Fine		; Se sì, vai alla fine

		mov	[Numero],al
		call	ScriviNumero

		mov	al,' '
		mov	ah,0eh		; Funzione di scrittura a video
		mov	bx,00h		; Pagina 0 (BH)
		int	10h		

		jmp	Leggi		; Leggi un altro carattere
Fine:	mov ax, 4C00h         ; servizio esci (return code=0) 
        int 21h

		
ScriviNumero:
		xor	bh,bh
		mov	dl,2
		mov	dh,[Numero]
Ripeti:
		mov	cl,4
		ror	dh,cl
		mov	bl,dh
		and	bl,0fh
		mov 	al,[CaratteriEsa+bx]
		mov	ah,0eh
		mov	bx,00h
		int	10h
		dec	dl
		jnz	Ripeti

		ret