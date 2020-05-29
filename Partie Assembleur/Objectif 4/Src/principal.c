#include "gassp72.h"
#include "etat.h"

#define M2TIR 985661
#define SEUIL 2

vu16 dma_buf[64];
int compt_occurences[6] = {0,0,0,0,0,0};
int compt_score[6] = {0,0,0,0,0,0};
int k_freq[6] = {17,18,19,20,23,24};

unsigned int SYSTICK_PER = 10 * 0.001 * 72 * 1000000; 
//intervalle entre deux interruptions entre 5 et 20ms

int module(vu16 *, int);
extern short Son;
extern int LongueurSon;
extern int PeriodeSonMicroSec;
void callback(void);
type_etat etat;

void sys_callback(void){
	//GPIO_Set(GPIOB,1);
	// D?marrage DMA pour 64 points
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
				//Active_IT_Debordement_Timer( TIM4, 2, callback );
				compt_score[i]++;
				etat.position = 0;
			} 
			compt_occurences[i] = 0;
		}
	}
	//GPIO_Clear(GPIOB,1);
}

int main(void)
{
	int PeriodeSonTick = PeriodeSonMicroSec * 72;
	int Periode_PWM_en_Tck = 10 * PeriodeSonTick; 	
	
	// activation de la PLL qui multiplie la fr?quence du quartz par 9
	CLOCK_Configure();
	// config port PB0 pour être utilisé par TIM3-CH3
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	//etat.taille = LongueurSon;
	etat.taille = 200;
	etat.position = etat.taille ;
	etat.son = &Son;
	etat.periode_ticks = PeriodeSonTick;
	// config TIM3-CH3 en mode PWM
	etat.resolution = PWM_Init_ff( TIM3, 3, Periode_PWM_en_Tck );
	
	// initialisation du timer 4
	// Periode_en_Tck doit fournir la dur?e entre interruptions,
	// exprim?e en p?riodes Tck de l'horloge principale du STM32 (72 MHz)
	Timer_1234_Init_ff( TIM4, PeriodeSonTick );

	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 2 est la priorit?, timer_callback est l'adresse de cette fonction, a cr??r en asm,
	// cette fonction doit ?tre conforme ? l'AAPCS
	Active_IT_Debordement_Timer( TIM4, 2, callback );
	// lancement du timer
	Run_Timer( TIM4 );
	
	// activation ADC, sampling time 1us
	Init_TimingADC_ActiveADC_ff( ADC1, 0x33 ); // utilise le deuxieme argument 
	Single_Channel_ADC( ADC1, 2 );
	// D?clenchement ADC par timer2, periode (72MHz/320kHz)ticks
	Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
	// Config DMA pour utilisation du buffer dma_buf (a cr??r)
	Init_ADC1_DMA1( 0, dma_buf );

	// Config Timer, p?riode exprim?e en p?riodes horloge CPU (72 MHz)
	Systick_Period_ff( SYSTICK_PER );
	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 3 est la priorit?, sys_callback est l'adresse de cette fonction, a cr??r en C
	Systick_Prio_IT( 3, sys_callback );
	SysTick_On;
	SysTick_Enable_IT;
	

while	(1) {}

}

