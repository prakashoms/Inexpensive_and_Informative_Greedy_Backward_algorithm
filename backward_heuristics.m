function [dkl_app1, xVal_app1, cost_store_app1, dkl_app2, xVal_app2, cost_store_app2] = ...
    backward_heuristics(sensor_ip, cost, max_cost, tmin, tmax, approach, lambda, funct, f_ref_pdf)

% Approach = [a1,a2], Simple Greedy- a1=1, Inexpensive Greedy- a2=1
nVars = length(sensor_ip); % b in sensor_ip indicates b sensors measuring that var

% Approach 1: Simple backward greedy approach (BG)
costUsed = cost*sensor_ip';
dkl_app1(1) = ckl_integral_calc(tmin, tmax, sensor_ip', lambda, funct, f_ref_pdf); % sensor_ip' is a colm vector
xVal_app1(1,:) = sensor_ip;
cost_store_app1(1) = costUsed;

if approach(1) == 1 % Simple Greedy
    
    x0 = sensor_ip;
    x1 = sensor_ip;
    sen0 = [];
    
    rem_sen = 2;
    while costUsed > max_cost
        
        dfdx = zeros(1,nVars);
        for i = 1:nVars
            if x1(i) >= 1 % remove sen only when it is >= 1
                x1(i) = x1(i) - 1;
                f1(i) = ckl_integral_calc(tmin, tmax, x1', lambda, funct, f_ref_pdf);
                f0 = dkl_app1(rem_sen-1);
                dfdx(i) = (f1(i) - f0); % Simple Greedy % dfdx will be +ve
                x1(i) = x1(i) + 1;
            elseif x1(i) == 0
                sen0 = [sen0 i];
            end
        end
        dfdx(unique(sen0)) = 10000;
        [M,~] = min(dfdx); % CRKL will increase with removal of sensors
        % dfdx will be +ve
        
        %%% --- Checking for multiple same increase % Comment it if it is not
        %%% required
        mindf = find(dfdx == M);
        [~,idx_df] = max( cost(mindf) ); % costly sensors will be removed
        I = mindf(idx_df);
        %%% ---
        
        if ismember(I,sen0)
            print('Error catch in Approach 1: sensor rejected may not be the right one.')
            pause
            continue
        end
        
        costUsed = costUsed - cost(I);
        x0(I) = x0(I) - 1;
        x1 = x0;
        dkl_app1(rem_sen) = f1(I);
        xVal_app1(rem_sen,:) = x0;
        cost_store_app1(rem_sen) = costUsed;
        
        rem_sen = rem_sen + 1;
        
    end
    clear f1 f0
end
%
% Approach 2: Inexpensive Greedy

costUsed = cost*sensor_ip';
dkl_app2(1) = ckl_integral_calc(tmin, tmax, sensor_ip', lambda, funct, f_ref_pdf);
xVal_app2(1,:) = sensor_ip;
cost_store_app2(1) = costUsed;

if approach(2) == 1 % Inexpensive backward greedy approach (IBG)
    x0 = sensor_ip;
    x1 = sensor_ip;
    sen0 = [];
    
    rem_sen = 2;
    while costUsed > max_cost
        
        dfdx = zeros(1,nVars);
        for i = 1:nVars
            if x1(i) >= 1 % remove sen only when it is >= 1
                x1(i) = x1(i) - 1;
                f1(i) = ckl_integral_calc(tmin, tmax, x1', lambda, funct, f_ref_pdf);
                f0 = dkl_app2(rem_sen-1);
                dfdx(i) = (f1(i) - f0)/cost(i); % Inexpensive Greedy % dfdx will be +ve
                x1(i) = x1(i) + 1;
            elseif x1(i) == 0
                sen0 = [sen0 i];
            end
        end
        dfdx(unique(sen0)) = 10000;
        [M,~] = min(dfdx); % CRKL will increase with removal of sensors
        % dfdx will be +ve
        
        %%% --- Checking for multiple same increase % Comment it if it is not
        %%% required
        mindf = find(dfdx == M);
        [~,idx_df] = max( cost(mindf) ); % costly sensors will be removed
        I = mindf(idx_df);
        %%% ---
        
        if ismember(I,sen0)
            print('Error catch in Approach 2: sensor rejected may not be the right one.')
            pause
            continue
        end
        
        costUsed = costUsed - cost(I);
        x0(I) = x0(I) - 1;
        x1 = x0;
        dkl_app2(rem_sen) = f1(I);
        xVal_app2(rem_sen,:) = x0;
        cost_store_app2(rem_sen) = costUsed;
        
        rem_sen = rem_sen + 1;
    end
    clear f1 f0
end

end