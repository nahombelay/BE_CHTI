	thumb
	area moncode, code, readonly
		
	export callback
	extern etat
	extern Son
		
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM
E_POS	equ	0
E_TAI	equ	4
E_SON	equ	8
E_RES	equ	12
E_PER	equ	16
OFFSET	equ	32768 ; 2^16-1 = 2^15 car valeurs signées 
		
callback proc
	
	push	{lr, r4, r5}
	ldr		r0, =etat
	ldr		r1, [r0, #E_TAI] ;taille
	ldr		r2, [r0, #E_POS] ; position
	ldr		r12, =TIM3_CCR3

;Si on arrive à la fin du son
	cmp		r1, r2
	beq		fin_son
;si c'est > positif on continue
	
	ldr		r3, [r0, #E_SON]
	ldrsh	r4, [r3, r2, lsl #1];on a son[position]
	ldr		r5, [r0, #E_RES]; resolution 

;on applique la fonction affine pour améliorer le son

	add		r4, #OFFSET ;pour n'avoir que des valeurs > 0
	mul		r4, r5
	lsr		r4, #16; equivalent à r4/2^16 
	
;on envoie le son au PWM et on actualise la position
	str		r4, [r12]
	add		r2, #1
	str		r2, [r0, #E_POS]
	
;on retourne au prog principal
	pop {lr, r4, r5}
	bx 	lr
	
	
	
fin_son
	mov		r2, #0
	str		r1, [r0, #E_POS]
;on retourne au prog principal
	pop {lr, r4, r5}
	bx 	lr
	
	endp
	end
		
	