/**
  ******************************************************************************
  * @file    Project/STM8L15x_StdPeriph_Template/main.c
  * @author  MCD Application Team
  * @version V1.6.1
  * @date    30-September-2014
  * @brief   Main program body
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; COPYRIGHT 2014 STMicroelectronics</center></h2>
  *
  * Licensed under MCD-ST Liberty SW License Agreement V2, (the "License");
  * You may not use this file except in compliance with the License.
  * You may obtain a copy of the License at:
  *
  *        http://www.st.com/software_license_agreement_liberty_v2
  *
  * Unless required by applicable law or agreed to in writing, software 
  * distributed under the License is distributed on an "AS IS" BASIS, 
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
#include "stm8l15x.h"
#include "keyboard.h"
#include "valve.h"
#include "VBAT.h"
#include "LCD.h"
#include "common.h"

/** @addtogroup STM8L15x_StdPeriph_Template
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

#define TIM4_PERIOD 124
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
RTC_TimeTypeDef watch;
RTC_TimeTypeDef StartTime;
RTC_TimeTypeDef StopTime;
RTC_AlarmTypeDef RTC_AlarmStruct;
RTC_AlarmTypeDef RTC_NowAlarmStruct;
RTC_AlarmTypeDef AlarmWhenStop;
RTC_DateTypeDef RTC_DateStruct;

extern enum buttons PutButton;
extern enum ValveState VALVESTATE;
__IO uint32_t TimingDelay;
RTC_Weekday_TypeDef test = RTC_Weekday_Monday;
enum ProgramMode ProgramState = NORMAL;
enum ProgramMode ProgramStatePrevios = NORMAL;
FunctionalState AlarmState = DISABLE;
uint8_t RainDelay = 0;
extern enum com SelectCOM;
extern uint8_t SleepTime;
uint16_t ChildLockInc = 0;
uint8_t ChildLockMode = 0;

uint16_t VBAT = 0;

struct HowFreq
{
  uint8_t day;
  uint8_t hours;
  enum HoursDay HoursDay;
};

struct NextIrrig
{
  uint8_t day;
  uint8_t hours;
  enum HoursDay HoursDay;
};
struct NextIrrig NextIrrig;
struct HowFreq HowFreq;

uint16_t HowLongVal = 0;
/* Private function prototypes -----------------------------------------------*/
static void clk_init(void);
static void gpio_init(void);
static void pwr_init(void);
static void gpio_init_interrupt(void);
static void rtc_init(void);
static void error(void);

static void TIM4_Config(void);
void Delay(__IO uint32_t nTime); //nTime in millisecond
void TimingDelay_Decrement(void);
static void PlusSegment(enum CurrentSetting CurrentSetting);
static void MinusSegment(enum CurrentSetting CurrentSetting);
static void SetAlarmForIrrig(void);
static void CalcNexIrrig(void);
static void SetHowLong(RTC_TimeTypeDef *Now);
static void GetKeyboard(void);

