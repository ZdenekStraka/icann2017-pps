function visstates=compEst(stimul,vishid,visbiases,hidbiases,VISFXN,HIDFXN,num_iter1,num_iter2)
% function creates reconstruction of the stimul

% created by ZS
[ hidstates_mean ] = vis2hid(stimul,vishid,hidbiases,HIDFXN,num_iter1);
 [ visstates] = hid2vis(hidstates_mean,vishid,visbiases,VISFXN,num_iter2);

end