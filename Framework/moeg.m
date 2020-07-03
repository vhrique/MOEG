function [PFg, PSg, Rg, Ig, PFs, PSs, Rs, Is] = MOEG(data, mop)
%%  Multi-objective Framework for Ensemble Generation
%
%	Creates an ensemble of models using multi-objective optimisation
%	design.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       data: Data structure
%       mop: MOP definition class
%       opt: MOEG options structure
%   
%   Outputs:
%       PFg: Member generation Pareto front approximation;
%       PSg: Member generation Pareto set approximation;
%       Rg: Member generation models' ranking;
%       Ig: Member generation models' index;
%       PFs: Member selection Pareto front approximation;
%       PSs: Member selection Pareto set approximation;
%       Rs: Member selection ensembles' ranking;
%       Is: Member selection ensembles' index;
%
%--------------------------------------------------------------------------
%
%   Version Beta - Copyright 2018
%
%       For new releases and bug fixing of this toolbox, please send e-mail
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

    %% Member generation
    
    [PFg, PSg] = member_generation(mop, data);
    
    %% Create a set with all trained classifiers
    
    all_mdls = create_models(PSg, @(x)mop.eval(x, data, 'val'));
    
    %% Member selection
    
    [PFs, PSs] = member_selection(all_mdls, data);
    
    %% Multi-criteria Decision Making:
    
    [Rg, Ig] = rank_models(PFg(:, 1:4));
    [Rs, Is] = rank_models(PFs(:, 1:4));
    
end

