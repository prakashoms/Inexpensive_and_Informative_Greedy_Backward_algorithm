function rel = ammonia_rel_exp(t, x, lambda)

x = reshape(x,[length(x),1]); % make sure it is colm vec

x = (1 - exp(- lambda * t)) .^ repmat(x,1, length(t)) ; % failure prob dist

x1=x(1,:); x2=x(2,:); x3=x(3,:); x4=x(4,:); x5=x(5,:); x6=x(6,:); x7=x(7,:); x8=x(8,:);
y1 = 1-x(1,:);
y2 = 1-x(2,:);
y3 = 1-x(3,:);
y4 = 1-x(4,:);
y5 = 1-x(5,:);
y6 = 1-x(6,:);
y7 = 1-x(7,:);
y8 = 1-x(8,:);

rel = 1 - (x6.*x7.*x8+(1-x6.*x8).*x4.*x5.*x7+y7.*x4.*x5.*x6.*x8+((1-x4.*x8).*y7+x7.*y4.*y8).*x1.*x2.*x3.*x5.*x6+((1-x5.*x6).*y7+x7.*y5.*y6).*x1.*x2.*x3.*x4.*x8+y6.*y4.*x1.*x2.*x3.*x5.*x7.*x8+y8.*y5.*x1.*x2.*x3.*x4.*x6.*x7);
