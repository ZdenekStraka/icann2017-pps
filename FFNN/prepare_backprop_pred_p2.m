clear all
load('ready_FFNN_scenario1_FFNN_p2_v2.mat','hidstates_vis_veloc','samples_two_tuples')
load('PPS_train_scenario1_FFNN_p2_v2.mat','R_tact')

desired_tact=zeros(size(R_tact,1),size(R_tact,2));
for i=1:size(R_tact,1)
 desired_tact(i,:)=R_tact(samples_two_tuples(i,2),:);   
end

choose=randperm(size(R_tact,1))';
desired_tact=desired_tact(choose,:);
hidstates_vis_veloc=hidstates_vis_veloc(choose,:);
save('backprop_learning_scenario1_FFNN_p2_v2','desired_tact','hidstates_vis_veloc','choose','-v7.3')

