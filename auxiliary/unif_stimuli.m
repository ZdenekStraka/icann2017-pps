function [S] = unif_stimuli(num_samples, xA, yA, xB, yB)
%UNIF_STIMULY generate positions of stimuli (uniform distribution) in given rectangle 
% rectangle is given by corners xA,yA (bottom left) and xB,yB (top right)

Xcoord=scalefxn(rand(num_samples,1),0,1,xA,xB);
Ycoord=scalefxn(rand(num_samples,1),0,1,yA,yB);

S=[Xcoord,Ycoord];
end

