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
    bool isEanble ;
    Candle();
    void Init(int shift);
    ~Candle();
};
Candle::Candle()
{
    isEanble  = false;
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
    int x = 3;
    for(int i=shift-x;i<=shift+x;++i){
        if(myLow(i)< low){
            isLowest = false;
        }
        if(myHigh(i)>high){
            isHighest = false;
        }
    }
    isEanble  = true;
}
Candle::~Candle()
{
}
