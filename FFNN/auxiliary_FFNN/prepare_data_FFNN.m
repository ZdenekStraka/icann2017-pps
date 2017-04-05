function [samples_two_tuples]=prepare_data_FFNN(dataset_size,skin_activ,time_window)

%created by ZS


%initialize RAND,RANDN to a different state
rand('state',sum(100*clock))
randn('state',sum(100*clock))

% find indices of activations of the skin population
idx_skin_act=find(skin_activ);

samples_two_tuples=repmat((1:dataset_size)',1,2);

for i=1:size(idx_skin_act,1)
    idx_tmp=idx_skin_act(i);
    for j=1:time_window-1
        if( idx_tmp-j~=0 && ~skin_activ(idx_tmp-j) )
     samples_two_tuples(idx_tmp-j,2)=idx_tmp;
        else
            break;
        end
    end
end



end

