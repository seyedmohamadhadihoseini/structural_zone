double BodyAverageSize(int period, int shift)
{
    double sum = 0;
    for (int i = shift; i < shift + period; ++i)
    {
        sum += myBody(i);
    }
    return sum / period;
}
double CandleAverageSize(int period, int shift)
{
    double sum = 0;
    for (int i = shift; i < shift + period; ++i)
    {
        sum += myAll(i);
    }
    return sum / period;
}
bool isHighest(int shift)
{
    double high = myHigh(shift);
    double preHigh = myHigh(shift + 1);
    double nextHigh = myHigh(shift - 1);
    return high > preHigh && high > nextHigh;
}
bool isLowest(int shift)
{
    double low = myLow(shift);
    double preLow = myLow(shift + 1);
    double nextLow = myLow(shift - 1);
    return low < preLow && low < nextLow;
}