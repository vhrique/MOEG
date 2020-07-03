classdef mop_member_generation_tree
%%  Tree Member Generation Multi-objective Problem definition for MOEG
%
%	A class for the definition of an Decision Trees member generation
%   multi-objective problem, to be used by the MOEG framework.
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
        function obj = mop_member_generation_tree(nvar, objectives)
            obj.n_var = nvar;
            
            obj.objectives = objectives;
            
            obj.n_obj = objectives + 1;
%             obj.n_obj = length(objectives) + 1;
            
            obj.lb = zeros(1, nvar);
            obj.ub = ones(1, nvar);                        
        end
        
        function [objectives, decision_var, mdl, features, complexity] = eval(obj, decision_var, data, mode)
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
            % Classification Measures and Complexity
            complexity = sum(features);
            %objectives = [compute_binary_objectives(Y, y, obj.objectives), complexity];
            objectives = [compute_multiclass_objectives(Y, y), complexity];
        end
    end
    
end

