function [ S ] = line_traject_scen1_FFNN(xA, yA, xB, yB, dlMin, dlMax, time_window)
%LINETRAJECT creates trajectori that is ended with stimulation on skin
% visual field is given by rectangle with corners xA,yA and xB,yB. 
% tactile field is given by rectangle with corners xC,yC and xD,yD.
% Length of one step is in the interval (dlMin, dlMax). 
% time_window determines size of S (-1 for all samples)

% created by ZS

dl=dlMin+(dlMax-dlMin)*rand;

S=[];

    %top
    xStart=xA+(xB-xA)*rand;
    yStart=yB;
    
    xEnd=xA+(xB-xA)*rand;
    yEnd=yA;
    
    dirVect=[xEnd-xStart,yEnd-yStart];
    

    dxVect=dl*(1/norm(dirVect)).*dirVect;
      
    next(1)=xStart;
    next(2)=yStart;

    
    while next(2)>yA
    S=[S;next];
    next=S(end,:)+dxVect;    
  
    end
    
    S=[S;[xEnd,yEnd]];

if time_window==-1
    
else
if(size(S,1)>time_window)
  
    S=S(end-time_window+1:end,:);
end
end
  
end

