CPU 8086

SECTION data
Frase: db 'Buongiorno', 0
Messaggio: db 34, ': vocale (v/V) o conosnante (c/c)?'

SECTION text
..start:
    mov ax, data
    mov ds, ax

ScorriStringa:

VerificaRisposta:

Fine:
    mov ax 4c00h
    int 21h