void GetKeyboard(void)
{
  BitStatus key;
  static uint8_t ChildLockOut;
  uint8_t OFFInc = 0;
  key = GPIO_ReadInputDataBit(BUTTONGPIO2, PLUS_MINUS);
  if (key)
  {
    SleepTime = SLEEPTIME;
    if (SelectCOM == COMSTATE1)
    {
      PutButton = MINUS;
    }
    else
    {
      PutButton = PLUS;
    }
    Delay(75);
  }
  key = GPIO_ReadInputDataBit(BUTTONGPIO1, RAIN_SETUP);
  if (key)
  {
    SleepTime = SLEEPTIME;
    if (SelectCOM == COMSTATE1)
    {
      PutButton = OK;
    }
    else
    {
      Delay(300);
      ChildLockInc = 0;
      while (GPIO_ReadInputDataBit(BUTTONGPIO1, RAIN_SETUP) && (ChildLockInc < 14))
      {
        ChildLockInc++;
        Delay(200);
      }

      if (ChildLockInc >= 14)
      {
        if (ChildLockMode)
        {
          ChildLockOut = 1;
        }
        ChildLockMode = !ChildLockMode;
        return;
      }
      if (ChildLockOut)
      {
        ChildLockOut--;
      }
      else
      {
        PutButton = DELAY;
      }
    }
    Delay(200);
  }
  key = GPIO_ReadInputDataBit(BUTTONGPIO1, OFF_MAN);
  if (key)
  {
    SleepTime = SLEEPTIME;
    if (SelectCOM == COMSTATE1)
    {
      PutButton = MANUAL;
    }
    else
    {
      while (GPIO_ReadInputDataBit(BUTTONGPIO1, OFF_MAN) && (OFFInc < 14))
      {
        OFFInc++;
        Delay(200);
      }
      if (OFFInc >= 14)
      {
        if (ProgramState == OFFMODE)
        {
          SetAlarmForIrrig();
          ProgramState = SET_ALARM_HOWFREQ;
        }
        else
        {
          ProgramState = OFFMODE;
        }
        return;
      }
      PutButton = OFF;
    }
    Delay(200);
    }
  if (ChildLockMode)
  {
    PutButton = NOPUT;
    lcd_childlock(1);
  }
  else
  {
    lcd_childlock(0);
  }
}
/* Private functions ---------------------------------------------------------*/
/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
  uint8_t i = 0;
  extern uint8_t SleepTime;
  HowFreq.day = 0;
  HowFreq.hours = 0;
  HowFreq.HoursDay = HRS;

  NextIrrig.day = 0;
  NextIrrig.hours = 0;
  NextIrrig.HoursDay = HRS;
  /* Infinite loop */

  clk_init();
  pwr_init();
  rtc_init();
  TIM4_Config();
  gpio_init();
  VBAT_init();
  ValveInit();
  lcd_init();
  lcd_SetStaticSegment(1);
  while (1)
  {
    lcd_clear();
    switch (ProgramState)
    {
      case BATTERYLOW:
      {
        ValveClose();
        ProgramStatePrevios = BATTERYLOW;
        while(1)
        {
          lcd_SetBattery(BatLow);
          lcd_SetSevSegmentBlink(BATTERYLOWBLINK);
          lcd_update();
        }
        break;
      }
    case SET_ALARM_AFTRCONF:
    {
      SetAlarmForIrrig();
      ProgramState = SET_ALARM_HOWFREQ;
      break;
    }
    case SET_ALARM_HOWFREQ:
    {
      if (HowLongVal == 0)
      {
        AlarmState = DISABLE;
        RTC_AlarmCmd(AlarmState);
        ProgramState = NORMAL;
        break;
      }

      if (HowFreq.HoursDay == HRS)
      {
        if (HowFreq.hours == 0)
        {
          AlarmState = DISABLE;
          RTC_AlarmCmd(AlarmState);
          ProgramState = NORMAL;
          break;
        }
      }
      else
      {
        if (HowFreq.day == 0)
        {
          AlarmState = DISABLE;
          RTC_AlarmCmd(AlarmState);
          ProgramState = NORMAL;
          break;
        }
      }

      RTC_AlarmCmd(DISABLE);

      RTC_SetAlarm(RTC_Format_BIN, &RTC_AlarmStruct);
      AlarmState = ENABLE;
      RTC_AlarmCmd(AlarmState);

      RTC_GetAlarm(RTC_Format_BIN, &RTC_AlarmStruct);
      ProgramState = NORMAL;
      break;
    }
    case SET_ALARM_HOWLONG:
    {

      SetHowLong(&StartTime);
      //Set alarm for next enable valve, but not enable alarm. Enable alarm after close valve
      SetAlarmForIrrig();

      ProgramState = NORMAL;
      break;
    }
    case VALVEOPEN:
    {
      ValveOpen();
      ProgramState = SET_ALARM_HOWLONG;
      break;
    }
    case VALVECLOSE:
    {
      ValveClose();
      ProgramState = SET_ALARM_HOWFREQ;
      break;
    }
    case MANUALMODE:
    {
      uint16_t BufHowLongVal = HowLongVal;
      enum CurrentSetting CurrentSetting = HowLong;
      while ((PutButton != OFF) && (CurrentSetting != StartTimeHours))
      {
        GetKeyboard();
        lcd_clear();
        lcd_SetStaticSegment(1);
        lcd_SetSevSegmentBlink(CurrentSetting);
        lcd_SetHowLong(HowLongVal);

        lcd_update();

        ToggleCOM();
        switch (PutButton)
        {
        case MANUAL:
          ClearButton(&PutButton);
          CurrentSetting++;
          break;
        case PLUS:
        {
          PlusSegment(CurrentSetting);
          ClearButton(&PutButton);
          break;
        }
        case MINUS:
        {
          MinusSegment(CurrentSetting);
          ClearButton(&PutButton);
          break;
        }
        default:
          //ClearButton(&PutButton);
          break;
        }
      }

      if (!VALVESTATE)
      {
        ValveClose();
      }

      if (HowLongVal == 0)
      {
        ProgramState = VALVECLOSE;
        HowLongVal = BufHowLongVal;
        lcd_SetSevSegmentBlink(NONESET);
        ClearButton(&PutButton);
        break;
      }
      ValveOpen();
      SetHowLong(&watch);

      lcd_SetSevSegmentBlink(NONESET);
      while ((PutButton != OFF) && (ProgramState == MANUALMODE))
      {
        GetKeyboard();
        SleepTime = 60;
        lcd_clear();
        lcd_SetStaticSegment(1);
        lcd_SetHowLong(HowLongVal);
        lcd_irrigation(VALVESTATE);
        lcd_update();

        ToggleCOM();
      }

      ProgramState = VALVECLOSE;
      HowLongVal = BufHowLongVal;
      lcd_SetSevSegmentBlink(NONESET);
      ClearButton(&PutButton);
      break;
    }
    case RAINDELAYMODE:
      AlarmState = DISABLE;
      lcd_raindelay(1);
      if (RainDelay == 0)
      {
        SetAlarmForIrrig();
        ProgramState = SET_ALARM_HOWFREQ;
        lcd_raindelay(0);
      }
    case NORMAL:
    {
      ProgramStatePrevios = NORMAL;
      GetKeyboard();
      VBAT = GetVBAT();
      if ((VBAT/100) < 36)
      {
        lcd_SetBattery(BatLow);
      }
      else if ((VBAT/100) < 42)
      {
        lcd_SetBattery(BatMiddle);
      }
      else
      {
        lcd_SetBattery(BatHigh);
      }

      switch (PutButton)
      {
      case OFF:

        ClearButton(&PutButton);
        break;
      case OK:
        ProgramState = SETUP;
        ClearButton(&PutButton);
        break;
      case MANUAL:
        ProgramState = MANUALMODE;
        ClearButton(&PutButton);
        break;
      case DELAY:
        RainDelay = !RainDelay;

        ClearButton(&PutButton);
        break;
      case PLUS:
        ClearButton(&PutButton);
        break;
      case MINUS:
        ClearButton(&PutButton);
        break;
      default:
        //ClearButton(&PutButton);
        break;
      }
      if (RTC_WaitForSynchro() == SUCCESS)
      {
        RTC_GetTime(RTC_Format_BIN, &watch);
      }

      if (RainDelay)
      {
        ProgramState = RAINDELAYMODE;
      }

      CalcNexIrrig();
      lcd_set_StartTime(&StartTime);
      lcd_set_time(&watch);
      lcd_SetStaticSegment(1);
      if (HowFreq.HoursDay == HRS)
      {
        lcd_SetHowFreq(HowFreq.hours, HRS);
      }
      else
      {
        lcd_SetHowFreq(HowFreq.day, DAY);
      }

      RTC_AlarmCmd(AlarmState);
      if (AlarmState == ENABLE)
      {
        lcd_automode(1);
        if (NextIrrig.HoursDay == HRS)
        {
          lcd_SetNextIrrigation(NextIrrig.hours, HRS);
        }
        else
        {
          lcd_SetNextIrrigation(NextIrrig.day, DAY);
        }
      }
      else
      {

        lcd_automode(0);
        lcd_SetNextIrrigation(1000, NONEHD);
      }

      lcd_SetHowLong(HowLongVal);

      lcd_irrigation(VALVESTATE);

      break;
    }

    case SETUP:
    {
      enum CurrentSetting CurrentSetting = CurrentTimeHours;

      while ((PutButton != OFF) && (CurrentSetting != NONESET))
      {
        lcd_clear();
        GetKeyboard();
        lcd_SetStaticSegment(1);
        lcd_SetSevSegmentBlink(CurrentSetting);
        switch (CurrentSetting)
        {
        case CurrentTimeHours:

        case CurrentTimeMin:
          if (RTC_WaitForSynchro() == SUCCESS)
          {
            RTC_GetTime(RTC_Format_BIN, &watch);
          }
          lcd_set_time(&watch);
          break;
        case HowFreqDAYorHRS:
          /* if (HowFreq.HoursDay == DAY)
          {
            T12(1);
            T11(0);
          }
          else
          {
            T11(1);
            T12(0);
          }
          break;
          */
        case HowFreqValue:
          if (HowFreq.HoursDay == HRS)
          {
            lcd_SetHowFreq(HowFreq.hours, HRS);
          }
          else
          {
            lcd_SetHowFreq(HowFreq.day, DAY);
          }
          break;
        case HowLong:
          lcd_SetHowLong(HowLongVal);
          break;
        case StartTimeHours:
        case StartTimeMin:
          lcd_set_StartTime(&StartTime);
          break;
        }

        lcd_update();

        ToggleCOM();
        switch (PutButton)
        {
        case OK:
          ClearButton(&PutButton);
          CurrentSetting++;
          break;
        case PLUS:
        {
          PlusSegment(CurrentSetting);
          ClearButton(&PutButton);
          break;
        }
        case MINUS:
        {
          MinusSegment(CurrentSetting);
          ClearButton(&PutButton);
          break;
        }
        default:
          //ClearButton(&PutButton);
          break;
        }
      }

      if (!VALVESTATE)
      {
        ValveClose();
      }

      ProgramState = SET_ALARM_AFTRCONF;
      lcd_SetSevSegmentBlink(NONESET);
      ClearButton(&PutButton);
      break;
    }

    case TESTMODE:
    {
      if (i == 10)
      {
        i = 0;
      }
      Delay(1000);

      SevenSegmentSet(5, i);
      SevenSegmentSet(6, i);
      SevenSegmentSet(7, i);
      SevenSegmentSet(8, i);
      SevenSegmentSet(9, i);
      SevenSegmentSet(10, i);
      SevenSegmentSet(11, i);
      SevenSegmentSet(12, i);
      SevenSegmentSet(13, i);
      SevenSegmentSet(14, i);
      SevenSegmentSet(15, i);
      i++;
      lcd_update();
      break;
    }
    case SLEEP:
    {
      ProgramState = ProgramStatePrevios;
      
      gpio_init_interrupt();
      Delay(2);
      EnableCOM();
      lcd_clear();
      lcd_update();
      PWR_UltraLowPowerCmd(ENABLE);

      ADC_Cmd(ADC1,DISABLE);
      halt();
      PWR_UltraLowPowerCmd(DISABLE);
      ADC_Cmd(ADC1,ENABLE);

      gpio_init();
      COMFromHalt();
      Delay(50);
      ClearButton(&PutButton);
      break;
    }
    case OFFMODE:
    {
      ProgramStatePrevios = OFFMODE;
      GetKeyboard();
      if (RTC_WaitForSynchro() == SUCCESS)
      {
        RTC_GetTime(RTC_Format_BIN, &watch);
      }
      lcd_set_time(&watch);
      RTC_AlarmCmd(DISABLE);
      break;
    }
    }

    lcd_update();
    ToggleCOM();
  }
}

