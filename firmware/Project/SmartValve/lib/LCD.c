/* Includes ------------------------------------------------------------------*/
#include "LCD.h"
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
struct RAM00 RAM00;
struct RAM01 RAM01;
struct RAM02 RAM02;
struct RAM03 RAM03;
struct RAM04 RAM04;
struct RAM05 RAM05;
struct RAM06 RAM06;
struct RAM07 RAM07;
struct RAM08 RAM08;
struct RAM09 RAM09;
struct RAM010 RAM010;
struct RAM011 RAM011;
struct RAM012 RAM012;
struct RAM013 RAM013;

struct RAM10 RAM10;
struct RAM11 RAM11;
struct RAM12 RAM12;
struct RAM13 RAM13;
struct RAM14 RAM14;
struct RAM15 RAM15;
struct RAM16 RAM16;
struct RAM17 RAM17;
struct RAM18 RAM18;
struct RAM19 RAM19;
struct RAM110 RAM110;
struct RAM111 RAM111;
struct RAM112 RAM112;
struct RAM113 RAM113;
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

  A1(1);
  B1(1);
  C1(1);
  D1(1);
  E1(1);
  G1(1);
  F1(1);
  
  T7(1);
  lcd_update();

}

void lcd_update(void)
{
  LCD_PageSelect(LCD_PageSelection_FirstPage);
  LCD_WriteRAM(LCD_RAMRegister_0,*(uint8_t*)&RAM00);
  LCD_WriteRAM(LCD_RAMRegister_1,*(uint8_t*)&RAM01);
  LCD_WriteRAM(LCD_RAMRegister_2,*(uint8_t*)&RAM02);
  LCD_WriteRAM(LCD_RAMRegister_3,*(uint8_t*)&RAM03);
  LCD_WriteRAM(LCD_RAMRegister_4,*(uint8_t*)&RAM04);
  LCD_WriteRAM(LCD_RAMRegister_5,*(uint8_t*)&RAM05);
  LCD_WriteRAM(LCD_RAMRegister_6,*(uint8_t*)&RAM06);
  LCD_WriteRAM(LCD_RAMRegister_7,*(uint8_t*)&RAM07);
  LCD_WriteRAM(LCD_RAMRegister_8,*(uint8_t*)&RAM08);
  LCD_WriteRAM(LCD_RAMRegister_9,*(uint8_t*)&RAM09);
  LCD_WriteRAM(LCD_RAMRegister_10,*(uint8_t*)&RAM010);
  LCD_WriteRAM(LCD_RAMRegister_11,*(uint8_t*)&RAM011);
  LCD_WriteRAM(LCD_RAMRegister_12,*(uint8_t*)&RAM012);
  LCD_WriteRAM(LCD_RAMRegister_13,*(uint8_t*)&RAM013);
  
  LCD_PageSelect(LCD_PageSelection_SecondPage);
  LCD_WriteRAM(LCD_RAMRegister_0,*(uint8_t*)&RAM10);
  LCD_WriteRAM(LCD_RAMRegister_1,*(uint8_t*)&RAM11);
  LCD_WriteRAM(LCD_RAMRegister_2,*(uint8_t*)&RAM12);
  LCD_WriteRAM(LCD_RAMRegister_3,*(uint8_t*)&RAM13);
  LCD_WriteRAM(LCD_RAMRegister_4,*(uint8_t*)&RAM14);
  LCD_WriteRAM(LCD_RAMRegister_5,*(uint8_t*)&RAM15);
  LCD_WriteRAM(LCD_RAMRegister_6,*(uint8_t*)&RAM16);
  LCD_WriteRAM(LCD_RAMRegister_7,*(uint8_t*)&RAM17);
  LCD_WriteRAM(LCD_RAMRegister_8,*(uint8_t*)&RAM18);
  LCD_WriteRAM(LCD_RAMRegister_9,*(uint8_t*)&RAM19);
  LCD_WriteRAM(LCD_RAMRegister_10,*(uint8_t*)&RAM110);
  LCD_WriteRAM(LCD_RAMRegister_11,*(uint8_t*)&RAM111);
  LCD_WriteRAM(LCD_RAMRegister_12,*(uint8_t*)&RAM112);
  LCD_WriteRAM(LCD_RAMRegister_13,*(uint8_t*)&RAM113);
}