classdef mop_member_selection
%%  Member Selection Multi-objective Problem definition for MOEG
%
%	A class for the definition of an ensemble member selection
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
%       mop_member_selection:
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
        function obj = mop_member_selection(nvar, objectives)
            obj.n_var = nvar;
            
            obj.objectives = objectives;
            
%             obj.n_obj = length(objectives) + 1;
            obj.n_obj = objectives + 1;
            
            obj.lb = zeros(1, nvar);
            obj.ub = ones(1, nvar);                        
        end
        
        function [objectives, decision_var, ens] = eval(obj, decision_var, models, data, mode)
            %% Adjust member selection

            % Adjust decision variables
            selected_members = (decision_var >= 0.5);

            % If no member is selected, penalize
            if sum(selected_members) < 3
                complexity = 1000000;
                objectives = [ones(1, 4), complexity];
                ens = {};
                return;
            end

            %% Adjust data

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

            % Create new ensemble
            ens = custom_ensemble;
            ens.mode = 'classification';
            ens.classes = unique(Y)';

            % Loop through members
            idx = 0;
            for e = 1:length(selected_members)

                if(selected_members(e))

                    idx = idx + 1;

                    ens.models{idx} = models{e}.model;
                    ens.features{idx} = models{e}.features;
                end
            end

            % Predict
            y = predict(ens, X);

            %% Compute Objectives
            
            % Complexity
            complexity = 0;
            for e = 1:length(selected_members)
                if(selected_members(e))
                    complexity = complexity + models{e}.complexity;
                end
            end
            
            % Return objectives
%             objectives = [compute_binary_objectives(Y, y, obj.objectives), complexity];
            objectives = [compute_multiclass_objectives(Y, y), complexity];
        end
    end
end

