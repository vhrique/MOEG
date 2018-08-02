function [ens] = create_ensembles(X, eval, data)
%%  Create set of ensembles with all models
%
%	Creates an ensemble with a set of nondominated models.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       X: Decision variables
%       eval: MOP function callback
%       data: Data structure
%   
%   Outputs:
%       best: best trained single model;
%
%--------------------------------------------------------------------------
%
%   Version Beta - Copyright 2018
%
%       For new releases and bug fixing of this Tool Set please send e-mail
%       to the authors.
%
%--------------------------------------------------------------------------
%
%   Institution:
%       Optimization, Modeling and Control Systems Research Group
%
%       Graduate Program in Industrial and Systems Engineering - PPGEPS
%           <https://www.pucpr.br/escola-politecnica/mestrado-doutorado/
%           engenharia-de-produc%CC%A7a%CC%83o-e-sistemas/>
%
%       Pontifical Catholic University of Paraná - Brazil.
%           <http://en.pucpr.br/>
%
%--------------------------------------------------------------------------
%
%	Authors:
%       Victor Henrique Alves Ribeiro
%           <victor.henrique@pucpr.edu.br>
%
%--------------------------------------------------------------------------
%
%   Publications:
%       <list publications>
% 

    %% Output ensemble
    
    % Create empty ensemble
    ens = custom_ensemble;
    
    % Add models to ensemble
    for m = 1 : size(X, 1)
        
        [~, ~, model] = eval(X(members(m), :), data, 'val');
        
        ens.models{m} = model;
        ens.features{m} = X(members(m), :) >= 0.5;
    end
end