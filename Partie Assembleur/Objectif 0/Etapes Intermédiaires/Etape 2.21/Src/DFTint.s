	thumb
	AREA DFTint, code, READONLY
	
	export dftint
		
dftint	proc
;TabSig dans r0 ;valeur de k dans r1 ;adresse de TabCos dans r2 
	push	{r4, r5, r6}	
;initialisation
	mov	r3, #0	;i ; initialisation (c'est le premier tour de la boucle)
	mov	r12, #0
	mul	r12, r1, r3	;r12 contient i * k normalement 0 à la premiere itération
	mov	r4, #0	;initialisation resultat 

;debut for
	; on fait le modulo de r12 (i*k)
debfor	mul	r12, r1, r3 ;r12 = r1*r3 soit i*k
	and 	r12, #63
	; on met dans r5 la valeur du cos(i*k)
	ldrsh	r5, [r2, r12, lsl #1]
	; on met dans r6 la valeur du signal(k)
	ldrsh	r6, [r0, r3, lsl #1]
	; on ajoute le produit dans r4
	mla	r4, r5, r6, r4 ;r4 = r4 + r5*r6
	add 	r3, #1
	cmp	r3, #64
	blt	debfor
;fin for
	mov	r0, r4
	pop	{r4, r5, r6}
	bx	lr	
	endp
	end
