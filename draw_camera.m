function draw_camera(C, group)
% point_o is a 3*1 matrix, C(complete camera calibration matrix) is a 3*4 matrix
% left side : group == 1; right side: group == 2; 

M = C(:,1:3);
[K,R] = rq(M);
T = M\C(:,4);
point_o = -T;

point_x = R\[1;0;0];
point_y = R\[0;1;0];
point_z = R\[0;0;1];
if (group == 2)
    scatter3(point_o(1,1), point_o(2,1), point_o(3,1), 'bo');
else
    scatter3(point_o(1,1), point_o(2,1), point_o(3,1), 'ro');
end
l = 50;
if(group == 1)
    plot3([point_o(1,1);point_o(1,1)-point_x(1,1)*l],[point_o(2,1);point_o(2,1)-point_x(2,1)*l],[point_o(3,1);point_o(3,1)-point_x(3,1)*l],'r-');
    plot3([point_o(1,1);point_o(1,1)-point_y(1,1)*l],[point_o(2,1);point_o(2,1)-point_y(2,1)*l],[point_o(3,1);point_o(3,1)-point_y(3,1)*l],'r-');
    plot3([point_o(1,1);point_o(1,1)-point_z(1,1)*l],[point_o(2,1);point_o(2,1)-point_z(2,1)*l],[point_o(3,1);point_o(3,1)-point_z(3,1)*l],'r-');
elseif(group == 2)
    plot3([point_o(1,1);point_o(1,1)+point_x(1,1)*l],[point_o(2,1);point_o(2,1)+point_x(2,1)*l],[point_o(3,1);point_o(3,1)+point_x(3,1)*l],'b-');
    plot3([point_o(1,1);point_o(1,1)+point_y(1,1)*l],[point_o(2,1);point_o(2,1)+point_y(2,1)*l],[point_o(3,1);point_o(3,1)+point_y(3,1)*l],'b-');
    plot3([point_o(1,1);point_o(1,1)+point_z(1,1)*l],[point_o(2,1);point_o(2,1)+point_z(2,1)*l],[point_o(3,1);point_o(3,1)+point_z(3,1)*l],'b-');
end


    
