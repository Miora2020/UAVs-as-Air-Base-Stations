function[SINR]=SINR_calculation(Power_Received,Interference,Noice)
Power_Received_watt=10^(Power_Received/10)/1000;
Noice;
Noice_watt=10^(Noice/10);
Noice_watt;
SINR_watt=Power_Received_watt/(Interference+Noice_watt);
SINR=10*log10(SINR_watt);

end
