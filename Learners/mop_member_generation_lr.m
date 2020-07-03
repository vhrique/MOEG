classdef mop_member_generation_lr
%%  LR Member Generation Multi-objective Problem definition for MOEG
%
%	A class for the definition of a Logistic Regression member 
%   generation multi-objective problem, to be used by the MOEG framework.
%
%--------------------------------------------------------------------------
%
%   Properties:
%       n_obj:
%           Number of objectives
%       n_var:
%           Number of decision variables
%       lb:
%           Decision variables' lower bound
%       ub:
%           Decision variables' upper bound
%
%   Methods:
%       mop_member_generation_tree:
%           Initializes the object.
%       eval:
%           MOP function callback
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
    
    properties
        objectives = {};
        n_obj = 1
        n_var = 1
        lb = 0
        ub = 1
    end
    
    methods
        function obj = mop_member_generation_lr(nvar, objectives)
            obj.n_var = 2 * nvar;
            
            obj.objectives = objectives;
            obj.n_obj = length(objectives) + 1;
            
            obj.lb = [zeros(1, nvar), -20 * ones(1, nvar)];
            obj.ub = [ones(1, nvar), 20 * ones(1, nvar)];                        
        end
        
        function [objectives, decision_var, mdl, features, complexity] = eval(obj, decision_var, data, mode)
            %% Adjust features

            % Extract features and weights
            features = decision_var(1:end/2) >= 0.5;
            weights = decision_var(end/2+1:end);

            % If no features are selected, penalize.
            if sum(features .* weights) == 0
                complexity = 1000;
                objectives = [ones(1, 4), 1000];
                mdl = {};
                return;
            end

            %% Adjust data

            % Training set
            X_train = data.x_train;
            Y_train = data.y_train;

            % Test set
            switch mode
                case 'val'
                    X = data.x_val;
                    Y = data.y_val;
                case 'test'
                    X = data.x_test;
                    Y = data.y_test;
            end

            %% Model

            % Train model
            mdl = fitclr(X_train(:, features), Y_train, weights(features));

            % Predict
            y = predict(mdl, X(:, features));

            %% Objectives
            % Classification Measures and Complexity
            complexity = sum(features .* abs(weights));
            objectives = [compute_binary_objectives(Y, y, obj.objectives), complexity];
        end
    end
    
end

