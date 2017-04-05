% plot the graph with the errors (see the article)
% first run test_learned_FFNN_scen1_FFNN_v2A

% tuning covariance matrix
C=[0.00125233944521611,0;0,0.00125233944521611]; 
for i=size(cond,2):-1:1

      i

    start(i,:)=S_PPS(cond(i),:);
    goal(i,:)=centersDes(i,:);
    speed(i,:)=norm(V_PPS(cond(i),:));
    
 

end
    est=centersEst;
    errorEst=diag(pdist2(est,goal)); 
    trajLength=diag(pdist2(start,goal));

    figure
    val=round(errorEst(:)*1000+0.5);
    colors=jet(max(val)-min(val)+1);

    for it=1:size(cond,2)
    if ~isnan(errorEst(it))  
    stem3(goal(it,1),trajLength(it),errorEst(it),'.','Color',colors(val(it),:)-min(val)+1,'MarkerSize',20)
    hold on
    else
    plot(goal(it,1),trajLength(it),'xk','MarkerSize',10)
    hold on    
    end

    end
    
    plot([0.2 0.2],[0 1.2],'--b')
    plot([0.6 0.6],[0 1.2],'--b')
    
    xlabel('x^{tact}_{meas}','FontSize', 15)
    ylabel('D','FontSize', 15)
    title('err','FontSize', 15)
    h=colorbar;
    set(h,'fontsize',13);
    
    colormap(colors)
    caxis([min(errorEst) max(errorEst)])
        
    




