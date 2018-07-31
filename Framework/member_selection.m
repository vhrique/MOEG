function [all_ens, ensemble] = f_member_selection(ens, data)
    %% Initialize optimization data

    % Initialize optimization parameters 
    nvar = size(ens, 2);
    nobj = 5;
    lb = zeros(1, nvar);
    ub = ones(1, nvar);
    mop = @(x)f_mop_ensemble(x, ens, data);
    spMODEDat = f_spMODEparam(nobj, nvar, mop, lb', ub');

    % Modifications
    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 200; % For testing
    spMODEDat.MAXFUNEVALS = 10000; % For testing
    spMODEDat.SeeProgress = 'yes';

    %% Run optimization

    OUT = spMODE(spMODEDat);
    
    %% Select best ensemble with MCDM
    
    ensemble = f_select_ensemble(OUT.PFront(:, [1, 4, 5]), OUT.PSet, ens);
    all_ens = OUT.PSet;

%     %% Save data
% 
%     filename = sprintf('data/tmp/member_selection.mat');
%     
%     save(filename, 'OUT', 'ensemble', 'data');
%     
%     filename = sprintf('data/results/member_selection_%s_%s.mat', ...
%         data.dataset, date);
%     
%     save(filename, 'OUT', 'ensemble', 'data');
end