void clk_init(void)
{
  uint32_t i = 0;

  CLK_DeInit();
  CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_4);
  CLK_LSEConfig(CLK_LSE_ON);
  while (CLK_GetFlagStatus(CLK_FLAG_LSERDY) != SET)
    ;
  for (i = 80000; i != 0; i--)
    ;

  CLK_LSEClockSecuritySystemEnable();
  CLK_RTCClockConfig(CLK_RTCCLKSource_LSE, CLK_RTCCLKDiv_1);

  CLK_PeripheralClockConfig(CLK_Peripheral_RTC, ENABLE);
  /* Enable TIM4 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_TIM4, ENABLE);
  /* Enable ADC1 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);

  while (CLK_GetFlagStatus(CLK_FLAG_RTCSWBSY) != SET)
    ;
  CLK_ClearFlag();
}

void pwr_init(void)
{
  PWR_DeInit();
  PWR_PVDLevelConfig(PWR_PVDLevel_3V05);
  PWR_PVDCmd(ENABLE);
  
}

/**
  * @brief  Configure TIM4 peripheral   
  * @param  None
  * @retval None
  */
static void TIM4_Config(void)
{
  /* TIM4 configuration:
   - TIM4CLK is set to 4 MHz, the TIM4 Prescaler is equal to 32 so the TIM1 counter
   clock used is 4 MHz / 32 = 125 000 Hz
  - With 125 000 Hz we can generate time base:
      max time base is 2.048 ms if TIM4_PERIOD = 255 --> (255 + 1) / 125000 = 2.048 ms
      min time base is 0.016 ms if TIM4_PERIOD = 1   --> (  1 + 1) / 125000 = 0.016 ms
  - In this example we need to generate a time base equal to 1 ms
   so TIM4_PERIOD = (0.001 * 125000 - 1) = 124 */

  /* Time base configuration */
  TIM4_TimeBaseInit(TIM4_Prescaler_32, TIM4_PERIOD);
  /* Clear TIM4 update flag */
  TIM4_ClearFlag(TIM4_FLAG_Update);
  /* Enable update interrupt */
  TIM4_ITConfig(TIM4_IT_Update, ENABLE);
  /* enable interrupts */
  //enableInterrupts();

  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);

  enableInterrupts();
}
/**
  * @brief  Inserts a delay time.
  * @param  nTime: specifies the delay time length, in milliseconds.
  * @retval None
  */
