classdef fitclr
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        weights
    end
    
    methods
        function obj = fitclr(X, Y, weights)
            obj.weights = weights;
        end
        function y = predict(obj, X)
            p = X * obj.weights';
            y = (1 ./ (1 + exp(-p))) >= 0.5;
        end
    end
    
end

