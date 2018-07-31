%%  Evaluate Ensemble of Logistic regressors
%
%	Evaluates an ensemble of logistic regressors.
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
%       Evaluates an ensemble of logistic regressors.
%
%       For new releases and bug fixing of this Tool Set please send e-mail
%       to the authors.
%
%   Publications:
%       <list publications>
%   
%   Inputs:
%       ens: A set of trained logistic regressors.
%       data: training, test and validation data.
%       mode: type of data
%           'test'
%            'val'
%   
%   Outputs:
%       J: -Accuracy, -Sensitivity, -Specificity, -F1 score, +Complexity
%           Size: 5.
% 

function [J] = f_evaluate_ensemble(ens, data, mode)
    
    ensemble_size = size(ens, 2);
    
    % Select evaluation dataset
    switch mode
        case 'test'
            Y = data.y_test == 1;
            y_all = [ens(:).y_test];
        case 'val'
            Y = data.y_val == 1;
            y_all = [ens(:).y_val];
    end
    
    % Majority voting
    y_ens = (sum(y_all, 2)/ensemble_size) >= 0.5;
    if isempty(ens)
        y_ens = ~Y;
    end
    
    % Calculate objectives
    obj = f_objectives(Y, y_ens);
    
    complexity = 0;
    for e = 1 : ensemble_size
        complexity = complexity + ens(e).J(end);
    end
    
    J = [obj, complexity];
end