% This function attempts to generate a Sudoku game given a difficulty.

% Generation will follow an algorithm outlined by Andrew C. Stuart in an
% online paper named "Sudoku Creation and Grading"
% https://www.sudokuwiki.org/Sudoku_Creation_and_Grading.pdf

% Fill 9 random cells with 1 to 9
% Solve the puzzle
% Set cells to zero at random until a specified number of zeros is reached,
% or the puzzle is no longer solvable

function [generated_matrix] = generate_matrix(difficulty)
    % set the amount of reductions to be done based on the difficulty level.
    if strcmp(difficulty, "easy")
        % for a total of 40-50 givens
        total_reductions = 42 - randi(11);
    elseif strcmp(difficulty, "medium")
        % for a total of 33-39 givens
        total_reductions = 49 - randi(7);
    end
    % initialise the generated matrix as zero
    matrix = 0;
    % if the matrix can not be populated the first time, it will be set to
    % zero and this loop will run until it is successfully populated.
    while matrix == 0
            matrix = zeros(9,9);
            % populate the matrix with one of each non-zero digit (this
            % matrix will always have at least 1 solution)
            rng("shuffle")
            % create 9 permutations of numbers between 1 and 81
            cells = randperm(81,9);
            % convert each permutation to a row and column then insert it
            % into the matrix
            for i = 1:9
                row = ceil(cells(i)/9);
                col = mod(cells(i),9)+1;
                matrix(row,col) = i;
            end
            % call generate_possible_solution, a modified version of
            % solve_matrix that does not stop when multiple solutions are
            % found.
            matrix = generate_possible_solution(matrix);
    end
        % Set cells to zero at random (reduce the matrix) until the
        % specified number of zeros is reached, or the puzzle is no longer
        % solvable

        % initialise variables for the reduction process
        matrix_reducible = matrix;
        reductions = 0;
        attempts = 0;

        % reduce until target number of reductions is reached or attempts
        % to reduce get to 100.
        while reductions < total_reductions && attempts < 100
            % pick a random non-zero cell (element) to reduce
            row = randi(9);
            col = randi(9);
            while matrix_reducible(row,col) == 0
                row = randi(9);
                col = randi(9);
            end
            % store the original_number incase the matrix becomes
            % unsolvable and it needs to be reverted
            original_number = matrix_reducible(row,col);
            % set the target cell to zero
            matrix_reducible(row,col) = 0;
            % solve the matrix by calling solve_matrix. If solve_matrix
            % outputs the solution and not the number of solutions, then
            % the reduction made was valid, and the next reduction can take
            % place
            if length(solve_matrix(matrix_reducible)) ~= 1
                reductions = reductions + 1;
            % else, revert the reduction and move on
            else
                matrix_reducible(row,col) = original_number;
            end
            % it is very rare (at least on my laptop) that this algorithm
            % takes more than a second, but in some cases it does, so
            % the amount of attempts made is displayed to the user
            clc;
            fprintf("%.0f/100\n", attempts);
            attempts = attempts + 1;
        end
    % set the output variable to the reduced matrix.
    generated_matrix = matrix_reducible;
end