% Trying to display the puzzle in a figure.

% Define the Sudoku board
default_game_matrix = [
    5 3 0 0 7 0 0 0 0;
    6 0 0 1 9 5 0 0 0;
    0 9 8 0 0 0 0 6 0;
    8 0 0 0 6 0 0 0 3;
    4 0 0 8 0 3 0 0 1;
    7 0 0 0 2 0 0 0 6;
    0 6 0 0 0 0 2 8 0;
    0 0 0 4 1 9 0 0 5;
    0 0 0 0 8 0 0 7 9
];

% Create a figure
figure;

% Display the Sudoku board
for i = 1:9
    for j = 1:9
        % https://au.mathworks.com/help/matlab/ref/text.html
        text(j, 10-i, num2str(default_game_matrix(i,j)));
    end
end

% Set axis boundaries
axis([0.5, 9.5, 0.5, 9.5]);
% Hide the axis
axis off;