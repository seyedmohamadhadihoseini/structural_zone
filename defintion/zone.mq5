
class Zone
{
private:
    /* data */
public:
    double high;
    double low;
    bool isBullish;
    datetime time;
    bool isEnable;
    bool isMainZone;
    string id;
    int step;
    int mainZoneIndex;
    datetime crossTime;
    datetime firstCrossShift;
    Zone(/* args */);
    void DrawZone(datetime time1, datetime time2);
    void Init(double _high, double _low, bool _isBullish, datetime _time, bool _isMainZone);
    bool IsCrossed(double candleHigh, double candleLow);
    void Remove();
    ~Zone();
};

Zone::Zone(/* args */)
{
    isEnable = false;
    step = 0;
    mainZoneIndex = -1;
    crossTime = 0;
    
}

void Zone::Init(double _high, double _low, bool _isBullish, datetime _time, bool _isMainZone)
{
    high = _high;
    low = _low;
    isBullish = _isBullish;
    time = _time;
    isMainZone = _isMainZone;
    isEnable = true;
    id = CreateRandomString();
}
void Zone::Remove()
{
    isEnable = false;
    RectangleDelete(0, "rec" + (string)id);
}
bool Zone::IsCrossed(double candleHigh, double candleLow)
{
    if (isBullish)
    {
        if (candleLow < low && candleHigh >= low)
        {
            return true;
        }
    }
    else
    {
        if (candleHigh > high && candleLow <= high)
        {
            return true;
        }
    }
    return false;
    return ((isBullish && (candleLow < low)) || (!isBullish && (candleHigh > high)));
}
void Zone::DrawZone(datetime time1, datetime time2)
{
    color clr = clrRed;
    if (!isMainZone)
    {
        clr = clrOrangeRed;
    }
    if (isBullish)
    {
        clr = clrGreen;
        if (!isMainZone)
        {
            clr = clrYellowGreen;
        }
    }
    datetime endDate = time2;
    if (time2 == 0)
    {
        // endDate = myTime(0) + (zoneRectangleWidth - extCandle.index) * Period() * 60;
        endDate = myTime(0) + (Period() * 10);
    }
    //  Print("in draw zone => time1:",time1," and its price:",high,"  time2:",time2,"  and its price:",low);
    RectangleCreate(0, "rec" + (string)id, 0, time1, high, endDate, low, clr);
    NameCounter++;
}
Zone::~Zone()
{
}

class ZoneArr
{
private:
    int FindEmptyIndex();

public:
    datetime lastDatetime;
    Zone arr[200];
    int length;
    ZoneArr(/* args */);
    void Set(Zone &zone);
    void RemoveZone(Zone &zone);
    bool isExist(Zone &time);
    bool isZoneOld(datetime time);
    ~ZoneArr();
};

ZoneArr::ZoneArr(/* args */)
{
    length = 200;
    lastDatetime = 0;
}
void ZoneArr::Set(Zone &zone)
{
    if (isExist(zone))
    {
        return;
    }
    int index = FindEmptyIndex();
    if (index < length)
    {
        arr[index] = zone;
        lastDatetime = zone.time;
    }
}
bool ZoneArr::isZoneOld(datetime time)
{
    return time < lastDatetime;
}
int ZoneArr::FindEmptyIndex()
{
    for (int i = 0; i < length; i++)
    {
        if (!arr[i].isEnable)
        {
            return i;
        }
    }
    return -1;
}

bool ZoneArr::isExist(Zone &zone)
{
    for (int i = 0; i < length; ++i)
    {
        if (zone.isEnable)
        {

            if (arr[i].time == zone.time && arr[i].high == zone.high && arr[i].low == zone.low)
            {
                return true;
            }
        }
    }
    return false;
}
void ZoneArr::RemoveZone(Zone &zone)
{
    for (int i = 0; i < length; ++i)
    {
        if (arr[i].time == zone.time)
        {
            arr[i].Remove();
            break;
        }
    }
}
ZoneArr::~ZoneArr()
{
}
