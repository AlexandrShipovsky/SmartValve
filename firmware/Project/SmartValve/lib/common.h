/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __COMMON_H
#define __COMMON_H

#define SLEEPTIME (uint8_t)6
#define SMALLSLEEPTIME (uint8_t)6
#define SLEEPPVDTIME (uint8_t)6

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
  MANUALMODEEXIT,
  RAINDELAYMODE,
  OFFMODE,
  BATTERYLOW
};



#endif