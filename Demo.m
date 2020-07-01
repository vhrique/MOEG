%% Data preparation

% Load and adjust data
load ionosphere.mat
Y = strcmp(Y, 'g');

% Create data structure
[train, val, test] = dividerand(length(Y), 0.6, 0.2, 0.2);

data.x_train = X(train, :);
data.y_train = Y(train);
data.x_val = X(val, :);
data.y_val = Y(val);
data.x_test = X(test, :);
data.y_test = Y(test);

data.dataset = 'ionosphere';

%% Create ensemble of Decision Trees

% start timer
tic

% Initialize problem
mop = mop_member_generation_tree(size(data.x_train, 2));

% Create ensemble
[best_ens, best_mdl, all_ens, all_mdl] = MOEG(data, mop);

% End
time_s = toc;
fprintf('\t\tTree Ensemble created in %.1f seconds!\n', time_s);