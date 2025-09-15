% tests for verify_solution function

% test zeros matrix
clc
disp("test for 9x9 zeros matrix")
disp("expected output:")
disp("2")
disp("actual output:")
disp(verify_solution(zeros(9,9)))

% test correctly solved puzzle
handle_input("load 358967421741352689629184375173546892492873516586219743264795138915438267837621954");
clc
disp("test for a correctly solved matrix")
disp("expected output:")
disp("1")
disp("actual output:")
disp(verify_solution(game_matrix))

% test incorrectly solved puzzle
handle_input("load 338967421741352689629184375173546892492873516586219743264795138915438267837621954");
clc
disp("test for an incorrectly solved matrix")
disp("expected output:")
disp("0")
disp("actual output:")
disp(verify_solution(game_matrix))