% Attempts to solve a given Sudoku game (returns the solved puzzle when
% there is 1 solution, returns 0 when there are likely no solutions, and
% returns 2 when there are 2 or more solutions)

% steps (decomposition):
% clone the inputted matrix
% find the first zero within the inputted matrix
% increment that zero by 1
% if the board is still valid, then increment the next zero
% if the board is not valid at any point, then don't increment the next
% zero but keep incrementing the current zero
% if the current zero reaches 9 and is still invalid, then fill it with
% zero and increment the previous zero by 1

function [solved_matrix] = solve_matrix(matrix)
    matrix_iterable = matrix;
    % Find the indices of zeros in the game matrix using a function that
    % was found on https://au.mathworks.com/help/matlab/ref/find.html

    % The find function orders everything up to down and not left to right,
    % to change this, the indices could be sorted in ascending order in
    % terms of the row_indices.
    [row_indices, col_indices] = find(matrix == 0);
    iteration = 1;
    % cap solver at 3000000 steps and initialise the steps and solutions
    % variables
    steps = 0;
    solutions = 0;
    while iteration <= length(row_indices) && steps < 3000000 && solutions < 2
        % increment the steps variable
        steps = steps+1;

        % check if iteration = 0 (ie the solver has backtracked out of
        % bounds and the search is done)
        % this could happen whether the solution count is 0,1,2 etc
        if iteration == 0
            break;
        end

        % increment the current cell (element) by 1 and store the new value
        % in iteration_num
        iteration_num = matrix_iterable(row_indices(iteration),col_indices(iteration)) + 1;
        matrix_iterable(row_indices(iteration),col_indices(iteration)) = matrix_iterable(row_indices(iteration),col_indices(iteration)) + 1;

        % the following code tests to see if the resultant matrix is still
        % valid:

        % store the row and column corresponding to the current cell
        current_row = matrix_iterable(row_indices(iteration),1:9);
        current_col = matrix_iterable(1:9,col_indices(iteration));

        % store the boundaries of the subgrid (block) where the current
        % cell is located.
        subgrid_row_lower = ceil(row_indices(iteration)/3)*3-2;
        subgrid_col_lower = ceil(col_indices(iteration)/3)*3-2;
        subgrid_row_upper = ceil(row_indices(iteration)/3)*3;
        subgrid_col_upper = ceil(col_indices(iteration)/3)*3;

        % use these boundaries to get the entire subgrid
        subgrid = matrix_iterable(subgrid_row_lower:subgrid_row_upper,subgrid_col_lower:subgrid_col_upper);

        % current_row == cell_value creates an array of zeros and ones,
        % with ones corresponding to the places where its cell value in
        % current_row is equal to "cell_value". Therefore, taking
        % the sum of current_row == cell_value returns the number
        % of instances of cell_value in the row.

        % this if statement utilises this logic to validate the
        % value of each cell. (if not (only occurrence in row &&
        % only occurrence in column && only occurrence in subgrid))
        % then invalidate the solution.
        if sum(current_row == iteration_num) == 1 && sum(current_col == iteration_num) == 1 && sum(sum(subgrid == iteration_num)) == 1 && iteration_num < 10
            % if it's valid, move on to the next cell to brute force
            iteration = iteration + 1;
        % if its not valid, then this cell is incremented again at the
        % start of the while loop unless the cell is above 9, in which case
        % a previous cell must be wrong so reset the current cell to zero
        % and go back to the last cell.
        elseif iteration_num > 10
            % set the current cell to zero and go back to the previous cell
            matrix_iterable(row_indices(iteration),col_indices(iteration)) = 0;
            iteration = iteration - 1;
        % else, the while loop will repeat and increment the current cell
        % until it is valid or above 9.
        end
        % the current iteration will only be incremented out of bounds if
        % the value of the last valid cell in this algorithm is found and
        % verified to be correct. In other words, the current iteration
        % will go out of bounds only after a solution is found.

        % The next if statement uses this logic to increment the solution
        % count and set the solved matrix to the current experimental
        % matrix's value.
        if iteration > length(row_indices)
            solved_matrix = matrix_iterable;
            solutions = solutions + 1;
            % iteration is set back in allowed bounds to keep searching for
            % a second solution
            iteration = iteration - 1;
        end
    end
    % if solution count is 1, then return with the solved_matrix value set
    % to the solution within the while loop.
    if solutions == 1
        return
    % else, set the solved_matrix to the solution count instead.
    else
        solved_matrix = solutions;
    end
end