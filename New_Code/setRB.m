function[RB]=setRB(SNR_dB)
RB=2;
RB=round(max(2,min(100,10^((SNR_dB-2.8)/10))));
end