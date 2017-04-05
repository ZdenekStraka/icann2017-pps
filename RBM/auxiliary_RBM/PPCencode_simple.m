function R = PPCencode_simple(S,G,lattice,C)

% PPCencode_simple   Response of a population of Gaussian-tuned neurons
%
% USAGE:
%   R = PPCencode_simple(X,G,lattice,C)
%
% Samples a matrix of size (Nexamples x Nneurons), when given a matrix of
% inputs X of size (Ndims x Nexamples) (notice this transposition), the tuning curve maxima G (Nexamples x
% 1),lattice structure (see function create_lattice) and the constant tuning covariance matrix C.
%in previous experiments C=[0.00125233944521611,0;0,0.00125233944521611]
% original meaning of the C parameter (originaly params.C)
% % universal PPC params
% FWHM = 1/6;                                 % deg (Deneve01: "45-75deg")
% c = FWHM/(2*sqrt(2*log(2)));                % std. dev. in degrees
% params.C = eye(params.Ndims)*c^2;
% %%% essentially, one std of the tuning curve (in one direction only) is
% %%% about 7% of the total grid; so the 1-std (in both directions) coverage
% %%% of each tuning curve is 14% of the total area

%-------------------------------------------------------------------------%
%Modified by ZS (original name PPCencode): 09/27/16
%   -large changes in the parameters, but the core is almost unchanged
% Revised: 02/17/15
%   -replaced call to tiledGaussianTuning.m with call to tiledTuning.m
%   -renamed from GTrespfxn.m to PPCencode.m
% Revised: 06/21/14
%   -put the guts into tiledGaussianTuning
%   -took out the sampling of gains, which now lives in
%   unifSmplAboutCenter.m, and should be called before this function
% Revised: 05/06/14
%   -vectorized inputs and outputs! (avoids parfor loop)
% Created: ??/??/??
%   by JGM
%-------------------------------------------------------------------------%

% embed in smoothly tiled Gaussian tuning curves and sample
%   F = tiledTuning(X,g,inputUnitType,params); %in the original version
F = tiledTuning_simple(S,G,lattice,C);
%   F = tiledTuning_vt(S,G,mods,params);
R = sampler(F,'Poisson',[]);


end
