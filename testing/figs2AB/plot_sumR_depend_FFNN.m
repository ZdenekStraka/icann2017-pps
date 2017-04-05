% plot the graph with the confidence (see the article)
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
    trajLength=diag(pdist2(start,goal));

    
    figure
    colors=jet(max(ceil(sumR))-min(ceil(sumR)));

    for it=1:size(cond,2)
    if sumR(it)~=0 
    stem3(goal(it,1),trajLength(it),sumR(it),'.','Color',colors(ceil(sumR(it)),:),'MarkerSize',20)
    hold on
    else
    plot(goal(it,1),trajLength(it),'x','Color',colors(1,:),'MarkerSize',10)
    hold on    
    end
%     end
    end
    
    plot([0.2 0.2],[0 1.2],'--b')
    plot([0.6 0.6],[0 1.2],'--b')
    
    xlabel('x^{tact}_{meas}','FontSize', 15)
    ylabel('D','FontSize', 15)
    title('\eta','FontSize', 15)
    h=colorbar;
    set(h,'fontsize',13);
    
    colormap(colors)
    caxis([min(ceil(sumR)) max(ceil(sumR))])
    




