function [visstates, hidstates] = CDstepper_simple(hidstates,vishid,visbiases,...
    hidbiases,HIDFXN,VISFXN,numCDsteps)
% contrastive divergence Gibbs sampler for RBMs
%-------------------------------------------------------------------------%
%Modified by ZS (original name CDstepper): 09/30/16
%   -large changes in the parameters, but the core is almost unchanged
% 
% Revised: 10/25/10
%   -changed to use all samples (no more "means")
% Adapted: 08/03/10 (happy b'day, TAM)
%   by JGM
%-------------------------------------------------------------------------%

% Gibbs sample
for step = 1:numCDsteps
    
    % feed down and back up
    vismeans = feedforward(hidstates,vishid',visbiases',VISFXN,[]);
    visstates = sampler(vismeans,VISFXN,[]);
    hidmeans = feedforward(visstates,vishid,hidbiases,HIDFXN,[]);
    hidstates = sampler(hidmeans,HIDFXN,[]);
    
    if sum(sum(isnan(vismeans)))
        fprintf('warning: confabulations contain NaNs\n');
        pause()
    end
   
end

end
