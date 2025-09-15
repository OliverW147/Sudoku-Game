% Basically a clone of solve_matrix.m, except it breaks once a solution is
% found and randomly permutates the order of the cells it brute forces
% instead of doing it column by column so that ordered values don't
% populate the first column (as it is highly probable that a solution for
% column 1 being 1,2,...,8,9 is valid)

% Generates a solution for a Sudoku game (returns a possible solved puzzle
% even if there are multiple solutions)

function [solved_matrix] = generate_possible_solution(matrix)
    matrix_iterable = matrix;
    % Find the locations of zeros in the matrix (not my line of code)
    % The way the find function works orders everything up to down and not
    % left to right
    % however these are going to be shuffled so that the generated Sudokus
    % are more random (as explained in the first comment)
    [row_indices, col_indices] = find(matrix == 0);
        %[sorted_row_indices, sorted_col_indices] = find(matrix == 0);
        %rng("shuffle");
        %shuffle_order = randperm(length(sorted_row_indices));
        %row_indices = zeros(length(sorted_row_indices),1);
        %col_indices = zeros(length(sorted_row_indices),1);
        %for i = 1:length(sorted_row_indices)
        %    row_indices(i) = sorted_row_indices(shuffle_order(i));
        %    col_indices(i) = sorted_col_indices(shuffle_order(i));
        %end
        %disp(length(sorted_row_indices))
        %pause(1)
    iteration = 1;
    % cap solver at 1500000 steps
    steps = 0;
    solutions = 0;
    while iteration <= length(row_indices) && steps < 1500000
        steps = steps+1;
        % check if iteration = 0 (ie the search is done)
        if iteration == 0
            break;
        end

        % increment the cell by 1 and store the new value in iteration_num
        iteration_num = matrix_iterable(row_indices(iteration),col_indices(iteration)) + 1;
        matrix_iterable(row_indices(iteration),col_indices(iteration)) = matrix_iterable(row_indices(iteration),col_indices(iteration)) + 1;

        % test to see if the matrix is still valid


        % get the row and column of the iteration
        current_row = matrix_iterable(row_indices(iteration),1:9);
        current_col = matrix_iterable(1:9,col_indices(iteration));
        % get the subgrid boundaries of the current iteration
        subgrid_row_lower = ceil(row_indices(iteration)/3)*3-2;
        subgrid_col_lower = ceil(col_indices(iteration)/3)*3-2;
        subgrid_row_upper = ceil(row_indices(iteration)/3)*3;
        subgrid_col_upper = ceil(col_indices(iteration)/3)*3;
        % use these boundaries to get the subgrid
        subgrid = matrix_iterable(subgrid_row_lower:subgrid_row_upper,subgrid_col_lower:subgrid_col_upper);

        % current_row == num (eg 3) produces a boolean array with
        % 1s (Trues) where current_row is equal to num (eg 3) because it is
        % 2d, 2 sums are needed, the first sum sums the columns (nature of
        % sum function), the second sum sums the rows

        if sum(current_row == iteration_num) == 1 && sum(current_col == iteration_num) == 1 && sum(sum(subgrid == iteration_num)) == 1 && iteration_num < 10
            % if it's valid, move on to the next cell to brute force
            iteration = iteration + 1;
        % if its not valid, then this cell is incremented again at the
        % start of the while loop unless the cell is above 9, in which case
        % the previous cell must be wrong so reset the current cell and go
        % back to it.
        elseif iteration_num > 10
            matrix_iterable(row_indices(iteration),col_indices(iteration)) = 0;
            iteration = iteration - 1;
        end
        if iteration > length(row_indices)
            solved_matrix = matrix_iterable;
            solutions = 1;
            break
        end
    end
    if solutions == 0
        solved_matrix = 0;
    end
end