function [best_mdl] = select_model(J, all_mdls)
%%  Select best single model
%
%	Among a set of nondominated models, the best one is selected with MCDM.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       J: Objectives
%       all_mdls: Ensemble with all nondominated trained models
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
    
    %% Select best model using Physical Programming
    % TODO: improve preference matrix
    
    n_J = (J - min(J)) ./ (max(J) - min(J));
    matrix = repmat([0.0 0.1 0.2 0.4 0.6], size(J,2), 1);
    ranking = Rank_PhysicalProgramming(n_J, matrix);
    
    best_mdl = all_mdls{ranking(1)};
    
end