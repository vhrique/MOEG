function [all_mdls, best_mdl] = member_generation(data, mop)
%%  Multi-objective Ensemble Member Generation
%
%	Creates a set of nondominated models using multi-objective
%	optimisation design.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       data: Data structure
%       mop: MOP definition structure
%   
%   Outputs:
%       all_mdl: all nondominated trained single models;
%       best_mdl: best trained single model (selected with MCDM);
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
%       Pontifical Catholic University of Paran� - Brazil.
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
    spMODEDat = create_spMODEparam(...
        mop.nobj, mop.nvar, ...
        @(x)mop.eval(x, data, 'val'), ...
        mop.lb', mop.ub');

    % Modifications
    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 200;
    spMODEDat.MAXFUNEVALS = 10000;
    spMODEDat.SeeProgress = 'yes';
    
    %% Run Optimization
    
    % Optimization algorithm
    OUT = spMODE(spMODEDat);
    
    % Optimization output
    PFront = OUT.PFront;
    PSet = OUT.PSet;
    
    %% Create a set with all trained classifiers
    
    all_mdls = create_models(PSet, mop.eval, data);
    
    %% Select best classifier using MCDM

    best_mdl = select_model(PFront, all_mdls);
    
end