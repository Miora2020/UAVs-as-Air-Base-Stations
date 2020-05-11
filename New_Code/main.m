
%***************       personal information   *************************************************
%
%
%             %Name             : Lefteris
%             %SurName          : Tsiphs
%             %UserName         : icsdm418006
%             %Email            : icsdm418006@icsd.aegean.gr
%             %Project          : " LTE-Α and Machine Learning : K-means "    
%
%************************************************************************************************




clear all
clc


%*****************************   global variables  ********************************************


REPerB=84*2;%resource elements per resourse block
Category=[1,2,3];% 1:urban, 2:suburban,3:rural
F_HATA=1500;%MHz
NoiceFigure=10; %dB
BI=15;
NoisePower= -174 +10*log10(180*10^3)+NoiceFigure+BI;
SINRmin=-9.3;%d
Lbody=3;%dB body loss
Lbpl=18;%dB building penetration loss
Lj=2;%jumber loos
Ga=5;% gain 


%***************************** end  global variables  ******************************************







%***************************** configuration of MeNB   ******************************************

MeNB(1).x=500;% x coordinate
MeNB(1).y=500;% y coordinate
MeNB(1).ChannelBandwidth=20;%MHz
MeNB(1).carrier=1.8*10^9;%MHz
MeNB(1).takeBitPerMilisec=100000;%MHz
MeNB(1).powerTransmit=45;  %dBm
MeNB(1).height=100; %metres

for i=1:20
MeNB(1).UEdata(i)=0;%MHz  
end

MaxPathLoss=Calculate_MaxPathLoss(MeNB(1).powerTransmit,NoisePower,SINRmin);%Max Path Loss 

%*****************************  End configuration of MeNB   ******************************************







%*****************************   configuration of  20-UEs %*****************************************
%                              Here we locate the Ues In the Grid



for i=1:50

   UE(i).x=400;% x coordinate
   UE(i).y=500;% y coordinate
   UE(i).height=1.7;
   UserLocationX(i)= 0;
   UserLocationY(i)= 0;
   UserLocationZ(i)= 0;
     
 end

i=1
 x=400;% x coordinate
 y=500
while i<51
    x=randi(1000, 1, 1);
    y=randi(1000, 1, 1);
  if (x<400 || x>500) && (y<400 || y>500)
   UE(i).x=x;% x coordinate
   UE(i).y=y;% y coordinate
   UserLocationX(i)= UE(i).x;
   UserLocationY(i)= UE(i).y;
   UserLocationZ(i)= 1.7;
   i=i+1;
 end
end

%*****************************  End  configuration of  20-UEs %*****************************************





%*****************************  scatter plot of  UEs and ENB %*****************************************

figure('Color', 'white')
plot(UserLocationX, UserLocationY, '^', 'MarkerSize', 5, 'LineWidth', 3), hold on
BaseStationX = 500;
BaseStationY = 500;
plot(BaseStationX, BaseStationY, 'rs', 'MarkerSize', 5, 'LineWidth', 4), hold on, grid on, grid minor
hleg = legend('User Location', 'Base Station');
set(hleg, 'Location', 'NorthEastOutside');
xlabel('coordinate Χ');
ylabel('coordinate Υ');
 

 
%***************************** End  scatter plot of  UEs and ENB %*****************************************
 
 





