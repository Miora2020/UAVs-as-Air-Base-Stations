function CQI=CQI_calculation(SINR)


if (SINR<-9.478)
    CQI=0;
elseif (SINR>= -9.478) &&  (SINR<=-6.658)
    CQI=1;
elseif (SINR> -6.658) &&  (SINR<=-4.098)
     CQI=2;
elseif (SINR> -4.098) &&  (SINR<=-1.798)
    CQI=3;
elseif (SINR> -1.798) &&  (SINR<=0.399)
     CQI=4;
elseif (SINR> 0.399)   &&  (SINR<=2.424)
     CQI=5;
elseif (SINR>2.424) &&  (SINR<=6.367)
      CQI=6;
elseif (SINR>6.367) &&  (SINR<=8.456)
      CQI=7;
elseif (SINR>8.456) &&  (SINR<=10.266)
      CQI=8;
elseif (SINR>10.266) &&  (SINR<=12.218)
    CQI=9;
elseif (SINR>12.218) &&  (SINR<=14.122)
    CQI=10;
elseif (SINR>14.122) &&  (SINR<=15.849)
    CQI=11;
elseif (SINR>15.849) &&  (SINR<=17.786)
    CQI=12;
    elseif (SINR>17.786) &&  (SINR<=19.809)
    CQI=13;
else
     CQI=14;


    end
end
