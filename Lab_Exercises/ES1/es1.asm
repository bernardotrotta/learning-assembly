CPU 8086

SECTION text
..start:
Leggi:	mov	ah,00h		; Questa è la funzione di lettura
		int	16h		; di un carattere

		cmp	al,1Bh		; Il codice ASCII è 1B (ESC)? 
		je	Fine		; Se sì, vai alla fine
				
		mov	ah,0eh		; Funzione di scrittura a video
		mov	bx,00h		; Pagina 0 (BH)
		int	10h		

		jmp	Leggi		; Leggi un altro carattere

Fine:	MOV AX, 4C00h         ; servizio esci (return code=0) 
        INT 21h
