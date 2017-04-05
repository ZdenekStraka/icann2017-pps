% function EFH_simple(trainSet,VISFXN,HIDFXN,maxepoch,Ncases,numCDsteps,nameSave,restart,saveEpochs)
% EFH   Exponential Family Harmonium training
%   EFH trains an exponential-family harmonium.  
clear all; close all


% load trainset
filename='vis_veloc_train_scen1_FFNN.mat';
varName='R_vis_veloc';
load(filename,varName);
trainSet=eval(varName);
% set types of the units
VISFXN='Poisson';
HIDFXN='Bernoulli';
% choose epochs to save learned RBM
saveEpochs=[5,20,50];
% length of the learning
maxepoch=60;
% size of the batch
Ncases=40;
% length of the contrastive divergence
numCDsteps=1;
nameSave='RBM_vis_velocity_scen1_FFNN_p1';
% set to 1 if learning starts from beginning
restart=1;
% number of hidden units
Nhid=150;



%-------------------------------------------------------------------------%
%Modified by ZS (original name EFH): 09/30/16
%   -large changes in the parameters, but the core is almost unchanged
% 
% 
% Revised: 01/15/15
%   -pulled out testEFHdecoding as a separate function
% Revised: 09/18/14
%   -renamed rbm.m -> EFH.m
% Revised: 05/14/13
%   -cleaned up
% Revised: 05/10/13
%   -added options for recurrency
% Revised: 09/14/10
%   -fixed tester to work with DBNs rather than just RBMs
% Revised: 05/25/10
%   -made number of contrastive-divergence steps variable
%   -incorporated rbmhidlinear
% Revised: 05/24/10
%   -fixed formatting
% modified by JGM
%-------------------------------------------------------------------------%



%---------------------------------- INIT ---------------------------------%
% for displaying
% DISP = zeros(1,6);
% if sum(DISP)
%     close; figure(110); colormap(gray);
%     rows = 4; cols = 5; space = 0;
%     ax = getCustomAxesPos(rows,cols,space);
%     indices = ceil(Nhid*rand(rows*cols,1));
% end

% init constants (moved from params structure)
mw =  500;                           % [50 newtons]
mvb = 120;                           % [50 newtons]
mhb = 120;                           % [50 newtons]
b = mw/2;                     % [250? N-s/m]
%%% with this setting of b, k < mw/16 to prevent oscillations; i.e., 
%%% k < 31.25---at least for the continuous-time version.  In discrete time
%%% your margin gets slightly bigger (k < 33.8).
k = 0.001;                           % [0.02 N/m]
Ts = 1;                              % "sampling interval"
amass = 1.10;                        % A "matrix" for masses
% numCDsteps = 1;

massUpdate = @(mass0,iEp)(amass^iEp*mass0);
Nvis=size(trainSet,2);

% (re)init
if restart == 1
    
    Nbatches=size(trainSet,1)/Ncases;


    
    %%% datagenargs = [datagenargs{:},{'dbndepth',i_rbm,'dbnwts',wts}];
%     datagenargs = {'dbndepth',i_rbm,'dbnwts',wts};
% %     [vishid,hidbiases,visbiases,vishidinc,hidbiasinc,visbiasinc] =...
% %         reinitializeEFH(i_rbm,params_RBMms.numsUnits,wts);
    [vishid,hidbiases,visbiases,vishidinc,hidbiasinc,visbiasinc] =...
    reinitializeEFH_simple(Nvis,Nhid);
    
    
    restart=0; epoch=1; erravg=0; tErravg=inf; trErravg=inf; counter=0;
%     if strcmp(params.machine,'domestica')
%         params.mw = gpuArray(params.mw);
%         params.mvb = gpuArray(params.mvb);
%         params.mhb = gpuArray(params.mhb);
%         params.b = gpuArray(params.b);
%         params.k = gpuArray(params.k);
%         epoch = gpuArray(epoch);
% 	maxepoch = gpuArray(maxepoch);
%     end
%     batchphidmeans = zeros(Ncases,Nhid,Nbatches,'like',params.mw);
    allErrors = zeros(maxepoch,1,'like',mw);
    
    
