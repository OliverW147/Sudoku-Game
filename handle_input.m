% This function handles user input and implements most of the functionality

function [] = handle_input(input)
    % Global variable definitions are used to allow for modifying the
    % current game martix rather than aways parsing them as arguments.
    global game_matrix last_edit
    % strsplit and lower transform the user input here, rather than
    % overusing strcompi.
    args = strsplit(lower(input));
    switch args{1}

        % if input is "puzzle", make sure second user-input argument is a
        % valid difficulty, if so, call select_random_matrix(<difficulty>)
        % to randomly select a puzzle from the appropriate csv file within
        % the directory and assign it to the current game_matrix. Then call
        % display_matrix(game_matrix) to display the current puzzle.

        % note that all of the puzzles defined in the csv files are from
        % https://github.com/dimitri/sudoku


        case "puzzle"
            try
            switch args{2}
                case "easy"
                    game_matrix = select_random_matrix("easy");
                    display_matrix(game_matrix);
                case "hard"
                    game_matrix = select_random_matrix("hard");
                    display_matrix(game_matrix);
                otherwise
                    fprintf("Invalid input entered\n");
            end
            catch
                    fprintf("Invalid input entered\n");
            end
        

        % if input is "gen_puzzle", make sure second user-input argument is
        % a valid difficulty, if so, call generate_matrix(<difficulty>) to
        % generate a puzzle and assign it to the current game_matrix, and
        % call display_matrix(game_matrix) to display the current puzzle.


        case "gen_puzzle"
            try
            switch args{2}
                case "easy"
                    game_matrix = generate_matrix("easy");
                    clc;
                    display_matrix(game_matrix);
                case "medium"
                    game_matrix = generate_matrix("medium");
                    clc;
                    display_matrix(game_matrix);
                otherwise
                    fprintf("Invalid input entered\n");
            end
            catch
                fprintf("Invalid input entered\n");
            end


        % if input is "fill", validate whether the second input argument is
        % valid. If so, set the specified index of the game matrix
        % (cell/element) to the specified value. Else, tell the user to try
        % again.


        case "fill"
            try
                % a valid second argument could be 1,1,2 where 1,1 is the
                % index of a current puzzle's cell and 2 is the value to
                % assign that cell. split(<args>) is used to seperate these
                % values.
                fill_args = split(args{2},",");
                % check if the values are integers within the appropriate
                % bounds. (if arg1 is integer && arg1 is between 1 and 9 &&
                % if arg2 is integer && arg2 is between 1 and 9 && if arg3
                % is integer && arg3 is between 0 and 9)
                if (~mod(str2double(fill_args{1}), 1) == 1) && (1<=str2double(fill_args{1}) && str2double(fill_args{1})<=9) && (~mod(str2double(fill_args{2}), 1) == 1) && (1<=str2double(fill_args{2}) && str2double(fill_args{2})<=9) && (~mod(str2double(fill_args{3}), 1) == 1) && (0<=str2double(fill_args{3}) && str2double(fill_args{3})<=9)
                    % previous_value is defined to check whether to display
                    % a congratulation message
                    previous_value = game_matrix(str2double(fill_args{1}),str2double(fill_args{2}));
                    % store the index of the last edited cell and its old
                    % value,
                    last_edit = [str2double(fill_args{1}),str2double(fill_args{2}),previous_value];
                    % make the edit to the game matrix
                    game_matrix(str2double(fill_args{1}),str2double(fill_args{2})) = str2double(fill_args{3});
                    % clear the command window output
                    clc
                    % call display_matrix(game_matrix) to display the
                    % update.
                    display_matrix(game_matrix);

                    % call verify_solution(game_matrix) to check whether
                    % the puzzle is done. verify_solution(<matrix>) will
                    % return 0 if the puzzle is finished and wrong, 1 if it
                    % is finished and correct, and 2 if it is incomplete.

                    % if the previous_value of the edited cell was zero,
                    % check if the puzzle is complete
                    if previous_value == 0
                        % if it is complete and right, display
                        % congratulations
                        if verify_solution(game_matrix) == 1
                            fprintf("Congratulations! You have successfully solved the puzzle.\n")
                        % if it is complete and wrong, display the
                        % 'incorrect' message
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
            

        % if case is "display", clear the command window and call
        % display_matrix(game_matrix) to display the current game.


        case "display"
            clc
            display_matrix(game_matrix);


        % if case is "clue", attempt to solve the game, then pick a random
        % cell with the value of zero from the current game and insert the
        % value of that cell from the solved game into the current game.


        case "clue"
            % if not already solved
            if verify_solution(game_matrix) ~= 1
                % clear command window
                clc;
                % display the game matrix before attempting to find a clue
                display_matrix(game_matrix);
                % solve the current game matrix and store it in
                % solved_game_matrix
                solved_game_matrix = solve_matrix(game_matrix);
                % as solve_matrix(game_matrix) returns a matrix when solved or
                % an integer representing the number of solutions when
                % unsolved (zero or more than one), this if statement
                % checks if solving was successful.
                if length(solved_game_matrix) ~= 1
                    % clear the command window
                    clc;
                    % store the indices of values equal to zero within the
                    % game_matrix to row_indices and col_indices.
                    [row_indices, col_indices] = find(game_matrix == 0);
                    % set an rng seed based on the time
                    rng("shuffle");
                    % choose a random index of a zero value in the game
                    % matrix
                    random_index = randi(length(row_indices));
                    % display the random index that was chosen to the user
                    fprintf("A clue was given at %.0f, %.0f.\n", row_indices(random_index),col_indices(random_index));
                    % store the index of the last edited cell and its old
                    % value,
                    last_edit = [row_indices(random_index),col_indices(random_index),game_matrix(row_indices(random_index),col_indices(random_index))];
                    % update the zero value in the game_matrix to the
                    % non-zero value in the solved matrix
                    game_matrix(row_indices(random_index),col_indices(random_index)) = solved_game_matrix(row_indices(random_index),col_indices(random_index));
                    % call display_matrix(game_matrix) to display the
                    % updated game.
                    display_matrix(game_matrix);
                % if there are zero solutions to the game matrix, then
                % print that the solver couldn't find any solutions
                elseif solved_game_matrix == 0
                    fprintf("This puzzle is either really hard or contains mistakes.\nNo clues were found.\n");
                % if there are multiple solutions to the game matrix, then
                % print that the puzzle is invalid
                else
                    fprintf("This puzzle is invalid.\n");
                end
            % if the puzzle is already solved then tell the user.
            else
                fprintf("This puzzle is already solved.\n");
            end


        % if case is "verify", attempt to solve the game and if
        % solve_matrix(game_matrix) returns a matrix and not an integer,
        % then it is solved.


        case "verify"
            % call verify_solution to make sure that the game is not
            % already solved
            if verify_solution(game_matrix) ~= 1
                % clear the command window and call
                % display_matrix(game_matrix) to display the current
                % game_matrix
                clc;
                display_matrix(game_matrix);
                % attempt to solve the game and store the result in
                % solved_game_matrix
                solved_game_matrix = solve_matrix(game_matrix);
                % solve_matrix() returns a matrix when solved or an integer
                % representing the number of solutions when there is not
                % one solution.
                % if solved_game_matrix is a matrix then it is likely
                % solvable
                if length(solved_game_matrix) ~= 1
                    fprintf("This puzzle is likely solvable.\n");
                % else if there were no solutions found, then tell this to
                % the user.
                elseif solved_game_matrix == 0
                    fprintf("This puzzle is either really hard or contains mistakes.\nNo solutions were found.\n");
                % else, there were multiple solutions, tell the user the
                % puzzle is invalid.
                else
                    fprintf("This puzzle is invalid.\n");
                end
            % if verify_solution(game_matrix) returns 1, the puzzle is
            % already solved.
            else
                fprintf("This puzzle is already solved.\n");
            end


        % if case is "solve", attempt to solve the game_matrix and set the
        % game_matrix to the solution if a solution is found. (similar to
        % case "verify")


        case "solve"
            % call verify_solution to make sure that the game is not
            % already solved
            if verify_solution(game_matrix) ~= 1
                % clear the command window and call
                % display_matrix(game_matrix) to display the current
                % game_matrix
                clc;
                display_matrix(game_matrix);
                % attempt to solve the game and store the result in
                % solved_game_matrix
                solved_game_matrix = solve_matrix(game_matrix);
                % solve_matrix() returns a matrix when solved or an integer
                % representing the number of solutions when there is not
                % one solution.
                % if solved_game_matrix is a matrix then it is likely
                % solvable
                if length(solved_game_matrix) ~= 1
                    % clear the command window
                    clc
                    % tell the user a solution was found
                    fprintf("A solution was found!\n");
                    % update game_matrix to the solution and call
                    % display_matrix(game_matrix) to display the solution
                    game_matrix = solved_game_matrix;
                    display_matrix(game_matrix);
                % if there were no solutions found, tell this to the user
                elseif solved_game_matrix == 0
                    fprintf("This puzzle is either really hard or contains mistakes.\nNo solutions were found.\n");
                % if there were multiple solutions found, tell the user the
                % puzzle is invalid.
                else
                    fprintf("This puzzle is invalid.\n");
                end
            % if verify_solution(game_matrix) returns 1, the puzzle is
            % already solved.
            else
                fprintf("This puzzle is already solved.\n");
            end


        % if case is "undo", replace the last edited cell with its previous
        % value


        case "undo"
            % replace the last edited cell with its previous value
            game_matrix(last_edit(1),last_edit(2)) = last_edit(3);
            % clear the command window, inform the user of the undo, then
            % call display_matrix(game_matrix) to display the updated
            % puzzle.
            clc
            fprintf("Undid the previous move.\n");
            display_matrix(game_matrix);

        
        % if case is "save", iterate through every cell (element) in the
        % game_matrix and print it.


        case "save"
            fprintf("Here is the current puzzle's state:\n")
            for row = 1:9
                for col = 1:9
                    fprintf("%.0f", game_matrix(row,col));
                end
            end
            fprintf("\n")

        
        % if case is "load", check if the second user-input argument is a valid
        % representation of a puzzle. If it is, then set that input to the
        % current game matrix.


        case "load"
            try  
            % if the input is the right length
            if length(args{2}) == 81
                is_valid = 1;
                numbers = zeros(1,81);
                % attempt to concatenate everything to an integer/digit and
                % append it to a 1D array. If it fails, the catch statement
                % will tell the user their input is invalid.
                for i = 1:81
                    % the lines in this next if statement are purely for
                    % readability.
                    if ~isnumeric(str2double(args{2}(i)))
                        is_valid = 0;
                    end

                    % append the valid values to the 1D array
                    numbers(i) = str2double(args{2}(i));
                    disp(numbers)
                end
                if is_valid == 1
                    % use the reshape function to transform the 1x81 matrix
                    % into the 9x9 game_matrix.
                    game_matrix = reshape(numbers,9,9);
                    % clear the command window and display the loaded
                    % puzzle with a success message.
                    clc
                    fprintf("Successfully loaded the puzzle.\n");
                    display_matrix(game_matrix);
                % these next else statements will execute if the input is
                % invalid.
                else
                    fprintf("Invalid input entered.\n");
                end
            else
                fprintf("Invalid input entered.\n");
            end
            catch
                fprintf("Invalid input entered.\n");
            end


        % if case is "error", throw an error that will be caught by the
        % main game loop. The main game loop will then thank the user for
        % playing and then break.


        case "exit"
            error('Exit');


        % if case is help, clear the command window and then call a
        % function to print all the available commands to the user.


        case "help"
            clc;
            print_help();


        % if case is "explain", print an explanation of Sudoku.


        case "explain"
            clc
            % Note that this explanation of Sudoku is sourced from online.
            fprintf("In Sudoku, the objective is to fill a 9×9 grid with numbers from 1 to 9,\n" + ...
                " ensuring that no number is repeated in any row, column, or 3×3 subgrid. This means\n" + ...
                "that each row, column, and subgrid must contain all the numbers from 1 to 9 exactly\n" + ...
                "once. A basic strategy for solving Sudoku puzzles is to start by identifying any\n" + ...
                "numbers that can only appear in one position in a row, column, or subgrid. This can\n" + ...
                "be done by looking for numbers that are already present in a row, column, or subgrid\n" + ...
                "and then identifying the missing numbers. If there is only one missing number in a\n" + ...
                "particular row, column, or subgrid, it must go in the remaining empty cell. This\n" + ...
                "process of elimination helps to gradually fill in cells and find the solution.\n");
        
        
        % if case is "extras", execute some functionality based on the
        % second input. The extras are mainly here to demonstrate concepts
        % mentioned in practicals.


        case "extras"
            try
            switch args{2}
                % imshow/imsave/plot/randword

                % displays the current Sudoku game as a grayscale image
                % using imshow()
                case "imshow"
                    % transform game_matrix so that zeros are white instead
                    % of black
                    inverted_matrix = abs(game_matrix - 9);
                    % show image
                    imshow(inverted_matrix,[0,9]);

                % saves the current Sudoku game as a grayscale image using
                % imwrite()
                case "imwrite"
                    % transform game_matrix so that zeros are white instead
                    % of black
                    inverted_matrix = (abs(game_matrix - 9))./9;
                    % save image
                    imwrite(inverted_matrix,"saved_puzzle_grayscale.png");

                    % example usage of "whos"
                    % image_data = imread("saved_puzzle_grayscale.png");
                    % whos image_data;

                % plot the current Sudoku game on a figure.
                case "plot"
                    % Create a figure
                    figure;
                    % display each cell (element) of the current Sudoku
                    % game as text on the figure's axes.
                    hold on
                    % plot function didn't work for 2D array so do this
                    % instead
                    for i = 1:9
                        for j = 1:9
                            % https://au.mathworks.com/help/matlab/ref/text.html
                            text(j, 10-i, num2str(game_matrix(i,j)));
                        end
                    end
                    hold off
                    % Set axes view boundaries
                    axis([0.5, 9.5, 0.5, 9.5]);
                    % Hide the actual axis
                    axis off;

                % print a random word from a .txt file of
                % Sudoku-solving techniques.
                case "randword"
                    dictionary = fileread("dictionary_of_techniques.txt");
                    dictionary = splitlines(dictionary);
                    rng("shuffle");
                    rand_index = randi(length(dictionary));
                    clc;
                    fprintf("Here is the random word relating to a Sudoku technique:\n%s\n", dictionary{rand_index});

                % handle invalid second user-input argument.
                otherwise
                    fprintf("Invalid input entered.\n");
            end
            catch
                fprintf("Invalid input entered.\n");
            end
        % handle invalid first user-input argument.
        otherwise
            fprintf("Invalid input entered\n");
    end
end