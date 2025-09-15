% This function returns a random matrix from the csv files in this directory.

function [selected_matrix] = select_random_matrix(difficulty)
    % if and elseif statements that set the file to read based to the given
    % difficulty, and then change the difficulty so that it can be printed
    % with correct grammar at the end of this function
    if strcmp(difficulty, "easy")
        filename = "easy_puzzles.csv";
        difficulty = "n easy";
    elseif strcmp(difficulty, "hard")
        filename = "hard_puzzles.csv";
        difficulty = " hard";
    end
    % use csv read to read the puzzles (1 per line) stored in a csv file.
    % note that puzzles are from % https://github.com/dimitri/sudoku
    matrices = csvread(filename);
    % select a random puzzle
    rng("shuffle");
    random_selection = randi(height(matrices));
    matrix = zeros(1,81);
    % append the row of the chosen puzzle into a 1x81 array.
    for i = 1:81
       matrix(i) = matrices(random_selection,i);
    end
    % reshape the 1x81 array into a 9x9 array
    selected_matrix = reshape(matrix,9,9);
    % clear the command window and prompt the user that a puzzle has been
    % returned
    clc;
    fprintf("Successfully loaded a%s puzzle.\n", difficulty);
end