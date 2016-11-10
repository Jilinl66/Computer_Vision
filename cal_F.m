function F = cal_F(img1_name, img2_name, filename)
img1 = imread(img1_name);
img2 = imread(img2_name);

%Compute Fundamental matrix
figure(1)
imshow(img1);
figure(2)
imshow(img2);
%calculate Fundamental Matrix
[img_point_x1, img_point_y1] = getpts(figure(1));
[img_point_x2, img_point_y2] = getpts(figure(2));
F = estimateFundamentalMatrix([img_point_x1, img_point_y1],[img_point_x2, img_point_y2],'Method','Norm8Point');
save(filename, 'F');
close all 