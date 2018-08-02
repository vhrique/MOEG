function [objectives, decision_var, ens] = mop_ensemble(decision_var, models, data)
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
%       decision_var: Decision variables (selected models);
%       models: Set of nondominated models;
%       data: Evaluation data;
%   
%   Outputs:
%       objectives: Objectives;
%       decision_var: Decision variables;
%       ens: Ensemble with selected members;
% 
    
    %% Adjust member selection
    
    % Adjust decision variables
    selected_members = (decision_var >= 0.5);
    
    % If no member is selected, use all
    if sum(selected_members) == 0
        selected_members = selected_members + 1;
    end
    
    %% Adjust data
    
    % Test set
    X = data.x_val;
    Y = data.y_val;
    
    %% Model
    
    % Create new ensemble
    ens = custom_ensemble;
    ens.models = models{selected_members}.mdl;
    ens.features = models{selected_members}.features;
    
    % Predict
    y = predict(ens, X);
    
    %% Compute Objectives
    
    % Classification Error
    objectives(1) = sum(y ~= Y) / length(Y);
    
    % Complexity
    objectives(2) = sum(selected_members);
    
end