void Delay(__IO uint32_t nTime)
{
  TimingDelay = nTime;

  while (TimingDelay != 0)
    ;
}

/**
  * @brief  Decrements the TimingDelay variable.
  * @param  None
  * @retval None
  */
void TimingDelay_Decrement(void)
{
  if (TimingDelay != 0x00)
  {
    TimingDelay--;
  }
}

void rtc_init(void)
{
  /*
  if(RTC_DeInit()!= SUCCESS)
  {
    error();
  } 
*/
  //RTC_EnterInitMode();
  RTC_InitTypeDef RTC_Struct;
  RTC_Struct.RTC_HourFormat = RTC_HourFormat_24;
  RTC_Struct.RTC_AsynchPrediv = 0x7F;
  RTC_Struct.RTC_SynchPrediv = 0x00FF;

  if (RTC_Init(&RTC_Struct) != SUCCESS)
  {
    error();
  }

  RTC_ITConfig(RTC_IT_ALRA, ENABLE);
  //RTC_AlarmCmd(ENABLE);

  //RTC_ExitInitMode();
}

void gpio_init(void)
{
  disableInterrupts();
  GPIO_Init(BUTTONGPIO1, OFF_MAN, GPIO_Mode_In_FL_No_IT);
  GPIO_Init(BUTTONGPIO1, RAIN_SETUP, GPIO_Mode_In_FL_No_IT);
  GPIO_Init(BUTTONGPIO2, PLUS_MINUS, GPIO_Mode_In_FL_No_IT);
  //GPIO_ExternalPullUpConfig(BUTTONGPIO2,PLUS_MINUS, ENABLE);

  GPIO_Init(BUTTONGPIO2, COM1, GPIO_Mode_Out_PP_High_Slow);
  GPIO_Init(BUTTONGPIO2, COM2, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOA, GPIO_Pin_0, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOA, GPIO_Pin_1, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOA, GPIO_Pin_7, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOG, GPIO_Pin_0, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOG, GPIO_Pin_1, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOG, GPIO_Pin_2, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOG, GPIO_Pin_3, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOG, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOD, GPIO_Pin_3, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOF, GPIO_Pin_0, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOF, GPIO_Pin_1, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOC, GPIO_Pin_2, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOC, GPIO_Pin_3, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOC, GPIO_Pin_4, GPIO_Mode_Out_PP_Low_Slow);

  GPIO_Init(GPIOE, GPIO_Pin_6, GPIO_Mode_Out_PP_Low_Slow);
  GPIO_Init(GPIOE, GPIO_Pin_7, GPIO_Mode_Out_PP_Low_Slow);
  EXTI_DeInit();
  enableInterrupts();
}

