function c = tapas_logrt_linear_binary_dw_config
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The Gaussian noise observation model assumes that responses have a Gaussian distribution around
% the inferred mean of the relevant state. The only parameter of the model is the noise variance
% (NOT standard deviation) zeta.
%
% --------------------------------------------------------------------------------------------------
% Adapted for MID by David Willinger, UZH, 2020
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.


% Config structure
c = struct;

% Model name
c.model = 'Linear log-reaction time for binary models';

% Sufficient statistics of Gaussian parameter priors
%
% Beta_0
c.be0mu = log(500); 
c.be0sa = 4;
% Beta_1
c.be1mu = 0;
c.be1sa = 4;

% Beta_2
c.be2mu = 0; 
c.be2sa = 4;

% Beta_3
c.be3mu = 0; 
c.be3sa = 4;

% Beta_4
c.be4mu = 0; 
c.be4sa = 4;

% Beta_5
c.be5mu = 0; 
c.be5sa = 4;

% Beta_6
c.be6mu = 0; 
c.be6sa = 4;

% Beta_7
c.be7mu = 0; 
c.be7sa = 4;

% Beta_8
c.be8mu = 0; 
c.be8sa = 4;

% Zeta
% default:
% c.logzemu = log(log(20));
% c.logzesa = log(2);

c.logzemu = log(log(20));
%c.logzemu = log(6);
c.logzesa = log(2); % fix ZE
%c.logzesa = 0.05; % fix ZE

% Gather prior settings in vectors
c.priormus = [
    c.be0mu,...
    c.be1mu,...
    c.be2mu,...
    c.be3mu,...
    c.be4mu,...
    c.be5mu,...
    c.be6mu,... 
    c.be7mu,...
    c.be8mu,...
    c.logzemu,...
         ];

c.priorsas = [
    c.be0sa,...
    c.be1sa,...
    c.be2sa,...
    c.be3sa,...
    c.be4sa,...
    c.be5sa,...
    c.be6sa,...
    c.be7sa,...
    c.be8sa,...
    c.logzesa,...
         ];

% Model filehandle
c.obs_fun = @tapas_logrt_linear_binary_dw;

% Handle to function that transforms observation parameters to their native space
% from the space they are estimated in
c.transp_obs_fun = @tapas_logrt_linear_binary_dw_transp;

return;
