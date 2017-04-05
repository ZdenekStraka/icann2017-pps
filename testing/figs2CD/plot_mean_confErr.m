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
    trajLength=diag(pdist2(start,goal));
    errorEst=diag(pdist2(est,goal)); 
    
    toskin=((goal(:,1)>0.2).*(goal(:,1)<0.6));
    notNans=~isnan(errorEst);
    
    bp=0:0.1:0.7;
    us=[];
    xlab=[];
    errMean=[];
    etaMean=[];
    for i=1:numel(bp)-1
    us(:,i)=((trajLength>bp(i)).*(trajLength<bp(i+1)));
    choosen=find((us(:,i)).*(toskin).*(notNans));
    errMean(i)=mean(errorEst(choosen));
    etaMean(i)=mean(sumR(choosen));
    xlab(i)=mean([bp(i),bp(i+1)]);
    end
    [hAx] =  plotyy(xlab,errMean,xlab,etaMean);
    set(hAx(1),'yTick',0:0.01:0.1)
    set(hAx(2),'yTick',0:10:50)

    ylabel(hAx(1),'mean(err)') % left y-axis 
    ylabel(hAx(2),'mean(\eta)') % right y-axis
    xlabel('D')

