bool isOccurSetupInLowTime(int shift, datetime crossTime, Zone &zone)
{
    int endIndex = findIndexOfDate(crossTime) + 1;
    ZoneArr zArr;
    int length = FindLastStructure(shift, endIndex, zArr);
    bool result = CheckEntryA(zone,zArr,length) || CheckEntryB(zone,zArr,length) || CheckEntryC(zone,zArr,length);
    if(result == true){
        Print("you did it");
    }
    return result;
};
bool CheckEntryA(Zone &zone, ZoneArr &zArr, int length)
{
    if (length == 4)
    {
        bool condition;
        if (zone.isBullish)
        {
            condition = zArr.arr[0].high > zArr.arr[2].high && zArr.arr[2].high > zone.high;
            condition &= zArr.arr[1].low < zArr.arr[3].low && zArr.arr[1].low < zone.high && zArr.arr[1].low >= zone.low;
        }
        else
        {
            condition = (zArr.arr[0].low < zArr.arr[2].low) && (zArr.arr[2].low < zone.low);
            condition &= (zArr.arr[1].high > zArr.arr[3].high) && (zArr.arr[1].high > zone.low) && (zArr.arr[1].high <= zone.high);
        }
        bool lastCondition = zone.isBullish && myBid() <= zArr.arr[2].high;
        lastCondition |= (!zone.isBullish) && myAsk() >= zArr.arr[2].low;
        condition &= lastCondition;
        return condition;
    }
    return false;
}
bool CheckEntryB(Zone &zone, ZoneArr &zArr, int length)
{
    if (length == 3)
    {
        bool condition;
        if (zone.isBullish)
        {
            condition = (zArr.arr[0].low > zArr.arr[2].low) && (zArr.arr[0].low <= zone.high);
            condition &= (zArr.arr[0].isBullish && (!zArr.arr[1].isBullish) && zArr.arr[2].isBullish);
            condition &= (zArr.arr[1].high > zArr.arr[0].low) && (zArr.arr[1].high > zone.high);
        }
        else
        {
            condition = (zArr.arr[0].high < zArr.arr[2].high) && (zArr.arr[0].high >= zone.low);
            condition &= ((!zArr.arr[0].isBullish) && (zArr.arr[1].isBullish) && (!zArr.arr[2].isBullish));
            condition &= (zArr.arr[1].low < zArr.arr[0].high) && (zArr.arr[1].low < zone.low);
        }
        bool lastCondition = zone.isBullish && myAsk() >= zArr.arr[1].high;
        lastCondition |= (!zone.isBullish) && myBid() <= zArr.arr[1].low;
        condition &= lastCondition;
        return condition;
    }
    return false;
}
bool CheckEntryC(Zone &zone, ZoneArr &zArr, int length)
{
    if (length == 4)
    {
        bool condition;
        if (zone.isBullish)
        {
            condition = (zArr.arr[0].high > zArr.arr[2].high) && (zArr.arr[2].high >= zone.high);
            condition &= ((!zArr.arr[0].isBullish) && (zArr.arr[1].isBullish) && (!zArr.arr[2].isBullish) && (zArr.arr[3].isBullish));
            condition &= (zArr.arr[1].low > zArr.arr[3].low) && (zArr.arr[1].low > zone.high);
        }
        else
        {
            condition = (zArr.arr[0].low < zArr.arr[2].low) && (zArr.arr[2].low <= zone.low);
            condition &= ((zArr.arr[0].isBullish) && (!zArr.arr[1].isBullish) && (zArr.arr[2].isBullish) && (!zArr.arr[3].isBullish));
            condition &= (zArr.arr[1].high < zArr.arr[3].high) && (zArr.arr[1].high < zone.low);
        }
        bool lastCondition = zone.isBullish && myBid() <= zArr.arr[1].low;
        lastCondition |= (!zone.isBullish) && myAsk() >= zArr.arr[1].high;
        condition &= lastCondition;
        return condition;
    }
    return false;
}
bool CheckEntry1(Zone &zone, int shift, int endIndex)
{
    int index = -1;
    int step = 0;
    double extValue = zone.isBullish ? 0 : 9999999;
    for (int i = endIndex; i >= shift; i--)
    {
        extValue = zone.isBullish ? MathMax(myHigh(i, lowTimeframe), extValue) : MathMin(myLow(i, lowTimeframe), extValue);
        bool cond = zone.isBullish && myLow(i, lowTimeframe) < myLow(endIndex, lowTimeframe);
        cond |= !zone.isBullish && myHigh(i, lowTimeframe) > myHigh(endIndex, lowTimeframe);

        bool cond2 = zone.isBullish && extValue > zone.high;
        cond2 |= !zone.isBullish && extValue < zone.low;

        if (cond && cond2)
        {
            index = i;
            step = 1;
            break;
        }
    }
    if (step == 0)
    {
        return false;
    }

    for (int i = index; i >= shift; --i)
    {
        bool cond = zone.isBullish && myHigh(i, lowTimeframe) > extValue;
        cond |= !zone.isBullish && myLow(i, lowTimeframe) < extValue;
        if (cond)
        {
            step = 2;
            break;
        }
    }
    if (step != 2)
    {
        return false;
    }
    bool result = zone.isBullish && myBid() <= extValue;
    result |= !zone.isBullish && myAsk() >= extValue;
    return result;
}
bool CheckEntry2(Zone &zone, int shift, int endIndex)
{
    int step = 0;
    int index = -1;
    double extValue = 0;
    for (int i = endIndex - 1; i > shift; --i)
    {
        extValue = MathMax(myHigh(i, lowTimeframe), extValue);
        if (myClose(i, lowTimeframe) < myOpen(i, lowTimeframe))
        {
            step = 1;
            index = i;
            break;
        }
    }
    if (step == 0)
    {
        return false;
    }
    for (int i = index; i >= shift; --i)
    {
        if (myLow(i, lowTimeframe) <= zone.high && myLow(i, lowTimeframe) > myLow(endIndex, lowTimeframe))
        {
            step = 2;
        }
        if (myLow(i, lowTimeframe) < myLow(endIndex, lowTimeframe))
        {
            step = -1;
        }
    }
    if (step != 2)
    {
        return false;
    }
    bool result = myAsk() >= extValue;
    return result;
}
bool CheckEntry3(int shift, ZoneArr &zArr, int length)
{

    return true;
}

