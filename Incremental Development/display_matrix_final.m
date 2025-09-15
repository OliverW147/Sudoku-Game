% This function prints the given Sudoku puzzle (9x9 matrix) nicely
% formatted to the command window

function [] = display_matrix(matrix)
    % get the size of the matrix
    [rows, cols] = size(matrix);
    % print a line at the top of the displayed matrix
    fprintf("-------------------------------------------\n");
    for i = 1:rows
        % print a line on the left of each row of the displayed matrix
        fprintf("|  ");
        for j = 1:cols
            % iterate through each element and print its value
            fprintf(" %.0f ", matrix(i,j));
            % every three columns, print a vertical line to help visualise
            % each of the 9 subgrids (3x3 blocks) in the Sudoku puzzle.
            if mod(j,3) == 0
                fprintf("  |  ");
            end
        end
        % move on to the next line
        fprintf("\n");
        % every three rows, print a horizontal line to help visualise each
        % of the 9 subgrids (3x3 blocks) in the Sudoku puzzle.
        if mod(i,3) == 0
            fprintf("-------------------------------------------\n");
        end
    end
end