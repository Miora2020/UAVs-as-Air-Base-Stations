function Priority=Priority_calculation(QCI)


if(QCI==1)
   Priority=2;
    elseif(QCI==2)
     Priority=4;
        elseif(QCI==3)
          Priority=5;
            elseif(QCI==4)
             Priority=3;
                elseif(QCI==5)
                Priority=1;
else
                    Priority="ERROR";
end
end