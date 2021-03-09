/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __VALVE_H
#define __VALVE_H

#include "stm8l15x.h"

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define SWICHDELAY 300
#define PULSEWIDTH 500

#define VALVE_ENABLE_PORT GPIOE
#define VALVE_PULSE_PORT GPIOD

#define OPEN_VALVE_ENABLE_PIN GPIO_Pin_5
#define CLOSE_VALVE_ENABLE_PIN GPIO_Pin_4

#define OPEN_VALVE_PULSE_PIN GPIO_Pin_0
#define CLOSE_VALVE_PULSE_PIN GPIO_Pin_2
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
void ValveInit(void);
void ValveOpen(void);
void ValveClose(void);
#endif /*__VALVE_H */