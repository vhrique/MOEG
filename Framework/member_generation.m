function [ensemble, best_member] = f_member_generation(data, mop)
    %% Initialize optimization data
    
    % Initialize optimization data
    spMODEDat = f_spMODEparam(...
        mop.nobj, mop.nvar, ...
        @(x)mop.eval(x, data, 'val'), ...
        mop.lb', mop.ub');

    % Modifications
    spMODEDat.Alphas = 10;
    spMODEDat.MAXGEN = 200;
    spMODEDat.MAXFUNEVALS = 10000;
    spMODEDat.SeeProgress = 'yes';
    
    %% Run optimization
    
    % Optimize
    OUT = spMODE(spMODEDat);
    
    %% Select best classifier with MCDM
    
    options.type = 'rank';
    options.number = 1;

    best_member = f_create_ensemble(...
        OUT.PFront(:, [1, 4, 5]), OUT.PSet, mop.eval, options, data);
    
    %% Create ensemble with all generated classifiers

    options.type = 'full';
    
    ensemble = f_create_ensemble(OUT.PFront, OUT.PSet, mop.eval, options, data);

%     %% Save data
% 
%     filename = sprintf('data/tmp/member_generation.mat');
%     
%     save(filename, 'OUT', 'data', 'best_member', 'ensemble');
%     
%     filename = sprintf('data/results/member_generation_%s_%s.mat', ...
%         data.dataset, date);
%     
%     save(filename, 'OUT', 'data', 'best_member', 'ensemble');
end