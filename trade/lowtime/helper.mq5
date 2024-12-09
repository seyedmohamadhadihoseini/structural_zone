void FindMin(Zone &mainZone, int zoneZoneIndex, int entryIndex, int valueIndex)
{
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];
    if ((isBullish && price <= mainZone.high) || (!isBullish && price >= mainZone.low))
    {
        double preValue = zone_zone.values[entryIndex][valueIndex];
        double newValue = myExt(zone_zone.values[entryIndex][valueIndex], price, !isBullish);
        AllZone_Zones.arr[zoneZoneIndex].values[entryIndex][valueIndex] = newValue;
        AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] = valueIndex + 1;

        if (preValue != newValue)
        {
            AllZone_Zones.arr[zoneZoneIndex].time[entryIndex] = myTime(0, lowTimeframe);
        }
    }
    else if ((isBullish && price > mainZone.high) || (!isBullish && price < mainZone.low))
    {
        if (AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] == (valueIndex + 1))
        {
            if (myTime(0, lowTimeframe) != zone_zone.time[entryIndex])
            {
                AllZone_Zones.arr[zoneZoneIndex].step[entryIndex] = valueIndex + 1;
            }
        }
    }
}
void FindMax(Zone &mainZone, int zoneZoneIndex, int entryIndex, int valueIndex)
{
    bool isBullish = mainZone.isBullish;
    double price = isBullish ? myBid() : myAsk();
    Zone_Zone zone_zone = AllZone_Zones.arr[zoneZoneIndex];

    if ((isBullish && price >= mainZone.high) || (!isBullish && price <= mainZone.low))
    {
        double preVal = zone_zone.values[entryIndex][valueIndex];
        double newVal = myExt(zone_zone.values[entryIndex][valueIndex], price, isBullish);
        AllZone_Zones.arr[zoneZoneIndex].values[entryIndex][valueIndex] = newVal;
        AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] = valueIndex + 1;

        if (newVal != preVal)
        {
            AllZone_Zones.arr[zoneZoneIndex].time[entryIndex] = myTime(0, lowTimeframe);
        }
    }
    else if ((isBullish && price < mainZone.high) || (!isBullish && price > mainZone.low))
    {
        if (AllZone_Zones.arr[zoneZoneIndex].length[entryIndex] == valueIndex + 1)
        {
            if (myTime(0, lowTimeframe) != zone_zone.time[entryIndex])
            {
                AllZone_Zones.arr[zoneZoneIndex].step[entryIndex] = valueIndex + 1;
            }
        }
    }
}
