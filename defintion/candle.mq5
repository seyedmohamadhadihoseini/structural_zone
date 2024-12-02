class Candle
{
private:
public:
    double high;
    double low;
    double open;
    double close;
    datetime time;
    bool isHighest;
    bool isLowest;
    Candle();
    void Init(int shift);
    ~Candle();
};
Candle::Candle()
{
}
void Candle::Init(int shift)
{
    high = myHigh(shift);
    low = myLow(shift);
    open = myOpen(shift);
    close = myClose(shift);
    time = myTime(shift);
    isLowest = (myLow(shift) < myLow(shift + 1)) && (myLow(shift) < myLow(shift - 1));
    isHighest = (myHigh(shift) > myHigh(shift + 1)) && (myHigh(shift) > myHigh(shift - 1));
}
Candle::~Candle()
{
}