void gpio_init_interrupt(void)
{
  disableInterrupts();
  GPIO_Init(BUTTONGPIO1, OFF_MAN, GPIO_Mode_In_FL_IT);
  GPIO_Init(BUTTONGPIO1, RAIN_SETUP, GPIO_Mode_In_FL_IT);
  GPIO_Init(BUTTONGPIO2, PLUS_MINUS, GPIO_Mode_In_FL_IT);

  //GPIO_ExternalPullUpConfig(BUTTONGPIO2,PLUS_MINUS, ENABLE);

  //GPIO_Init(BUTTONGPIO2, COM1, GPIO_Mode_Out_PP_High_Slow);
  //GPIO_Init(BUTTONGPIO2, COM2, GPIO_Mode_Out_PP_Low_Slow);
  EXTI_DeInit();

  EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_7, EXTI_Trigger_Rising);

  EXTI_ClearITPendingBit(EXTI_IT_Pin0);
  EXTI_ClearITPendingBit(EXTI_IT_Pin1);
  EXTI_ClearITPendingBit(EXTI_IT_Pin7);
  enableInterrupts();
}

void PlusSegment(enum CurrentSetting CurrentSetting)
{
  switch (CurrentSetting)
  {
  case CurrentTimeHours:
    if (watch.RTC_Hours == 23)
    {

      watch.RTC_Hours = 0;
    }
    else
    {
      watch.RTC_Hours++;
    }
    RTC_SetTime(RTC_Format_BIN, &watch);
    break;
  case CurrentTimeMin:
    if (watch.RTC_Minutes == 59)
    {
      watch.RTC_Minutes = 0;
    }
    else
    {
      watch.RTC_Minutes++;
    }
    RTC_SetTime(RTC_Format_BIN, &watch);
    break;
  case HowFreqDAYorHRS:
    if (HowFreq.HoursDay == DAY)
    {
      HowFreq.HoursDay = HRS;
    }
    else
    {
      HowFreq.HoursDay = DAY;
    }
    Delay(125);
    break;
  case HowFreqValue:
    if (HowFreq.HoursDay == DAY)
    {
      if (HowFreq.day == 7)
      {
        HowFreq.day = 0;
      }
      else
      {
        HowFreq.day++;
      }
    }
    else
    {
      if (HowFreq.hours == 99)
      {
        HowFreq.hours = 0;
      }
      else
      {
        HowFreq.hours++;
      }
    }
    break;
  case HowLong:
    if (HowLongVal == 999)
    {
      HowLongVal = 0;
    }
    else
    {
      HowLongVal++;
    }
    break;
  case StartTimeHours:
    if (StartTime.RTC_Hours == 23)
    {
      StartTime.RTC_Hours = 0;
    }
    else
    {
      StartTime.RTC_Hours++;
    }
    break;
  case StartTimeMin:
    if (StartTime.RTC_Minutes == 59)
    {
      StartTime.RTC_Minutes = 0;
    }
    else
    {
      StartTime.RTC_Minutes++;
    }
    break;
  }
}

