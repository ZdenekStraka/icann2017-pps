function [center1,sigma1] = getPosOnePopul(visms,sigmaT,lattice1)

%GetPosOnePopul    The function determines position (as a normal distribution) encoded by a population of unimodal neurons  
%  [center1,sigma1] = getPosOnePopul(visms,sigmaT,lattice1)
%  visms-activity of the a population of unimodal neurons
%  sigmaT is a constant tuning covariance matrix 2x2 (for 2D case)
%  lattice1-see function create_lattice for explanation[
%  center1,sigma1 - position encoded by population1

% created by ZS

num1=numel(lattice1{1});
% numTact=numel(lattice2{1});
sum1=sum(visms(1:num1));

if sum1>0
sigma1=(1/(sum1))*sigmaT;
cVis=visms(1:num1);
ncVis=size(lattice1{1},1);
stimulVisMatr=reshape([cVis(:) ; zeros(rem(ncVis - rem(numel(cVis),ncVis),ncVis),1)],ncVis,[]).';
centerVisX=(1/sum1)*(sum(sum(stimulVisMatr.*lattice1{1}')));
centerVisY=(1/sum1)*(sum(sum(stimulVisMatr.*lattice1{2})));
center1=[centerVisX;centerVisY];
else
sigma1=nan;
center1=nan;
end




end