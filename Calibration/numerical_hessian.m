function H = numerical_hessian(f, x0)
    % Input:  f - function handle
    %         x0 - column vector (Nx1) at which to compute the Hessian
    % Output: H - Hessian matrix (NxN)

    N = length(x0);
    epsilon = 2*sqrt(1e-6); % Finite difference step size
    H = zeros(N);

    for i = 1:N
        for j = 1:N
            if i == j
                x_plus = x0;
                x_plus(i) = x_plus(i) + epsilon;
                x_minus = x0;
                x_minus(i) = x_minus(i) - epsilon;
                H(i, j) = (f(x_plus) - 2 * f(x0) + f(x_minus)) / (epsilon^2);
            else
                x_plus_plus = x0;
                x_plus_plus(i) = x_plus_plus(i) + epsilon;
                x_plus_plus(j) = x_plus_plus(j) + epsilon;
                
                x_plus_minus = x0;
                x_plus_minus(i) = x_plus_minus(i) + epsilon;
                x_plus_minus(j) = x_plus_minus(j) - epsilon;
                
                x_minus_plus = x0;
                x_minus_plus(i) = x_minus_plus(i) - epsilon;
                x_minus_plus(j) = x_minus_plus(j) + epsilon;
                
                x_minus_minus = x0;
                x_minus_minus(i) = x_minus_minus(i) - epsilon;
                x_minus_minus(j) = x_minus_minus(j) - epsilon;
                
                H(i, j) = (f(x_plus_plus) - f(x_plus_minus) - f(x_minus_plus) + f(x_minus_minus)) / (4 * epsilon^2);
            end
        end
    end
end
