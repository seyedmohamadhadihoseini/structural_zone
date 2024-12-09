bool CheckEntry2(Zone &mainZone, int zoneZoneIndex)
{
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
    if (zone_zone.time[0] == myTime(0))
    {
        return false;
    }
    if (zone_zone.step[0] == 0)
    {
        FindMin(mainZone,zoneZoneIndex,0 ,0);
    }
    else if (zone_zone.step[0] == 1)
    {
        FindMax(mainZone,zoneZoneIndex,0, 1);
    }
    else if (zone_zone.step[0] == 2)
    {
        FindMin(mainZone,zoneZoneIndex,0, 2);
    }
    else if (zone_zone.step[0] == 3)
    {
        FindMax(mainZone,zoneZoneIndex,0, 3);
        Zone_Zone temp = AllZone_Zones.arr[zoneZoneIndex];
        if (temp.values[0][0] > temp.values[0][2] && temp.values[0][3] > temp.values[0][1])
        {
            if(price <= temp.values[0][1]){
                return true;
            }
        }
    }
    return false;
}