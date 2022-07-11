clear
clc

% Backward greedy algorithm: main code (IIGB)
funct = @ammonia_rel_exp; % demonstrated using ammonia expression


lambda = [0.0393212829757871	0.0789988503572366	0.0769869276489643	8.91154415336837	2.64536746236903	0.0641335068711560	1.78450107789245	0.0251854271830586]';
nvar = 8;
cost = ones(1, nvar);

tmin = 0;
tmax = 10; % in yrs


max_cost = 3;
senPerVarMax = 2;

sensor_ip = senPerVarMax*ones(1, nvar);
approach = [1, 1]; % applying simple greedy only

% calculation reference density
% Manually calculating integrand
sen_f = senPerVarMax*ones(1, nvar); % all vars are measured

tinst = tmin:0.01:tmax; % kld_integral_calc.m also has delt=0.01; make changes accordingly
len = length(tinst);
f_ref_pdf = zeros(len,1);
for i = 1:len
    f_ref_pdf(i) = funct(tinst(i), sen_f, lambda);
end

[dkl_app1, xVal_app1, cost_store_app1, dkl_app2, xVal_app2, cost_store_app2] = ...
    backward_heuristics(sensor_ip, cost, max_cost, tmin, tmax, approach, lambda, funct, f_ref_pdf);
