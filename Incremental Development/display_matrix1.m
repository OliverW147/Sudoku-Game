function [] = display_matrix(matrix)
    [rows, cols] = size(matrix);
    fprintf("-------------------------------------------\n");
    for i = 1:cols
        fprintf("|  ");
        for j = 1:rows
            fprintf(" %.0f ", matrix(i,j));
            if mod(j,3) == 0
                fprintf("  |  ");
            end
        end
        fprintf("\n");
        if mod(i,3) == 0
            fprintf("-------------------------------------------\n");
        end
    end
end