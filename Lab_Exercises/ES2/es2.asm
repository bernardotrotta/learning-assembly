CPU 8086

SECTION data
CaratteriEsa     DB	'0123456789ABCDEF'
Numero	     RESB 1

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
		mov	ah,0
		mov	al,[Numero]
		mov	bl,16
		div	bl
		mov	ah,0
		mov	si,ax
		mov	al,[CaratteriEsa+si]

		mov	ah,0eh
		mov	bx,00h
		int	10h

		mov	ah,0
		mov	al,[Numero]
		mov	bl,16
		div	bl
		xchg	ah,al
		mov	ah,0
		mov	si,ax
		mov	al,[CaratteriEsa+si]
		mov	ah,0eh
		mov	bx,00h
		int	10h
		ret


