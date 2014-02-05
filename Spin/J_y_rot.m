function [m] = J_y_rot(S,theta,phi)

m = cos(theta) * sin(phi) * J_x(S) - cos(phi) * J_y(S) + sin(theta)*sin(phi)*J_z(S);
