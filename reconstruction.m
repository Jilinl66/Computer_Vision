% projective 3D point X (1-by-4 vector)from its projections in 2 images x (2-by-2 matrix)
% imsize is 2-by-2 matrix, camera matrices P is 2 cell of 3-by-4 matrix
function X = reconstruction(C1, C2, p1, p2)

%imsize = size(img);
%for k = 1:2
 %   H = [2/imsize(1,1) 0 -1
  %       0 2/imsize(1,2) -1
   %      0 0              1];
    % C(:, :, k) = H*C(:, :, k);
     %x(:, k) = H(1:2, 1:2)*x(:, k) + H(1:2, 3);
%end

A = [];
A = [A; p1(1, 1)*C1(3, :) - C1(1, :)];
A = [A; p1(1, 2)*C1(3, :) - C1(2, :)];
A = [A; p2(1, 1)*C2(3, :) - C2(1, :)];
A = [A; p2(1, 2)*C2(3, :) - C2(2, :)];
[U, S, V] = svd(A, 0); % V is 4_by_1 vector
X = V(:, end);
X = X* 1/X(4, 1);
X = X(1: 3, 1);
end