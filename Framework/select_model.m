function [ranking] = rank_models(J, X)
%%  Rank models
%
%	Use MCDM to rank predictive models.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       J: Objectives
%       all_mdls: Ensemble with all nondominated trained models
%   
%   Outputs:
%       ranking: the ranking of models;
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
%       Pontifical Catholic University of Paran� - Brazil.
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
    
end