%% Initialize datasets' names

datasets = {'data_water_2018_3'};
    
% Number of iterations
J = 1;
            
%% Initialize results variable

if exist('data/tmp/gecco_state.mat', 'file') == 2
    load 'data/tmp/gecco_state.mat';
else
    results = [];
    results_f1 = [];
    i = 1;
    j = 1;
end

%% For each dataset and iteration
for i = i : length(datasets)
    
    % Print State
    fprintf('Dataset (%d/%d): %s\n', i, length(datasets), datasets{i});
        
    for j = j : J
       
        % Save state
        save('data/tmp/gecco_state.mat', 'results', 'results_f1', 'i', 'j');

        % Print State
        fprintf('\tIteration: %d/%d\n', j, J);
        
        %% Load dataset
        data = f_preprocess_data(datasets{i});

        fprintf('\t\tData processed!\n');
        
        %% Create ensemble of Logistic Regressor
%         tic
% 
%         % Compute data size
%         n_features = size(data.x_train, 2);
% 
%         % Initialize parameters
%         mop.nvar = 2 * (n_features + 1);
%         mop.nobj = 5;
%         mop.lb = [zeros(1, n_features + 1), (-20 * ones(1, n_features + 1))];
%         mop.ub = [ones(1, n_features + 1), (20 * ones(1, n_features + 1))];
%         mop.eval = @f_mop_logistic;
%         
%         mop.nvar = n_features;
%         mop.nobj = 5;
%         mop.lb = zeros(1, n_features);
%         mop.ub = ones(1, n_features);
%         mop.eval = @f_mop_logitBin;
% 
%         mop.nvar = 2 * (n_features + 1);
%         mop.nobj = 5;
%         mop.lb = [zeros(1, n_features + 1), (-20 * ones(1, n_features + 1))];
%         mop.ub = [ones(1, n_features + 1), (20 * ones(1, n_features + 1))];
%         mop.eval = @f_mop_logitBin2;      
%         
%         % Create ensemble
%         [full, ens, best] = moeg(data, mop);
%         
%         fprintf('\t\tLR Ensemble created in %.1f seconds!\n', toc);
%         
%         % Evaluate best member
%         obj = f_evaluate_ensemble(best, data, 'test');
%         results(i, j, 1) = -obj(1);
%         results_f1(i, j, 1) = -obj(4);
%         
%         % Evaluate best ensemble
%         obj = f_evaluate_ensemble(ens, data, 'test');
%         results(i, j, 2) = -obj(1);
%         results_f1(i, j, 2) = -obj(4);
%         
%         % Save models
%         full_lr{i,j} = full;
%         ens_lr{i,j} = ens;
%         best_lr{i,j} = best;
%         
%         save('data/tmp/gecco_models_lr.mat', 'full_lr', 'best_lr', 'ens_lr');

        %% Create ensemble of ANN
