 % points_img1 and points_img2 is num_of_correspondence_by_2 matrix
% threeD_points is num_of_correspondence_by_3 matrix
close all
%{
Set 1:
'DSCF4178.jpg', 'DSCF4180.jpg', 5, right face
'DSCF4178.jpg', 'DSCF4180.jpg', 50, right body and front leg 
'DSCF4180.jpg', 'DSCF4182.jpg', 20, right butt and back leg
'DSCF4187.jpg', 'DSCF4190.jpg', 5, left face
'DSCF4183.jpg', 'DSCF4187.jpg', 50, left body and front leg
'DSCF4182.jpg', 'DSCF4183.jpg', 20,  left butt and back leg

Set 2:
'DSCF4177.jpg', 'DSCF4195.jpg', 5, right face
'DSCF4177.jpg', 'DSCF4195.jpg', 50, right body and front leg
'DSCF4177.jpg', 'DSCF4182.jpg', 20, right butt and back leg
'DSCF4186'jpg', 'DSCF4189.jpg', 5, left face
'DSCF4184.jpg', 'DSCF4186.jpg', 50, left body and front leg
'DSCF4182.jpg', 'DSCF4184.jpg', 20, left butt and back leg
%}

img_pairs1 = {{'DSCF4178.jpg', 'DSCF4180.jpg'}, {'DSCF4178.jpg', 'DSCF4180.jpg'}, ...
    {'DSCF4180.jpg', 'DSCF4182.jpg'}, {'DSCF4187.jpg', 'DSCF4189.jpg'},...
    {'DSCF4183.jpg', 'DSCF4187.jpg'}, {'DSCF4182.jpg', 'DSCF4183.jpg'}};
img_pairs2 = {{'DSCF4177.jpg', 'DSCF4195.jpg'}, {'DSCF4177.jpg', 'DSCF4195.jpg'}, ...
    {'DSCF4177.jpg', 'DSCF4182.jpg'}, {'DSCF4186.jpg', 'DSCF4189.jpg'},...
    {'DSCF4184.jpg', 'DSCF4186.jpg'}, {'DSCF4182.jpg', 'DSCF4184.jpg'}};
export = 1;
color = ['r','b', 'g', 'b', 'y', 'm'];

for s = 1: 2
    if s == 1
       img_pairs = img_pairs1; 
       camera_set = 1;
       c = 'r';
    end
    if s == 2
       img_pairs = img_pairs2; 
       camera_set = 2;
       c = 'b';
    end
threeD_points = []; 
for i = 1: 6
    switch(i)
        case 1
            num_of_correspondence = 15; %10
        case 2
            num_of_correspondence = 50; %45
        case 3
            num_of_correspondence = 15; %20
        case 4
            num_of_correspondence = 15; %10
        case 5
            num_of_correspondence = 50; %45
        case 6
            num_of_correspondence = 15; %20
    end

    if export == 1
        filename1 = ['F_', img_pairs{i}{1}(5: 8), '_', img_pairs{i}{2}(5: 8), '.mat'];
        load(filename1, 'F');
        [points1_img1, points1_img2] = cal_epipolarLine(img_pairs{i}{1}, img_pairs{i}{2}, num_of_correspondence, F);
        filename2 = ['points_', img_pairs{i}{1}(5: 8), '_', img_pairs{i}{2}(5: 8), '_', num2str(i), '.mat'];
        point_cell{1} = points1_img1;
        point_cell{2} = points1_img2;
        save(filename2, 'point_cell');
    else 
        filename = ['points_', img_pairs{i}{1}(5: 8), '_', img_pairs{i}{2}(5: 8), '_', num2str(i), '.mat'];
        load(filename, 'point_cell')
        points1_img1 = point_cell{1}; 
        points1_img2 = point_cell{2};  
    end
    
    % 3D reconstruction
    load(['C_', img_pairs{i}{1}(5: 8), '.mat'], ['C_', img_pairs{i}{1}(5: 8)]);
    load(['C_', img_pairs{i}{2}(5: 8), '.mat'], ['C_', img_pairs{i}{2}(5: 8)]);
    C1 = eval(['C_', img_pairs{i}{1}(5: 8)]);
    C2 = eval(['C_', img_pairs{i}{2}(5: 8)]);
    for j = 1: num_of_correspondence
        X = reconstruction(C1, C2, points1_img1(j, :), points1_img2(j, :));
        threeD_points = [threeD_points; X'];
    end
    figure(3)
    %mesh(threeD_points(:,1), threeD_points(:,2), threeD_points(:,3));
    scatter3(threeD_points(:,1), threeD_points(:,2), threeD_points(:,3), [c,'+']);
    %pause(1)
    set(gca, 'DataAspectRatio', [1 1 1]);
    hold on
end
end

% draw camera
if camera_set == 1
    C_left = {4187, 4189, 4183, 4182};
    C_right = {4178,4180};
end
if camera_set == 2
    C_left = {4186,4189,4184, 4182};
    C_right = {4177,4195};
end
for i = 1 : 4
    load(['C_',num2str(C_left{i}),'.mat'] , ['C_',num2str(C_left{i})]);
    C1 = eval(['C_',num2str(C_left{i})]);
    draw_camera(C1,1);
end
for i = 1: 2
    load(['C_',num2str(C_right{i}),'.mat'] , ['C_',num2str(C_right{i})]);
    C2 = eval(['C_',num2str(C_right{i})]);
    draw_camera(C2,2);
    pause(2)
    hold on
end