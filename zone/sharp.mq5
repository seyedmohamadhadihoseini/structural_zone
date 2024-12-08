// void SharpZone(int shift)
// {
//     double averages = BodyAverageSize(14, shift + 1);
//     color side = clrRed;
//     if (mySide(shift) == 1)
//     {
//         side = clrGreen;
//     }
//     if (myBody(shift) >= 2.5 * averages)
//     {
//         RectangleCreate(0, "rec" + (string)NameCounter, 0, myTime(shift + 1), myOpen(shift + 1), myTime(shift - 5), myClose(shift + 1), side);
//         NameCounter++;
//     }
// }
int FindSharpExtermum(int start, int end, bool isMinest)
{
    // find most ext big sharp candle.
    int index = -1;
    double value = 99999999;

    if (isMinest)
    {
        for (int i = start; i >= end; i--)
        {
            if (myAll(i) > CandleAverageSize(sharpPeriod, i + 1) * sharpFactor)
            {
                if (myLow(i) < value && mySide(i) > 0)
                {
                    value = myLow(i);
                    index = i;
                }
            }
        }
    }
    else
    {
        value = 0;
        for (int i = start; i >= end; i--)
        {
            if (myAll(i) > CandleAverageSize(sharpPeriod, i + 1) * sharpFactor)
            {
                if (myHigh(i) > value && mySide(i) < 0)
                {
                    value = myHigh(i);
                    index = i;
                }
            }
        }
    }

    return index;
}
bool FindSharpZone(datetime startTime, datetime endTime, bool isBullish, Zone &zone)
{
    int start = findIndexOfDate(startTime);
    int end = findIndexOfDate(endTime);
    int shift = FindSharpExtermum(start - 1, end + 1, isBullish);
    if(shift == -1){
        return false;
    }
    zone.Init(myHigh(shift + 1), myLow(shift + 1), isBullish, myTime(shift + 1), true);
    return true;
}