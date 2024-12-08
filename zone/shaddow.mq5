// void ShadowZone(int shift, Candle &candle)
// {
//     double high = myHigh(shift);
//     double low = myLow(shift);
//     Zone zone;
//     Zone liquid;
//     if (candle.isLowest)
//     {
//         if (low < candle.low)
//         {
//             int index = FindExtermum(findIndexOfDate(candle.time), shift, false);
//             zone.Init(myBodyUpper(index), myHigh(index), false, myTime(index));
//             zone.DrawZone(myTime(index), myTime(shift));
//             candle.Init(index);
//             candle.isHighest = true;
//             candle.isLowest = false;
//             Print("new low zone . shift:", shift, " and index=", index);
//         }
//         else
//         {

//             int target, liquidIndex;
//             bool result = FindExtermumWithSecondChance(target, liquidIndex, findIndexOfDate(candle.time), shift, false);
//             if (result)
//             {
//                 zone.Init(myBodyUpper(target), myHigh(target), false, myTime(target));
//                 zone.DrawZone(myTime(target), myTime(shift));
//                 liquid.Init(myBodyUpper(liquidIndex), myHigh(liquidIndex), false, myTime(liquidIndex));
//                 liquid.DrawZone(myTime(liquidIndex), myTime(shift));
//                 candle.Init(target);
//                 Print("new second chance low zone . shift:", shift);
//             }
//         }
//     }
//     else if (candle.isHighest)
//     {
//         if (high > candle.high)
//         {
//             int index = FindExtermum(findIndexOfDate(candle.time), shift, true);
//             zone.Init(myBodyLower(index), myLow(index), true, myTime(index));
//             zone.DrawZone(myTime(index), myTime(shift));
//             candle.Init(index);
//             candle.isHighest = true;
//             candle.isLowest = false;
//             Print("new  high zone . shift:", shift);
//         }
//         else
//         {
//             int target, liquidIndex;
//             bool result = FindExtermumWithSecondChance(target, liquidIndex, findIndexOfDate(candle.time), shift, true);
//             if (result)
//             {
//                 zone.Init(myBodyLower(target), myLow(target), true, myTime(target));
//                 zone.DrawZone(myTime(target), myTime(shift));
//                 liquid.Init(myBodyLower(liquidIndex), myLow(liquidIndex), true, myTime(liquidIndex));
//                 liquid.DrawZone(myTime(liquidIndex), myTime(shift));
//                 candle.Init(target);
//                 Print("new chance high zone . shift:", shift);
//             }
//         }
//     }
// }
int FindExtermum(int startIndex, int endIndex, bool isMinest)
{
    int index = -1;
    double value = 0;
    if (isMinest)
    {
        value = 9999999;
    }
    // Print("start index:",startIndex,"  end index:",endIndex);
    for (int i = startIndex; i >= endIndex; --i)
    {
        if (isMinest && myLow(i) < value)
        {
            value = myLow(i);
            index = i;
        }
        else if ((!isMinest) && myHigh(i) > value)
        {
            value = myHigh(i);
            index = i;
        }
    }
    return index;
}
// bool FindExtermumWithSecondChance(int &targetIndex, int &liquidIndex, int start, int end, bool isMin)
// {
//     bool result = false;
//     int index = FindExtermum(start, end, isMin);
//     if (index == -1)
//     {
//         return false;
//     }
//     int conditionCount = 0;
//     int liShift = 0;
//     for (int i = index - 1; i >= end; i--)
//     {
//         if (conditionCount == 0)
//         {
//             if (isMin && myClose(i) < myOpen(i))
//             {
//                 conditionCount++;
//                 liShift = i;
//             }
//             else if (!isMin && myClose(i) > myOpen(i))
//             {
//                 conditionCount++;
//                 liShift = i;
//             }
//         }
//         else
//         {
//             if (isMin && myClose(i) > myOpen(i))
//             {
//                 conditionCount++;
//                 break;
//             }
//             else if (!isMin && myClose(i) < myOpen(i))
//             {
//                 conditionCount++;
//                 break;
//             }
//         }
//     }
//     Print("index:", index, " condition count:", conditionCount, "   shift", end);
//     if (conditionCount < 2)
//     {
//         return false;
//     }
//     targetIndex = index;
//     liquidIndex = liShift;
//     return true;
// }

/**************************************************************************/
/**************************************************************************/
/**************************************************************************/
/**************************************************************************/
/**************************************************************************/

bool FindShadowZone(datetime startTime, datetime endTime, bool isBullish, Zone &zone)
{
    int start = findIndexOfDate(startTime);
    int end = findIndexOfDate(endTime);

    int shift = FindExtermum(start - 1, end + 1, isBullish);
    if(shift == -1){
        return false;
    }
    Candle bar;
    bar.Init(shift);
    if (isBullish)
    {
        zone.Init(myBodyLower(shift), myLow(shift), isBullish, myTime(shift), true);
    }
    else
    {
        zone.Init(myHigh(shift),myBodyUpper(shift), isBullish, myTime(shift), true);
    }

    return true;
}