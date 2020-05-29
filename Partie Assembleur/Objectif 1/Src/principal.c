/*Partie 2.2.2*/
#include "gassp72.h"

extern short TabCos;
extern short TabSin;
//le tabsig initial
extern short TabSig;
//les trois tabsig du test_DFT
extern short TabSig1;
extern short TabSig2;
extern short TabSig3;

//int dftint(short *, int, short *);
int module(short *, int);
int tabMod[64];


int main(void)
{

for (int k = 0; k < 64; k++) {
	//changer la variable tabsig en fonction de ce qu'on veut tester
	tabMod[k] = module(&TabSig3, k);
	
}

while	(1) {}

}

