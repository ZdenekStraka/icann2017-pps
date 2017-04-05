clear all
test_learned_FFNN_scen1_FFNN_v2B
% tuning covariance matrix
C=[0.00125233944521611,0;0,0.00125233944521611]; 
for i=size(cond,2):-1:1
    
      i
   
    start(i,:)=S_PPS(cond(i),:);
    goal(i,:)=centersDes(i,:);
    speed(i,:)=norm(V_PPS(cond(i),:));

    

end
    est=centersEst;
%     stdEst=sqrt(sigmaEst); 
    trajLength=diag(pdist2(start,goal));
    errorEst=diag(pdist2(est,goal)); 
    
    toskin=((goal(:,1)>0.2).*(goal(:,1)<0.6));
    nonZerSpeed=speed>0;
 
    

% borders
nanSkin=find((isnan(errorEst)).*(toskin).*(nonZerSpeed));
plot(speed(find((toskin).*(nonZerSpeed))),trajLength(find((toskin).*(nonZerSpeed))),'.b')
hold on

plot(speed(nanSkin),trajLength(nanSkin),'rx')
xlabel('speed')
ylabel('D')
    
