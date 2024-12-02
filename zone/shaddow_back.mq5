
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