%         tic
% 
%         % Compute data size
%         n_features = 85;
% 
%         % Initialize parameters
% %         mop.nvar = n_features;
% %         mop.nobj = 5;
% %         mop.lb = [-20 * ones(1, n_features)];
% %         mop.ub = [20 * ones(1, n_features)];
% %         mop.eval = @f_mop_ann;
%         
%         mop.nvar = n_features;
%         mop.nobj = 5;
%         mop.lb = [-20 * ones(1, n_features)];
%         mop.ub = [20 * ones(1, n_features)];
%         mop.eval = @f_mop_mlp;
%         
%         % Create ensemble
%         [full, ens, best] = moeg(data, mop);
%         
%         fprintf('\t\tANN Ensemble created in %.1f seconds!\n', toc);
%         
%         % Evaluate best member
%         obj = f_evaluate_ensemble(best, data, 'test');
%         results(i, j, 3) = -obj(1);
%         results_f1(i, j, 3) = -obj(4);
%         
%         % Evaluate best ensemble
%         obj = f_evaluate_ensemble(ens, data, 'test');
%         results(i, j, 4) = -obj(1);
%         results_f1(i, j, 4) = -obj(4);
%         
%         % Save models
%         full_ann{i,j} = full;
%         ens_ann{i,j} = ens;
%         best_ann{i,j} = best;
%         
%         save('data/tmp/gecco_models_ann.mat', 'full_ann', 'best_ann', 'ens_ann');

        %% Create ensemble of Decision Trees
        tic

        % Compute data size
        n_features = size(data.x_train, 2);

        % Initialize parameters
        mop.nvar = n_features;
        mop.nobj = 5;
        mop.lb = [zeros(1, n_features)];
        mop.ub = [ones(1, n_features)];
        mop.eval = @f_mop_tree;
        
        % Create ensemble
        [full, ens, best] = moeg(data, mop);
        
        fprintf('\t\tTree Ensemble created in %.1f seconds!\n', toc);
        
        % Evaluate best member
        obj = f_evaluate_ensemble(best, data, 'test');
        results(i, j, 5) = -obj(1);
        results_f1(i, j, 5) = -obj(4);
        
        % Evaluate best ensemble
        obj = f_evaluate_ensemble(ens, data, 'test');
        results(i, j, 6) = -obj(1);
        results_f1(i, j, 6) = -obj(4);
        
        % Save models
        full_tree{i,j} = full;
        ens_tree{i,j} = ens;
        best_tree{i,j} = best;
        
        save('data/tmp/gecco_models_tree.mat', 'full_tree', 'best_tree', 'ens_tree');

        %% Create ensemble of Support Vector Machines
        
%         tic
% 
%         % Compute data size
%         n_features = size(data.x_train, 2);
% 
%         % Initialize parameters
%         mop.nvar = n_features;
%         mop.nobj = 5;
%         mop.lb = [1, 2, zeros(1, n_features)];
%         mop.ub = [10, 2, ones(1, n_features)];
%         mop.eval = @f_mop_svm;
%         
%         % Create ensemble
%         [full, ens, best] = moeg(data, mop);
%         
%         fprintf('\t\tSVM Ensemble created in %.1f seconds!\n', toc);
%         
%         % Evaluate best member
%         obj = f_evaluate_ensemble(best, data, 'test');
%         results(i, j, 7) = -obj(1);
%         results_f1(i, j, 7) = -obj(4);
%         
%         % Evaluate best ensemble
%         obj = f_evaluate_ensemble(ens, data, 'test');
%         results(i, j, 8) = -obj(1);
%         results_f1(i, j, 8) = -obj(4);
%         
%         % Save models
%         full_svm{i,j} = full;
%         ens_svm{i,j} = ens;
%         best_svm{i,j} = best;
%         
%         save('data/tmp/gecco_models_svm.mat', 'full_svm', 'best_svm', 'ens_svm');

        %% Print results
        
        fprintf('\t\tFinal results collected!\n');
%         fprintf('\t\t\tLR:          %.2f%%\n', results_f1(i, j, 1) * 100);
%         fprintf('\t\t\tMOEG-LR:     %.2f%%\n', results_f1(i, j, 2) * 100);
%         fprintf('\t\t\tANN:         %.2f%%\n', results_f1(i, j, 3) * 100);
%         fprintf('\t\t\tMOEG-ANN:	%.2f%%\n', results_f1(i, j, 4) * 100);
        fprintf('\t\t\tDT:          %.2f%%\n', results_f1(i, j, 5) * 100);
        fprintf('\t\t\tMOEG-DT:     %.2f%%\n', results_f1(i, j, 6) * 100);
%         fprintf('\t\t\tSVM:         %.2f%%\n', results_f1(i, j, 7) * 100);
%         fprintf('\t\t\tMOEG-SVM:	%.2f%%\n', results_f1(i, j, 8) * 100);
        
    end
    
    j = 1;
end

%% Save results

filename = sprintf('data/results/results_%s.mat', date);
save(filename, 'results', 'results_f1');