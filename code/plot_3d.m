function plot_3d(points, R_2, t_2)
  N = size(points, 1);

  depth = points(:, 3);
  depth = (depth - min(depth)) / (max(depth) - min(depth)) / 1.5;
  depth_colors = hsv2rgb([depth, ones(N, 2)]);
    
  O2 = -R_2 \ t_2;
  Ox = [0, O2(1)];
  Oy = [0, O2(2)];
  Oz = [0, O2(3)];
  x = points(:, 1);
  y = points(:, 2);
  z = points(:, 3);

  figure;
  hold on;
  scatter3(-Ox, -Oy, Oz, '+k');
  for n = 1:N
    plot3(-x(n), -y(n), z(n), 'o', 'MarkerEdgeColor', depth_colors(n, :));
  end
end