% This function handles all user input and executes the appropriate
% functionality where valid
function [] = handle_input(input)
    global game_matrix
    % strsplit and lower are employed rather than strcompi
    args = strsplit(lower(input));
    switch args{1}
        case "generate"
            switch args{2}
                case "very_easy"
                    game_matrix = generate_matrix("very_easy");
                    clc
                    display_matrix(game_matrix);
                case "easy"
                    game_matrix = generate_matrix("easy");
                    clc
                    display_matrix(game_matrix);
                case "medium"
                    game_matrix = generate_matrix("medium");
                    clc
                    display_matrix(game_matrix);
                otherwise
                    fprintf("Invalid input entered\n");
            end
        case "fill"
            % if game matrix is not zero, values are integers between 1-9
            try
                fill_args = split(args{2},",");
                % if is integer and is between 1 (0 for fill_args{3}) and 9
                if (~mod(str2double(fill_args{1}), 1) == 1) && (1<=str2double(fill_args{1}) && str2double(fill_args{1})<=9) && (~mod(str2double(fill_args{2}), 1) == 1) && (1<=str2double(fill_args{2}) && str2double(fill_args{2})<=9) && (~mod(str2double(fill_args{3}), 1) == 1) && (0<=str2double(fill_args{3}) && str2double(fill_args{3})<=9)
                    % previous_value used for checking whether to display
                    % congratulation message
                    previous_value = game_matrix(str2double(fill_args{1}),str2double(fill_args{2}));
                    game_matrix(str2double(fill_args{1}),str2double(fill_args{2})) = str2double(fill_args{3});
                    clc
                    display_matrix(game_matrix);
                    % check each fill if the game is done

                    % (verify_solution() will return 2 if the game is unfinished)
                    if previous_value == 0
                        if verify_solution(game_matrix) == 1
                            fprintf("Congratulations! You have successfully solved the puzzle.\n")
                        elseif verify_solution(game_matrix) == 0
                            fprintf("Uh oh! You have finished the puzzle,\nbut it looks like it is incorrect. Unlucky!\n")
                        end
                    end
                else
                    fprintf("Invalid input entered\n");
            end
            catch
                fprintf("Invalid input entered\n");
            end
            
        case "display"
            clc
            display_matrix(game_matrix);
        case "clue"
            % derived from case "solve"
            if verify_solution(game_matrix) ~= 1
                clc;
                display_matrix(game_matrix);
                solved_game_matrix = solve_matrix(game_matrix);
                % solve_matrix() returns a matrix when solved or an integer
                % representing the number of solutions when there is not 1
                if length(solved_game_matrix) ~= 1
                    clc
                    [row_indices, col_indices] = find(game_matrix == 0);
                    % use rng seed based on the time
                    rng("shuffle");
                    random_index = randi(length(row_indices));
                    fprintf("A clue was given at %.0f, %.0f.\n", row_indices(random_index),col_indices(random_index));
                    game_matrix(row_indices(random_index),col_indices(random_index)) = solved_game_matrix(row_indices(random_index),col_indices(random_index));
                    display_matrix(game_matrix);
                else
                    fprintf("This puzzle is invalid, no clues were found.\n");
                end
            else
                fprintf("This puzzle is already solved.\n");
            end
        case "verify"
            if verify_solution(game_matrix) ~= 1
                clc;
                display_matrix(game_matrix);
                solved_game_matrix = solve_matrix(game_matrix);
                % solve_matrix() returns a matrix when solved or an integer
                % representing the number of solutions when there is not 1
                if length(solved_game_matrix) ~= 1
                    fprintf("This puzzle is solvable.\n");
                else
                    fprintf("This puzzle is unsolvable.\nA mistake has most likely been made when solving. Unlucky!\n(or a puzzle hasn't been generated yet.)\n");
                end
            else
                fprintf("This puzzle is already solved.\n");
            end
        case "solve"
            if verify_solution(game_matrix) ~= 1
                clc;
                display_matrix(game_matrix);
                solved_game_matrix = solve_matrix(game_matrix);
                % solve_matrix() returns a matrix when solved or an integer
                % representing the number of solutions when there is not 1
                if length(solved_game_matrix) ~= 1
                    clc
                    fprintf("A solution was found!\n");
                    game_matrix = solved_game_matrix;
                    display_matrix(game_matrix);
                elseif solved_game_matrix == 0
                    fprintf("This puzzle is invalid, no solutions were found.\n");
                else
                    fprintf("This puzzle is invalid, multiple solutions were found.\n");
                end
            else
                fprintf("This puzzle is already solved.\n");
            end
        case "undo"
            fprintf("");
        case "save"
            fprintf("Here is the current puzzle state:\n")
            for row = 1:9
                for col = 1:9
                    fprintf("%.0f", game_matrix(row,col));
                end
            end
            fprintf("\n")
        case "load"
            try  
            if length(args{2}) == 81
                is_valid = 1;
                numbers = zeros(1,81);
                for i = 1:81
                    % If a value is not numeric than str2double will fail
                    % and trigger the catch statement, args in the if
                    % statement are there mainly for readability
                    if ~isnumeric(str2double(args{2}(i)))
                        is_valid = 0;
                    end

                    % append all values to an array
                    numbers(i) = str2double(args{2}(i));
                    disp(numbers)
                end
                if is_valid == 1
                    game_matrix = reshape(numbers,9,9);
                    clc
                    fprintf("Successfully loaded the puzzle.\n");
                    display_matrix(game_matrix);
                else
                    fprintf("Invalid puzzle provided.\n")
                end
            else
                fprintf("Invalid puzzle provided.\n")
            end
            catch
                fprintf("Invalid puzzle provided.\n")
            end
        case "exit"
            error('Exit');
        case "help"
            clc
            fprintf("help - list the available commands\n" + ...
                "explain - explains how to solve Sudoku puzzles\n" + ...
    "generate <easy/medium/hard> - generate a Sudoku puzzle of the specified difficulty\n" + ...
    "display - display the current puzzle\n" + ...
    "fill <row,column,value> - fill the given cell with the provided value\n" + ...
    "clue - reveal the correct value of a cell in the current puzzle (with justification if possible)\n\n" + ...
    "verify - check whether the puzzle is still solvable (to check for any wrong fills)\n" + ...
    "solve - solve the entirety of the current puzzle\n" + ...
    "undo - undo the last fill\n\n" + ...
    "save - outputs the current Sudoku puzzle state as a string that can be copied and pasted\n" + ...
    "load <string> - loads a Sudoku puzzle from a copied string\n" + ...
    "exit - exit the game\n\n");
        case "explain"
            clc
            % This explanation is from ChatGPT, additionally, I'm not
            % confident with the syntax of cell arrays of character vectors
            % and had to get help using textwrap
            explanation = "In Sudoku, the objective is to fill a 9×9 grid with numbers from 1 to 9, ensuring that no number is repeated in any row, column, or 3×3 subgrid. This means that each row, column, and subgrid must contain all the numbers from 1 to 9 exactly once. A basic strategy for solving Sudoku puzzles is to start by identifying any numbers that can only appear in one position in a row, column, or subgrid. This can be done by looking for numbers that are already present in a row, column, or subgrid and then identifying the missing numbers. If there is only one missing number in a particular row, column, or subgrid, it must go in the remaining empty cell. This process of elimination helps to gradually fill in more cells and find the solution.";
            % Textwrap seperates the cell array into groups of words less
            % than x characters long
            explanation = textwrap({explanation}, 40);
            fprintf("%s\n", explanation{:});
        otherwise
            fprintf("Invalid input entered\n");
    end
end