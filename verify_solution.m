% This function verifies the validity of a solution to a Sudoku game. It
% outputs 0 when a puzzle is improperly solved, 1 when it is properly
% solved, and 2 if it is unsolved.

% note that this function is fairly similar to solve_matrix

function [is_valid] = verify_solution(matrix)
    % Find the indices of zeros in the game matrix using a function that
    % was found on https://au.mathworks.com/help/matlab/ref/find.html
    [row_indices, col_indices] = find(matrix == 0);
    % set the validity of the solution to 1 (to be possibly proven false in
    % the upcoming nested for loop)
    is_valid = 1;
    % isempty function determines whether there are zeros in the given
    % matrix by checking the length of its zeros' indices
    if isempty(row_indices)
        % iterate through every cell (element) in the matrix
        for row = 1:9
            for col = 1:9
                % store the value of the current cell
                cell_value = matrix(row,col);
                % store the row and column corresponding to the current
                % cell
                current_row = matrix(row,1:9);
                current_col = matrix(1:9,col);
                % store the boundaries of the subgrid (block) where the
                % current cell is.
                subgrid_row_lower = ceil(row/3)*3-2;
                subgrid_col_lower = ceil(col/3)*3-2;
                subgrid_row_upper = ceil(row/3)*3;
                subgrid_col_upper = ceil(col/3)*3;
                % use these boundaries to get the entire subgrid
                subgrid = matrix(subgrid_row_lower:subgrid_row_upper,subgrid_col_lower:subgrid_col_upper);
                
                % current_row == cell_value creates an array of zeros and ones,
                % with ones corresponding to the places where its cell value in
                % current_row is equal to "cell_value". Therefore, taking
                % the sum of current_row == cell_value returns the number
                % of instances of cell_value in the row.

                % this if statement utilises this logic to validate the
                % value of each cell. (if not (only occurrence in row &&
                % only occurrence in column && only occurrence in subgrid))
                % then invalidate the solution.
                if ~(sum(current_row == cell_value) == 1 && sum(current_col == cell_value) == 1 && sum(sum(subgrid == cell_value)) == 1)
                    % return 0 if puzzle is invalid
                    is_valid = 0;
                end
            end
        end
    else
        % return 2 if puzzle is incomplete
        is_valid = 2;
    end
end