%*****************************   initialization phase of UEs        *****************************************
% Here we calculate some parameters of the UEs before they moving(PL,SINR,CQI,Max throughput, max resurceBlock that the UE xan take )


    for i=1:50

        UE(i).distancefrom_eNB_m(1)=round(Distance(MeNB(1).x,MeNB(1).y,UE(i).x,UE(i).y));%calculate  distance   between each UE ad eNB  
        UE(i).PL_dB(1) =(HATA_Model((UE(i).distancefrom_eNB_m(1)/1000),F_HATA(1),MeNB(1).height, UE(i).height,Category(2)))+Lbody+Lbpl+Lj;%calculate Path Loss for each UE
        UE(i).PowerReceive_dBmW(1)= MeNB(1).powerTransmit -UE(i).PL_dB+Ga;%calculate Power receive ( Pr) for each UE
        UE(i).SNR_dB(1)=UE(i).PowerReceive_dBmW-NoisePower;%calculate SINR for each UE [dB]
        UE(i).SNR(1)= 10^(UE(i).SNR_dB(1)/10);%calculate SINR for each UE
        UE(i).CQI(1)=CQI_calculation(UE(i).SNR_dB(1));%calculate CQI for each UE [dB]
        UE(i).MODULATION(1)= Modulation_calculation(UE(i).SNR_dB(1));%calculate Modulation scheme  for each UE depending on CQI [dB]
        UE(i).resurceBlock(1)=setRB(UE(i).SNR_dB(1));%calculate  how many resource block can  each UE receive [dB]
          % UE(i).throughput(1)=throughput_calculation( UE(i).MODULATION,UE(i).resurceBlock(1),UE(i).SNR_dB(1));%calculate throughput each UE receive [dB]


    end



        %{
        Ues request service from provider
        calcualation of servise priority
        sheduler give as many resources as needed min{ can_decode,service_requires}
        %}
for i=1:50
UE(i).QCI(1)=QCI_example_service();
UE(i).ExampleServise(1)=ExampleServise_calculation(UE(i).QCI);
UE(i).Priority=Priority_calculation(UE(i).QCI);
UE(i).Resource_Block_Allocation(1)=Resource_Block_Allocation_calculation( UE(i).QCI(1), UE(i).resurceBlock(1));
UE(i).throughput(1)=throughput_calculation( UE(i).MODULATION(1),UE(i).Resource_Block_Allocation(1), UE(i).SNR_dB(1));
end







%%--------------- Selecting Data of interest ---------------------
% ---------------------------- Code ------------------------------
Table_UE = struct2table(UE);
data = Table_UE(:,1:2);
data = table2array(data);




%________________________________________________________________
%________________________________________________________________

%%------------  Selecting Optimal Number of Clusters ------------
% -------------- Method 1: Using the Elbow Method ---------------
% ---------------------------- Code -----------------------------


WCSS = [];
for k = 1:20
    sumd = 0;
    [idx,C,sumd] = kmeans(data,k);
    WCSS(k) = sum(sumd);
end 
figure
plot(1:20, WCSS); 
  ylabel(' WCSS','fontsize',14);
  xlabel(' drones','fontsize',14);


prompt = 'How many cluster do you want ?: ';
clstr = input(prompt);


%________________________________________________________________
%________________________________________________________________

%%--------------- Clustering data -------------------------------

[idx,C] = kmeans(data,clstr);

for i=1:50
UE(i).cluster_id(1)=idx(i);
end



%________________________________________________________________
%________________________________________________________________





for i=1:clstr
  
   Drone(i).x=C(i,1);% x coordinate
   Drone(i).y=C(i,2);% y coordinate  
   Drone(i).index=i;
   Drone(i).height=100;
   Drone(i).powerTransmit=20;%dbm;
end


for i=1:clstr
for j=1:50
    if Drone(i).index==UE(j).cluster_id
    UE(j).distancefromDrone(1)=round(Distance(Drone(i).x,Drone(i).y,UE(j).x,UE(j).y));
    if  UE(j).distancefromDrone(1)==0
    UE(j).distancefromDrone(1)=2;
    end
   % UE(j).PL_Drone_dB(1) =(HATA_Model((UE(j).distancefromDrone(1)/1000),F_HATA(1),Drone(i).height, UE(j).height,Category(2)))+Lbody+Lbpl+Lj;%calculate Path Loss for each UE
   UE(j).PL_Drone_dB(1)=Air2Ground(UE(j).distancefromDrone(1)/1000,F_HATA(1),Drone(i).height)+Lbody+Lj;
    UE(j).PowerReceiveFromDrone_dBmW(1)= Drone(i).powerTransmit -UE(j).PL_Drone_dB+Ga;%calculate Power receive ( Pr) for each UE
    end
   
    
 end
end

 for j=1:50
 UE(j).SNR_Drone_dB(1)=UE(j).PowerReceiveFromDrone_dBmW-NoisePower;
 UE(j).resurceBlock_Drone(1)=setRB(UE(j).SNR_Drone_dB(1));
 end


