%rand('state',0);
StockLimitation = 11;
ReviewPeriod = 5;
daysLimit = 20;
tempEI  = 3 ;
tempBI = 0;
tempOQ = 8;
tempSQ = 0;

DaysT3 = [];

DemandT1 = [0 ; 1 ; 2 ; 3 ; 4];
RndAssignT1 = [10 ; 35 ; 70 ; 91 ; 100];
Table1 = table(DemandT1,RndAssignT1);

DemandT3 = [];
RN4DemandT3 = [];

for i=1:20
    tempRN4Demand = randi(100,1);
    RN4DemandT3 = [RN4DemandT3 ; tempRN4Demand];
    for j=1:length(RndAssignT1)
        if tempRN4Demand<=RndAssignT1(j)
            tempDemand = DemandT1(j);
            break;
        end
    end
    DemandT3 = [DemandT3 ; tempDemand];
end

LeadTimeT2 = [3 ; 1 ; 2];
LeadTimeRangeT2 = [0 ; 6 ; 9];
Table2 = table(LeadTimeT2,LeadTimeRangeT2);

BIT3 = [];
EIT3 = [];
SQT3 = [];
OQT3 = [];
RN4LDTimeT3 = [];
DaysUOAT3 = [];

countDUOA = 1;
d = 1;
days = 1;

for d=1:daysLimit
    DaysT3 = [DaysT3 ; days];
    %fprintf("%d, days = %d",d,days);
    
    % Finding the BI %
    tempBI = tempEI;
    if (countDUOA == -1)
        tempBI = tempBI + tempOQ;
        countDUOA = '-';
    end
    BIT3  = [BIT3 ; tempBI];
    %fprintf(" BI=%d",tempBI);
    
    % Finding the demand %
    tempDemand = DemandT3(d);
    %fprintf(" DE=%d",tempDemand);
    
    % Finding EI and SQ %
    if tempBI>=(tempDemand+tempSQ)
            tempEI = (tempBI - tempDemand) - tempSQ;
            tempSQ = 0;
    end
    if tempBI<(tempDemand+tempSQ)
       tempSQ = tempSQ + (tempDemand - tempBI);
       tempEI = 0;
    end
    EIT3 =[EIT3 ; tempEI];
    SQT3 = [SQT3 ; tempSQ];
    %fprintf(" EI=%d, SQ=%d ",tempEI,tempSQ);
    
    % Generating OQ at review Periode and LeadTime%
    if days==5
        tempOQ = StockLimitation - tempEI;
        OQT3 = [OQT3  ; tempOQ];
        
        tempRN4LDTimeT3 = randi(9); 
        RN4LDTimeT3 = [RN4LDTimeT3 ; tempRN4LDTimeT3];
        
        for j=1:length(LeadTimeRangeT2)
            if tempRN4LDTimeT3<=LeadTimeRangeT2(j)
                countDUOA = LeadTimeT2(j);
                break;
            end
        end
        %fprintf("OQ=%d ,RN4LDTime=%d",tempOQ,tempRN4LDTimeT3); 
    else
        OQT3 = [OQT3 ; "-"];
        RN4LDTimeT3 = [RN4LDTimeT3 ; "-"];
        %fprintf(" OQ=%s ,RN4LDTime=%s,",'-','-'); 
    end
    
    % Iterating the LT untill order comes %
    if countDUOA ~= '-'
        DaysUOAT3 = [DaysUOAT3 ; countDUOA];
        %fprintf(" DUOA=%d\n",countDUOA);
        countDUOA = countDUOA - 1;
    else
        DaysUOAT3 = [DaysUOAT3 ; "-"];
        %fprintf(" DUOA=%s\n",'-');
    end
    
    % just for 1to5 reviewPeriode Looping %
    days = days + 1;
    if (days > ReviewPeriod)
        days = 1;
    end   
end

Table3 = table(DaysT3,BIT3,RN4DemandT3,DemandT3,EIT3,SQT3,OQT3,RN4LDTimeT3,DaysUOAT3);
disp(Table1);
disp(Table2);
disp(Table3);
fprintf("Average Ending Units In Inventory = %f\n",((sum(EIT3))/daysLimit));
count = 0;
for i=1:daysLimit
    if SQT3(i)~=0
        count = count + 1;
    end
end
fprintf("Average number of days when a Shortage Occurs = %f",(count/daysLimit));