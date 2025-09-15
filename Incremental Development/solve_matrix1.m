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
    while true
        row = 0;
        column = 0;
        for i = 1:9
            for j = 1:9
                if matrix(i,j) == 0
                    
                end
            end
        end
    end
end