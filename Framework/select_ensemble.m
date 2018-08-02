function [ens] = select_ensemble(J, X, ENS)
%%  Create Ensemble of logistic regressor with MCDM
%
%	Creates an ensemble of models using multi-criteria decision making.
%
%   Version Beta - Copyright 2018
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
%	Authors:
%       Victor Henrique Alves Ribeiro
%           <victor.henrique@pucpr.edu.br>
%
%   Overall Description:
%       Creates an ensemble of models using multi-criteria decision making.
%
%       For new releases and bug fixing of this Tool Set please send e-mail
%       to the authors.
%
%   Publications:
%       <list publications>
%   
%   Inputs:
%       J: Pareto Front;
%       X: Pareto Set;
%       ENS: full ensemble;
%   
%   Outputs:
%       ens: selected ensemble of models;

    % Physical programming
    J = (J - min(J)) ./ (max(J) - min(J));
    matrix = repmat([0.0 0.1 0.2 0.4 0.6], size(J,2), 1);
    ranking = Rank_PhysicalProgramming(J, matrix);
    
    % Select best combination
    pareto_members = 1:size(X, 1);
    best_member = pareto_members(ranking(1));
    
    % Extract ensemble
    members = 1:size(ENS, 2);
    best_ensemble = members(X(best_member, :) >= 0.5);
    ens = ENS(1, best_ensemble);
end