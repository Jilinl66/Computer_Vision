function [point_in_image1, point_in_image2] = cal_epipolarLine(img1_name, img2_name, count, F)
img1 = imread(img1_name);
img2 = imread(img2_name);

%choose point and draw line
point_in_image1 = [];
point_in_image2 = [];
for j = 1 : count
    figure(1)
    imshow(img1);
    [pointx, pointy] = getpts(figure(1)); 
    point_in_image1 = [point_in_image1; [pointx, pointy]];
    lines = epipolarLine(F, [pointx, pointy]);
    figure(2)
    imshow(img2);
    hold on 
    for i = 1:size(pointx)
        line = lines(i,:);
        a = line(1);
        b = line(2);
        c = line(3);
        x = 1:2848;
        y = ( - a*x - c) / b;
        plot(x, y);
    end
    hold off   
    [x, y] = getpts(figure(2));
    point_in_image2 = [point_in_image2; [x, y]];
end