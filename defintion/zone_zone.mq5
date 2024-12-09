class Zone_Zone
{
private:
public:
    string fromZoneId;
    string toZoneId;
    double values[3][5];
    datetime time[3];
    int step[3];
    int length[3];
    bool isEnable;
    datetime lastTime;
    int count ;
    Zone_Zone(/* args */);
    ~Zone_Zone();
};

Zone_Zone::Zone_Zone(/* args */)
{
    isEnable = false;
    count = 0;
    lastTime = 0;
    for (int i = 0; i < 3; i++)
    {
        step[i] = 0;
        length[i] = 0;
        time[i] =0;
    }
    for (int i = 0; i < 5; i++)
    {
        for(int j=0;j<3;j++){
            values[j][i] = 0;
        }
    }
}

Zone_Zone::~Zone_Zone()
{
}
class Zone_ZoneArr
{
private:
public:
    Zone_Zone arr[200];
    int length;
    Zone_ZoneArr(/* args */);
    int Set(string fromId, string toId);
    void Remove(string id);
    int GetIndex(string fromId, string toId);
    ~Zone_ZoneArr();
};

Zone_ZoneArr::Zone_ZoneArr(/* args */)
{
    length = 200;
}
int Zone_ZoneArr::GetIndex(string fromId, string toId)
{
    int index = -1;
    for (int i = 0; i < length; ++i)
    {
        if (arr[i].isEnable)
        {
            if (arr[i].fromZoneId == fromId && arr[i].toZoneId == toId)
            {
                index = i;
            }
        }
    }

    return index;
}
void Zone_ZoneArr::Remove(string id)
{
    for (int i = 0; i < length; i++)
    {
        if (arr[i].fromZoneId == id || arr[i].toZoneId == id)
        {
            arr[i].isEnable = false;
            break;
        }
    }
}
int Zone_ZoneArr::Set(string fromId, string toId)
{
    int index = -1;
    for (int i = 0; i < length; i++)
    {
        if (!arr[i].isEnable)
        {
            Zone_Zone temp;
            temp.fromZoneId = fromId;
            temp.toZoneId = toId;
            temp.isEnable = true;
            arr[i] = temp;
            index = i;
            break;
        }
    }
    return index;
}
Zone_ZoneArr::~Zone_ZoneArr()
{
}
