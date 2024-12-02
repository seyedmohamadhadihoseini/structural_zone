void SharpZone(int shift)
{
    double averages = BodyAverageSize(14, shift + 1);
    color side = clrRed;
    if (mySide(shift) == 1)
    {
        side = clrGreen;
    }
    if (myBody(shift) >= 2.5 * averages)
    {
        RectangleCreate(0, "rec" + (string)NameCounter, 0, myTime(shift + 1), myOpen(shift + 1), myTime(shift - 5), myClose(shift + 1), side);
        NameCounter++;
    }
}
