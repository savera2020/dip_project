%% read training data write close loop solution of MSE


Y = I_flat';      % 16384 x 1200 x
X = radon_flat';   % 33300 x 1200

%% C = Y* XT * inv(X*XT + .1 I)
I = eye(size(X,1));

D = inv(X*X' + 0.1*I); 
C = Y*X'*D;
I1 = eye(size(C,1));
X_back = C'*inv(C*C' + .1*I1)*Y ;