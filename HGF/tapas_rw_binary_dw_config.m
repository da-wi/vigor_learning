function c = tapas_rw_binary_dw_config
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Contains the configuration for the Rescorla-Wagner (RW) learning model for binary inputs.
%
% The RW model was introduced in :
%
% Rescorla, R. A., and Wagner, A. R. (1972). "A theory of Pavlovian conditioning:
% Variations in the effectiveness of reinforcement," in Classical Conditioning
% II: Current Research and Theory, eds. A. H. Black and W. F. Prokasy (New
% York: Appleton-Century-Crofts), 64-99.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The RW configuration consists of the priors of the learning rate alpha and the initial value v_0
% of the value v. The priors are Gaussian in the space where the parameters they refer to are
% estimated. They are specified by their sufficient statistics: mean and variance (NOT standard
% deviation).
% 
% Both alpha and v_0 are estimated in 'logit-space' because they are bounded inside the unit
% interval.
%
% 'Logit-space' is a logistic sigmoid transformation of native space
% 
% tapas_logit(x) = ln(x/(1-x)); x = 1/(1+exp(-tapas_logit(x)))
%
% Any of the parameters can be fixed (i.e., set to a fixed value) by setting the variance of their
% prior to zero. To fix v_0 to 0.5 set the mean as well as the variance of the prior to zero.
%
% Fitted trajectories can be plotted by using the command
%
% >> tapas_rw_binary_plotTraj(est)
% 
% where est is the stucture returned by tapas_fitModel. This structure contains the estimated
% parameters alpha and v_0 in est.p_prc and the estimated trajectories of the agent's
% representations:
%              
%         est.p_prc.v_0      initial value of v
%         est.p_prc.alpha    alpha
%
%         est.traj.v         value: v
%         est.traj.da        prediction error: delta
%
% Tips:
% - Your guide to all these adjustments is the log-model evidence (LME). Whenever the LME increases
%   by at least 3 across datasets, the adjustment was a good idea and can be justified by just this:
%   the LME increased, so you had a better model.
%
% --------------------------------------------------------------------------------------------------
% Adapted for MID by David Willinger, UZH, 2020
%
% Config structure
c = struct;

% Model name
c.model = 'tapas_rw_binary';

% Initial v
c.logitv_0mu = tapas_logit(0.66, 1);
c.logitv_0sa = 1;
%c.logitv_0sa = 0;

% Alpha
c.logitalmu = tapas_logit(0.05, 1);
c.logitalsa = 1;
%c.logitalmu = -1000;
%c.logitalsa = 0;

% Gather prior settings in vectors
c.priormus = [
    c.logitv_0mu,...
    c.logitalmu,...
         ];

c.priorsas = [
    c.logitv_0sa,...
    c.logitalsa,...
         ];

% Model function handle
c.prc_fun = @tapas_rw_binary_dw;

% Handle to function that transforms perceptual parameters to their native space
% from the space they are estimated in
c.transp_prc_fun = @tapas_rw_binary_transp;

return;
