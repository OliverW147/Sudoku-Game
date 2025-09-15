% Generation will follow an alg outlined by Andrew C. Stuart in an online
% paper named "Sudoku Creation and Grading"

% Fill 9 random cells with 1 to 9
% Solve the puzzle
% Set cells to zero at random until the puzzle is not solvable

function [generated_matrix] = generate_matrix(difficulty)
    matrix = 0;
    if strcmp(difficulty, "easy")
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
        cells = randperm(81,81);
        matrix_reducible = matrix;
        for i = 1:81
            row = ceil(cells(i)/9);
            col = mod(cells(i),9)+1;
            matrix_reducible(row,col) = 0;
            display_matrix(matrix_reducible)
            pause(1)
            if length(solve_matrix(matrix_reducible)) ~= 1
                matrix_reducible = matrix;
                generated_matrix = matrix;
            else
                generated_matrix = matrix;
                break
            end
        end
    end
    if strcmp(difficulty, "medium")
    end
    if strcmp(difficulty, "hard")
    end
end