
bool CheckForNewTradeAndTradeIt(int shift)
{
    for (int i = 0; i < AllZones.length; ++i)
    {
        if (!AllZones.arr[i].isEnable || AllZones.arr[i].isMainZone)
        {
            continue;
        }
        Zone zone = AllZones.arr[i];
        if (zone.step == 0)
        {
            if (zone.time == myTime(shift))
            {
                continue;
            }
            double xHigh = myHigh(0);
            double xLow = myLow(shift);
            double x = iHigh(Symbol(), Period(), 0);
            bool isCrossedZone = zone.IsCrossed(xHigh, xLow);

            if (isCrossedZone)
            {
                AllZones.arr[i].step = 1;
                AllZones.arr[i].firstCrossShift = myTime(shift);
            }
        }
        else
        {
            if (myTime(shift) > AllZones.arr[i].firstCrossShift)
            {
                bool isReverseMarket = (zone.isBullish && mySide(shift + 1) > 0) || (!zone.isBullish && mySide(shift + 1) < 0);
                if (isReverseMarket)
                {
                    AllZones.arr[i].Remove();
                    continue;
                }
            }
            Zone mZone;
            if (findNearMainZones(zone.isBullish ? myBid() : myAsk(), zone, mZone, shift))
            {
                if (isOccurSetupInLowTime(zone, mZone,zone.crossTime))
                {
                    Print("i want to take trader");
                    int cmd = 1;
                    double sl = mZone.high;
                    if (zone.isBullish)
                    {
                        cmd = 0;
                        sl = mZone.low;
                    }
                    OpenPosition(cmd, sl);
                    AllZones.arr[i].Remove();
                }
            }
        }
    }
    return true;
}

int findNearMainZones(double price, Zone &liquid, Zone &mainZone, int shift)
{
    int index = liquid.mainZoneIndex;
    if (index != -1)
    {
        Zone zone = AllZones.arr[index];
        if (!zone.IsCrossed(myHigh(shift), myLow(shift)))
        {
            mainZone = zone;
            return true;
        }
    }
    index = -1;
    for (int i = 0; i < AllZones.length; i++)
    {
        Zone zone = AllZones.arr[i];
        if (zone.isEnable && zone.isMainZone && zone.isBullish == liquid.isBullish)
        {
            if ((zone.isBullish && zone.low <= liquid.low) || ((!zone.isBullish) && zone.high >= liquid.high))
            {
                if (price <= zone.high && price >= zone.low)
                {
                    index = i;
                    liquid.crossTime = myTime(i, lowTimeframe);
                    liquid.mainZoneIndex = i;
                    break;
                }
            }
        }
    }
    if (index == -1)
    {
        return false;
    }
    mainZone = AllZones.arr[index];
    return true;
}