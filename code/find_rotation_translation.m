function [R, t] = find_rotation_translation(E)
  [U, ~, V] = svd(E);
  R_p = [0, -1, 0; 1, 0, 0; 0, 0, 1];
  R_n = [0, 1, 0; -1, 0, 0; 0, 0, 1];

  R_1 = U * R_p' * V';
  R_2 = U * R_n' * V';

  tt = U(:, end);

  R = {R_1, -R_1, R_2, -R_2};
  t = {tt, -tt};
end