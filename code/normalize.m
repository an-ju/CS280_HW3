function [nX, mX, stdX] = normalize(X)
  mX = mean(X);
  stdX = std(X);
  nX = (X - mX) / stdX;
end