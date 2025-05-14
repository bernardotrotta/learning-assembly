CPU 8086

SECTION data
TITOLO           DB    'Hello World! $'

SECTION stack stack class=stack 
         RESB 512   ; memoria per lo Stack: in
STACKTOP:

SECTION main

;---------------------------------------------------------------------;
;                   Corpo principale del programma                    ;
;---------------------------------------------------------------------;

..start:
                  MOV     AX,data 
                  MOV     DS,AX 
                  MOV     AX,stack 
                  MOV     SS,AX 
                  MOV     SP,STACKTOP
				  
                  MOV   DX,TITOLO       ;Sceglie la stringa (DS:DX)

                  MOV   AH,09h          ;Servizio DOS 'Print String'; la
                  INT   21h             ; stringa e' puntata da DS:DX.

                  MOV AX, 4C00h         ; servizio esci (return code=0) 
                  INT 21h


