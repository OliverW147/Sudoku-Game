% Solves a Sudoku game (returns the solved puzzle when there is 1 solution
% or an integer representing the number of solutions when the solution
% count ~= 1)

% an optimisation was made to stop searching if a second solution is found

% steps (decomposition):
% clone the inputted matrix
% find the first zero within the inputted matrix (go left to right then down)
% increment that zero by 1
% if the board is still valid, then increment the next zero
% if the board is not valid at any point, then don't increment the next
% zero but keep incrementing the current zero
% if the current zero reaches 9 and is still invalid, then fill it with
% zero and increment the previous zero by 1

function [solved_matrix] = solve_matrix(matrix)
    matrix_iterable = matrix;
    % Find the locations of zeros in the matrix (not my line of code)
    % The way the find function works orders everything up to down and not
    % left to right
    [row_indices, col_indices] = find(matrix == 0);
    iteration = 1;
    % cap solver at 3000000 steps
    steps = 0;
    solutions = 0;
    while iteration <= length(row_indices) && steps < 3000000 && solutions < 2
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
            solutions = solutions + 1;
            iteration = iteration - 1;
        end
    end
    if solutions == 1
        return
    else
        solved_matrix = solutions;
    end
end