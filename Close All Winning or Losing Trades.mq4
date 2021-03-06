//+------------------------------------------------------------------+
//|                                                       Closed WIN |
//|                                Copyright © 2016 (Mike eXplosion) |
//+------------------------------------------------------------------+

#property copyright "Copyright © 2016 (Mike eXplosion)"
#property link      "https://www.mql5.com/en/users/mike_explosion"
#property version   "1.0"
#property strict
#property description "Cierre de posiciones ganadoras."
#property show_inputs

extern string Indicator       = "Closed All/Winners/Losers";
extern bool   Close_All  =false;
bool   Buy             =true;
bool   Sell            =true;
extern bool   Only_Winners  =true;
extern bool   Only_Losers =false;
//+------------------------------------------------------------------+
//| script program start function                                    |
//+------------------------------------------------------------------+
int start()
  {
///
   double total;
   int cnt;
   while(Close_All==true &&OrdersTotal()>0)
   {
   total = OrdersTotal();
   for (cnt = total-1; cnt >=0 ; cnt--)
   {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)) 
      {
         switch(OrderType())
         {
            case OP_BUY       :
            OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,Violet);break;
            case OP_SELL      :
            OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),3,Violet); break;
         }             
      }
      }
   }
////
   int ticket;
   if(OrdersTotal()==0) return(0);
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         if(Only_Winners==true && OrderProfit()<0) continue;
         if(Only_Losers==true && OrderProfit()>0) continue;
         if(OrderType()==0 && Buy==true)
           {

            ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_BID),3,Red);
            if(ticket==-1) Print("Error: ",GetLastError());
            if(ticket>0) Print("Posición ",OrderTicket()," cerrada.");
           }
         if(OrderType()==1 && Sell==true)
           {

            ticket=OrderClose(OrderTicket(),OrderLots(),MarketInfo(OrderSymbol(),MODE_ASK),3,Red);
            if(ticket==-1) Print("Error: ",GetLastError());
            if(ticket>0) Print("Posición ",OrderTicket()," cerrada.");
           }
        }
     }
   return(0);
  }
 