/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMON_H
#define __COMMON_H

#define SLEEPTIME (uint8_t)60

enum ProgramMode
{
  VALVEOPEN,
  VALVECLOSE,
  TESTMODE,
  NORMAL,
  SETUP,
  SLEEP,
  FROMSLEEP,
  SET_ALARM_HOWLONG,
  SET_ALARM_HOWFREQ,
  SET_ALARM_AFTRCONF,
  MANUALMODE,
  RAINDELAYMODE,
  OFFMODE
};



#endif