/*Partie 2.2.1*/
#include "gassp72.h"

extern int TabCos;
extern int TabSin;
extern int TabSig;
int dftint(int *, int, int *);
int TabReel[64];
int TabIm[64];


int main(void)
{

for (int k = 0; k < 64; k++) {
	TabReel[k] = dftint(&TabSig,k,&TabCos);
	TabIm[k] = dftint(&TabSig,k,&TabSin);
}

while	(1) {}

}

