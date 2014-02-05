function [m] = J_x_rot(S,theta,phi)

m = cos(theta) * cos(phi) * J_x(S) - sin(phi) * J_y(S) + sin(theta)*cos(phi)*J_z(S);
