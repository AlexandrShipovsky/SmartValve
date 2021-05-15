/* Includes ------------------------------------------------------------------*/
#include "LCD.h"
/* Private typedef -----------------------------------------------------------*/
typedef struct
{
  uint8_t A:1;
  uint8_t B:1;
  uint8_t C:1;
  uint8_t D:1;
  uint8_t E:1;
  uint8_t F:1;
  uint8_t G:1;
} SevenSegmentTypeDef;
SevenSegmentTypeDef ind;
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

static uint8_t BlinkState = 0;
/* Private function prototypes -----------------------------------------------*/
static void SevenSegmentCalc(uint8_t i,SevenSegmentTypeDef * ind);

void lcd_BlinkSegments(void)
{
  
  
  if(BlinkState)
  {
    COL1(1);
    BlinkState = 0;
  }
  else
  {
    COL1(0);
    BlinkState = 1;
  }
}
void lcd_SetBattery(enum BatteryState BatteryState)
{
  T1(0);
  T2(0);
  T3(0);
  switch(BatteryState)
  {
  case BatLow:
    T1(1);
    break;
    case BatMiddle:
      T1(1);
    T2(1);
    break;
    case BatHigh:
      T1(1);
    T2(1);
    T3(1);
    break; 
  default:
    break;
  }
}
void lcd_SetStaticSegment(uint8_t state)
{
  if(state)
  {
    T9(1);
    T10(1);
    T13(1);
    T14(1);
    T15(1);
    T16(1);
    T17(1);
    T20(1);
  }
  else
  {
    T9(0);
    T10(0);
    T13(0);
    T14(0);
    T15(0);
    T16(0);
    T17(0);
    T20(0);
  }
}
void lcd_set_time(RTC_TimeTypeDef watch)
{
  uint8_t integer = 0;
  integer = watch.RTC_Hours/10;
  SevenSegmentSet(1,integer);
  integer = watch.RTC_Hours%10;
  SevenSegmentSet(2,integer);
  
  integer = watch.RTC_Minutes/10;
  SevenSegmentSet(3,integer);
  integer = watch.RTC_Minutes%10;
  SevenSegmentSet(4,integer);
}


void SevenSegmentSet(uint8_t NumberSegment,uint8_t val)
{
  SevenSegmentCalc(val,&ind);
  switch(NumberSegment)
  {
  case 1:
    A1(ind.A);
    B1(ind.B);
    C1(ind.C);
    D1(ind.D);
    E1(ind.E);
    F1(ind.F);
    G1(ind.G);
    break;
    case 2:
    A2(ind.A);
    B2(ind.B);
    C2(ind.C);
    D2(ind.D);
    E2(ind.E);
    F2(ind.F);
    G2(ind.G);
    break;
    case 3:
    A3(ind.A);
    B3(ind.B);
    C3(ind.C);
    D3(ind.D);
    E3(ind.E);
    F3(ind.F);
    G3(ind.G);
    break;
      case 4:
    A4(ind.A);
    B4(ind.B);
    C4(ind.C);
    D4(ind.D);
    E4(ind.E);
    F4(ind.F);
    G4(ind.G);
    break;
  case 5:
    A5(ind.A);
    B5(ind.B);
    C5(ind.C);
    D5(ind.D);
    E5(ind.E);
    F5(ind.F);
    G5(ind.G);
    break;
    case 6:
    A6(ind.A);
    B6(ind.B);
    C6(ind.C);
    D6(ind.D);
    E6(ind.E);
    F6(ind.F);
    G6(ind.G);
    break;
    case 7:
      A7(ind.A);
    B7(ind.B);
    C7(ind.C);
    D7(ind.D);
    E7(ind.E);
    F7(ind.F);
    G7(ind.G);
    break;
    case 8:
      A8(ind.A);
    B8(ind.B);
    C8(ind.C);
    D8(ind.D);
    E8(ind.E);
    F8(ind.F);
    G8(ind.G);
    break;
    case 9:
      A9(ind.A);
    B9(ind.B);
    C9(ind.C);
    D9(ind.D);
    E9(ind.E);
    F9(ind.F);
    G9(ind.G);
    break;
    case 10:
      A10(ind.A);
    B10(ind.B);
    C10(ind.C);
    D10(ind.D);
    E10(ind.E);
    F10(ind.F);
    G10(ind.G);
    break;
    case 11:
      A11(ind.A);
    B11(ind.B);
    C11(ind.C);
    D11(ind.D);
    E11(ind.E);
    F11(ind.F);
    G11(ind.G);
    break;
    case 12:
      A12(ind.A);
    B12(ind.B);
    C12(ind.C);
    D12(ind.D);
    E12(ind.E);
    F12(ind.F);
    G12(ind.G);
    break;
    case 13:
      A13(ind.A);
    B13(ind.B);
    C13(ind.C);
    D13(ind.D);
    E13(ind.E);
    F13(ind.F);
    G13(ind.G);
    break;
    case 14:
      A14(ind.A);
    B14(ind.B);
    C14(ind.C);
    D14(ind.D);
    E14(ind.E);
    F14(ind.F);
    G14(ind.G);
    break;
    case 15:
      A15(ind.A);
    B15(ind.B);
    C15(ind.C);
    D15(ind.D);
    E15(ind.E);
    F15(ind.F);
    G15(ind.G);
    break;
  default:
    break;
  }
}
void SevenSegmentCalc(uint8_t i,SevenSegmentTypeDef * ind)
{
  
  switch(i)
  {
  case 0:
  ind->A = 1;
  ind->B = 1;
  ind->C = 1;
  ind->D = 1;
  ind->E = 1;
  ind->F = 1;
    break;
  case 1:
  ind->B = 1;
  ind->C = 1;
  break;
  case 2:
  ind->A = 1;
  ind->B = 1;
  ind->D = 1;
  ind->E = 1;
  ind->G = 1;
    break;
  case 3:
   ind->A = 1;
  ind->B = 1;
  ind->C = 1;
  ind->D = 1;
  ind->G = 1;
    break;
  case 4:
    ind->B = 1;
  ind->C = 1;
  ind->F = 1;
  ind->G = 1;
    break;
  case 5:
    ind->A = 1;
    ind->F = 1;
    ind->G = 1;
    ind->C = 1;
  ind->D = 1;
    break;
  case 6:
  ind->A = 1;
  ind->C = 1;
  ind->D = 1;
  ind->E = 1;
  ind->F = 1;
  ind->G = 1;
    break;
    
    case 7:
  ind->A = 1;
  ind->B = 1;
  ind->C = 1;
    break;
    
    case 8:
  ind->A = 1;
  ind->B = 1;
  ind->C = 1;
  ind->D = 1;
  ind->E = 1;
  ind->F = 1;
  ind->G = 1;
    break;
    
    case 9:
  ind->A = 1;
  ind->B = 1;
  ind->C = 1;
  ind->D = 1;
  ind->F = 1;
  ind->G = 1;
    break;
    
    
  default:
    ind->A = 0;
  ind->B = 0;
  ind->C = 0;
  ind->D = 0;
  ind->E = 0;
  ind->F = 0;
  ind->G = 0;
    break;
  }
  
}
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
  //LCD_PageSelect(LCD_PageSelection_FirstPage);
  //LCD_BlinkConfig(LCD_BlinkMode_AllSEG_AllCOM,LCD_BlinkFrequency_Div256);

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