%     % plot errors
%     if TESTDECODING
%         
%         % NB!!  If params.swing is 100%, the decoding error computed on
%         % these data will start *increasing* after some point (e.g., epoch
%         % 20).  Don't be fooled!  It may well still be decreasing, which
%         % you can see by changing Rtest so that it is generated with (e.g.)
%         % params.swing = 0.  This has happened before.
%         
%         if isfield(params,'dynamics')
%             if ~exist('testData','var'), testData = getLDSdata(params); end
%         else
%             [Rtest,Stest] = DATAGENPP(Nbatches,params,datagenargs{:});
%             [testData.R,testData.S] = longdata(Rtest,Stest);
%             clear Rtest Stest
%         end
%         
%         yvar = []; vvar = [];
%         if usejava('desktop')
%             setColors;
%             figure(2014); clf; hold on;
%             subplot(1,2,1); hold on;
%             plotHandle(1) = plot(NaN,NaN);
%             hold off;
%             subplot(1,2,2); hold on;
%             plotHandle(2) = plot(NaN,NaN);
%             plotHandle(3) = plot(NaN,NaN);
%             hold off;
%         end
%     end
%     
 end
%-------------------------------------------------------------------------%





%---------------------------------- LOOP ---------------------------------%
% cycle through training data
for epoch = epoch:maxepoch
    errsum = 0;
    
    % mass updates
    mw = massUpdate(mw,epoch);
    mvb = massUpdate(mvb,epoch);
    mhb = massUpdate(mhb,epoch);
%     
%     % every Ntest epochs, make new data and maybe test the network
%     if mod(epoch,Ntest)==1
%         fprintf('.');
%         %%%%%
% %         if epoch > 1
% %             [batchdata,~,~,Q] = DATAGENPP(Nbatches,params,datagenargs{:},...
% %                 'ICs',Q.filterdata(end).states);
% %         else
% %             [batchdata,~,~,Q] = DATAGENPP(Nbatches,params,datagenargs{:});
% %         end
%         %%%%%
%         [batchdata,Strain] = DATAGENPP(Nbatches,params,datagenargs{:});
%         if TESTDECODING
%             [yvar,tErravg] = testEFHDecoding(vishid,hidbiases,visbiases,...
%                 yvar,testData,params);
%         end
%     end
%     [Ncases,Ndims,Nbatches] = size(batchdata);    %%% ?? why redo?
    
    
    for iBatch = 1:Nbatches
%         fprintf('.');
%         TRAJINIT = 0;
        
        % positive phase
%         pvisstates = batchdata(:,:,iBatch);
        pvisstates = trainSet((iBatch-1)*Ncases+1:(iBatch)*Ncases,:);
%         if isfield(params,'dynamics')&&(i_rbm==1)
%             %%% ASSUMES RECURRENCE ON LEFT (e.g, BP RATHER THAN PB)
%             if sum(sum(abs(pvisstates(:,1:Nhid)))) == 0
%                 TRAJINIT = 1;
%             else
%                 pvisstates(:,1:Nhid) = phidstates; % poshidmeans;
%             end
%         end
        phidmeans = feedforward(pvisstates,vishid,hidbiases,HIDFXN,[]);
        phidstates = sampler(phidmeans,HIDFXN,[]);
%         batchphidmeans(:,:,iBatch) = phidmeans;	%%% really use means for RBM2 data??
        pouterprodsum = pvisstates'*phidstates;
        phidstatesum = sum(phidstates);
        pvisstatesum = sum(pvisstates);
        
        % negative phase         
%      % FOR TRBM
%         [negvisstates, neghidstates] = CDstepperFake(poshidstates,vishid,...
%             visbiases,hidbiases,HIDFXN,VISFXN,params,posdata);
        [qvisstates, qhidstates] = CDstepper_simple(phidstates,vishid,...
            visbiases,hidbiases,HIDFXN,VISFXN,numCDsteps);
