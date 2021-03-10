/* Includes ------------------------------------------------------------------*/
#include "valve.h"
	
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
extern void Delay(__IO uint32_t nTime);
enum ValveState VALVESTATE = NONE;
/* Private function prototypes -----------------------------------------------*/
/* Private functions ---------------------------------------------------------*/
/* Public functions ----------------------------------------------------------*/
void ValveInit(void)
{
  GPIO_Init(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN | CLOSE_VALVE_ENABLE_PIN,GPIO_Mode_Out_OD_HiZ_Slow); //pin enable1 and enable2 conf as out push-pull high level
  GPIO_Init(VALVE_PULSE_PORT, OPEN_VALVE_PULSE_PIN | CLOSE_VALVE_PULSE_PIN, GPIO_Mode_Out_PP_Low_Slow);
}

void ValveOpen(void)
{

  Delay(SWICHDELAY);
  GPIO_ResetBits(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN);
  Delay(SWICHDELAY);
  GPIO_SetBits(VALVE_PULSE_PORT,OPEN_VALVE_PULSE_PIN);
  Delay(PULSEWIDTH);
  GPIO_ResetBits(VALVE_PULSE_PORT,OPEN_VALVE_PULSE_PIN);
  
  GPIO_SetBits(VALVE_ENABLE_PORT,OPEN_VALVE_ENABLE_PIN);
  VALVESTATE = OPEN;
}

void ValveClose(void)
{
  Delay(SWICHDELAY);
  GPIO_ResetBits(VALVE_ENABLE_PORT,CLOSE_VALVE_ENABLE_PIN);
  Delay(SWICHDELAY);
  GPIO_SetBits(VALVE_PULSE_PORT,CLOSE_VALVE_PULSE_PIN);
  Delay(PULSEWIDTH);
  GPIO_ResetBits(VALVE_PULSE_PORT,CLOSE_VALVE_PULSE_PIN);
  
  GPIO_SetBits(VALVE_ENABLE_PORT,CLOSE_VALVE_ENABLE_PIN);
  VALVESTATE = CLOSED;
}
