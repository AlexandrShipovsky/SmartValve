#include "keyboard.h"

enum buttons PutButton;
enum com SelectCOM = COMSTATE1;

extern void Delay(__IO uint32_t nTime);

void ClearButton(enum buttons * button)
{
  *button = NOPUT;
  Delay(100);
}

void ToggleCOM(void)
  {
  disableInterrupts();
  GPIO_ToggleBits(BUTTONGPIO2,COM1);
  GPIO_ToggleBits(BUTTONGPIO2,COM2);
  if(SelectCOM == COMSTATE1)
  {
    SelectCOM = COMSTATE2;
  }
  else
  {
    SelectCOM = COMSTATE1;
  }
  enableInterrupts();
  }

void EnableCOM(void)
{
  GPIO_SetBits(BUTTONGPIO2,COM1);
  GPIO_SetBits(BUTTONGPIO2,COM2);
}

void COMFromHalt(void)
{
  SelectCOM = COMSTATE1;
  GPIO_Init(BUTTONGPIO2, COM1, GPIO_Mode_Out_PP_High_Slow);
  GPIO_Init(BUTTONGPIO2, COM2, GPIO_Mode_Out_PP_Low_Slow);
}