void MinusSegment(enum CurrentSetting CurrentSetting)
{
  switch (CurrentSetting)
  {
  case CurrentTimeHours:
    if (watch.RTC_Hours == 0)
    {

      watch.RTC_Hours = 23;
    }
    else
    {
      watch.RTC_Hours--;
    }
    RTC_SetTime(RTC_Format_BIN, &watch);
    break;
  case CurrentTimeMin:
    if (watch.RTC_Minutes == 0)
    {
      watch.RTC_Minutes = 59;
    }
    else
    {
      watch.RTC_Minutes--;
    }
    RTC_SetTime(RTC_Format_BIN, &watch);
    break;
  case HowFreqDAYorHRS:
    if (HowFreq.HoursDay == DAY)
    {
      HowFreq.HoursDay = HRS;
    }
    else
    {
      HowFreq.HoursDay = DAY;
    }
    Delay(125);
    break;
  case HowFreqValue:
    if (HowFreq.HoursDay == DAY)
    {
      if (HowFreq.day == 0)
      {
        HowFreq.day = 7;
      }
      else
      {
        HowFreq.day--;
      }
    }
    else
    {
      if (HowFreq.hours == 0)
      {
        HowFreq.hours = 99;
      }
      else
      {
        HowFreq.hours--;
      }
    }
    break;
  case HowLong:
    if (HowLongVal == 0)
    {
      HowLongVal = 999;
    }
    else
    {
      HowLongVal--;
    }
    break;
  case StartTimeHours:
    if (StartTime.RTC_Hours == 0)
    {
      StartTime.RTC_Hours = 23;
    }
    else
    {
      StartTime.RTC_Hours--;
    }
    break;
  case StartTimeMin:
    if (StartTime.RTC_Minutes == 0)
    {
      StartTime.RTC_Minutes = 59;
    }
    else
    {
      StartTime.RTC_Minutes--;
    }
    break;
  }
}

