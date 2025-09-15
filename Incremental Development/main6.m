clc
global game_matrix last_edit
game_matrix = zeros(9,9);
last_edit = [1,1,0];

fprintf("Welcome to my MATLAB implementation of Sudoku!\n\n");
fprintf("Use these commands to navigate around:\n\n");
print_help();

% pre-determined lists of puzzles are from https://github.com/dimitri/sudoku

% Main game loop
while true
    % The try statement allows the program to cleanly exit if the user
    % inputs the exit command, using the error() function. (simply breaking
    % this while loop from within the function doesn't seem possible and I
    % want to keep function arguments to a low)
    try
        user_input = input('Your Choice: ', 's');
        handle_input(user_input);
    catch
        fprintf("Now exiting... thanks for playing!\n");
        break;
    end
end

% use a figure for UI
% make output displayed either consistently above or below the puzzle
% output

% make final test cases for each accepted (and non-accepted) input
% make driver files for all functions