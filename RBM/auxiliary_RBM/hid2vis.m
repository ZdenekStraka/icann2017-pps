function [ visstates] = hid2vis(hidstates,vishid,visbiases,VISFXN,num_iter)
% function calculates activations visstates of the visible neurons given activations of the hidden neurons hidstates
% VISFXN-type of the visible units ('Poisson' or 'Bernoulli')
% num_iter-number of iterations for averaging (for VISFXN='Poisson' was used 15, for 'Bernoulli' it (i.e. 15) would be bad choice because rounding can cause some problems)

% created by ZS

visstates=zeros(size(hidstates,1),numel(visbiases));

for it=1:size(hidstates,1)
    
visstatestmp=[];
for i=1:num_iter
vismeans = feedforward(hidstates(it,:),vishid',visbiases',VISFXN,[]);
visstatestmp = [visstatestmp;sampler(vismeans,VISFXN,[])];
end

visstates(it,:)=round(mean(visstatestmp,1));

end

end

