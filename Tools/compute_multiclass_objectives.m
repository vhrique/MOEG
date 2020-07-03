function objectives = compute_multiclass_objectives(Y, y)

    %% Confusion Matrix
    conf = confusionmat(Y, y);
    
    %% Accuracy
    acc_all = sum(Y == y)/length(y);

    %% Class-specific accuracy
    acc = zeros(1, length(conf));
    for i = 1 : length(conf)
        acc(1, i) = conf(i, i) / sum(conf(i, :));
    end
    
    %% Return
    objectives = -[acc_all, acc];
end