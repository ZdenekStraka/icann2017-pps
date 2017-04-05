% create train set
clear all
close all
load('lattices_scen1_FFNN_v2.mat')

% boundaries of the visible visual and visible tactile space
xA=0;
yA=0;
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

%sample gain G as a unified distribution
% range is g_vis +/- swing*g_vis e.g. 15+/-(3(=15*0.2))
g_vis=15;
g_veloc=15;
g_tact=15;
swing=0.2;

% tuning covariance matrix
C=[0.00125233944521611,0;0,0.00125233944521611]; 
%veloc std/visual std is same as (xF-xE)/(xB-xA)
C_veloc=(sqrt(C)*((xF-xE)/(xB-xA)))^2;



% % % % % % % % % % % % % % % % 
num_samples_PPS_1It=100;
num_it=100;

% min/max "speed"
dlMin=0.005;
dlMax=0.01;


R_vis_veloc_big=[];
R_vis_big=[];
R_veloc_big=[];
R_tact_big=[];
R_tact_only_skin_big=[];
R_dummy_big=[];
S_PPS_big=[];
V_PPS_big=[];
tact_activ_big=[];

for ii=1:num_it
    ii
time_window=-1;
% generate trajectories
[S_PPS,V_PPS,tact_activ] = line_train_set_scen1_FFNN(num_samples_PPS_1It, xA, yA, xB, yB, xC, yC, xD, yD, dlMin, dlMax, time_window);

% generate "uncertainties"
G_vis = unifSmplAboutCenter(g_vis,swing,size(S_PPS,1));
G_tact = unifSmplAboutCenter(g_tact,swing,size(S_PPS,1));
G_veloc = unifSmplAboutCenter(g_veloc,swing,size(V_PPS,1));

% generate configuratons of the unimodal neurons
R_vis= PPCencode_simple(S_PPS,G_vis,lattice_visual,C);
R_veloc= PPCencode_simple(V_PPS,G_veloc,lattice_veloc,C_veloc);
R_vis_veloc=[R_vis,R_veloc];

% find stimuli outside the tactile modality
idxs_out_skin=find(~tact_activ);
R_tact= PPCencode_simple(S_PPS,G_tact,lattice_tact,C);
% for stimuli outside the skin set zeros
R_tact(idxs_out_skin,:)=0*R_tact(idxs_out_skin,:);


R_vis_veloc_big=[R_vis_veloc_big;R_vis_veloc];
R_tact_big=[R_tact_big;R_tact];
S_PPS_big=[S_PPS_big;S_PPS];
V_PPS_big=[V_PPS_big;V_PPS];
tact_activ_big=[tact_activ_big;tact_activ];

end

R_vis_veloc=R_vis_veloc_big;
R_tact=R_tact_big;
S_PPS=S_PPS_big;
V_PPS=V_PPS_big;
tact_activ=tact_activ_big;

% generate 2tuples: (stimul before the tactile stimulation)-->(tactile stimul)
time_window_tr=70;
[samples_two_tuples]=prepare_data_FFNN(size(R_tact,1),tact_activ,time_window_tr);
save('PPS_train_scenario1_FFNN_p2_v2','R_vis_veloc','R_tact','S_PPS','V_PPS','tact_activ','samples_two_tuples','-v7.3');





