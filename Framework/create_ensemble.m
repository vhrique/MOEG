function [ENS] = f_create_ensemble(J, X, eval, options, data)
%%  Create Ensemble of logistic regression with MCDM
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
%       J: Pareto Front.
%       X: Feature selection and weight vectors.
%           Size: 2 * Number of features;
%       eval: MOP function;
%       data: training and test data;
%       options: Options ensemble generation method:
%           options.type:
%               'full': all data from pareto set;
%               'best': The best model;
%               'rank': The 'options.number' best ranked;
%           options.number: number of members.
%   
%   Outputs:
%       ENS: trained ensemble of models;
% 
    
    %% Select members
    
    members = 1:size(X, 1);
    
    switch options.type
        case 'full'
            %members = members;
        case 'best'
            % TODO: improve
            members = members(sum(J == min(J), 2) ~= 0);
        case 'rank'
            % TODO: improve preference matrix
            n_J = (J - min(J)) ./ (max(J) - min(J));
            matrix = repmat([0.0 0.1 0.2 0.4 0.6], size(J,2), 1);
            ranking = Rank_PhysicalProgramming(n_J, matrix);
            members = members(ranking(1:options.number));
    end
    
    %% Output ensemble
    
    for m = 1 : length(members)
        
        ENS(m).X = X(members(m), :);
        ENS(m).J = J(members(m), :);
        
        [~, ~, ENS(m).y_val] = eval(ENS(m).X, data, 'val');
        [~, ~, ENS(m).y_test] = eval(ENS(m).X, data, 'test');
    end
end