
double myHigh(int shift)
{
    return iHigh(_Symbol, PERIOD_CURRENT, shift);
}

double myLow(int shift)
{
    return iLow(_Symbol, PERIOD_CURRENT, shift);
}
double myOpen(int shift)
{
    return iOpen(_Symbol, PERIOD_CURRENT, shift);
}
double myClose(int shift)
{
    return iClose(_Symbol, PERIOD_CURRENT, shift);
}
double myBodyLower(int shift)
{
    double close = myClose(shift);
    double open = myClose(shift);

    return MathMin(open, close);
}
double myBodyUpper(int shift)
{

    double close = myClose(shift);
    double open = myClose(shift);

    return MathMax(open, close);
}
double myBody(int shift)
{
    return MathAbs(myClose(shift) - myOpen(shift));
}

double mySide(int shift)
{
    if (myClose(shift) > myOpen(shift))
    {
        return 1;
    }
    else if (myClose(shift) < myOpen(shift))
    {
        return -1;
    }
    else
    {
        return 0;
    }
}
datetime myTime(int shift)
{
    return iTime(_Symbol, PERIOD_CURRENT, shift);
}
int findIndexOfDate(datetime date)
{
    int index = Bars(Symbol(), PERIOD_CURRENT, date, myTime(0));

    return index - 1;
}