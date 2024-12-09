#include "./helper.mq5";
#include "./entry1.mq5";
#include "./entry2.mq5";
#include "./entry3.mq5";
bool isOccurSetupInLowTime(Zone &liquid, Zone &mainZone)
{
    int zoneZoneIndex = AllZone_Zones.GetIndex(liquid.id, mainZone.id);
    if (zoneZoneIndex == -1)
    {
        zoneZoneIndex = AllZone_Zones.Set(liquid.id, mainZone.id);
        if (zoneZoneIndex == -1)
        {
            Print("memory fulled wait until its be free , made by zone_zone array");
            return false;
        }
    }

    bool result = CheckEntry1(mainZone,zoneZoneIndex);
    if (result == true)
    {
        Print("you did it");
    }
    return result;
};