%%%%%%%%%%%  %%%%%%%%%%%  %%%%%%%%%%%  PLOTS %%%%%%%%%%%  %%%%%%%%%%%  %%%%%%%%%%%  %%%%%%%%%%% 



%%--------------- Visualizing the Results------------------------
basicwaitbar();

 if clstr == 3
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3'};
  end
  if clstr == 4
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4'};
  end
  if clstr == 5
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5'};
  end
    if clstr == 6
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6'};
  end   

    if clstr == 7
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6','Cluster 7'};
    end  
  if clstr == 8
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6','Cluster 7','Cluster 8'};
  end 
if clstr == 9
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6','Cluster 7','Cluster 8','Cluster 9'};
end 
  if clstr == 10
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6','Cluster 7','Cluster 8','Cluster 9','Cluster 10'};
  end 
    if clstr == 20
         legends ={'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Cluster 5','Cluster 6','Cluster 7','Cluster 8','Cluster 9','Cluster 10','Cluster 11','Cluster 12','Cluster 13','Cluster 14','Cluster 15','Cluster 16','Cluster 17','Cluster 18','Cluster 19','Cluster 20'};
  end 
figure, 
%plot(UserLocationX, UserLocationY, '^', 'MarkerSize', 5, 'LineWidth', 3), hold on
gscatter(data(:,1),data(:,2),idx);
hold on
for i = 1:clstr
    scatter(C(i,1),C(i,2) ,96, 'black','filled');
    
end
%{
hold on
plot(BaseStationX, BaseStationY, 'rs', 'MarkerSize', 5, 'LineWidth', 4);
%}
legend(legends)
xlabel('coordinate Χ');
ylabel('coordinate Υ');
hold off



for i=1:50
 
SINR_Receive_Comparison_BarChar(i,1)=UE(i).SNR_Drone_dB;
SINR_Receive_Comparison_BarChar(i,2)=UE(i).SNR_dB;
Power_Receive_Comparison_BarChar(i,1)= UE(i).PowerReceiveFromDrone_dBmW;
Power_Receive_Comparison_BarChar(i,2)=UE(i).PowerReceive_dBmW;
end

 Mean_Power_Receive_Comparison_BarChar=[ mean(Power_Receive_Comparison_BarChar(:,1))  mean(Power_Receive_Comparison_BarChar(:,2)) ];
 Mean_SINR_Comparison_BarChar=[ mean(SINR_Receive_Comparison_BarChar(:,1))  mean(SINR_Receive_Comparison_BarChar(:,2)) ];
 x=[1:50];
 y=[1,2];
 
 
   figure
  X = categorical({'Drone','Base Station'});
  X = reordercats(X,{'Drone','Base Station'});
  bar(X,Mean_SINR_Comparison_BarChar);
  ylabel(' Average SINR[dB]','fontsize',14);
  
    
  
  
  %{
    figure
    bar(x,SINR_Receive_Comparison_BarChar);
    
    
    
    
    

    figure
     X = categorical({'Drone','Base Station'});
     X = reordercats(X,{'Drone','Base Station'});
     bar(X,Mean_Power_Receive_Comparison_BarChar);
  

 
  for i=1:50
   UserIndex(i)=UE(i).cluster_id;  
end
%}
  
  
  
  
disntance=0;
PathLoss=0;
PowerReceive=0;
SINR=0;
Rb=0;
for i=1:50
    if UE(i).distancefrom_eNB_m<UE(i).distancefromDrone
     disntance=disntance+1;
    end
     if UE(i).PL_Drone_dB>UE(i).PL_dB
     PathLoss=PathLoss+1;
    end
    if UE(i).PowerReceiveFromDrone_dBmW<UE(i).PowerReceive_dBmW
     PowerReceive=PowerReceive+1;
    end
        if UE(i).SNR_Drone_dB<UE(i).SNR_dB
     SINR=SINR+1;
        end
    if UE(i).resurceBlock_Drone<=UE(i).resurceBlock
     Rb=Rb+1;
    end
    
        
end