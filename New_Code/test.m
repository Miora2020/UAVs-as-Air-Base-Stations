RF=AggregatedResults.RandomForestPredictiondB;
 SVR=AggregatedResults.SVRPredictiondB;
 knifeEdge=AggregatedResults.PathLossKnifeEdgedB
 Knn=AggregatedResults.KNNPredictiondB;
 x=AggregatedResults.Xcordinatem;
y=AggregatedResults.YCordinatem;
Cost321=AggregatedResults.PathLossCost321dB;
Dominant=AggregatedResults.PathLossDominantdB; 

 SVR_1 = reshape(SVR,[100,50]);
 Cost321_1 = reshape(Cost321,[100,50]);
  knifeEdge_1 = reshape(knifeEdge,[100,50]);
   RF_1 = reshape(RF,[100,50]);
    Knn_1 = reshape(Knn,[100,50]);
     Dominant_1 = reshape(Dominant,[100,50]);
  X_1 = reshape(x,[100,50]);
 Y_1 = reshape(y,[100,50]);
 
 
 
figure(1)
contour(X_1,Y_1,Dominant_1)
colorbar('Direction','reverse')
figure(2)
contour(X_1,Y_1,Knn_1)
colorbar('Direction','reverse')
 figure(3)
 contour(X_1,Y_1,knifeEdge_1)
 colorbar('Direction','reverse')
figure(4)
contour(X_1,Y_1,Cost321_1)
colorbar('Direction','reverse')
figure(5)
contour(X_1,Y_1,SVR_1)
colorbar('Direction','reverse')
figure(6)
contour(X_1,Y_1,RF_1)
colorbar('Direction','reverse')

 


%{
figure(1)
contourf(Dominant_1,4)
colorbar('Direction','reverse')
figure(2)
contourf(Knn_1,4)
colorbar('Direction','reverse')
figure(3)
contourf(Cost321_1,4)
colorbar('Direction','reverse')
figure(4)
contourf(knifeEdge_1,4)
colorbar('Direction','reverse')
figure(5)
contourf(SVR_1,4)
colorbar('Direction','reverse')
figure(6)
contourf(RF_1,4)
colorbar('Direction','reverse')
%}
