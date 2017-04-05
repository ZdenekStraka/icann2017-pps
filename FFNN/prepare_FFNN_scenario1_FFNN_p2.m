clear all
close all

load('PPS_train_scenario1_FFNN_p2_v2.mat')

load('RBM_vis_velocity_scen1_FFNN_p1ep60.mat')


hidbiases_vis_veloc=hidbiases;
visbiases_vis_veloc=visbiases;
vishid_vis_veloc=vishid;
[ hidstates_vis_veloc ] = vis2hid(R_vis_veloc,vishid_vis_veloc,hidbiases_vis_veloc,'Bernoulli',1);


save('ready_FFNN_scenario1_FFNN_p2_v2','hidstates_vis_veloc','samples_two_tuples')

