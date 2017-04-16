function [F, res_err] = fundamental_matrix(matches)
  N = size(matches, 1);
  [X_1, mX_1, sX_1] = normalize(matches(:, 1));
  [Y_1, mY_1, sY_1] = normalize(matches(:, 2));
  [X_2, mX_2, sX_2] = normalize(matches(:, 3));
  [Y_2, mY_2, sY_2] = normalize(matches(:, 4));

  A = [X_1.*X_2, Y_1.*X_2, X_2, X_1.*Y_2, Y_1.*Y_2, Y_2, X_1, Y_1, ones(N, 1)];

  [~, ~, V] = svd(A, 0);
  f = V(:, end);
  F = reshape(f, 3, 3)';

  [U, S, V] = svd(F);
  S(3, 3) = 0;
  F = U*S*V';

  T_1 = [ 1/sX_1, 0, -mX_1/sX_1; 0, 1/sY_1, -mY_1/sY_1; 0, 0, 1];
  T_2 = [ 1/sX_2, 0, -mX_2/sX_2; 0, 1/sY_2, -mY_2/sY_2; 0, 0, 1]; 
  F = T_2'*F*T_1;

  res_err = 0;
  for n = 1:N
    x_1 = [matches(n, 1:2), 1]';
    x_2 = [matches(n, 3:4), 1]';
    d = abs(x_2'*F*x_1)^2;
    d_1 = F'*x_2;
    d_2 = F*x_1;
    res_err = res_err + d / (d_1'*d_1) + d / (d_2'*d_2);
  end
  res_err = res_err / (2*N);

end