void SetAlarmForIrrig(void)
{

  RTC_AlarmStruct.RTC_AlarmMask = RTC_AlarmMask_DateWeekDay;
  RTC_AlarmStruct.RTC_AlarmDateWeekDaySel = RTC_AlarmDateWeekDaySel_WeekDay;
  //StartTime.RTC_Seconds = watch.RTC_Seconds;
  RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);
  if (HowFreq.HoursDay == DAY)
  {

    //RTC_AlarmStruct.RTC_AlarmTime = StartTime;
    RTC_AlarmStruct.RTC_AlarmTime.RTC_Hours = StartTime.RTC_Hours;
    RTC_AlarmStruct.RTC_AlarmTime.RTC_Minutes = StartTime.RTC_Minutes;
    RTC_AlarmStruct.RTC_AlarmTime.RTC_Seconds = StartTime.RTC_Seconds;

    if (((watch.RTC_Hours * 60 + watch.RTC_Minutes) >= (StartTime.RTC_Hours * 60 + StartTime.RTC_Minutes)))
    {

      RTC_AlarmStruct.RTC_AlarmDateWeekDay = RTC_DateStruct.RTC_WeekDay + HowFreq.day;
      if (RTC_AlarmStruct.RTC_AlarmDateWeekDay > RTC_Weekday_Sunday)
      {
        RTC_AlarmStruct.RTC_AlarmDateWeekDay -= RTC_Weekday_Sunday;
      }
    }
    else
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay = RTC_DateStruct.RTC_WeekDay;
    }
  }
  else
  {
    //future
    if ((ProgramState == SET_ALARM_AFTRCONF) && ((watch.RTC_Hours * 60 + watch.RTC_Minutes) < (StartTime.RTC_Hours * 60 + StartTime.RTC_Minutes)))
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay = RTC_DateStruct.RTC_WeekDay;

      //RTC_AlarmStruct.RTC_AlarmTime = StartTime;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Hours = StartTime.RTC_Hours;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Minutes = StartTime.RTC_Minutes;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Seconds = StartTime.RTC_Seconds;
      return;
    }

    //past
    if ((ProgramState == SET_ALARM_AFTRCONF))
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay = RTC_DateStruct.RTC_WeekDay + 1;
      //RTC_AlarmStruct.RTC_AlarmTime = StartTime;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Hours = StartTime.RTC_Hours;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Minutes = StartTime.RTC_Minutes;
      RTC_AlarmStruct.RTC_AlarmTime.RTC_Seconds = StartTime.RTC_Seconds;
      return;
    }
    else
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay = 0;
    }

    StartTime.RTC_Hours = StartTime.RTC_Hours + (HowFreq.hours % 24);
    if (StartTime.RTC_Hours >= 24)
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay++;
      StartTime.RTC_Hours -= 24;
    }

    RTC_AlarmStruct.RTC_AlarmDateWeekDay += RTC_DateStruct.RTC_WeekDay + (HowFreq.hours / 24);
    if (RTC_AlarmStruct.RTC_AlarmDateWeekDay > RTC_Weekday_Sunday)
    {
      RTC_AlarmStruct.RTC_AlarmDateWeekDay -= RTC_Weekday_Sunday;
    }
  }
  //RTC_AlarmStruct.RTC_AlarmTime = StartTime;
  RTC_AlarmStruct.RTC_AlarmTime.RTC_Hours = StartTime.RTC_Hours;
  RTC_AlarmStruct.RTC_AlarmTime.RTC_Minutes = StartTime.RTC_Minutes;
  RTC_AlarmStruct.RTC_AlarmTime.RTC_Seconds = StartTime.RTC_Seconds;
}

