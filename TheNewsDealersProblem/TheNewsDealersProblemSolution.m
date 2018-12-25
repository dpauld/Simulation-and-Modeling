rand('state',0);
Good = 1;
Fair = 2;
Poor = 3;
TypeOfNewsDayT1 = [Good ; Fair ; Poor];
RandomDigitAssignmentT1 = [35 ; 80 ; 100];
Table1 = table(TypeOfNewsDayT1,RandomDigitAssignmentT1);

DemandT2 = [40 ; 50 ; 60 ; 70 ; 80 ; 90 ; 100];
GoodLimitsT2 = [3 ; 8 ; 23 ; 43 ; 78 ; 93 ; 100];
FairLimitsT2 = [10 ; 28 ; 68 ; 88 ; 96 ; 100 ; 0];
PoorLimitsT2 = [44 ; 66 ; 82 ; 94 ; 100 ; 0 ; 0];

Table2 = table(DemandT2,GoodLimitsT2,FairLimitsT2,PoorLimitsT2);

%Table2.Demand;
numberOfDay = 20;
numberOfPaperBuys = 70;

Day = [];
RN4TypeOfNews = [];
TypeOfNewsDay = [];
RD4Demand = [];
Demand = [];
RevFromSales = [];
LossProfit = [];
SlavageScrp = [];
Profit = [];
for i=1:numberOfDay
    Day = [Day ; i];
    tempRN4TON = randi(100);
    RN4TypeOfNews = [RN4TypeOfNews ; tempRN4TON];
    for j=1:length(RandomDigitAssignmentT1)
        if tempRN4TON<=RandomDigitAssignmentT1(j)
            temp = TypeOfNewsDayT1(j);
            break;
        end
    end
    TypeOfNewsDay = [TypeOfNewsDay ; temp];
    
    tempRD4Demand = randi(100);
    RD4Demand = [RD4Demand ; tempRD4Demand];
    
    if temp == Good
        for j=1:length(GoodLimitsT2)
            if (RD4Demand(i)<=GoodLimitsT2(j))
                 temp = DemandT2(j);
                 break;
            end
        end
    elseif (temp == Fair)
        for j=1:length(FairLimitsT2)
            if (RD4Demand(i)<=GoodLimitsT2(j))
                 temp = DemandT2(j);
                 break;
            end
        end
    else
        for j=1:length(PoorLimitsT2)
            if (RD4Demand(i)<=PoorLimitsT2(j))
                temp = DemandT2(j);
                break;
            end
        end
    end
    Demand = [Demand ; temp];
    
    dummyRevFromSales = temp*.5;
    RevFromSales = [RevFromSales ; dummyRevFromSales];
    
    dummyLossProfit = 0;
    if temp>numberOfPaperBuys
       dummyLossProfit = (temp - numberOfPaperBuys)*0.17;
    end
    LossProfit = [LossProfit ; dummyLossProfit];
    
    dummySlavageScrp = 0;
    if temp<numberOfPaperBuys
       dummySlavageScrp = (numberOfPaperBuys-temp)*0.05;
    end
    SlavageScrp = [SlavageScrp ; dummySlavageScrp];
    
    CostOfNewsPaper = numberOfPaperBuys*0.33;
    dummyProfit = dummyRevFromSales - dummyLossProfit - CostOfNewsPaper + dummySlavageScrp ;
    Profit = [Profit ; dummyProfit];
end
disp(Day);
disp(RN4TypeOfNews);
disp(TypeOfNewsDay);
disp(RD4Demand);
disp(Demand);
disp(RevFromSales);
disp(LossProfit);
disp(SlavageScrp);
disp(Profit);
fprintf("\n");
for i=1:numberOfDay
  fprintf("%d %d %d %d %d %d %.2f %.2f %.2f\n",Day(i),RN4TypeOfNews(i),TypeOfNewsDay(i),RD4Demand(i),Demand(i),RevFromSales(i),LossProfit(i),SlavageScrp(i),Profit(i));
end
Table3 = table(Day,RN4TypeOfNews,TypeOfNewsDay,RD4Demand,Demand,RevFromSales,LossProfit,SlavageScrp,Profit);
disp(Table1);
disp(Table2);
disp(Table3);
disp(sum(Profit));