function [ lattice ] = create_lattice(xstart, ystart, xend, yend, xneurons, yneurons)
%CREATE_LATTICE create structure with center possitons of RFs of unimodals
%neurons
%   xstart, ystart-bottom left corner, 
% xend, yend-top right corner,
% xneurons, yneurons-e.g. xneurons=4,yneurons=6 means that lattice has 4 x 6 neurons
% output: 1x2 cell, cell 1,1 xpossitions (transposed), cell 1,2 ypossitions

% created by ZS

xdiff=(xend-xstart)/(xneurons-1);
xcoord=xstart:xdiff:xend;
lattice{1,1}=repmat(xcoord,yneurons,1)';

ydiff=(yend-ystart)/(yneurons-1);
ycoord=(ystart:ydiff:yend)';
lattice{1,2}=repmat(ycoord,1,xneurons);


end

