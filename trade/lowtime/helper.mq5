void FindMin(Zone &mainZone,int zoneZoneIndex,int entryIndex, int valueIndex)
{
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];
    if ((isBullish && price <= mainZone.high) || (!isBullish && price >= mainZone.low))
    {
        AllZone_Zones.arr[zoneZoneIndex].values[entryIndex][valueIndex] = myExt(zone_zone.values[entryIndex][valueIndex], price, !isBullish);
        AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] = valueIndex + 1;
    }
    else if ((isBullish && price > mainZone.high) || (!isBullish && price < mainZone.low))
    {
        if (AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] == (valueIndex + 1))
        {
            AllZone_Zones.arr[zoneZoneIndex].step[entryIndex] = valueIndex + 1;
            zone_zone.time[entryIndex] = myTime(0);
        }
    }
}
void FindMax(Zone &mainZone,int zoneZoneIndex,int entryIndex, int valueIndex)
{
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
        Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];

    if ((isBullish && price >= mainZone.high) || (!isBullish && price <= mainZone.low))
    {
        AllZone_Zones.arr[zoneZoneIndex].values[entryIndex][valueIndex] = myExt(zone_zone.values[entryIndex][valueIndex], price, isBullish);
        AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] = valueIndex+1;
    }
    else if ((isBullish && price < mainZone.high) || (!isBullish && price > mainZone.low))
    {
        if (AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] == valueIndex+1)
        {
            AllZone_Zones.arr[zoneZoneIndex].step[entryIndex] = valueIndex+1;
            zone_zone.time[entryIndex] = myTime(0);
        }
    }
}
