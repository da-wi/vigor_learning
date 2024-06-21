function [logp, yhat, res] = tapas_logrt_linear_binary_dw(r, infStates, ptrans)
%
% --------------------------------------------------------------------------------------------------
% Adapted for MID by David Willinger, UZH, 2020
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

% Transform parameters to their native space
be0  = ptrans(1);
be1  = ptrans(2);
be2  = ptrans(3);
be3  = ptrans(4);
be4  = ptrans(5);
be5  = ptrans(6);
be6  = ptrans(7);
be7  = ptrans(8);
be8  = ptrans(9);
ze   = exp(ptrans(10));

% Initialize returned log-probabilities, predictions,
% and residuals as NaNs so that NaN is returned for all
% irregualar trials
n = size(infStates,1);
logp = NaN(n,1);
yhat = NaN(n,1);
res  = NaN(n,1);

% Extract trajectories of interest from infStates
v = infStates(:,1,1);   % reinforcer probability (~66 for win, ~33 for loss)
v = [ 0; v(1:end-1) ];   % reinforcer probability (~66 for win, ~33 for loss)

dahat = infStates(:,2,1);    % PE
evhat = infStates(:,3,1);    % EV
ev_inhibited = infStates(:,4,1);  % EV adj

correct = infStates(:,5,1);  % correct
correct = [ 0; correct(1:end-1) ]; % shift it, such that the previous trial is predictor

cue_value = infStates(:,6);
% cue_value = abs( (cue_value-mean(cue_value)) / std(cue_value) ) ;

%scaleddahat
scaleddahat = dahat./cue_value;
scaleddahat(isnan(scaleddahat)) = 0; 

dahat = [ 0; dahat(1:end-1) ]; % shift it, such that the previous trial is predictor
scaleddahat = [ 0; scaleddahat(1:end-1) ]; % shift it, such that the previous trial is predictor


outcome     = infStates(:,7);
et          = infStates(:,8);

% real da (=normalized PE [-1,1])
avg_outcome = infStates(:,8);
avg_reward = infStates(:,9);
avg_punish = infStates(:,10);
%da_norm = infStates(:,9);
%da_norm = [ 0; da_norm(1:end-1) ];

% real da_inhibited 
%available_reward = infStates(:,11);
%available_punishment = infStates(:,12);
repetition = infStates(:,13);

rpe = infStates(:,14);
rpe(isnan(rpe)) = 0;
ppe = infStates(:,15);
ppe(isnan(ppe)) = 0;

vhatpe = (rpe + ppe)./abs(cue_value);
vhatpe(isnan(vhatpe)) = 0;
vhatrpe = zeros(120,1);
vhatppe = zeros(120,1);
vhatrpe(cue_value > 0 ) = vhatpe(cue_value > 0 );
vhatppe(cue_value < 0 ) = vhatpe((cue_value < 0 ));

rpe = [ 0; rpe(1:end-1) ]; % shift it, such that the previous trial is predictor
ppe = [ 0; ppe(1:end-1) ]; % shift it, such that the previous trial is predictor
vhatpe = [ 0; vhatpe(1:end-1) ]; % shift it, such that the previous trial is predictor
vhatrpe = [ 0; vhatrpe(1:end-1) ]; % shift it, such that the previous trial is predictor
vhatppe = [ 0; vhatppe(1:end-1) ]; % shift it, such that the previous trial is predictor

ev_pos = infStates(:,16);
ev_neg = infStates(:,17);

% IMPORTANT: we model post error --> therefore after neutral trials we
% model as correct!!
%ppe(isnan(correct)) = 0;
%rpe(isnan(correct)) = 0;
correct(isnan(correct)) = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NEW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model 1
% logrt = be0 +be1.*abs(ev_neg) +be2.*ev_pos +be3.*avg_reward +be4.*avg_punish +be5.*correct +be6.*repetition +be7.*linspace(-1,1,120)' ; 

% Model 2
%logrt = be0 +be1.*abs(ev_neg) +be2.*ev_pos +be3.*ppe +be4.*rpe +be5.*linspace(-1,1,120)' ; 

% Model 3
% logrt mit posterror und surprise
%logrt = be0 +be1.*abs(evhat) +be2.*abs(dahat) +be3.*correct +be4.*linspace(-1,1,120)';

% for Esber-Hasbelgrove Salience
%logrt = be0 +be1.*et +be2.*abs(dahat) +be3.*correct +be4.*linspace(-1,1,120)';

% disp([be0 be1 be2 be3 be4])
% Model 4
%logrt = be0 +be1.*abs(ev_neg) +be2.*ev_pos +be3.*abs(dahat) +be4.*correct +be5.*linspace(-1,1,120)'; 

% Model 5
logrt = be0 +be1.*abs(evhat) +be2.*ppe +be3.*rpe +be4.*linspace(-1,1,120)' ; 

% Model 6
% logrt = be0 +be1.*abs(evhat) +be2.*vhatrpe +be3.*vhatppe +be4.*linspace(-1,1,120)';

%logrt = be0 +be1.*abs(evhat) +be2.*(scaleddahat) +be3.*correct +be4.*linspace(-1,1,120)';


% Weed irregular trials out from responses and inputs
logrt(r.irr) = [];

% Weed irregular trials out from responses and inputs
y = r.y(:,1);
y(r.irr) = [];

u = r.u(:,1);
u(r.irr) = [];

% Calculate log-probabilities for non-irregular trials
% Note: 8*atan(1) == 2*pi (this is used to guard against
% errors resulting from having used pi as a variable).
reg = ~ismember(1:n,r.irr);
logp(reg) = -1/2.*log(8*atan(1).*ze) -(y-logrt).^2./(2.*ze);
yhat(reg) = logrt;
res(reg) = y-logrt;

return;
