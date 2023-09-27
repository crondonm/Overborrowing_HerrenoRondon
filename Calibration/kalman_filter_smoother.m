function [filtered_states, filtered_covariance, smooth_states, smooth_covariance] = kalman_filter_smoother(y1, y2, H, A, Q, E, V)

% Input:
% y1, y2 - time series data (Nx1)
% H - observation matrix
% A - state transition matrix
% Q - state covariance matrix
% R - observation covariance matrix
% E - vector of state means
% V - initial state covariance

% Output:
% log_likelihood - the log-likelihood function
% X - filtered state estimates
% X_cov - filtered state covariance estimates
% X_smooth - smoothed state estimates
% X_cov_smooth - smoothed state covariance estimates

% Check if inputs are column vectors
    if isrow(y1)
        y1 = y1'; % Transpose y1 if it is a row vector
    end
    
    if isrow(y2)
        y2 = y2'; % Transpose y2 if it is a row vector
    end
    
    % Combine the time series
    Y = [y1, y2]'; % Combine y1 and y2 into a single matrix Y
    
    % Get the length of the time series
    N = length(y1); % Store the length of y1 (or y2) as N
    
    % Initialize state and covariance estimates
    
    X = zeros(size(A, 1), N); % Initialize filtered state estimates as a matrix of zeros with the same number of rows as A and N columns
    X_cov = zeros(size(A, 1), size(A, 1), N); % Initialize filtered state covariance estimates as a 3D matrix of zeros with dimensions (size(A, 1), size(A, 1), N)
    
    % Initialize initial state estimate and covariance
    
    X(:, 1) = E; % Set the first column of the filtered state estimates to the state means E
    X_cov(:, :, 1) = .1*eye(size(A, 1), size(A, 1)); % Set the first "slice" of the filtered state covariance estimates to the initial state covariance V
    
    % Kalman filter
    for t = 2:N
        % Prediction step
        X_pred = A * X(:, t - 1) + E; % Compute the predicted state as the product of A and the previous state estimate plus the state means E
        X_cov_pred = A * X_cov(:, :, t - 1) * A' + Q; % Compute the predicted state covariance as the product of A, the previous state covariance, and the transpose of A, plus the state covariance matrix Q
        
        % Update step
        Y_diff = Y(:, t) - H * X_pred; % Compute the difference between the actual observation and the predicted observation
        S = H * X_cov_pred * H'; % Compute the innovation covariance matrix S using H, the predicted state covariance, and the observation covariance matrix R
        K = X_cov_pred * H' / S; % Compute the Kalman gain matrix K using the predicted state covariance, the transpose of H, and the innovation covariance matrix S
        X(:, t) = X_pred + K * Y_diff; % Update the state estimate using the predicted state, the Kalman gain matrix, and the observation difference
        X_cov(:, :, t) = (eye(size(A, 1)) - K * H) * X_cov_pred; % Update the state covariance estimate using the identity matrix, the Kalman gain matrix, H, and the predicted state covariance
    end

    % Kalman smoother  
    X_smooth = X; % Initialize the smoothed state estimates as the filtered state estimates
    X_cov_smooth = X_cov; % Initialize the smoothed state covariance estimates as the filtered state covariance estimates
    
    for t = N - 1:-1:1
        % Smoothing step
        J = X_cov(:, :, t) * A' / X_cov_pred; % Compute the smoother gain matrix J using the filtered state covariance, the transpose of A, and the predicted state covariance
        X_smooth(:, t) = X(:, t) + J * (X_smooth(:, t + 1) - A * X(:, t) - E); % Update the smoothed state estimate using the filtered state estimate, the smoother gain matrix, the next smoothed state estimate, A, and the state means E
        X_cov_smooth(:, :, t) = X_cov(:, :, t) + J * (X_cov_smooth(:, :, t + 1) - X_cov_pred) * J'; % Update the smoothed state covariance estimate using the filtered state covariance, the smoother gain matrix, the next smoothed state covariance, and the predicted state covariance
    end
   
    filtered_states = X;
    filtered_covariance = X_cov;
    smooth_states = X_smooth;
    smooth_covariance = X_cov_smooth;
    
end

