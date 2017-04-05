clear all
load('backprop_learning_scenario1_FFNN_p2_v2.mat')

saveName='FFNN_1301p2';
 
inputs = hidstates_vis_veloc';
targets = desired_tact';

% Create a Fitting Network
hiddenLayerSize = 20;
net = fitnet(hiddenLayerSize,'trainscg');

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

net.trainParam.epochs=10000;
 
% Train the Network
[net,tr] = train(net,inputs,targets,'CheckpointFile',['MyCheckpoint_',saveName,'.mat']);

save([saveName,'.mat'],'net','tr');
