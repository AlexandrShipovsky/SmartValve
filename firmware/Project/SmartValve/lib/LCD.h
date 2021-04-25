/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LCD_H
#define __LCD_H
/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
/* Public typedef -----------------------------------------------------------*/
typedef struct
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
}RAM0;
/* Public define ------------------------------------------------------------*/
/* Public macro -------------------------------------------------------------*/
/* Public variables ---------------------------------------------------------*/
/* Public function prototypes -----------------------------------------------*/
void lcd_init(void);
#endif /*__VALVE_H */