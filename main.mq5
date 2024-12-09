#property copyright "developerseyed@gmail.com";
#property link "https://www.hadi.s4r4.com";
#property version "1.00";
#include "./defintion/index.mq5";
#include "./helper.mq5";
#include "./graphic/index.mq5";
#include "./zone/index.mq5";
#include "./trade/index.mq5";
#include "./test/index.mq5";
int NameCounter = 0;
int ArrowCounter = 0;

enum ZoneType
{
  shadow,
  sharp,
  shadowBack
};
input datetime init_date = (datetime) "2024-11-13 15:00:00";
input double init_high_zone = 2618.83;
input double init_low_zone = 2612.72;
input bool init_zone_isBullish = false;
input ZoneType zType = shadow;
input int sharpFactor = 2;
input int sharpPeriod = 14;
input ENUM_TIMEFRAMES lowTimeframe = PERIOD_M5;
input double trade_volume = 0.01;
input int trade_tp_pip = 10;
ZoneArr AllZones;
Zone_ZoneArr AllZone_Zones;
int FirstZoneId = 0;
int zoneInInitCount = 0;
int OnInit()
{
  MathSrand(GetTickCount());
  Zone initZone;
  initZone.Init(init_high_zone, init_low_zone, init_zone_isBullish, init_date, true);
  initZone.DrawZone(init_date, myTime(findIndexOfDate(init_date) - 5));
  AllZones.Set(initZone);

  int firstShift = findIndexOfDate(init_date);
  Print(AllZones.arr[0].isMainZone);

  for (int i = firstShift; i >= 0; i--)
  {
    HandleNewZones(i);
  }
  zoneInInitCount = NameCounter;
  Print("zone finded = ", NameCounter);

  return (INIT_SUCCEEDED);
}
void OnDeinit(const int reason)
{
  for (int i = 0; i <= NameCounter; ++i)
  {
    RectangleDelete(0, "rec" + (string)i);
  }
  for (int i = 0; i < AllZones.length; ++i)
  {
    AllZones.arr[i].isEnable = false;
    AllZones.arr[i].time = 0;
  }
  NameCounter = 0;
}
void OnTick()
{
  HandleNewZones(0);
  RemoveCrossedZone(true);
  CheckForNewTradeAndTradeIt(0);

  if (zoneInInitCount > NameCounter)
  {
    Print("add new zone good");
  }
}
