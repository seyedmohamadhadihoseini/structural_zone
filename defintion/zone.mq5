class Zone
{
private:
    /* data */
public:
    double high;
    double low;
    bool isBullish;
    datetime time;

    Zone(/* args */);
    void DrawZone(datetime time1, datetime time2);
    void Init(double _high, double _low, bool _isBullish, datetime _time);
    ~Zone();
};

Zone::Zone(/* args */)
{
}
void Zone::Init(double _high, double _low, bool _isBullish, datetime _time)
{
    high = _high;
    low = _low;
    isBullish = _isBullish;
    time = _time;
}
void Zone::DrawZone(datetime time1, datetime time2)
{
    color clr = clrRed;
    if (isBullish)
    {
        clr = clrGreen;
    }
    RectangleCreate(0, "rec" + (string)NameCounter, 0, time1, high, time2, low, clr);
    NameCounter++;
}
Zone::~Zone()
{
}
