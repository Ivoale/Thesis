function [Yt, It] = Thresh_2(X,threshold)
% Threshold the targets to be 1 or 0
% Returns the positions of the targets
% X is the data from standard deviation

hysteresis = 0.1*threshold;  % use this to stop chattering around a fixed value

if threshold < 0
    thresholdHI = threshold - hysteresis;
    thresholdLO = threshold + hysteresis;
else
    thresholdHI = threshold + hysteresis;
    thresholdLO = threshold - hysteresis;
end

[Nb Nf] = size(X);
Yt = zeros(Nb,Nf);


for k = 1:Nf
    
    y = X(:,k);
    i = 1;
    tmp = y(1);
    if tmp > threshold(i,k)
        Yt(i,k) = 1;
        It(i,k) = 1;
        last_tmp = 1;
    else
        Yt(i,k) = 0;
        It(i,k) = 1;
        last_tmp = 0;
    end;
    
    i = 2;
    for j = 2:Nb
        
        % Check current state to get threshold value:
        if last_tmp == 0
            threshold2 = thresholdHI(i,k);
        else
            threshold2 = thresholdLO(i,k);
        end
        
        tmp = X(j,k);
        if tmp > threshold2
            Yt(j,k) = 1;
            % Check for sign change
            if last_tmp == 0
                It(i,k) = j;
                i = i + 1;
                last_tmp = 1;
            end
        else
            Yt(j,k) = 0;
            % Check for sign change
            if last_tmp == 1
                It(i,k) = j;
                i = i + 1;
                last_tmp = 0;
            end
        end;
    end;
    
    % Add last entry to index:    
    
    It(i,k) = Nb;
end

end