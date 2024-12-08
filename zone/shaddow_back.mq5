
void ShadowBackZone(int shift)
{
    double high = myHigh(shift);
    double low = myLow(shift);
    double averages = BodyAverageSize(14, shift + 1);
    if (high > myHigh(shift + 1) && high > myHigh(shift - 1))
    {
        if (high - MathMax(myOpen(shift), myClose(shift)) > 1.5 * averages)
        {
            int occureIndex = -1;
            for (int i = shift + 1; i < shift + 300; ++i)
            {
                if (myLow(i) <= high && myHigh(i) >= high)
                {
                    if (myBody(i) <= 1.5 * BodyAverageSize(14, i + 1))
                    {
                        occureIndex = i;
                        break;
                    }
                }
            }
            if (occureIndex != -1)
            {
                RectangleCreate(0, "rec" + (string)NameCounter, 0, myTime(occureIndex), myHigh(occureIndex), myTime(occureIndex - (occureIndex - shift + 1)), myLow(occureIndex), clrGreen);
                NameCounter++;
            }
        }
    }
    else if (low < myLow(shift + 1) && low < myLow(shift - 1))
    {
        if (MathMin(myOpen(shift), myClose(shift)) - low > 1.5 * averages)
        {
            int occureIndex = -1;
            for (int i = shift + 1; i < shift + 300; ++i)
            {
                if (myLow(i) <= low && myHigh(i) >= low)
                {
                    if (myBody(i) <= 1.5 * BodyAverageSize(14, i + 1))
                    {
                        occureIndex = i;
                        break;
                    }
                }
            }
            if (occureIndex != -1)
            {
                RectangleCreate(0, "rec" + (string)NameCounter, 0, myTime(occureIndex), myHigh(occureIndex), myTime(occureIndex - (occureIndex - shift + 1)), myLow(occureIndex), clrRed);
                NameCounter++;
            }
        }
    }
}
void HandleShadowBack(int shift)
{
    static ZoneArr zones;

    Zone newZone;
    if (findNewStructure(shift, newZone))
    {
        zones.Set(newZone);
    }
    for (int i = 0; i < zones.length; ++i)
    {
        if(!zones.arr[i].isEnable){
            continue;
        }
        if (zones.arr[i].isBullish)
        {
            if (myLow(shift + 1) < zones.arr[i].low && myHigh(shift) > zones.arr[i].high)
            {
                Zone zone;
                zone.Init(myHigh(shift), myLow(shift + 1), false, myTime(shift), false);
                zone.DrawZone(myTime(shift + 1), myTime(shift - 5));
                AllZones.Set(zone);
                zones.arr[i].isEnable = false;
            }
        }
        else if (myHigh(shift + 1) > zones.arr[i].high && myLow(shift) < zones.arr[i].low)
        {
            Zone zone;
            zone.Init(myHigh(shift + 1), myLow(shift), true, myTime(shift), false);
            zone.DrawZone(myTime(shift + 1), myTime(shift - 5));
            AllZones.Set(zone);
            zones.arr[i].isEnable = false;
        }
    }
}
bool findNewStructure(int shift, Zone &zone)
{
    bool result = false;
    static Candle preCandle;
    static int count = 0;
    static int step = 0;
    Candle bar;
    bar.Init(shift);

    if (bar.isHighest)
    {
        if (!preCandle.isEanble)
        {
            preCandle.Init(shift);

            step = 1;
        }
        else
        {
            bool condition = bar.high > preCandle.high;
            if (step == 2 && condition)
            {
                // ArrowUpCreate(0, "up" + (string)++count, 0, preCandle.time, preCandle.low - myAll(findIndexOfDate(preCandle.time)), ANCHOR_BOTTOM, clrGreen);
                zone.Init(preCandle.low, preCandle.low, true, preCandle.time, true);
                preCandle.Init(shift);
                step = 1;
                result = true;
            }
            else
            {
                if (bar.high > preCandle.high)
                {
                    preCandle.Init(shift);
                }
            }
        }
    }
    else if (bar.isLowest)
    {
        if (!preCandle.isEanble)
        {
            preCandle.Init(shift);
            step = 2;
        }
        else
        {
            bool condition = bar.low < preCandle.high;
            if (step == 1 && condition)
            {
                // ArrowDownCreate(0, "down" + (string)++count, 0, preCandle.time, preCandle.high + myAll(findIndexOfDate(preCandle.time)), ANCHOR_BOTTOM, clrRed);
                zone.Init(preCandle.high, preCandle.high, false, preCandle.time, true);
                preCandle.Init(shift);
                step = 2;
                result = true;
            }
            else
            {
                if (bar.low < preCandle.low)
                {
                    preCandle.Init(shift);
                }
            }
        }
    }
    ArrowCounter = count;
    return result;
}