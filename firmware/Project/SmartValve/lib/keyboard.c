#include "keyboard.h"

enum buttons PutButton;
enum com SelectCOM = COMSTATE1;

void ClearButton(enum buttons * button)
{
  *button = NOPUT;
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
