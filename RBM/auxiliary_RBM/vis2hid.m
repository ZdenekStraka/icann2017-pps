function [ hidstates_mean ] = vis2hid(visstates,vishid,hidbiases,HIDFXN,num_iter)
% function calculates activations hidstates of the hidden neurons given activations of the visible neurons visstates
% HIDFXN-type of the hidden units ('Bernoulli' or 'Poisson')
% num_iter-number of iterations for averaging (it was used 15)

% created by ZS

hidstates_mean=zeros(size(visstates,1),numel(hidbiases));

for it=1:size(visstates,1)
    
phidstates1tmp=[];
for i=1:num_iter
phidmeans1 = feedforward(visstates(it,:),vishid,hidbiases,HIDFXN,[]);
phidstates1tmp =[phidstates1tmp;sampler(phidmeans1,HIDFXN,[])];
end
hidstates_mean(it,:)=mean(phidstates1tmp,1);

end


end

