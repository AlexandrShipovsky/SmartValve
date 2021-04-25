/* Includes ------------------------------------------------------------------*/
#include "LCD.h"
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
/* Private function prototypes -----------------------------------------------*/
void lcd_init(void)
{
  CLK_PeripheralClockConfig(CLK_Peripheral_LCD, ENABLE);
  LCD_Init(LCD_Prescaler_2,LCD_Divider_20,LCD_Duty_1_8,LCD_Bias_1_4,LCD_VoltageSource_Internal);
  LCD_PortMaskConfig(LCD_PortMaskRegister_0,0x1E);
  LCD_PortMaskConfig(LCD_PortMaskRegister_1,0xFC);
  LCD_PortMaskConfig(LCD_PortMaskRegister_2,0x3F);

  
  LCD_ContrastConfig(LCD_Contrast_Level_5);
  LCD_DeadTimeConfig(LCD_DeadTime_1);
  LCD_HighDriveCmd(ENABLE);
  LCD_Cmd(ENABLE);
  LCD_PageSelect(LCD_PageSelection_FirstPage);
  //LCD_BlinkConfig(LCD_BlinkMode_AllSEG_AllCOM,LCD_BlinkFrequency_Div256);

  uint8_t i = 0x00;
  for(i = 0x00;i <= 0x15;i++)
  {
  LCD_WriteRAM(i,0xFF);
  }
  LCD_PageSelect(LCD_PageSelection_SecondPage);
  for(i = 0x00;i <= 0x15;i++)
  {
  LCD_WriteRAM(i,0xFF);
  }

}