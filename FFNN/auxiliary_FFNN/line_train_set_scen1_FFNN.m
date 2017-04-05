function [S,V,tact_activ] = line_train_set_scen1_FFNN(num_lines, xA, yA, xB, yB, xC, yC, xD, yD, dlMin, dlMax, time_window)
%LINE_TRAIN_SET Create train set with num_lines lines. 
% S contains positions, V contains "velocity vector" (V(k)=S(k)-S(k-1))  
% num_lines number of lines
% visual field is given by rectangle with corners xA,yA and xB,yB. 
% tactile field is given by rectangle with corners xC,yC and xD,yD.
% Length of one step is in the interval (dlMin, dlMax). 
% time_window determines size of S (-1 for all samples)

% created by ZS

n=0;
S=[];
V=[];
tact_activ=[];
while(n<num_lines)
    [ Stmp ] = line_traject_scen1_FFNN(xA, yA, xB, yB, dlMin, dlMax, time_window);
    if ~isempty(Stmp)
        n=n+1;
        S=[S;Stmp];
        Stmp_trans=[Stmp(1,:); Stmp(1:end-1,:)];
        Vtmp=Stmp-Stmp_trans;
        V=[V;Vtmp];
        %prevent small velocity in the end
        V(end,:)=V(end-1,:);
        tact_activ_tmp=zeros(size(Stmp,1),1);
        if Stmp(end,1)<xD && Stmp(end,1)>xC
        tact_activ_tmp(end,1)=1;
        end
        tact_activ=[tact_activ;tact_activ_tmp];
        
    end
    
    
end


end

