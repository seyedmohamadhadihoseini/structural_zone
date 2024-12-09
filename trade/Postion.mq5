#include <Trade\Trade.mqh>
CTrade myTrade;
bool OpenPosition(int cmd, double sl_price)
{
    ENUM_ORDER_TYPE tradeType = ORDER_TYPE_BUY;
    double price = myAsk();
    double tp = price + (trade_tp_pip * _Point * 10);
    if (cmd == 1)
    {
        tradeType = ORDER_TYPE_SELL;
        price = myBid();
        tp = price - (trade_tp_pip * _Point * 10);
    }
    myTrade.PositionOpen(_Symbol, tradeType, trade_volume, price, sl_price, tp, "ORDERD BY developerseyed@gmail.com");
    return true;
}