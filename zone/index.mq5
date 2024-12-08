#include "./shaddow.mq5";
#include "./shaddow_back.mq5";
#include "./sharp.mq5";
#include "./helper.mq5";

void HandleNewZones(int shift)
{
    Candle bar;
    bar.Init(shift);
    if (zType == shadowBack)
    {
        HandleShadowBack(shift);
        return;
    }

    for (int i = 0; i < AllZones.length; ++i)
    {
        Zone zone = AllZones.arr[i];
        if (!zone.isEnable || !zone.isMainZone)
        {
            continue;
        }

        Zone zones[2];
        if (zType == sharp)
        {
            bool isZone2 = FindSharpZone(zone.time, bar.time, !zone.isBullish, zones[0]);
        }
        else
        {
            bool isZone1 = FindShadowZone(zone.time, bar.time, !zone.isBullish, zones[0]);
        }
        int x = 1;
        if (zone.IsCrossed(bar.high, bar.low))
        {
            for (int j = 0; j < x; ++j)
            {

                if (AllZones.isExist(zones[j]) || zones[j].time <= zone.time)
                {
                    continue;
                }
                // Print("zone is crossed in time:", myTime(shift), " zone crossed:", zone.time, " new zone:", zones[j].time);
                // Print("high:", bar.high, " zone high:", zone.high, " zone low:", zone.low);
                zones[j].DrawZone(zones[j].time, bar.time);
                AllZones.Set(zones[j]);
                zone.isEnable = false;
                AllZones.RemoveZone(zone);
            }
            // remove old + find new zones + display zones + add new zones to array
        }
        else
        {
            for (int j = 0; j < x; ++j)
            {
                Zone liquid;
                bool result = checkConditionForNewZone(zones[j].time, bar.time, zones[j].isBullish, zones[j], liquid);
                if (result)
                {
                    if (AllZones.isExist(zones[j]) || AllZones.isZoneOld(zones[j].time))
                    {
                        continue;
                    }
                    //  Print("second chance ; in time :", myTime(shift), "  and zone in :", zone.time, " new zone:", zones[j].time);

                    zones[j].DrawZone(zones[j].time, bar.time);
                    AllZones.Set(zones[j]);
                    liquid.DrawZone(liquid.time, myTime(findIndexOfDate(liquid.time) - 4));
                    AllZones.Set(liquid);
                }
            }

            //  find new zones => check for condition : if true => display zones + add new zones to array
        }
    }
}
bool checkConditionForNewZone(datetime startTime, datetime endTime, bool isBullish, Zone &main, Zone &liquid)
{
    int start = findIndexOfDate(startTime) - 1;
    int end = findIndexOfDate(endTime);
    int step = 0;
    int index = -1;
    double value = 0;
    for (int i = start; i >= end; --i)
    {
        if (step == 0)
        {
            if (isBullish && mySide(i) < 0)
            {
                step = 1;
                value = myHigh(i);
            }
            else if (!isBullish && mySide(i) > 0)
            {
                step = 1;
                value = myLow(i);
            }
        }
        else if (step == 1)
        {
            if (isBullish && myHigh(i) > value && myLow(i) > main.low)
            {
                step = 2;
                index = i;
                break;
            }
            else if (!isBullish && myLow(i) < value && myHigh(i) < main.high)
            {
                step = 2;
                index = i;
                break;
            }
        }
    }
    if (step != 2)
    {
        return false;
    }
    liquid.Init(myBodyUpper(index), myBodyLower(index), isBullish, myTime(index), false);
    return true;
}
void RemoveCrossedZone(bool isMainZone)
{
    for (int i = 0; i < AllZones.length; i++)
    {
        Zone zone = AllZones.arr[i];
        if (zone.IsCrossed(myHigh(0), myLow(0)))
        {
            if (zone.isMainZone == isMainZone)
            {
                AllZones.arr[i].isEnable = false;
            }
        }
    }
}
/*

1-array of zone

2-zone has field isenable

foreach  zones
  if cross zone
     zone is disable
     check for duplicate zone
     new zones active =>  add new zones

  if price movement
     check for duplicate zone
     new zones active => add new zones

we have ONE array => 1-main zone 2-liquid zone => can be property


find new zone => 1-shadow 2-sharp




*/