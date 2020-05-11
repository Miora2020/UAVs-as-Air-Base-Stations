function throughput =throughput_calculation(Modulation,numberOfResourceBlock,SINR)

if(SINR<=-9.478)
    throughput=0;
else
numberOfResourceElement=numberOfResourceBlock*84;
throughput=Modulation*numberOfResourceElement;

end
