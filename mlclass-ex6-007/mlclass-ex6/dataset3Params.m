function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

C_vec = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30]';
sigma_vec = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30]';
m = size(C_vec)(1);
err = 10000;

for i=1:m
  C_temp = C_vec(i);
  for j=1:m
    sigma_temp = sigma_vec(j);
    model = svmTrain(X, y, C_temp, @(x1, x2) gaussianKernel(x1, x2, sigma_temp), 1e-3, 5);
    predictions = svmPredict(model, Xval);
    new_err = mean(double(predictions ~= yval));

    if new_err < err
      C = C_temp;
      sigma = sigma_temp;
      err = new_err;
    end
  end
end

% =========================================================================

end
