# BE CHTI
---
######  Florian Leon et Nahom Belay

---
## Etape 1 : Signal carré de précision

>Tout fonctionne, on observe bien un signal carré avec le logic analyser.
>**NB :** On n'observe pas le signal avec le *portb.10* mais le *portb.1*
---  
## Etape 2 : DFT en virgule fixe

  ### Partie 1 : Préliminaires, tables trigo
>On vérifie cos^2(a) + sin^2(a) = 1 (code dans **test.s**)
>Pour vérifier ces résultats, on a stocké dans TabRes les valeurs de cos(k)^2 + sin(k)^2 pour k allant de 0 à 63 qu'on visualise avec Watch 1. cos(k) et sin(k) sont codés au format 1.15 donc leurs carré ainsi que la somme des carrés est codé au format 2.30.
     
  ### Partie 2 : Calcul DFT
   #### Question 1 (étape 2.21)
>Cette étape permet de vérifier que le calcul de notre partie réelle et imaginaire fonctionne bien.
>On a donc repris le code dans dftinit (on a donné un nom "générique" pour eviter toute confusion lorsqu'on appelle cette fonction pour calculer la partie imaginaire (avec TabSin plutôt que TabCos).
>Les résultats sont stockés dans deux tableaux TabReel et TabIm qu'on peut visualiser avec le Watch.

   #### Question 2 et 3 (étape 2.22)
>La fonction module fonctionne et renvoie bien le résultat voulu (deux pics d'amplitutde proche de 8; 7,999...; et pour k= 1 et 63).
>**NB :** Les tests ont effectués pour un signal ayant une fréquence de 1, un phase de 0 et  N = 64 uniquement
---

>Test marche bien avec le jeu de données fournis. Dans la fonction principale, il suffit de remplacer la variable TabSig par la varaible correspondant à au signal que l'on veut étudier. On place trois points d'arrêt dans la fonction module:
>- une à la ligne 21, ce qui permet de récupérer la partie réele dans le registre r12
>- une à la ligne 28, ce qui permet de récupérer la pratie imaginaire dans le registre r12
>- une à la ligne 31, ce qui nous permet de récupérer la module dans le registre r0.

>**NB :** le résultat du module ne correspond pas exactement à ce qui données dans le jeu de données (à 10^-5 ou 10^-7 près)
---
