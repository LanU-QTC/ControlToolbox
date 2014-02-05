function [m] = J_z_rot(S,theta,phi)

m = - sin(phi)*J_x(S) + cos(phi)*J_z(S);
