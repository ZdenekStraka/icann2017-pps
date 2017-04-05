clear all
% close all

load('lattices_scen1_FFNN_v2.mat')

load('PPS_test_scenario1_FFNN_p2_v2.mat')

load('RBM_vis_velocity_scen1_FFNN_p1ep60.mat')


load('FFNN_1301p2.mat')

C=[0.00125233944521611,0;0,0.00125233944521611]; 

hidbiases_vis_veloc=hidbiases;
visbiases_vis_veloc=visbiases;
vishid_vis_veloc=vishid;

% activations of the hidden neurons of the RBM
[ hidstates_speed_vis ] = vis2hid(R_vis_veloc,vishid_vis_veloc,hidbiases_vis_veloc,'Bernoulli',10);

remain=1:size(samples_two_tuples,1);

for it=1:size(remain,2)
% stimuli for which the prediction is made
cond(it)=samples_two_tuples(remain(it),1);
% stimuli at the end of the trajectory
cons(it)=samples_two_tuples(remain(it),2);
end

rng('default')
s=rng;
rng(2)
num=300;
select=randi(numel(cons),num,1);
rng(s)

cond=cond(select);
cons=cons(select);


hid=hidstates_speed_vis(cond,:);


for it2=1:size(hid,1)
% output of the FF NN    
visstatesPred(it2,:)=net(hid(it2,:)');
visstatesPred(it2,find(visstatesPred(it2,:)<1))=0;


it2

% encode output population
[center1,sigma1] = getPosOnePopul(visstatesPred(it2,:),C,lattice_tact);
if ~isnan(center1(1))
    centersEst(it2,:)=center1';
    sigmaEst(it2,:)=sigma1(1,1);
    sumR(it2,:)=sum(visstatesPred(it2,:));
else
    centersEst(it2,:)=[nan nan];
    sigmaEst(it2,:)=nan;
    sumR(it2,:)=sum(visstatesPred(it2,:));
end

if cons(it2)~=cond(it2) || tact_activ(cond(it2))
centersDes(it2,:)=S_PPS(cons(it2),:);
else
    it6=cond(it2); 
    while S_PPS(it6,2)>0.0001
    it6=it6+1;   
    end
centersDes(it2,:)=S_PPS(it6,:);
end
end


 


