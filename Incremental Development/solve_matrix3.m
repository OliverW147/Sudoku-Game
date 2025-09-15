% Solves a Sudoku game

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
    [row_indices, col_indices] = find(matrix == 0);
    %while true
        iteration = 1;
        matrix_iterable(row_indices(iteration),col_indices(iteration)) = matrix_iterable(row_indices(iteration),col_indices(iteration)) + 1;
        disp(matrix_iterable(row_indices(iteration),1:9))
        disp(matrix_iterable(1:9,col_indices(iteration)))
        subgrid_row_lower = floor(((row_indices(iteration)-1)/3))+1
        subgrid_row_upper = floor(((row_indices(iteration)-1)/3))+3
        subgrid_col_lower = floor(((col_indices(iteration)-1)/3))+1
        subgrid_col_upper = floor(((col_indices(iteration)-1)/3))+3
        disp(matrix_iterable(subgrid_row_lower:subgrid_row_upper,subgrid_col_lower:subgrid_col_upper))
        % if unique(matrix_iterable(1,1:9))
    %end
end