//lcd registers
/*



*/
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
}

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
}

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
}
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
}
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
}
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
}
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
}

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
}
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
}

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
}

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
}

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
}

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
}

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
}
/*



*/
// SECOND PAGE
struct RAM10
{
  uint8_t b0:1;
  uint8_t E13:1;
  uint8_t E12:1;
  uint8_t E11:1;
  uint8_t 10:1;
  uint8_t b5:1;
  uint8_t b6:1;
  uint8_t b7:1;
}

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
}

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
}

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
}

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
}

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
}

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
}

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
}

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
}

struct RAM19
{
  uint8_t D6:1;
  uint8_t D1:1;
  uint8_t D2:1;
  uint8_t D3:1;
  uint8_t D4:1;
  uint8_t T17:1;
  uint8_t b6:1;
  uint8_t b7:1;
}

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
}

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
}

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
}

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
}