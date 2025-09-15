% tests for solve_matrix function

% test invalid puzzle (zero matrix)
clc
disp("test for 9x9 zeros matrix")
disp("expected output:")
disp("2")
disp("actual output:")
disp(solve_matrix(zeros(9,9)))

% test already solved puzzle
handle_input("load 358967421741352689629184375173546892492873516586219743264795138915438267837621954");
clc
disp("test for a puzzle that is already solved")
disp("expected output:")
disp("0")
disp("actual output:")
disp(solve_matrix(game_matrix))

% test solvable puzzle
handle_input("load 040000020001000300700080006200501003503060701600807002400020007006000900050000040");
clc
disp("test for a solvable puzzle")
disp("expected output:")
disp("(the solved puzzle)")
disp("actual output:")
disp(solve_matrix(game_matrix))