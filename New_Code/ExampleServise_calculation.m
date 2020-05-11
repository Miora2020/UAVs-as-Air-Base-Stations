function ExampleServise=ExampleServise_calculation(QCI)


if(QCI==1)
   ExampleServise="Conversational Voice";
    elseif(QCI==2)
     ExampleServise="Conversational Video(Live Streaming)";
        elseif(QCI==3)
          ExampleServise="Non Conversational Video(Buffer Streaming)";
            elseif(QCI==4)
             ExampleServise="Real Time Gaming";
                elseif(QCI==5)
                ExampleServise="IMS Signaling";
else
                    ExampleServise="ERROR";
end
end
