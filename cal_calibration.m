function c = cal_calibration(img_name)
imgin = imread(img_name);
image = figure, imshow(imgin);
[img_point_x, img_point_y] = getpts(image);
if ((img_name == 'DSCF4177.jpg') | (img_name == 'DSCF4178.jpg') | (img_name == 'DSCF4195.jpg'))
    obpointlist = [[0,0,0,1];[64,0,0,1];[64,64,0,1];[0,0,19,1];[64,0,19,1];[64,64,19,1];[0,0,29,1];[64,0,29,1];[64,64,29,1];[16,16,29,1];[48,16,29,1];[48,48,29,1];[16,16,48,1];[48,16,48,1];[48,48,48,1];[0,48,67,1];[32,48,67,1];[32,80,67,1]];
    count = 18;
elseif (img_name == 'DSCF4183.jpg' | img_name == 'DSCF4184.jpg' | img_name == 'DSCF4186.jpg')
    obpointlist = [[0,64,0,1];[0,64,19,1];[0,80,29,1];[32,80,29,1];[0,80,48,1];[32,80,48,1];[0,80,67,1];[32,80,67,1]]
    count = 8;
elseif img_name == 'DSCF4182.jpg'
    obpointlist = [[0,0,0,1];[0,64,0,1];[0,0,19,1];[0,64,19,1];[0,0,29,1];[0,64,29,1];[16,16,29,1];[16,16,48,1];[0,48,67,1];[0,80,67,1]];
    count = 10;
elseif img_name == 'DSCF4180.jpg'
    obpointlist = [[0,0,0,1];[64,0,0,1];[0,0,19,1];[64,0,19,1];[0,0,29,1];[64,0,29,1];[16,16,29,1];[48,16,29,1];[16,16,48,1];[48,16,48,1];[0,48,67,1];[32,48,67,1]];
    count = 12;
elseif img_name == 'DSCF4189.jpg'
    obpointlist = [[64,0,0,1];[64,0,19,1];[64,0,29,1];[32,48,67,1];[32,80,67,1];[0,80,67,1]];
    count = 6;
elseif img_name == 'DSCF4187.jpg'
    obpointlist = [[48,16,48,1];[48,48,48,1];[32,48,48,1];[32,80,48,1];[0,80,48,1];[32,48,67,1];[32,80,67,1];[0,80,67,1];[120,0,0,1];[140,0,0,1];[160,0,0,1];[120,20,0,1]];
    count = 12;
elseif img_name == 'DSCF4190.jpg'
    obpointlist = [[64,0,0,1];[64,64,0,1];[64,0,19,1];[64,64,19,1];[64,0,29,1];[64,64,29,1];[48,16,48,1];[48,48,48,1];[32,48,67,1];[32,80,67,1];[80,0,0,1];[100,0,0,1]];
    count = 12;
end
obpointlistv = obpointlist;
obpointlistu = obpointlist;
impointlist = zeros(count*2,1);
for i = 1:count
    obpointlistu(i,:) = obpointlistu(i,:) * (-img_point_x(i));
    impointlist(i) = img_point_x(i);
    obpointlistv(i,:) = obpointlistv(i,:) * (-img_point_y(i));
    impointlist(i + count) =  img_point_y(i);
end

obpoint = [obpointlist, zeros(count, 4), obpointlistu(:,1:3); zeros(count, 4), obpointlist, obpointlistv(:,1:3)];
impointlist
cincolumn = obpoint\impointlist;
c = [cincolumn(1:4)';cincolumn(5:8)';cincolumn(9:11)',1];
