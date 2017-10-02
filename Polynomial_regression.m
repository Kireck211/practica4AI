dim=5;
h = figure();
title('Output values');

axis([-dim dim -dim dim]);

hold on
index = 1;
data = zeros(1,2);
while(1)
    [x,y,b] = ginput(1);
    if( length(b) == 0 )
        break;
    endif
    plot(x, y, "b+");
    data(index, :) = [x y];
    index++;
endwhile

y = data(:, 2);
m = length(y);
X = data(:, 1);

%Feature Scaling
mu = zeros(1, size(X, 2)); %vector of 1 row by the number of features
stddev = zeros(1, size(X, 2)); %vector of 1 row by the number of features

% Calculates mean and std dev for each feature
%for i=1:size(mu,2)
%    mu(1,i) = mean(X(:,i)); 
%    stddev(1,i) = std(X(:,i));
%    X(:,i) = (X(:,i)-mu(1,i))/stddev(1,i);
%end

X = [ones(m, 1), X(:,1) ,X(:,1).^2 ,X(:,1).^3 ];

d=size(X,2);
theta = zeros(d,1);
%theta = rand(d,1);

iterations = 500;
alpha = 0.001;
J = zeros(1,iterations);
for iter = 1:iterations
    theta -= ( (1/m) * ((X * theta) - y)' * X)' * alpha;

    plot(-dim:0.01:dim, theta(1) + (-dim:0.01:dim).*theta(2) + (-dim:0.01:dim).^2.*theta(3) + (-dim:0.01:dim).^3.*theta(4), "g-");
    J(iter) = sum( (1/m) * ((X * theta) - y)' * X);
end

plot(-dim:0.01:dim, theta(1) + (-dim:0.01:dim).*theta(2) + (-dim:0.01:dim).^2.*theta(3) + (-dim:0.01:dim).^3.*theta(4) , "r-"); 
title('Polynomial hypotesis');

figure()
plot(1:iter, J);
title('Cost Function');