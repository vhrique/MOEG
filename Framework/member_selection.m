function [PFront, PSet] = member_selection(models, data)
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
%       PFront: Pareto front approximation;
%       PSet: Pareto seto approximation;
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
    
    %% Multi-object Problem

    % Problem definition
    mop = mop_member_selection(length(models), 11);%{'ACC', 'TPR', 'TNR', 'F1'});
    
    %% Multi-objective Optimization
    
    % Initialize optimization algorithm parameters 
    spMODEDat = create_spMODEparam(...
        mop.n_obj, mop.n_var, ...
        @(x)mop.eval(x, models, data, 'val'), ...
        mop.lb', mop.ub');

    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 2;
    spMODEDat.MAXFUNEVALS = 10000;
    spMODEDat.SeeProgress = 'yes';
    
    % Run optimization
    OUT = spMODE(spMODEDat);
    
    %% Optimization output
    
    PFront = OUT.PFront;
    PSet = OUT.PSet;
end