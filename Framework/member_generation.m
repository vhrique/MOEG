function [PFront, PSet] = member_generation(mop, data)
%%  Multi-objective Ensemble Member Generation
%
%	Returns a set of nondominated models using multi-objective
%	optimisation design.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       mop: MOP definition structure
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
        mop.n_obj, mop.n_var, ...
        @(x)mop.eval(x, data, 'val'), ...
        mop.lb', mop.ub');

    % Modifications
    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 2;
    spMODEDat.MAXFUNEVALS = 10000;
    spMODEDat.SeeProgress = 'yes';
    
    %% Run Optimization
    
    OUT = spMODE(spMODEDat);
    
    %% Optimization output
    
    PFront = OUT.PFront;
    PSet = OUT.PSet;
end