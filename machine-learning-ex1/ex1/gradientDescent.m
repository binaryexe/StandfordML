function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT Performs gradient descent to learn theta
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) updates theta by 
%   taking num_iters gradient steps with learning rate alpha

% Initialize some useful values
m = length(y); % number of training examples
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCost) and gradient here.
    %
	h_theta = X * theta;
	%disp( itr);
	%disp( theta);
	cost_i = h_theta - y;
	%disp(cost_i);
	%disp(X);

	cost_j = cost_i' * X;
	%disp(size(cost_j));
	theta = theta - ((alpha/m) * cost_j');
	%disp(theta);
	%J = (cost_i .* cost_i)/(2*m);
	%disp(double(sum(J)));
	%pause;






    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCost(X, y, theta);

end

end
