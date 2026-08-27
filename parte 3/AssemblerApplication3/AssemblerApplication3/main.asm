.include "m328pdef.inc"

.def temp = r16
.def secuencia = r17
.def patron = r18
.def retardo1 = r19
.def retardo2 = r20
.def retardo3 = r21

.cseg
.org 0x0000
    rjmp RESET

RESET:
    ldi temp, high(RAMEND)
    out SPH, temp
    ldi temp, low(RAMEND)
    out SPL, temp

    ldi temp, 0xFF
    out DDRD, temp
    clr temp
    out PORTD, temp

    clr temp
    out DDRB, temp
    ldi temp, (1<<PB0)|(1<<PB1)|(1<<PB2)
    out PORTB, temp

    clr secuencia
    clr patron

PRINCIPAL:
    rcall LEER_BOTONES
    rcall EJECUTAR_SECUENCIA
    rjmp PRINCIPAL

EJECUTAR_SECUENCIA:
    ret

LEER_BOTONES:
    sbis PINB, PB0
    rjmp BOTON_SIGUIENTE
    ret

BOTON_SIGUIENTE:
    rcall RETARDO_ANTIRREBOTE
    sbic PINB, PB0
    rjmp FIN_LEER_BOTONES
    inc secuencia
    cpi secuencia, 8
    brlo SIGUIENTE_LISTA
    clr secuencia

SIGUIENTE_LISTA:
    clr patron

ESPERAR_SIGUIENTE:
    sbis PINB, PB0
    rjmp ESPERAR_SIGUIENTE
    rcall RETARDO_ANTIRREBOTE

FIN_LEER_BOTONES:
    ret

RETARDO_ANTIRREBOTE:
    ldi retardo1, 2

ANTIRREBOTE_1:
    ldi retardo2, 255

ANTIRREBOTE_2:
    ldi retardo3, 255

ANTIRREBOTE_3:
    dec retardo3
    brne ANTIRREBOTE_3
    dec retardo2
    brne ANTIRREBOTE_2
    dec retardo1
    brne ANTIRREBOTE_1
    ret
