/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __LCD_H
#define __LCD_H
/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
/* Public define ------------------------------------------------------------*/

   #define A13(state) RAM00.A13 = state;
   #define A12(state) RAM00.A12 = state;
   #define A11(state) RAM00.A11 = state;
   #define A10(state) RAM00.A10 = state;

   #define A14(state) RAM01.A14 = state;
   #define A15(state) RAM01.A15 = state;
  #define A7(state)  RAM01.A7 = state;
  #define A8(state)  RAM01.A8 = state;
  #define A9(state)  RAM01.A9 = state;
  #define A5(state)  RAM01.A5 = state;

  #define A6(state)  RAM02.A6 = state;
  #define A1(state)  RAM02.A1 = state;
  #define A2(state)  RAM02.A2 = state;
  #define A3(state)  RAM02.A3 = state;
  #define A4(state)  RAM02.A4 = state;
  #define T3(state)  RAM02.T3 = state;

   #define F13(state) RAM03.F13 = state;
   #define F12(state) RAM03.F12 = state;
   #define F11(state) RAM03.F11 = state;

   #define F10(state) RAM04.F10 = state;
   #define F14(state) RAM04.F14 = state;
   #define F15(state) RAM04.F15 = state;

  #define F7(state)  RAM05.F7 = state;
  #define F8(state)  RAM05.F8 = state;
  #define F9(state)  RAM05.F9 = state;
  #define F5(state)  RAM05.F5 = state;
  #define F6(state)  RAM05.F6 = state;
  #define F1(state)  RAM05.F1 = state;
  #define F2(state)  RAM05.F2 = state;
  #define F3(state)  RAM05.F3 = state;

  #define F4(state)  RAM06.F4 = state;
  #define T2(state)  RAM06.T2 = state;

   #define B13(state) RAM07.B13 = state;
   #define B12(state) RAM07.B12 = state;
   #define B11(state) RAM07.B11 = state;
   #define B10(state) RAM07.B10 = state;

   #define B14(state) RAM08.B14 = state;
   #define B15(state) RAM08.B15 = state;

  #define B6(state)  RAM09.B6 = state;
  #define B1(state)  RAM09.B1 = state;
  #define B2(state)  RAM09.B2 = state;
  #define B3(state)  RAM09.B3 = state;
  #define B4(state)  RAM09.B4 = state;
  #define T1(state)  RAM09.T1 = state;

   #define G13(state) RAM010.G13 = state;
   #define G12(state) RAM010.G12 = state;
   #define G11(state) RAM010.G11 = state;

   #define G10(state) RAM011.G10 = state;
   #define G14(state) RAM011.G14 = state;
   #define G15(state) RAM011.G15 = state;

   #define G7(state) RAM012.G7 = state;
   #define G8(state) RAM012.G8 = state;
   #define G9(state) RAM012.G9 = state;
   #define G5(state) RAM012.G5 = state;
   #define G6(state) RAM012.G6 = state;
   #define G1(state) RAM012.G1 = state;
   #define G2(state) RAM012.G2 = state;
   #define G3(state) RAM012.G3 = state;

   #define G4(state) RAM013.G4 = state;
   #define T4(state) RAM013.T4 = state;

/*



*/
// SECOND PAGE
   #define E13(state) RAM10.E13 = state;
   #define E12(state) RAM10.E12 = state;
   #define E11(state) RAM10.E11 = state;
   #define E10(state) RAM10.E10 = state;

   #define E14(state) RAM11.E14 = state;
   #define E15(state) RAM11.E15 = state;
  #define E7(state)  RAM11.E7 = state;
  #define E8(state)  RAM11.E8 = state;
  #define E9(state)  RAM11.E9 = state;
  #define E5(state)  RAM11.E5 = state;

  #define E6(state)  RAM12.E6 = state;
  #define E1(state)  RAM12.E1 = state;
  #define E2(state)  RAM12.E2 = state;
  #define E3(state)  RAM12.E3 = state;
  #define E4(state)  RAM12.E4 = state;
  #define T5(state)  RAM12.T5 = state;

   #define C13(state) RAM13.C13 = state;
   #define C12(state) RAM13.C12 = state;
   #define C11(state) RAM13.C11 = state;

   #define C10(state) RAM14.C10 = state;
   #define C14(state) RAM14.C14 = state;
   #define C15(state) RAM14.C15 = state;

  #define C7(state)  RAM15.C7 = state;
  #define C8(state)  RAM15.C8 = state;
  #define C9(state)  RAM15.C9 = state;
  #define C5(state)  RAM15.C5 = state;
  #define C6(state)  RAM15.C6 = state;
  #define C1(state)  RAM15.C1 = state;
  #define C2(state)  RAM15.C2 = state;
  #define C3(state)  RAM15.C3 = state;

  #define C4(state)  RAM16.C4 = state;
  #define T6(state)  RAM16.T6 = state;

   #define D13(state) RAM17.D13 = state;
   #define D12(state) RAM17.D12 = state;
   #define D11(state) RAM17.D11 = state;
   #define D10(state) RAM17.D10 = state;

   #define D14(state) RAM18.D14 = state;
   #define D15(state) RAM18.D15 = state;
  #define D7(state)  RAM18.D7 = state;
  #define D8(state)  RAM18.D8 = state;
  #define D9(state)  RAM18.D9 = state;
  #define D5(state)  RAM18.D5 = state;

  #define D6(state)  RAM19.D6 = state;
  #define D1(state)  RAM19.D1 = state;
  #define D2(state)  RAM19.D2 = state;
  #define D3(state)  RAM19.D3 = state;
  #define D4(state)  RAM19.D4 = state;
  #define T7(state) RAM19.T7 = state;

   #define T20(state) RAM110.T20 = state;
   #define COL2(state) RAM110.COL2 = state;

   #define T17(state) RAM111.T17 = state;
   #define T19(state) RAM111.T19 = state;
   #define T18(state) RAM111.T18 = state;

   #define T15(state) RAM112.T15 = state;
   #define T16(state) RAM112.T16 = state;
   #define T14(state) RAM112.T14 = state;
   #define T13(state) RAM112.T13 = state;
   #define T12(state) RAM112.T12 = state;
   #define T11(state) RAM112.T11 = state;
   #define T10(state) RAM112.T10 = state;
   #define COL1(state) RAM112.COL1 = state;

   #define T9(state) RAM113.T9 = state;
   #define T8(state) RAM113.T8 = state;


