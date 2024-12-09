bool CheckEntry2(Zone &mainZone, int zoneZoneIndex)
{
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();

    if (zone_zone.step[1] == 0)
    {
        if (isBullish)
            FindMin(mainZone, zoneZoneIndex, 1, 0);
        else
            FindMax(mainZone, zoneZoneIndex, 1, 0);
    }
    else if (zone_zone.step[1] == 1)
    {
        if (isBullish)
            FindMax(mainZone, zoneZoneIndex, 1, 1);
        else
            FindMin(mainZone, zoneZoneIndex, 1, 1);
    }
    else if (zone_zone.step[1] == 2)
    {
        if (isBullish)
            FindMin(mainZone, zoneZoneIndex, 1, 2);
        else
            FindMax(mainZone, zoneZoneIndex, 1, 2);
    }
    else if (zone_zone.step[1] == 3)
    {
        Zone_Zone temp = AllZone_Zones.arr[zoneZoneIndex];
        if (isBullish)
        {
            if (temp.values[1][0] < temp.values[1][2] && temp.values[1][1] > mainZone.high)
            {
                if (price >= temp.values[1][1])
                {
                    return true;
                }
            }
        }
        else
        {
            if (temp.values[1][0] > temp.values[1][2] && temp.values[1][1] < mainZone.low)
            {
                if (price <= temp.values[1][1])
                {
                    return true;
                }
            }
        }
    }
    return false;
}