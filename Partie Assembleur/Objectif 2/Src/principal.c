/*Partie 2.2.2*/
#include "gassp72.h"
#define M2TIR 985661
#define SEUIL 2

vu16 dma_buf[64];
int compt_occurences[6];
int compt_score[6];
int k_freq[6] = {17,18,19,20,23,24};

unsigned int SYSTICK_PER = 10 * 0.001 * 72 * 1000000; 
//intervalle entre deux interruptions entre 5 et 20ms

int module(vu16 *, int);

void sys_callback(void){
	//GPIO_Set(GPIOB,1);
	// Démarrage DMA pour 64 points
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	int dft_res[6];
	//Calcul de la dft
	for (int i = 0; i < 6; i++){
		dft_res[i] = module(dma_buf, k_freq[i] );
		if (dft_res[i] > M2TIR){
			compt_occurences[i]++;
		}else {
			if (compt_occurences[i] > SEUIL){
				compt_score[i]++;
			} 
			compt_occurences[i] = 0;
		}
	}
	//GPIO_Clear(GPIOB,1);
	
	
}

int main(void)
{
	// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();
	// PA2 (ADC voie 2) = entrée analog
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	// PB1 = sortie pour profilage à l'oscillo
	GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	// PB14 = sortie pour LED
	GPIO_Configure(GPIOB, 14, OUTPUT, OUTPUT_PPULL);

	// activation ADC, sampling time 1us
	Init_TimingADC_ActiveADC_ff( ADC1, 0x3c ); // utilise le deuxieme argument 
	Single_Channel_ADC( ADC1, 2 );
	// Déclenchement ADC par timer2, periode (72MHz/320kHz)ticks
	Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
	// Config DMA pour utilisation du buffer dma_buf (a créér)
	Init_ADC1_DMA1( 0, dma_buf );

	// Config Timer, période exprimée en périodes horloge CPU (72 MHz)
	Systick_Period_ff( SYSTICK_PER );
	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 3 est la priorité, sys_callback est l'adresse de cette fonction, a créér en C
	Systick_Prio_IT( 3, sys_callback );
	SysTick_On;
	SysTick_Enable_IT;

while	(1) {}

}

