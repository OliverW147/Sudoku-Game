% This function is a modified version of solve_matrix.m that ignores
% multiple solutions and always returns a solution even if there is more
% than one.

function [solved_matrix] = generate_possible_solution(matrix)
    matrix_iterable = matrix;
    % Find the indices of zeros in the game matrix using a function that
    % was found on https://au.mathworks.com/help/matlab/ref/find.html

    % The find function orders everything up to down and not left to right,
    % to change this, the indices could be shuffled randomly as seen in the
    % comments below, however, this addition heavily increases the time
    % complexity of the function/algorithm and was chosen to be omitted.
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
    
    % initialise important counters
    iteration = 1;
    % cap solver at 1500000 steps
    steps = 0;
    solutions = 0;
    while iteration <= length(row_indices) && steps < 1500000
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

        % The next if statement uses this logic to end the while loop and
        % return the solution that was found.
        if iteration > length(row_indices)
            solved_matrix = matrix_iterable;
            solutions = 1;
            break
        end
    end
    % if there were no solutions, then return 0.
    if solutions == 0
        solved_matrix = 0;
    end
end