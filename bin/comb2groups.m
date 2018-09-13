function pairs = comb2groups(vec1,vec2)
%   function pairs = comb2groups(vec1,vec2)
%
%   This function takes two vectors and combines the elements from those
%   vectors into all combinations of pairs.
%
% (c) Duc T. Nguyen and Blair Kaneshiro, 2017
% Distributed under Creative Commons Zero (CC0) license
% Contact: audexpcreator@gmail.com

[p,q] = meshgrid(vec1, vec2);
pairs=[p(:) q(:)];