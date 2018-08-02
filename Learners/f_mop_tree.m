function [objectives, decision_var, mdl] = f_mop_tree(decision_var, data, mode)
%%  Decision Tree MOP
%
%	Formalizes a multi-objective problem for the creation of Decision
%	Trees.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       decision_var: Feature subset.
%           Size: number of features;
%           Lower Bounds: [0 ... 0];
%           Upper Bounds: [1 ... 1].
%       data: validation or test data.
%   
%   Outputs:
%       objectives:  Error, number of features (complexity).
%       decision_var: feature selection vector;
%       mdl: trained model
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

    %% Adjust features
    
    % Select features
    features = decision_var >= 0.5;
    
    % If no features are selected, use only first.
    if sum(features) == 0
        features(1) = 1;
    end
    
    %% Adjust data
    
    % Training set
    X_train = data.x_train(:, features);
    Y_train = data.y_train;
    
    % Test set
    switch mode
        case 'val'
            X = data.x_val(:, features);
            Y = data.y_val;
        case 'test'
            X = data.x_test(:, features);
            Y = data.y_test;
    end
    
    %% Model
    
    % Train model
    mdl = fitctree(X_train, Y_train);
    
    % Predict
    y = predict(mdl, X);
    
    %% Objectives
    
    % Classification Error
    objectives(1) = sum(y ~= Y) / length(Y);
    
    % Complexity
    objectives(2) = sum(features);
end