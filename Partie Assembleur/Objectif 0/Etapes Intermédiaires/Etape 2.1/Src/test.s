	thumb
	AREA Test, code, READONLY
	
	export test
	extern TabCos
	extern TabSin


test proc
	push	{r4}	
; r0 valeur de l'angle et retour à la fin
	ldr	r3, =TabCos
; r1 : valeur du cos
	ldrsh 	r1, [r3, r0, lsl #1]
;carre de cos
	mul	r1, r1, r1 
;r2 : valeur du sin
	ldr	r4, =TabSin
	ldrsh	r2, [r4, r0, lsl #1]
;carre de sin
	mul	r2, r2, r2
;on ajoute les deux carrés
	add 	r0, r1, r2 ;fromat 2.30
	pop	{r4}	
	bx	lr


	endp
	end