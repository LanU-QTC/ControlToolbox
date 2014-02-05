% Check the normalisation of matrix representations as per excericse 3.17
% in Mehring's book 

%% Spin 1/2
clc

fprintf('1/2,0,0\n');

matrix_rep_for_normalised_tensor(1/2,0,0)./matrix_rep_for_tensor(1/2,0,0)

fprintf('1/2,1,q\n');

matrix_rep_for_normalised_tensor(1/2,1,0)./matrix_rep_for_tensor(1/2,1,0)

matrix_rep_for_normalised_tensor(1/2,1,1)./matrix_rep_for_tensor(1/2,1,1)

matrix_rep_for_normalised_tensor(1/2,1,-1)./matrix_rep_for_tensor(1/2,1,-1)

%% Spin 1
clc

fprintf('1,0,q\n');

matrix_rep_for_normalised_tensor(1,0,0)./matrix_rep_for_tensor(1,0,0)

fprintf('1,1,q\n');

matrix_rep_for_normalised_tensor(1,1,0)./matrix_rep_for_tensor(1,1,0)

matrix_rep_for_normalised_tensor(1,1,1)./matrix_rep_for_tensor(1,1,1)

matrix_rep_for_normalised_tensor(1,1,-1)./matrix_rep_for_tensor(1,1,-1)

fprintf('1,2,q\n');

matrix_rep_for_normalised_tensor(1,2,2)./matrix_rep_for_tensor(1,2,2)

matrix_rep_for_normalised_tensor(1,2,1)./matrix_rep_for_tensor(1,2,1)

matrix_rep_for_normalised_tensor(1,2,0)./matrix_rep_for_tensor(1,2,0)

matrix_rep_for_normalised_tensor(1,2,-1)./matrix_rep_for_tensor(1,2,-1)

matrix_rep_for_normalised_tensor(1,2,-2)./matrix_rep_for_tensor(1,2,-2)