	thumb
	area moncode, code, readonly

GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register
	export timer_callback
	extern currentVal

timer_callback proc
;on charge l'adresse de currentVal dans un registre libre
; on ne peut utiliser que r0 et r2
	ldr 	r0, =currentVal
;on recupere la valeur de currentVal dans un registre libre
	ldr 	r2, [r0]
; on recupere l'@ de port PB1
	ldr	r3, =GPIOB_BSRR
;ensuite si on a currentVal != 0 on branch pour le mettre à 0
	cbnz	r2, setZero
; si currentValue = 0 alors on continue normalement

; mise a 1 de PB1
	mov	r1, #0x00000002
	str	r1, [r3]
;on rajoute 1...
	mov 	r1, #1
;... avant de le mettre à currentVal
	str	r1, [r0]
	bx 	lr
; mise a zero de PB1
setZero mov	r1, #0x00020000
	str	r1, [r3]
	mov 	r1, #0
	str	r1, [r0]
	bx 	lr

	endp
	end
; N.B. le registre BSRR est write-only, on ne peut pas le relire

;ne pas oublier le endp et le end a un moment