int FindLastStructure(int startIndex, int endIndex, ZoneArr &zArr)
{

    int step = 0;
    int length = 0;
    // foreach candle by candle
    // if step is zero we look for
    for (int i = startIndex; i <= endIndex; i++)
    {
        bool isHighest = myHigh(i, lowTimeframe) >= myHigh(i + 1, lowTimeframe) && myHigh(i, lowTimeframe) >= myHigh(i - 1, lowTimeframe);
        bool isLowest = myLow(i, lowTimeframe) < myLow(i + 1, lowTimeframe) && myLow(i, lowTimeframe) <= myLow(i - 1, lowTimeframe);
        if (step == 0)
        {
            if (isHighest)
            {
                step = 1;
                Zone zone;
                zone.Init(myHigh(i, lowTimeframe), myHigh(i, lowTimeframe), false, myTime(i, lowTimeframe), true);
                zArr.arr[length] = zone;
                length += 1;
            }
            else if (isLowest)
            {
                step = 2;
                Zone zone;
                zone.Init(myLow(i, lowTimeframe), myLow(i, lowTimeframe), true, myTime(i, lowTimeframe), true);
                zArr.arr[length] = zone;
                length += 1;
            }
        }
        else if (step == 1)
        {
            if (isLowest)
            {
                step = 2;
                Zone zone;
                zone.Init(myLow(i, lowTimeframe), myLow(i, lowTimeframe), true, myTime(i, lowTimeframe), true);
                zArr.arr[length] = zone;
                length += 1;
            }
            else if (isHighest)
            {
                Zone zone;
                zone.Init(myHigh(i, lowTimeframe), myHigh(i, lowTimeframe), false, myTime(i, lowTimeframe), true);
                zArr.arr[length - 1] = zone;
            }
        }
        else if (step == 2)
        {
            if (isHighest)
            {
                step = 1;
                Zone zone;
                zone.Init(myHigh(i, lowTimeframe), myHigh(i, lowTimeframe), false, myTime(i, lowTimeframe), true);
                zArr.arr[length] = zone;
                length += 1;
            }
            else if (isLowest)
            {
                Zone zone;
                zone.Init(myLow(i, lowTimeframe), myLow(i, lowTimeframe), true, myTime(i, lowTimeframe), true);
                zArr.arr[length - 1] = zone;
            }
        }
    }
    return length;
}
