/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMON_H
#define __COMMON_H

#define SLEEPTIME (uint8_t)60
#define SLEEPPVDTIME (uint8_t)10

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
  OFFMODE,
  BATTERYLOW
};



#endif