% tests for display_matrix function (this will never be parsed a non 9x9
% matrix so it is unnecessary to test those cases)


% test for zeros matrix
clc
disp("test for the zeros matrix")
disp("expected output:")
disp("the zeros matrix displayed as a Sudoku puzzle")
disp("actual output:")
display_matrix(zeros(9,9))

% test for an actual puzzle
handle_input("load 040000020001000300700080006200501003503060701600807002400020007006000900050000040");
clc
disp("test for an actual puzzle")
disp("expected output:")
disp("a Sudoku puzzle")
disp("actual output:")
display_matrix(game_matrix)