% tests for select_random_matrix function


% test for easy difficulty
clc
disp("test for easy difficulty")
disp("expected output:")
disp("(a randomly selected puzzle from easy_puzzles.csv)")
disp("actual output:")
disp(select_random_matrix("easy"))

% test for hard difficulty
clc
disp("test for hard difficulty")
disp("expected output:")
disp("(a randomly selected puzzle from hard_puzzles.csv)")
disp("actual output:")
disp(select_random_matrix("hard"))