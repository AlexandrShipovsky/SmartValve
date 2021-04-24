/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __VBAT_H
#define __VBAT_H
/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
/* Public typedef -----------------------------------------------------------*/
/* Public define ------------------------------------------------------------*/
/* Public macro -------------------------------------------------------------*/
/* Public variables ---------------------------------------------------------*/
/* Public function prototypes -----------------------------------------------*/
void VBAT_init(void);
uint16_t GetVBAT(void); // Voltage in milivolts

#endif /*__VBAT_H */