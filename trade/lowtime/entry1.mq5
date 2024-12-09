bool CheckEntry1(Zone &mainZone, int zoneZoneIndex)
{
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
    bool condition = zone_zone.lastTime != myTime(0, lowTimeframe);
    if (condition)
    {
        AllZone_Zones.arr[zoneZoneIndex].lastTime = myTime(0, lowTimeframe);
        AllZone_Zones.arr[zoneZoneIndex].count++;
    }
    return (AllZone_Zones.arr[zoneZoneIndex].count == 10);
    if (zone_zone.step[0] == 0)
    {
        if (isBullish)
            FindMin(mainZone, zoneZoneIndex, 0, 0);
        else
            FindMax(mainZone, zoneZoneIndex, 0, 0);
    }
    else if (zone_zone.step[0] == 1)
    {
        if (isBullish)
            FindMax(mainZone, zoneZoneIndex, 0, 1);
        else
            FindMin(mainZone, zoneZoneIndex, 0, 1);
    }
    else if (zone_zone.step[0] == 2)
    {
        if (isBullish)
            FindMin(mainZone, zoneZoneIndex, 0, 2);
        else
            FindMax(mainZone, zoneZoneIndex, 0, 2);
    }
    else if (zone_zone.step[0] == 3)
    {
        if (isBullish)
            FindMax(mainZone, zoneZoneIndex, 0, 3);
        else
            FindMin(mainZone, zoneZoneIndex, 0, 3);
        Zone_Zone temp = AllZone_Zones.arr[zoneZoneIndex];
        if (isBullish)
        {
            if (temp.values[0][0] > temp.values[0][2] && temp.values[0][3] > temp.values[0][1])
            {
                if (price <= temp.values[0][1])
                {
                    return true;
                }
            }
        }
        else
        {
            if (temp.values[0][0] < temp.values[0][2] && temp.values[0][3] < temp.values[0][1])
            {
                if (price >= temp.values[0][1])
                {
                    return true;
                }
            }
        }
    }
    return false;
}