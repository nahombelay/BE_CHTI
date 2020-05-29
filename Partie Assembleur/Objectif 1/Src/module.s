	thumb
	AREA Module, code, READONLY
;La valeur de retour est obtenue par sommation des carrés effectuée sur 64 bits signés 
;puis ramenée à 32 bits en ne conservant que les 32 bits de fort poids
	export module
	extern dftint; qui prend tabsig, k et tabcos/tabsin
	extern TabCos
	extern TabSin

module proc
;r0 addresse du signal
;r1 valeur de k
;r2 va servir a recuperer l'addresse de TabCos ou de TabSin
;r3 et r4 pour stocker la multiplication signé sur 64 bits du cos
;r5 et r6 pour stocker la multiplication signé sur 64 bits su sin
;r12 pour stocker le retour de dftint
	push	{lr, r4, r5, r6}
	ldr	r2, =TabCos
	push	{r0}
	bl	dftint
	mov	r12, r0
	smull	r3, r4, r0, r0 ;dans r3 et r4 on a le carré du cos
	pop	{r0}

	ldr	r2, =TabSin
	push	{r0}
	bl	dftint
	mov	r12, r0
	smull	r5, r6, r0, r0 ;dans r5 et r6 on a le carré du sin
	pop	{r0}
	add	r0, r4, r6

	pop	{lr, r4, r5, r6}
	bx 	lr
	endp
	end