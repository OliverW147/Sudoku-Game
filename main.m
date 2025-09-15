% This is the main file for my Sudoku implementation.

% This file initialises main variables, prints a welcome message, lists
% available commands, then enters the main game loop.

% Clear the command window
clc;
% Declare the game matrix and the last edit made to the game matrix as
% global variables, and then initialise them.
global game_matrix last_edit;
game_matrix = zeros(9,9);
last_edit = [1,1,0];

% print the welcome message and the available commands by calling
% print_help()
fprintf("Welcome to my MATLAB implementation of Sudoku!\n\n");
fprintf("Use these commands to navigate around:\n\n");
print_help();

% Enter the main game loop, where user input is stored and handled by the
% handle_input function.
while true
    % The try statement allows the program to cleanly exit if the user
    % inputs the exit command, by using the error() function. (simply
    % breaking this while loop from within the function doesn't seem
    % practical without using more function arguments)
    try
        user_input = input('Your Choice: ', 's');
        handle_input(user_input);
    catch
        fprintf("Now exiting... thanks for playing!\n");
        break;
    end
end