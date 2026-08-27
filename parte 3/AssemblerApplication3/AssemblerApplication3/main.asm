.include "m328pdef.inc"

.def temp = r16

.cseg
.org 0x0000
    rjmp RESET

RESET:
    clr temp

PRINCIPAL:
    rjmp PRINCIPAL
