function [Xtt, XtT, P_tt, P_tT ] = kalmanfilter(A, C, D, E, data)


Z = data;
T = size(Z,1)

% 2. Initialization

n = size(A, 1);
Xtt1 = zeros(n, T);
Xtt = zeros(n, T);
XtT = zeros(n, T);
P_tt1 = zeros(n, n, T);
P_tt = zeros(n, n, T);
P_tT = zeros(n, n, T);
X_00 = zeros(n, 1);
P_00 = 10*eye(n);

% Kalman Filter

for t = 1:T
    if t == 1
            Xtt1 = A*X_00;
            P_tt1 = A*P_00*A' + C*C';
    else 
            Xtt1(:, t) = A*Xtt(:, t-1); 
            P_tt1(:, :, t) = A*P_tt(:, :, t-1)*A' + C*C';
    end
    Omega = D*P_tt1(:, :, t)*D';
    Kt = P_tt1(:, :, t)*D'*inv(Omega);
    Ztilde = Z(t, 1) - D*Xtt1(:, t);
    Xtt(:, t) = Xtt1(:, t) + Kt*Ztilde;
    P_tt(:, :, t) = P_tt1(:, :, t) - Kt*Omega*Kt';
end
   
% Kalman Smoother

XtT(:, T) = Xtt(:, T);
P_tT(:, :, T) = P_tt(:, :, T);
for t = T-1:-1:1
    Jt = P_tt(:, :, t)*A'/P_tt1(:, :, t+1);
    XtT(:, t) = Xtt(:, t) + Jt*(XtT(:, t + 1) - Xtt1(:, t+1));
    P_tT(:, :, t) = P_tt(:, :, t) + Jt*(P_tT(:, :, t + 1) - P_tt1(:, :, t+1))*Jt';
end    

end