/* Public typedef -----------------------------------------------------------*/
// FIRST PAGE
struct RAM00
{
  uint8_t b0:1;
  uint8_t A13:1;
  uint8_t A12:1;
  uint8_t A11:1;
  uint8_t A10:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM01
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t A14:1;
  uint8_t A15:1;
  uint8_t A7:1;
  uint8_t A8:1;
  uint8_t A9:1;
  uint8_t A5:1;
};

struct RAM02
{
  uint8_t A6:1;
  uint8_t A1:1;
  uint8_t A2:1;
  uint8_t A3:1;
  uint8_t A4:1;
  uint8_t T3:1;
  uint8_t b6:1;
  uint8_t b7:1;
};
struct RAM03
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t F13:1;
  uint8_t F12:1;
  uint8_t F11:1;
};
struct RAM04
{
  uint8_t F10:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t F14:1;
  uint8_t F15:1;
};
struct RAM05
{
  uint8_t F7:1;
  uint8_t F8:1;
  uint8_t F9:1;
  uint8_t F5:1;
  uint8_t F6:1;
  uint8_t F1:1;
  uint8_t F2:1;
  uint8_t F3:1;
};
struct RAM06
{
  uint8_t F4:1;
  uint8_t T2:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM07
{
  uint8_t b0:1;
  uint8_t B13:1;
  uint8_t B12:1;
  uint8_t B11:1;
  uint8_t B10:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};
struct RAM08
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t B14:1;
  uint8_t B15:1;
  uint8_t B7:1;
  uint8_t B8:1;
  uint8_t B9:1;
  uint8_t B5:1;
};

struct RAM09
{
  uint8_t B6:1;
  uint8_t B1:1;
  uint8_t B2:1;
  uint8_t B3:1;
  uint8_t B4:1;
  uint8_t T1:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM010
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t G13:1;
  uint8_t G12:1;
  uint8_t G11:1;
};

struct RAM011
{
  uint8_t G10:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t G14:1;
  uint8_t G15:1;
};

struct RAM012
{
  uint8_t G7:1;
  uint8_t G8:1;
  uint8_t G9:1;
  uint8_t G5:1;
  uint8_t G6:1;
  uint8_t G1:1;
  uint8_t G2:1;
  uint8_t G3:1;
};

struct RAM013
{
  uint8_t G4:1;
  uint8_t T4:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};
/*



*/
// SECOND PAGE
struct RAM10
{
  uint8_t b0:1;
  uint8_t E13:1;
  uint8_t E12:1;
  uint8_t E11:1;
  uint8_t E10:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM11
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t E14:1;
  uint8_t E15:1;
  uint8_t E7:1;
  uint8_t E8:1;
  uint8_t E9:1;
  uint8_t E5:1;
};

struct RAM12
{
  uint8_t E6:1;
  uint8_t E1:1;
  uint8_t E2:1;
  uint8_t E3:1;
  uint8_t E4:1;
  uint8_t T5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM13
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t C13:1;
  uint8_t C12:1;
  uint8_t C11:1;
};

struct RAM14
{
  uint8_t C10:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t C14:1;
  uint8_t C15:1;
};

struct RAM15
{
  uint8_t C7:1;
  uint8_t C8:1;
  uint8_t C9:1;
  uint8_t C5:1;
  uint8_t C6:1;
  uint8_t C1:1;
  uint8_t C2:1;
  uint8_t C3:1;
};

struct RAM16
{
  uint8_t C4:1;
  uint8_t T6:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM17
{
  uint8_t b0:1;
  uint8_t D13:1;
  uint8_t D12:1;
  uint8_t D11:1;
  uint8_t D10:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM18
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t D14:1;
  uint8_t D15:1;
  uint8_t D7:1;
  uint8_t D8:1;
  uint8_t D9:1;
  uint8_t D5:1;
};

struct RAM19
{
  uint8_t D6:1;
  uint8_t D1:1;
  uint8_t D2:1;
  uint8_t D3:1;
  uint8_t D4:1;
  uint8_t T7:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

struct RAM110
{
  uint8_t b0:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t T20:1;
  uint8_t COL2:1;
};

struct RAM111
{
  uint8_t T17:1;
  uint8_t b1:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t T19:1;
  uint8_t T18:1;
};

struct RAM112
{
  uint8_t T15:1;
  uint8_t T16:1;
  uint8_t T14:1;
  uint8_t T13:1;
  uint8_t T12:1;
  uint8_t T11:1;
  uint8_t T10:1;
  uint8_t COL1:1;
};

struct RAM113
{
  uint8_t T9:1;
  uint8_t T8:1;
  uint8_t b2:1;
  uint8_t b3:1;
  uint8_t b4:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
};

/* Public macro -------------------------------------------------------------*/
/* Public variables ---------------------------------------------------------*/
/* Public function prototypes -----------------------------------------------*/
void lcd_init(void);
void lcd_update(void);
void SevenSegmentSet(uint8_t NumberSegment,uint8_t val);
void lcd_set_time(RTC_TimeTypeDef * watch);
#endif /*__VALVE_H */