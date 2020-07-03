function objectives = compute_binary_objectives(Y, y, metrics)

    %% Compute TP, FP, TN and FN
    tp = sum(Y & y);
    fp = sum(~Y & y);
    fn = sum(Y & ~y);
    tn = sum(~Y & ~y);
    
    %% Compute metrics
    
    % Initialize empty objectives vector
    objectives = zeros(1, length(metrics));
    
    % For each objective
    for i = 1 : length(metrics)
        
        switch metrics{i}
            case 'TPR'
                objectives(i) = -(tp / (tp + fn));
            case 'TNR'
                objectives(i) = -(tn / (tn + fp));
            case 'PPV'
                objectives(i) = -(tp / (tp + fp));
            case 'NPV'
                objectives(i) = tn / (tn + fn);
            case 'FNR'
                objectives(i) = fn / (fn + tp);
            case 'FPR'
                objectives(i) = fp / (fp + tn);
            case 'FDR'
                objectives(i) = fp / (fp + tn);
            case 'ERR'
                objectives(i) = (fp + fn) / (tp + tn + fp + fn);
            case 'ACC'
                objectives(i) = -((tp + tn) / (tp + tn + fp + fn));
            case 'F1'
                objectives(i) = -(2 * tp / (2 * tp + fp + fn));
            case 'MCC'
                objectives(i) = -((tp*tn - fp*fn)/sqrt((tp + fp)*(tp + fn)*(tn + fp)*(tn + fn)));
        end
    end
end