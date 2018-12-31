rand('state',0);
numberOfDay = 20;
numberOfPaperBuysSet = [20 ; 30 ; 40 ; 50 ; 60 ; 70 ; 80 ; 90 ; 100];
totalProfitSet = [];

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
disp(Table1);
disp(Table2);
    
for a=1:length(numberOfPaperBuysSet)
    numberOfPaperBuys = numberOfPaperBuysSet(a);
    
    %Table2.Demand;

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
                tempNewsTyp = TypeOfNewsDayT1(j);
                break;
            end
        end
        TypeOfNewsDay = [TypeOfNewsDay ; tempNewsTyp];
    
        tempRD4Demand = randi(100);
        RD4Demand = [RD4Demand ; tempRD4Demand];
    
        if tempNewsTyp == Good
            for j=1:length(GoodLimitsT2)
                if (RD4Demand(i)<=GoodLimitsT2(j))
                     tempDmnd = DemandT2(j);
                     break;
                end
            end
        elseif (tempNewsTyp == Fair)
            for j=1:length(FairLimitsT2)
                if (RD4Demand(i)<=GoodLimitsT2(j))
                     tempDmnd = DemandT2(j);
                     break;
                end
            end
        else
            for j=1:length(PoorLimitsT2)
                if (RD4Demand(i)<=PoorLimitsT2(j))
                    tempDmnd = DemandT2(j);
                    break;
                end
            end
        end
        Demand = [Demand ; tempDmnd];
        
        tempRevFromSales = tempDmnd*.5;
        RevFromSales = [RevFromSales ; tempRevFromSales];
        
        tempLossProfit = 0;
        if tempDmnd>numberOfPaperBuys
           tempLossProfit = (temp - numberOfPaperBuys)*0.17;
        end
        LossProfit = [LossProfit ; tempLossProfit];
        
        tempSlavageScrp = 0;
        if temp<numberOfPaperBuys
           tempSlavageScrp = (numberOfPaperBuys-temp)*0.05;
        end
        SlavageScrp = [SlavageScrp ; tempSlavageScrp];
    
        CostOfNewsPaper = numberOfPaperBuys*0.33;
        tempProfit = tempRevFromSales - tempLossProfit - CostOfNewsPaper + tempSlavageScrp ;
        Profit = [Profit ; tempProfit];
    end
    fprintf("numberOfPaperBuys= %d\n",numberOfPaperBuys);
    Table3 = table(Day,RN4TypeOfNews,TypeOfNewsDay,RD4Demand,Demand,RevFromSales,LossProfit,SlavageScrp,Profit);
    disp(Table3);
    totalProfitSet = [totalProfitSet ; sum(Profit)];
    fprintf("___________________________________\n");
end
Table4 = table(numberOfPaperBuysSet,totalProfitSet);
disp(Table4);

plot(transpose(numberOfPaperBuysSet),transpose(totalProfitSet));
xlabel('number Of Paper Buys');
ylabel('total Profit');