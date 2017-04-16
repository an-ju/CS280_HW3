function [points, rec_err] = find_3d_points(matches, P_1, P_2)
  N = size(matches, 1);
  points = zeros(N, 3);
  rec_err = 0;

  for n = 1:N
    x_1 = matches(n, 1);
    y_1 = matches(n, 2);
    x_2 = matches(n, 3);
    y_2 = matches(n, 4);

    A = [P_1(3,1)*x_1-P_1(1,1), P_1(3,2)*x_1-P_1(1,2), P_1(3,3)*x_1-P_1(1,3);
        P_1(3,1)*y_1-P_1(2,1), P_1(3,2)*y_1-P_1(2,2), P_1(3,3)*y_1-P_1(2,3);
        P_2(3,1)*x_2-P_2(1,1), P_2(3,2)*x_2-P_2(1,2), P_2(3,3)*x_2-P_2(1,3);
        P_2(3,1)*y_2-P_2(2,1), P_2(3,2)*y_2-P_2(2,2), P_2(3,3)*y_2-P_2(2,3)];
    b = [P_1(1,4)-P_1(3,4)*x_1;
        P_1(2,4)-P_1(3,4)*y_1;
        P_2(1,4)-P_2(3,4)*x_2;
        P_2(2,4)-P_2(3,4)*y_2];

    points(n, :) = A \ b;
    point = points(n, :);

    xx_1 = P_1 * [point, 1]';
    xx_1 = [xx_1(1)/xx_1(3), xx_1(2)/xx_1(3)];
    xx_2 = P_2 * [point, 1]';
    xx_2 = [xx_2(1)/xx_2(3), xx_2(2)/xx_2(3)];
    rec_err = rec_err + norm(xx_1-matches(n, 1:2)) + norm(xx_2-matches(n, 3:4));
  end
  rec_err = rec_err / (2 * N);
end