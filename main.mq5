#property copyright "developerseyed@gmail.com";
#property link "https://www.hadi.s4r4.com";
#property version "1.00";
#include "./defintion/index.mq5";
#include "./helper.mq5";
#include "./graphic/index.mq5";
#include "./zone/index.mq5";
int NameCounter = 0;
enum ZoneType
{
  shadow,
  sharp,
  shadowBack
};
input ZoneType zone_type = shadow;
input datetime start_date = (datetime) "2024-11-22 16:00:00";
Candle CurrentCandle;
Zone CurrentZone;
int OnInit()
{
  int firstShift = findIndexOfDate(start_date);
  CurrentCandle.Init(firstShift);
  Print(firstShift);
  for (int i = firstShift; i >= 0 ; i--)
  {
    if (zone_type == shadow)
    { 
      ShadowZone(i,CurrentCandle);
    }
    else if (zone_type == sharp)
    {
      SharpZone(i);
    }
    else
    {
      ShadowBackZone(i);
    }
  }
  Print(NameCounter);
  return (INIT_SUCCEEDED);
}
void OnDeinit(const int reason)
{
  for (int i = 0; i <= NameCounter; ++i)
  {
    RectangleDelete(0, "rec" + (string)i);
  }
}
void OnTick()
{
}
