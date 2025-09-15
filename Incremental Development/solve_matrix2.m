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
        disp(matrix_iterable)
        row_indices(iteration)
    %end
end