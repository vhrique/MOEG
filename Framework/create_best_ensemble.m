%% Create all models

mop1 = mop_member_generation_tree(size(data.x_train, 2));

mdls = create_models(PSg, @(x)mop1.eval(x, data, 'val'));

%% Select best ensemble

PSs_best = select_model(PFs, PSs);

%% Create best ensemble

mop2 = mop_member_selection(length(mdls));

ens = create_ensembles(PSs_best, @(x)mop2.eval(x, mdls, data));

%% Create full ensemble

full_ens = create_ensembles(ones(1,length(mdls)), @(x)mop2.eval(x, mdls, data));