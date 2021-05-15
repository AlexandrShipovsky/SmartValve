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

/** @addtogroup STM8L15x_StdPeriph_Template
  * @{
  */

/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/

#define TIM4_PERIOD       124
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
RTC_TimeTypeDef watch;
extern enum buttons PutButton;
extern enum ValveState VALVESTATE;
__IO uint32_t TimingDelay;

uint16_t VBAT = 0;
/* Private function prototypes -----------------------------------------------*/
static void clk_init(void);
static void gpio_init(void);
static void rtc_init(void);
static void error(void);

static void TIM4_Config(void);
void Delay(__IO uint32_t nTime); //nTime in millisecond
void TimingDelay_Decrement(void);
/* Private functions ---------------------------------------------------------*/

/**
  * @brief  Main program.
  * @param  None
  * @retval None
  */
void main(void)
{
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
    if(i == 10)
    {
      i =0;
    }
    VBAT = GetVBAT();
    if(VBAT < 3800)
    {
      lcd_SetBattery(BatLow);
    }
    else if(VBAT < 4300)
    {
      lcd_SetBattery(BatMiddle);
    }
    else
    {
      lcd_SetBattery(BatHigh);
    }
    /*Delay(1000);
    
    SevenSegmentSet(5,i);
    SevenSegmentSet(6,i);
    SevenSegmentSet(7,i);
    SevenSegmentSet(8,i);
    SevenSegmentSet(9,i);
    SevenSegmentSet(10,i);
    SevenSegmentSet(11,i);
    SevenSegmentSet(12,i);
    SevenSegmentSet(13,i);
    SevenSegmentSet(14,i);
    SevenSegmentSet(15,i);
*/
    switch(PutButton)
    {
    case OFF:
      ValveClose();
      ClearButton(&PutButton);
      break;
    case OK:
      ValveOpen();
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
    RTC_GetTime(RTC_Format_BCD,&watch);
    lcd_set_time(watch);
    lcd_update();
    i++;
    ToggleCOM();
  }
}


void clk_init(void)
{
  uint32_t i = 0;
  
  CLK_DeInit();
  CLK_SYSCLKDivConfig(CLK_SYSCLKDiv_4);
  CLK_LSEConfig(CLK_LSE_ON);
  while(CLK_GetFlagStatus(CLK_FLAG_LSERDY) != SET);
  for(i = 80000;i != 0; i--);

  CLK_LSEClockSecuritySystemEnable();
  CLK_RTCClockConfig(CLK_RTCCLKSource_LSE,CLK_RTCCLKDiv_1);
  
  CLK_PeripheralClockConfig(CLK_Peripheral_RTC, ENABLE);
  /* Enable TIM4 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_TIM4, ENABLE);
  /* Enable ADC1 CLK */
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);
  
  while(CLK_GetFlagStatus(CLK_FLAG_RTCSWBSY) != SET);
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

  while (TimingDelay != 0);
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
  if(RTC_DeInit()!= SUCCESS)
  {
    error();
  } 

  RTC_InitTypeDef RTC_Struct;
  RTC_Struct.RTC_HourFormat = RTC_HourFormat_24;
  RTC_Struct.RTC_AsynchPrediv = 0x7F;
  RTC_Struct.RTC_SynchPrediv = 0x00FF;
  
  if(RTC_Init(&RTC_Struct)!= SUCCESS)
  {
    error();
  }
  
  
}


void gpio_init(void)
{
  GPIO_Init(BUTTONGPIO1,OFF_MAN|RAIN_SETUP,GPIO_Mode_In_FL_IT); 
  
  GPIO_Init(BUTTONGPIO2,PLUS_MINUS,GPIO_Mode_In_FL_IT);
  //GPIO_ExternalPullUpConfig(BUTTONGPIO2,PLUS_MINUS, ENABLE);
  
  GPIO_Init(BUTTONGPIO2,COM1,GPIO_Mode_Out_PP_High_Slow);
  GPIO_Init(BUTTONGPIO2,COM2,GPIO_Mode_Out_PP_Low_Slow);
  
  EXTI_SetPinSensitivity(EXTI_Pin_0, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_1, EXTI_Trigger_Rising);
  EXTI_SetPinSensitivity(EXTI_Pin_7, EXTI_Trigger_Rising);
  enableInterrupts();
  
  EXTI_ClearITPendingBit(EXTI_IT_Pin0);
  EXTI_ClearITPendingBit(EXTI_IT_Pin1);
  EXTI_ClearITPendingBit(EXTI_IT_Pin7);
  
  
}




void error(void)
{
}


#ifdef  USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
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
