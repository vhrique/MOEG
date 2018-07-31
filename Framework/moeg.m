function [full_ensemble, best_ensemble, best_member, all_ens] = moeg(data, mop)
%%  MOEG Multi-objective Ensemble Generation
%   Detailed explanation goes here

    %% Member generation
    
    [full_ensemble, best_member] = member_generation(data, mop);
    
    %% Member selection
    
    [all_ens, best_ensemble] = member_selection(full_ensemble, data);

end