void CalcNexIrrig(void)
{
  int8_t days = 0;
  int8_t hours = 0;
  NextIrrig.HoursDay = HRS;
  NextIrrig.hours = hours;
  RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);
  RTC_GetAlarm(RTC_Format_BIN, &RTC_NowAlarmStruct);

  if (RTC_NowAlarmStruct.RTC_AlarmDateWeekDay >= RTC_DateStruct.RTC_WeekDay)
  {
    days = RTC_NowAlarmStruct.RTC_AlarmDateWeekDay - RTC_DateStruct.RTC_WeekDay;
  }
  else
  {
    days = RTC_NowAlarmStruct.RTC_AlarmDateWeekDay + (RTC_Weekday_Sunday - RTC_DateStruct.RTC_WeekDay);
  }
  if (days != 0)
  {
    NextIrrig.HoursDay = DAY;
    NextIrrig.day = days;
    return;
  }

  if (RTC_NowAlarmStruct.RTC_AlarmTime.RTC_Hours >= watch.RTC_Hours)
  {
    hours = RTC_NowAlarmStruct.RTC_AlarmTime.RTC_Hours - watch.RTC_Hours;
  }
  else
  {
    hours = RTC_NowAlarmStruct.RTC_AlarmTime.RTC_Hours + (24 - watch.RTC_Hours);
  }
  if (hours != 0)
  {
    NextIrrig.HoursDay = HRS;
    NextIrrig.hours = hours;
  }
}

void SetHowLong(RTC_TimeTypeDef *Now)
{

  uint8_t d, h, m;

  RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);

  m = HowLongVal % 60;
  h = (HowLongVal / 60) % 24;
  d = (HowLongVal / 60) / 24;

  StopTime.RTC_Minutes = Now->RTC_Minutes + m;
  if (StopTime.RTC_Minutes >= 60)
  {
    StopTime.RTC_Minutes %= 60;
    h++;
  }

  StopTime.RTC_Hours = Now->RTC_Hours + h;
  if (StopTime.RTC_Hours >= 24)
  {
    StopTime.RTC_Hours %= 24;
    d++;
  }

  d += RTC_DateStruct.RTC_WeekDay;
  if (d > RTC_Weekday_Sunday)
  {
    d -= RTC_Weekday_Sunday;
  }

  StopTime.RTC_Seconds = 0;//watch.RTC_Seconds;
  //AlarmWhenStop.RTC_AlarmTime = StopTime;
  AlarmWhenStop.RTC_AlarmTime.RTC_Hours = StopTime.RTC_Hours;
  AlarmWhenStop.RTC_AlarmTime.RTC_Minutes = StopTime.RTC_Minutes;
  AlarmWhenStop.RTC_AlarmTime.RTC_Seconds = StopTime.RTC_Seconds;

  AlarmWhenStop.RTC_AlarmDateWeekDaySel = RTC_AlarmDateWeekDaySel_WeekDay;
  AlarmWhenStop.RTC_AlarmMask = RTC_AlarmMask_DateWeekDay;
  AlarmWhenStop.RTC_AlarmDateWeekDay = d;

  RTC_AlarmCmd(DISABLE);
  RTC_SetAlarm(RTC_Format_BIN, &AlarmWhenStop);
  RTC_AlarmCmd(ENABLE);
  RTC_GetAlarm(RTC_Format_BIN, &RTC_NowAlarmStruct);
}

void error(void)
{
  uint16_t i = 0;
  for (i = 0; i < 65000; i++)
    ;
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
    error();
  }
}
#endif

/**
  * @}
  */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
