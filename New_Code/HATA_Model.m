function [ PL ] = HATA_Model( d,f,Hbs,Hms,Category )

%Correction factor a(Hms)
if (f <= 200)
    a = (8.29*(log10(1.548*Hms))^2) - 1.1;
elseif (f >= 400)
    a = (3.28*(log10(11.75*Hms))^2) - 4.97;
end

A = 69.55 + 26.16*log10(f) - 13.82*log10(Hbs) - a*(Hms);
B = 44.9 - 6.55*log10(Hbs);
C = 5.4 + 2*(log10(f/28))^2;
D = 40.94 + 4.78*(log10(f))^2 - 18.33*log10(f);

%Urban category=1
if(Category==1)
    PL = A + B*log10(d);


%Suburban category=2
elseif(Category==2)
    PL = A + B*log10(d) - C;

%Rular category=3
else 
    PL = A+ B*log10(d) - D;
end

end

