function [pvec, pstruct] = tapas_rw_binary_2lr_dw_transp(r, ptrans)
% --------------------------------------------------------------------------------------------------
% Adapted for MID by David Willinger, UZH, 2020
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

pvec    = NaN(1,length(ptrans));
pstruct = struct;

pvec(1)       = tapas_sgm(ptrans(1),1); % v_0
pstruct.v_0   = pvec(1);
pvec(2)       = tapas_sgm(ptrans(2),1); % alpha reward
pstruct.alr    = pvec(2);
pvec(3)       = tapas_sgm(ptrans(3),1); % alpha loss
pstruct.all    = pvec(3);

return;