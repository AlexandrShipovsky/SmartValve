/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __KEYBOARD_H
#define __KEYBOARD_H

#include "stm8l15x.h"
/* Public typedef -----------------------------------------------------------*/
/* Public define ------------------------------------------------------------*/
#define BUTTONGPIO1 GPIOC
#define BUTTONGPIO2 GPIOG
#define OFF_MAN GPIO_Pin_1
#define RAIN_SETUP GPIO_Pin_0
#define PLUS_MINUS GPIO_Pin_7
#define COM1 GPIO_Pin_6
#define COM2 GPIO_Pin_5
/* Public macro -------------------------------------------------------------*/
/* Public variables ---------------------------------------------------------*/
enum buttons
{
  NOPUT,
  OFF,
  MANUAL,
  DELAY,
  OK,
  PLUS,
  MINUS
};

enum com
  {
  COMSTATE1,
  COMSTATE2
};
/* Public function prototypes -----------------------------------------------*/
void ClearButton(enum buttons * button);
void ToggleCOM(void);
void EnableCOM(void);
void COMFromHalt(void);


#endif /*__KEYBOARD_H */