% Generation will follow an alg outlined by Andrew C. Stuart in an online
% paper named "Sudoku Creation and Grading"

% Fill 9 random cells with 1 to 9
% Solve the puzzle
% Set cells to zero at random until the puzzle is not solvable

function [generated_matrix] = generate_matrix(difficulty)
    
    if strcmp(difficulty, "very_easy")
        % for a total of 40-50 givens
        total_reductions = 42 - randi(11);
    end
    if strcmp(difficulty, "easy")
        % for a total of 33-39 givens
        total_reductions = 49 - randi(7);
    end
    if strcmp(difficulty, "medium")
        % for a total of 26-32 givens
        total_reductions = 56 - randi(7);
    end
    matrix = 0;
    while matrix == 0
            matrix = zeros(9,9);
            % populate matrix with initial values (this matrix will always have
            % at least 1 solution)
            rng("shuffle")
            cells = randperm(81,9);
            for i = 1:9
                row = ceil(cells(i)/9);
                col = mod(cells(i),9)+1;
                matrix(row,col) = i;
            end
            matrix = generate_possible_solution(matrix);
    end
        rng("shuffle")
        matrix_reducible = matrix;
        reductions = 0;
        attempts = 0;
        while reductions < total_reductions && attempts < 100
            row = randi(9);
            col = randi(9);
            while matrix_reducible(row,col) == 0
                row = randi(9);
                col = randi(9);
            end
            original_number = matrix_reducible(row,col);
            matrix_reducible(row,col) = 0;
            if length(solve_matrix(matrix_reducible)) ~= 1
                reductions = reductions + 1;
            else
                matrix_reducible(row,col) = original_number;
            end
            clc
            fprintf("%.0f%%\n", attempts)
            attempts = attempts + 1;
        end
    generated_matrix = matrix_reducible;
end