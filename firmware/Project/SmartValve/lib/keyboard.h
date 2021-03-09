/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __KEYBOARD_H
#define __KEYBOARD_H


/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
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
/* Private function prototypes -----------------------------------------------*/
void ClearButton(enum buttons * button);




#endif /*__KEYBOARD_H */