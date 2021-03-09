/* Includes ------------------------------------------------------------------*/
#include "valve.h"
	
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
void ValveInit(void)
{
  GPIO_Init(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN | CLOSE_VALVE_ENABLE_PIN,GPIO_Mode_Out_PP_High_Slow); //pin enable1 and enable2 conf as out push-pull high level
  
  
  /* GPIOD configuration: TIM1 channel 1 (PD2) */
  GPIO_Init(GPIOD, GPIO_Pin_2, GPIO_Mode_Out_PP_Low_Slow);
  
  CLK_PeripheralClockConfig(CLK_Peripheral_TIM1, ENABLE);
  
  TIM1_TimeBaseInit(3999, TIM1_CounterMode_Up, 1000, 0);
  TIM1_SelectOnePulseMode(TIM1_OPMode_Single);
  TIM1_OC1Init(TIM1_OCMode_Active, TIM1_OutputState_Enable, TIM1_OutputNState_Disable,
               (uint16_t)150, TIM1_OCPolarity_Low, TIM1_OCNPolarity_Low, TIM1_OCIdleState_Set,
               TIM1_OCNIdleState_Set);
  
  
}

void ValveOpen(void)
{

  GPIO_SetBits(VALVE_ENABLE_PORT,CLOSE_VALVE_ENABLE_PIN);

  GPIO_ResetBits(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN);

}

void ValveClose(void)
{
  TIM1_Cmd(DISABLE);

  GPIO_SetBits(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN);

  GPIO_ResetBits(VALVE_ENABLE_PORT,CLOSE_VALVE_ENABLE_PIN);
  
}
