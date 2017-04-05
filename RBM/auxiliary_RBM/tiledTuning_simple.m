function F = tiledTuning_simple(S,G,lattice,C)
% tiledTuning   A population of smoothly tiled tuning curves
%
% USAGE:
%   F = tiledTuning_simple(X,g,lattice,C);
%
% Produces a matrix F of size (Nexamples x Nneurons) when given a matrix of
% inputs X (Nexamples x Ndims), a vector of gains g (Nexamples x 1), and
% the constant tuning covariance matrix C.
%in previous experiments C=[0.00125233944521611,0;0,0.00125233944521611]
% original meaning of the C parameter (originaly params.C)
% % universal PPC params
% FWHM = 1/6;                                 % deg (Deneve01: "45-75deg")
% c = FWHM/(2*sqrt(2*log(2)));                % std. dev. in degrees
% params.C = eye(params.Ndims)*c^2;
% %%% essentially, one std of the tuning curve (in one direction only) is
% %%% about 7% of the total grid; so the 1-std (in both directions) coverage
% %%% of each tuning curve is 14% of the total area



% tiledTuning   A population of smoothly tiled tuning curves
%
% USAGE:
%   F = tiledTuning(X,g,params);
%
% Produces a matrix F of size (Nexamples x Nneurons) when given a matrix of
% inputs X (Nexamples x Ndims), a vector of gains g (Nexamples x 1), and
% the params structure.
%
% NB: main use is in PPCencode, but it can be used on its own for a
% "noiseless responses."

%-------------------------------------------------------------------------%
%Modified by ZS (original name tiledTuning): 09/27/16
%   -large changes in the parameters (simplified), but the core is almost unchanged
% Revised: 08/07/14
%   -replaced machine ('domestica') check with data class check
% Revised: 07/29/14
%   -added gpu stuff
% Revised: 07/24/14
%   -rewrote from scratch to use binary singleton expansion, tensorOp.m
%   -incorporated Ndims = 1, 2 to one case
%   -generalized to any Ndims
% Adapted: 06/21/14
%   -from GTrespfxn (version history below)
% Revised: 05/06/14
%   -vectorized inputs and outputs! (avoids parfor loop)
%   -renamed from respfxn to GTrespfxn
% Created: ??/??/??
%   by JGM
%-------------------------------------------------------------------------%

% params
Info = inv(C);
lattice1_tmp=lattice{1};
Nunits = numel(lattice1_tmp);

Ndims=numel(size(lattice1_tmp));




latticePDs = NaN(Nunits,1,Ndims,'like',S);
for iDim = 1:Ndims
    thisLattice = shiftdim(lattice{iDim},iDim-1);
    latticePDs(:,1,iDim) = thisLattice(:);
end
Infotensor = reshape(Info,[Ndims,1,Ndims])*ones(1,1,'like',S);
Y = bsxfun(@minus,reshape(S,[1,size(S,1),Ndims]),latticePDs);
YtrS = tensorOp(Y,Infotensor(:,ones(size(S,1),1,'like',S),:));
quadraticForm = sum(YtrS.*Y,3)';

%%% may ultimately want to make the tuning curves a parameter....
% switch inputUnitType
%     case {'Bernoulli','Binomial'}
%         % subtract from logit(g), send through the logistic function
%         logit = @(z)(log(z./(1-z)));
%         logistic = @(z)(1./(1 + exp(-z)));
%         F = logistic(bsxfun(@minus,logit(g),quadraticForm/2));
%     otherwise % Gaussian tuning
        % exponentiate to get a Gaussian, scale by gains
        F = bsxfun(@times,G,exp(-quadraticForm/2));
% end

end


