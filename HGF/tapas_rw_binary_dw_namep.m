function pstruct = tapas_rw_binary_dw_namep(pvec)
% --------------------------------------------------------------------------------------------------
% Adapted for MID by David Willinger, UZH, 2020
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

pstruct = struct;

pstruct.v_0   = pvec(1);
pstruct.al    = pvec(2);

return;