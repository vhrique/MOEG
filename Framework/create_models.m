function [models] = create_models(X, eval, data)
%%  Create a set of trained models
%
%	Creates a set of nondominated trained models.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       X: Decision variables
%       eval: MOP function callback
%       data: Data structure
%   
%   Outputs:
%       models: a set of trained models and selected features;
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

    %% Output models
    
    % for each nondominated solution
    for m = 1 : size(X, 1)
        
        % Prepare features
        models{m}.features = X(m, :) >= 0.5;
        
        % Train model
        [~, ~, models{m}.model] = eval(X(models{m}.features, :), data, 'val');
    end
end