function Modulation=Modulation_calculation(SINR)


if (SINR<-9.478)
    Modulation=0;
elseif (SINR>= -9.478) &&  (SINR<=-6.658)
   Modulation=2;
elseif (SINR> -6.658) &&  (SINR<=-4.098)
    Modulation=2;
elseif (SINR> -4.098) &&  (SINR<=-1.798)
     Modulation=2;
elseif (SINR> -1.798) &&  (SINR<=0.399)
        Modulation=2;
elseif (SINR> 0.399)   &&  (SINR<=2.424)
      Modulation=2;
elseif (SINR>2.424) &&  (SINR<=6.367)
         Modulation=4;
elseif (SINR>6.367) &&  (SINR<=8.456)
          Modulation=4;
elseif (SINR>8.456) &&  (SINR<=10.266)
      Modulation=4;
elseif (SINR>10.266) &&  (SINR<=12.218)
      Modulation=6;
elseif (SINR>12.218) &&  (SINR<=14.122)
          Modulation=6;
elseif (SINR>14.122) &&  (SINR<=15.849)
           Modulation=6;
elseif (SINR>15.849) &&  (SINR<=17.786)
         Modulation=6;
    elseif (SINR>17.786) &&  (SINR<=19.809)
          Modulation=6;
else
          Modulation=6;


    end
end