%         if TRAJINIT, qvisstates(:,1:Nhid) = 0; end
        qouterprodsum  = qvisstates'*qhidstates;
        qhidstatesum = sum(qhidstates);
        qvisstatesum = sum(qvisstates);
        
        % for printing (only)
        err = sum(sum((pvisstates - qvisstates).^2))/Ncases;
        errsum = err + errsum;
        
        % the gradient "signal"
        gradientsigW = (pouterprodsum - qouterprodsum)/Ncases;
        gradientsigbh = (phidstatesum - qhidstatesum)/Ncases;
        gradientsigbv = (pvisstatesum - qvisstatesum)'/Ncases;
        
        % update weight/biases and their velocities simultaneously
        [vishid,vishidinc] = secondOrderWeightUpdate_simple(vishid,...
            vishidinc,gradientsigW,mw,b,k,VISFXN,Ts);
        [hidbiases,hidbiasinc] = secondOrderWeightUpdate_simple(hidbiases,...
            hidbiasinc,gradientsigbh,mhb,b,k,HIDFXN,Ts);
        [visbiases,visbiasinc] = secondOrderWeightUpdate_simple(visbiases,...
            visbiasinc,gradientsigbv,mvb,b,k,VISFXN,Ts);
        
%         % display
%         if sum(DISP)
%             EFHdisp(DISP,pvisstates,qhidstates,negvismeans,neghidprobs,...
%                 vishid,rows,cols,indices,params)
%         end
        
    end
    fprintf('\n');
    erravg = errsum/Nbatches;
    allErrors(epoch) = erravg;
    
    % say error
    fprintf('epoch %4i error %6.4e trerror %6.4e terror %6.4e\n',...
        epoch,erravg,trErravg,tErravg);
%     save rbmwts vishid hidbiases visbiases params epoch
    
%     if TESTDECODING&&usejava('desktop')
%         set(0,'CurrentFigure',figure(2014));
%         hold on;
%         set(plotHandle(1),'XData',1:epoch,'YData',allErrors(1:epoch),'color','k');
%         if mod(epoch,Ntest)==1
%             set(plotHandle(2),'XData',find(mod(1:epoch,Ntest)==1),'YData',yvar,'color','r');
%             % set(plotHandle(3),'XData',(Ntest:Ntest:epoch)-Ntest,'YData',vvar,'color','g');
%         end
%         hold off;
%         %%% set(subplotHandle,'XLim',[0 Max]);
%         %%% if you want to keep the x or y limits fixed over the animation....
%     end
    if ismember(epoch,saveEpochs)
 save([nameSave,'ep',num2str(epoch)], 'vishid', 'hidbiases', 'visbiases');   
    end
end
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%

  save([nameSave,'ep',num2str(maxepoch)], 'vishid', 'hidbiases', 'visbiases');
% end



%-------------------------------------------------------------------------%
% Version 1.000
%
% Code provided by Geoff Hinton and Ruslan Salakhutdinov
%
% Permission is granted for anyone to copy, use, modify, or distribute this
% program and accompanying programs and documents for any purpose, provided
% this copyright notice is retained and prominently displayed, along with a
% note saying that the original programs are available from our web page.
% The programs and documents are distributed without any warranty, express
% or implied.  As the programs were written for research purposes only,
% they have not been tested to the degree that would be advisable in any
% important application.  All use of these programs is entirely at the
% user's own risk.

% This program trains Restricted Boltzmann Machine in which visible,
% binary, stochastic pixels are connected to hidden, binary, stochastic
% feature detectors using symmetrically weighted connections. Learning is
% done with 1-step Contrastive Divergence. The program assumes that the
% following variables are set externally:
%
%   maxepoch    -- maximum number of epochs
%   Nhid      -- number of hidden units
%   batchdata   -- the data that is divided into batches
%   (Ncases Ndims Nbatches)
%   restart     -- set to 1 if learning starts from beginning
%-------------------------------------------------------------------------%
