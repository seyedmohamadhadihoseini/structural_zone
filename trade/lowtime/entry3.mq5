bool CheckEntry3(Zone &mainZone, datetime crossTime)
{
    int crossIndex = findIndexOfDate(crossTime, lowTimeframe);
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();

    double highsValue[2] = {0, 0};
    double lowsValue[2] = {0, 0};

    if (isBullish)
    {
        int count = 0;
        for (int i = crossIndex; i >= 0; --i)
        {
            if (isHighestInLow(i))
            {
                highsValue[count++] = myHigh(i, lowTimeframe);
            }
            if (count == 2)
            {
                break;
            }
        }
        count = 0;
        for (int i = crossIndex; i >= 0; --i)
        {
            if (isLowestInLow(i))
            {
                lowsValue[count++] = myLow(i, lowTimeframe);
            }
            if (count == 2)
            {
                break;
            }
        }
        bool condition = isBullish && (highsValue[1] > highsValue[0]) && (lowsValue[0] < mainZone.high) && (lowsValue[1] > mainZone.high) && (lowsValue[1] < highsValue[0]);
        condition |= (!isBullish) && (lowsValue[1] < lowsValue[0]) && (highsValue[0] > mainZone.low) && (highsValue[1] < mainZone.low) && (highsValue[1] > lowsValue[0]);

        return condition;
    }

    return false;
}
bool isHighestInLow(int shift)
{
    return (myHigh(shift, lowTimeframe) > myHigh(shift - 1, lowTimeframe)) && (myHigh(shift, lowTimeframe) > myHigh(shift + 1, lowTimeframe));
}
bool isLowestInLow(int shift)
{
    return (myLow(shift, lowTimeframe) < myLow(shift - 1, lowTimeframe)) && (myLow(shift, lowTimeframe) < myLow(shift + 1, lowTimeframe));
}