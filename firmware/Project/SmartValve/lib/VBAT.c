/* Includes ------------------------------------------------------------------*/
#include "VBAT.h"
/* Private typedef -----------------------------------------------------------*/
/* Private define ------------------------------------------------------------*/
#define VREF (uint16_t)995 //mVolts
/* Private macro -------------------------------------------------------------*/
/* Private variables ---------------------------------------------------------*/
static uint16_t VREF_RAW = 0;
/* Private function prototypes -----------------------------------------------*/
static void GetVREF(void);
extern void Delay(__IO uint32_t nTime);

void GetVREF(void)
{
  ADC_DeInit(ADC1);
  ADC_Init(ADC1,ADC_ConversionMode_Single,ADC_Resolution_12Bit,ADC_Prescaler_2);
  ADC_SamplingTimeConfig(ADC1,ADC_Group_FastChannels,ADC_SamplingTime_384Cycles);
  ADC_Cmd(ADC1,ENABLE);
  
  //ADC_ChannelCmd(ADC1,ADC_Channel_Vrefint,ENABLE);
  ADC_VrefintCmd(ENABLE);
  Delay(200);
  ADC_SoftwareStartConv(ADC1);
  while (ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == 0)
        {}
  VREF_RAW = ADC_GetConversionValue(ADC1);
  ADC_ClearFlag(ADC1,ADC_FLAG_EOC);
  //ADC_ChannelCmd(ADC1,ADC_Channel_Vrefint,DISABLE);
  ADC_VrefintCmd(DISABLE);
  
  /* Deinitialize the ADC */
  ADC_DeInit(ADC1);  
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, DISABLE);
}
void VBAT_init(void)
{
  GetVREF();
  CLK_PeripheralClockConfig(CLK_Peripheral_ADC1, ENABLE);
  ADC_Init(ADC1,ADC_ConversionMode_Single,ADC_Resolution_12Bit,ADC_Prescaler_2);
  ADC_SamplingTimeConfig(ADC1,ADC_Group_SlowChannels,ADC_SamplingTime_384Cycles);
  
  ADC_Cmd(ADC1,ENABLE);
  ADC_SchmittTriggerConfig(ADC1,ADC_Channel_3,DISABLE);
  ADC_ChannelCmd(ADC1,ADC_Channel_3,ENABLE);
}

uint16_t GetVBAT(void)
{
  uint32_t ret = 0;
  ADC_SoftwareStartConv(ADC1);
  while (ADC_GetFlagStatus(ADC1, ADC_FLAG_EOC) == 0)
        {}
  ret = ADC_GetConversionValue(ADC1);
  ret *= 2*VREF;
  ret /= VREF_RAW;
  ADC_ClearFlag(ADC1,ADC_FLAG_EOC);
  return (uint16_t)ret;
}
