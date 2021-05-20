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
extern enum buttons PutButton;
extern enum ValveState VALVESTATE;
__IO uint32_t TimingDelay;

enum ProgramMode ProgramState = NORMAL;

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
static void rtc_init(void);
static void error(void);

static void TIM4_Config(void);
void Delay(__IO uint32_t nTime); //nTime in millisecond
void TimingDelay_Decrement(void);
void PlusSegment(enum CurrentSetting CurrentSetting);
void MinusSegment(enum CurrentSetting CurrentSetting);
void SetAlarmForIrrig(void);
/* Private functions ---------------------------------------------------------*/
/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
  HowFreq.day = 0;
  HowFreq.hours = 0;
  HowFreq.HoursDay = HRS;

  NextIrrig.day = 0;
  NextIrrig.hours = 0;
  NextIrrig.HoursDay = HRS;
  /* Infinite loop */

  clk_init();
  rtc_init();
  TIM4_Config();
  gpio_init();
  VBAT_init();
  ValveInit();
  lcd_init();
  lcd_SetStaticSegment(1);
  uint8_t i = 0;
  while (1)
  {
    switch (ProgramState)
    {
    case VALVEOPEN:
    {
      ValveOpen();
      ProgramState = NORMAL;
      break;
    }
    case VALVECLOSE:
    {
      ValveClose();
      ProgramState = NORMAL;
      break;
    }
    case NORMAL:
    {
      VBAT = GetVBAT();
      if (VBAT < 3800)
      {
        lcd_SetBattery(BatLow);
      }
      else if (VBAT < 4300)
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
        ClearButton(&PutButton);
        break;
      case DELAY:
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
      lcd_set_StartTime(StartTime);
      lcd_set_time(watch);
      lcd_SetStaticSegment(1);
      if (HowFreq.HoursDay == HRS)
      {
        lcd_SetHowFreq(HowFreq.hours, HRS);
      }
      else
      {
        lcd_SetHowFreq(HowFreq.day, DAY);
      }
      if (NextIrrig.HoursDay == HRS)
      {
        lcd_SetNextIrrigation(NextIrrig.hours, HRS);
      }
      else
      {
        lcd_SetNextIrrigation(NextIrrig.day, DAY);
      }
      lcd_SetHowLong(HowLongVal);
      break;
    }

    case SETUP:
    {
      enum CurrentSetting CurrentSetting = CurrentTimeHours;

      while ((PutButton != OFF) && (CurrentSetting != NONESET))
      {
        lcd_clear();
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
          lcd_set_time(watch);
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
          lcd_set_StartTime(StartTime);
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
      SetAlarmForIrrig();
      ProgramState = NORMAL;
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
      ProgramState = NORMAL;

      Delay(2);
      EnableCOM();
      lcd_clear();
      lcd_update();
      halt();
      COMFromHalt();
      ClearButton(&PutButton);
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
  /*if(RTC_DeInit()!= SUCCESS)
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
  //RTC_ExitInitMode();
}

void gpio_init(void)
{
  GPIO_Init(BUTTONGPIO1, OFF_MAN | RAIN_SETUP, GPIO_Mode_In_FL_IT);

  GPIO_Init(BUTTONGPIO2, PLUS_MINUS, GPIO_Mode_In_FL_IT);
  //GPIO_ExternalPullUpConfig(BUTTONGPIO2,PLUS_MINUS, ENABLE);

  GPIO_Init(BUTTONGPIO2, COM1, GPIO_Mode_Out_PP_High_Slow);
  GPIO_Init(BUTTONGPIO2, COM2, GPIO_Mode_Out_PP_Low_Slow);

  EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_7, EXTI_Trigger_Rising);
  enableInterrupts();

  EXTI_ClearITPendingBit(EXTI_IT_Pin0);
  EXTI_ClearITPendingBit(EXTI_IT_Pin1);
  EXTI_ClearITPendingBit(EXTI_IT_Pin7);
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
    break;
  case HowFreqValue:
    if (HowFreq.HoursDay == DAY)
    {
      if (HowFreq.day == 99)
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
    break;
  case HowFreqValue:
    if (HowFreq.HoursDay == DAY)
    {
      if (HowFreq.day == 0)
      {
        HowFreq.day = 99;
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
    if (HowLongVal == 999)
    {
      HowLongVal = 0;
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
};

void SetAlarmForIrrig(void)
{
  RTC_AlarmTypeDef RTC_AlarmStruct;
  RTC_DateTypeDef RTC_DateStruct;
  RTC_GetDate(RTC_Format_BIN, &RTC_DateStruct);

  RTC_AlarmStruct.RTC_AlarmTime = StartTime;
  RTC_AlarmStruct.RTC_AlarmDateWeekDaySel = RTC_AlarmDateWeekDaySel_WeekDay;
  RTC_AlarmStruct.RTC_AlarmDateWeekDay = RTC_DateStruct.RTC_WeekDay;

  RTC_SetAlarm(RTC_Format_BIN, &RTC_AlarmStruct);
  RTC_AlarmCmd(ENABLE);
}

void error(void)
{
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
