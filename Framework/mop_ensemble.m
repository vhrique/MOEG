%%  Select members for Ensemble of logistic regressors
%
%	Formalizes a MOP for the selection of members for an ensemble.
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
%       Selects members for an ensemble learner.
%
%       For new releases and bug fixing of this Tool Set please send e-mail
%       to the authors.
%
%   Publications:
%       <list publications>
%   
%   Inputs:
%       X: Selected learners;
%       ENS: Ensemble;
%       data: evaluation data;
%   
%   Outputs:
%       J: objectives;
%       X: Selected learners;
% 

function [J, X] = mop_ensemble(X, ens, data)
    
    all_members = 1 : size(X, 2);
    
    mask = (X >= 0.5);
    
    if sum(mask) == 0
        selected_members = all_members;
    else
        selected_members = all_members(mask);
    end
    
    ENS = ens(selected_members);
    
    J = evaluate_ensemble(ENS, data, 'test');
    
end