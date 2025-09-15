clc
global game_matrix
game_matrix = zeros(9,9);

fprintf("Welcome to my MATLAB implementation of Sudoku!\n\n");
pause(0);
fprintf("Use these commands to navigate around:\n\n" + ...
    "help - list the available commands\n" + ...
    "generate <easy/medium/hard> - generate a Sudoku puzzle of the specified difficulty\n" + ...
    "display - display the current puzzle\n" + ...
    "fill <row,column,value> - fill the given cell with the provided value\n" + ...
    "clue - reveal the correct value of a cell in the current puzzle (with justification if possible)\n\n" + ...
    "verify - check whether the puzzle is still solvable (to check for any wrong fills)\n" + ...
    "solve - solve the entirety of the current puzzle\n" + ...
    "undo - undo the last fill\n\n" + ...
    "save - outputs the current Sudoku puzzle state as a string that can be copied and pasted\n" + ...
    "load <string> - loads a Sudoku puzzle from a copied string\n" + ...
    "exit - exit the game\n\n" + ...
    "First letter abbreviations can also be used (besides for solve)\n\n");

% Main game loop
while true
    % The try statement allows the program to cleanly exit if the user
    % inputs the exit command, using the error() function.
    % (simply breaking from within the function doesn't seem possible)
    try
        user_input = input('Your Choice: ', 's');
        handle_input(user_input);
    catch
        fprintf("Now exiting... thanks for playing!\n");
        break; % Break out of the while loop if an error occurs (i.e., when 'exit' is entered)
    end
end

% use rng somehow
% congratulate the user for winning
% have different ways to input (individual number vs whole matrix)
% backtracking solver (never guess a value which already exists in the same row/column/block)

game_matrix = zeros(9,9);