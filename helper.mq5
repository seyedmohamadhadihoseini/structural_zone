
double myHigh(int shift,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    return iHigh(_Symbol, period, shift);
}

double myLow(int shift,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    return iLow(_Symbol, period, shift);
}
double myOpen(int shift,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    return iOpen(_Symbol, period, shift);
}
double myClose(int shift,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    return iClose(_Symbol, period, shift);
}
double myPrice(bool isAsk){
    if(isAsk){
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
double myAll(int shift){
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
datetime myTime(int shift,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    return iTime(_Symbol, period, shift);
}
double myBid(){
    return SymbolInfoDouble(Symbol(),SYMBOL_BID);
}
double myAsk(){
    return SymbolInfoDouble(Symbol(),SYMBOL_ASK);
}
int findIndexOfDate(datetime date,ENUM_TIMEFRAMES period=PERIOD_CURRENT)
{
    int index = Bars(Symbol(), period, date, myTime(0));

    return index - 1;
}
