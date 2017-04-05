clear all
close all
load('lattices_scen1_FFNN_v2.mat')

% boundaries of the visual and tactile space
xA=0;
yA=-0.1;
xB=0.8;
yB=0.7;
xC=0.2;
yC=0.0;
xD=0.6;
yD=0.0;

% boundaries of the velocity space
xE=-0.012;
yE=-0.012;
xF=0.012;
yF=0.012;

% % % % % % % % % % % % % % % % % % % % % 
% visual nad velocity stimuli


num_samples=100000;
[S_vis] = unif_stimuli(num_samples, xA, yA, xB, yB);
[S_veloc] = unif_stimuli(num_samples, xE, yE, xF, yF);

%sample gain G as a unified distribution
% range is g_vis +/- swing*g_vis e.g. 15+/-(3(=15*0.2))
g_vis=15;
g_veloc=15;
swing=0.2;
G_vis = unifSmplAboutCenter(g_vis,swing,size(S_vis,1));
G_veloc = unifSmplAboutCenter(g_veloc,swing,size(S_veloc,1));
% tuning covariance matrix
C=[0.00125233944521611,0;0,0.00125233944521611]; 
%veloc std/visual std is same as (xF-xE)/(xB-xA)
C_veloc=(sqrt(C)*((xF-xE)/(xB-xA)))^2;

% get activations of the visual unimodal neurons
R_vis= PPCencode_simple(S_vis,G_vis,lattice_visual,C);

% get activations of the velocity neurons
R_veloc= PPCencode_simple(S_veloc,G_veloc,lattice_veloc,C_veloc);

R_vis_veloc=[R_vis,R_veloc];
save('vis_veloc_train_scen1_FFNN','R_vis_veloc','R_veloc','R_vis','S_vis','S_veloc','-v7.3');


