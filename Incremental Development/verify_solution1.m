% Verifies the validity of a solution to a Sudoku game.

% This entire function is just a modified version of solve_matrix()

function [is_valid] = verify_solution(matrix)
    % Find the locations of zeros in the matrix (not my line of code)
    [row_indices, col_indices] = find(matrix == 0);
    % return 1 if puzzle is solved (is set to 0 if invalid later)
    is_valid = 1;
    if isempty(row_indices)
        for row = 1:9
            for col = 1:9
                cell_value = matrix(row,col);
                % get the row and column of the iteration
                current_row = matrix(row,1:9);
                current_col = matrix(1:9,col);
                % get the subgrid boundaries of the current iteration
                subgrid_row_lower = ceil(row/3)*3-2;
                subgrid_col_lower = ceil(col/3)*3-2;
                subgrid_row_upper = ceil(row/3)*3;
                subgrid_col_upper = ceil(col/3)*3;
                % use these boundaries to get the subgrid
                subgrid = matrix(subgrid_row_lower:subgrid_row_upper,subgrid_col_lower:subgrid_col_upper);
       
                % if cell is invalid, 
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