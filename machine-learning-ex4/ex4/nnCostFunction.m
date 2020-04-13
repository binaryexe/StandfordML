function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% Theta1 has size 25 x 401

% X = 5000 x 400
X = [ones(m,1) X];
z2 = X * Theta1';
a2 = sigmoid(z2);


a2 = [ones(size(a2,1), 1) a2];
% a2 - 5000 x 26
% Theta2 has size 10 x 26
z3 = a2 * Theta2';
% a3 = z3 = 5000 x 10

a3 = sigmoid(z3);

% implemetation of H_Theta(x)
% step 1 - calculate value for every label
hx_log1 = log(a3);
hx_log2 = log(1 - a3);


theta1_temp = Theta1;
theta1_temp(:, 1) = 0;
theta2_temp = Theta2;
theta2_temp(:, 1) = 0;


reg_term  = sum(sum(theta1_temp.^2)) + sum(sum(theta2_temp.^2));

for i = 1:m
	J = J  - (hx_log1(i, y(i)) + sum(hx_log2(i,:)) - hx_log2(i, y(i)));
end

J = J/m;

J = J + ((reg_term * lambda) / (2*m));

% ======================== 3rd part ================================================

y_vec = zeros(m, num_labels);


for i=1:m,
	y_vec( i, y(i)) = 1;
end

% 3 rd part
%

for t =1:m
 % step 1
 % already done previously
 a_1 = X(t, :);
% a_1 = [1 a_1];
 z_2 = a_1 * Theta1';
 a_2 = sigmoid(z_2);
 a_2 = [1 a_2];
 z_3 = a_2 * Theta2';
 a_3 = sigmoid(z_3 );
 
 %step 2
 delta_3 = a_3 - y_vec(t, :);
 
 % step 3
 %disp(size());
 
 z2_temp = z2(t, :);
 z2_temp = [1 z2_temp];

 delta_2 =  ( delta_3 * Theta2) .* sigmoidGradient(z2_temp);
 
 %step 4
 
 delta_2_temp = delta_2(2:end);
 Theta1_grad =  Theta1_grad + delta_2_temp' * (X(t, :));
 
 Theta2_grad =  Theta2_grad + delta_3' * (a2(t, :));
 
end
disp(size(Theta1_grad));
disp(size(Theta2_grad));

Theta1_grad = Theta1_grad ./ m;
Theta2_grad = Theta2_grad ./m;

%{
one_col_vec = ones(m, 1);
delta3 = a3 - y_vec;

delta2 = (delta3 * Theta2 ) .* sigmoidGradient([one_col_vec z2]);

disp(size(delta2));
disp(size(X));

Theta1_grad = (delta2' * X) ./ m;

Theta2_grad = (delta3' * a2) ./ m;
%}

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
