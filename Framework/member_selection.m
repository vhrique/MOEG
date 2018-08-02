function [all_ens, best_ens] = member_selection(models, data)
%%  Multi-objective Ensemble Member Selection
%
%	Creates a set of nondominated ensembles using multi-objective
%	optimisation design.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       models: Set of nondominated trained models
%       data: Data structure
%   
%   Outputs:
%       all_ens: all nondominated trained ensembles models;
%       best_mdl: best trained ensemble model (selected with MCDM);
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

    %% Initialize optimization data

    % Initialize optimization parameters 
    nvar = length(models);
    nobj = 2;
    lb = zeros(1, nvar);
    ub = ones(1, nvar);
    mop = @(x)mop_ensemble(x, models, data);
    spMODEDat = create_spMODEparam(nobj, nvar, mop, lb', ub');

    % Modifications
    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 200;
    spMODEDat.MAXFUNEVALS = 10000;
    spMODEDat.SeeProgress = 'yes';

    %% Run optimization

    % Optimization algorithm
    OUT = spMODE(spMODEDat);
    
    % Optimization output
    J = OUT.PFront;
    X = OUT.PSet;
    
    %% Create a set with all trained ensembles
    
    all_mdls = create_ensembles(PSet, mop.eval, data);
    
    %% Select best classifier using MCDM

    best_mdl = select_model(PFront, all_mdls);
end