clc

% use rng somehow

default_game_matrix = zeros(9,9);

default_game_matrix = generate_matrix();

editable_game_matrix = default_game_matrix;

display_matrix(default_game_matrix);

default_game_matrix(1,2) = 3;
pause(1);
clc
display_matrix(default_game_matrix);