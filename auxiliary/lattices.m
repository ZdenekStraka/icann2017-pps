clear all
close all
%create visual and tactile lattice and plot it
%A,B corners of the visual field
%C,D corners of the tactile field 
% -------------------B
% -                  -
% -   --------D      -
% -   -       -      -
% -   -       -      -
% -   C--------      -
% -                  -
% A-------------------

xA=0;
yA=-0.1;
xB=0.8;
yB=0.7;
xC=0.1;
yC=0;
xD=0.7;
yD=0.001;
size_neur_x1=17;
size_neur_y1=17;
size_neur_x2=25;
size_neur_y2=1;


[ lattice_visual ] = create_lattice(xA, yA, xB, yB, size_neur_x1, size_neur_y1);
[ lattice_tact ] = create_lattice(xC, yC, xD, yD, size_neur_x2, size_neur_y2);
%  surf(lattice_tact{1}',lattice_tact{2},0*lattice_tact{2});

 
%  create speed vector plattice and plot it
% E,F corners of the speed vector field
%size of the field shloud be bigger than dlMax
xE=-0.012;
yE=-0.012;
xF=0.012;
yF=0.012;
size_neur_x=25;

[ lattice_veloc ] = create_lattice(xE, yE, xF, yF, size_neur_x, size_neur_x);
%   surf(lattice_speed{1}',lattice_speed{2},0*lattice_speed{2});
save('lattices_scen1_FFNN_v2','lattice_visual','lattice_tact','lattice_veloc');
