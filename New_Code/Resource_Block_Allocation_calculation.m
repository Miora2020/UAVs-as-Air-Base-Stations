function Resource_Block_Allocation=Resource_Block_Allocation_calculation(QCI,UeRB)
Resource_Block_Required=0;

if(QCI==1)
   ExampleServise="Conversational Voice";
   Resource_Block_Required=3;
    elseif(QCI==2)
     ExampleServise="Conversational Video(Live Streaming)";
     Resource_Block_Required=7;
        elseif(QCI==3)
          ExampleServise="Non Conversational Video(Buffer Streaming)";
          Resource_Block_Required=5;
            elseif(QCI==4)
             ExampleServise="Real Time Gaming";
             Resource_Block_Required=2;
                elseif(QCI==5)
                ExampleServise="IMS Signaling";
                Resource_Block_Required=2;
                
else
                    Resource_Block_Allocation="ERROR";
end



Resource_Block_Allocation=min(UeRB,Resource_Block_Required);
end
