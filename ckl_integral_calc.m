function kld = ckl_integral_calc(tmin, tmax, sen_g, lambda, funct, f_ref_pdf)


% Manually calculating integrand
tinst = tmin:0.01:tmax;
len = length(tinst);
kl_inst = zeros(len,1);

idx = 0;
for i = 1:len
    f_ref = f_ref_pdf(i);
    g_des = funct(tinst(i), sen_g, lambda);
    if (f_ref < 1e-10 || g_des < 1e-10)
        if i == 1
            idx = 1;
        end
        break
    end
    % this exp is CRKL
    kl_inst(i) = f_ref * (log( f_ref / g_des ) + ( g_des / f_ref ) - 1 );
end

if (any(isinf(kl_inst)) || any(isnan(kl_inst)) || ~isreal(kl_inst))
    disp('CRKL is either inf, nan, or complex. Check!')
    pause
end

len = length(tinst);
kl_trapz = zeros(1,len);
for j = 1:len-1
    kl_trapz(j) = 0.5 * (tinst(j+1) - tinst(j)) * ( kl_inst(j) + kl_inst(j+1) );
    
end
kld = sum(kl_trapz);

if idx == 1 % if 1st element is 0 then rdes is almost 0, crkl is undefined (large value is chosen)
    kld = 1000; % Note this 1000 < 10000 (this is used in backward_heuristics.m)
end

end