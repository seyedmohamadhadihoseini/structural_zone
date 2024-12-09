
double myHigh(int shift, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    if (period == PERIOD_CURRENT)
    {
        period = Period();
    }
    return iHigh(_Symbol, period, shift);
}

double myLow(int shift, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    return iLow(_Symbol, period, shift);
}
double myOpen(int shift, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    return iOpen(_Symbol, period, shift);
}
double myClose(int shift, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    return iClose(_Symbol, period, shift);
}
double myPrice(bool isAsk)
{
    if (isAsk)
    {
        return myAsk();
    }
    return myBid();
}
double myBodyLower(int shift)
{
    double close = myClose(shift);
    double open = myOpen(shift);

    return MathMin(open, close);
}
double myBodyUpper(int shift)
{

    double close = myClose(shift);
    double open = myOpen(shift);

    return MathMax(open, close);
}
double myBody(int shift)
{
    return MathAbs(myClose(shift) - myOpen(shift));
}
double myAll(int shift)
{
    return myHigh(shift) - myLow(shift);
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
double myExt(double price1, double price2, bool isMax = true)
{
    double result = MathMin(price2, price1);
    if (price1 == 0)
    {
        result = price2;
    }
    else if (price2 == 0)
    {
        result = price1;
    }
    else if (isMax)
    {
        result = MathMax(price1, price2);
    }
    return result;
}
datetime myTime(int shift, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    return iTime(_Symbol, period, shift);
}
double myBid()
{
    return SymbolInfoDouble(Symbol(), SYMBOL_BID);
}
double myAsk()
{
    return SymbolInfoDouble(Symbol(), SYMBOL_ASK);
}
int findIndexOfDate(datetime date, ENUM_TIMEFRAMES period = PERIOD_CURRENT)
{
    int index = Bars(Symbol(), period, date, myTime(0));

    return index - 1;
}
string CreateRandomString(int length = 50)
{
    string chars[63] = {"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "l", "k", "j", "h", "g", "f", "d", "s", "a", "z", "x", "c", "v", "b", "n", "m", "A", "S", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "K", "J", "H", "G", "F", "D", "D", "S", "A", "A", "Z", "X", "C", "V", "B", "N", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
    string result = "";
    for (int i = 0; i < length; ++i)
    {
        int index = MathRand() % 63;
        result = result + (string)chars[index];
    }
    return result;
}