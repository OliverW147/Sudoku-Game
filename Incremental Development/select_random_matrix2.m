% Selects a random matrix from the csv files in this directory.

function [selected_matrix] = select_random_matrix(difficulty)
    if strcmp(difficulty, "easy")
        filename = "easy_puzzles.csv";
        % prevents using another if statement later
        % (fixes grammer for print statement)
        difficulty = "n easy";
    elseif strcmp(difficulty, "hard")
        filename = "hard_puzzles.csv";
        difficulty = " hard";
    end
    matrices = csvread(filename);
    rng("shuffle");
    random_selection = randi(height(matrices));
    matrix = zeros(1,81);
    for i = 1:81
       matrix(i) = matrices(random_selection,i);
    end
    selected_matrix = reshape(matrix,9,9);
    clc
    fprintf("Successfully loaded a%s puzzle.\n", difficulty);
end