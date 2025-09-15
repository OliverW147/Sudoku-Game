% This function handles all user input and executes the appropriate
% functionality where valid
function [] = handle_input(input)
    global game_matrix
    % using strsplit and lower is employed rather than strcompi
    args = strsplit(lower(input));
    switch args{1}
        case "generate"
            % note to not forget to implement error handling for nested
            % switch statements
            switch args{2}
                case "easy"
                    fprintf("");
                case "medium"
                    fprintf("");
                case "hard"
                    fprintf("");
            end
        case "fill"
            % if game matrix is not zero, values are integers between 1-9
            fill_args = split(args{2},",");
            game_matrix(str2double(fill_args{1}),str2double(fill_args{2})) = str2double(fill_args{3});
            clc
            display_matrix(game_matrix);
            
        case "display"
            clc
            display_matrix(game_matrix);
        case "clue"
            fprintf("");
        case "verify"
            fprintf("");
        case "solve"
            fprintf("");
        case "undo"
            fprintf("");
        case "save"
            fprintf("");
        case "load"
            fprintf("");
        case "exit"
            clc
            error('Exit');
        case "help"
            clc
            fprintf("help - list the available commands\n" + ...
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
    end
end