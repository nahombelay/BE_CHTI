/*Partie 2.1*/
#include "gassp72.h"

extern short TabCos;
extern short TabSin;
int test(short);
int TabRes[64];



short angle;

int main(void)
{

for (int k = 0; k < 64; k++) {
	TabRes[k] = test(k);
}

while	(1) {}

}

