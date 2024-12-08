
void test()
{
    ZoneArr zArr;
    int length = FindLastStructure(0, 45, zArr);
    Print("the array is *************************");
    for (int i = 0; i < length; i++)
    {
        Zone zone = zArr.arr[i];
        if (zone.isBullish)
        {
            ArrowUpCreate(0, "up" + (string)++NameCounter, 0, zone.time, zone.high);
        }
        else
        {
            ArrowDownCreate(0, "down" + (string)++NameCounter, 0, zone.time, zone.high);
        }
        Print("value:", zArr.arr[i].high);
    }
    Print("******************");
}