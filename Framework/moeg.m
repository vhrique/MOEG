function [best_ens, best_mdl, all_ens, all_mdl] = MOEG(data, mop)
%%  Multi-objective Framework for Ensemble Generation
%
%	Creates an ensemble of models using multi-objective optimisation
%	design.
%
%--------------------------------------------------------------------------
%
%   Inputs:
%       data: Data structure
%       mop: MOP definition structure
%       opt: MOEG options structure
%   
%   Outputs:
%       best_ens: best trained ensemble of models;
%       best_mdl: best trained single model;
%       all_ens: all trained ensemble of models;
%       all_mdl: all trained single models;
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

    %% Member generation
    
    [all_mdl, best_mdl] = member_generation(data, mop);
    
    %% Member selection
    
    [all_ens, best_ens] = member_selection(all_mdl, data);

end

