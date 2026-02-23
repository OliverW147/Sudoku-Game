# Sudoku in MATLAB

## Description

This project allows users to play Sudoku puzzles of varying difficulties, generate new puzzles, and utilise several helper functions to solve and analyse the game.

This implementation is based on the puzzle generation algorithm outlined by Andrew C. Stuart in his paper "Sudoku Creation and Grading". The puzzles included in this repository are sourced from https://github.com/dimitri/sudoku.

## How to Run

1.  Ensure you have MATLAB installed.
2.  Clone or download this repository to your local machine.
3.  Open MATLAB and navigate to the directory where you saved the project files.
4.  Run the `main.m` file by typing `main` in the MATLAB command window and pressing Enter.

## Commands

Upon running the program, you will be greeted with a welcome message and a list of available commands. Here is a summary of the commands you can use:

*   **`help`**: Displays the list of available commands.
*   **`explain`**: Provides an explanation of how to play Sudoku.
*   **`puzzle <easy/hard>`**: Selects and displays a random puzzle from the pre-loaded set of the specified difficulty.
*   **`gen_puzzle <easy/medium>`**: Generates and displays a new Sudoku puzzle of the specified difficulty.
*   **`display`**: Clears the command window and displays the current puzzle.
*   **`fill <row,column,value>`**: Fills the specified cell with the given value. For example, `fill 1,1,5` will place the number 5 in the top-left cell.
*   **`clue`**: Reveals the correct value for a single random empty cell.
*   **`verify`**: Checks if the current puzzle is still solvable (useful for checking for incorrect entries).
*   **`solve`**: Attempts to solve the entire puzzle and displays the solution if found.
*   **`undo`**: Reverts the last "fill" command.
*   **`save`**: Outputs the current state of the puzzle as a string that can be copied.
*   **`load <string>`**: Loads a puzzle from a string (e.g., one that was previously saved).
*   **`extras <plot/imshow/imwrite/randword>`**:
    *   `plot`: Displays the puzzle in a MATLAB figure.
    *   `imshow`: Displays the puzzle as a grayscale image.
    *   `imwrite`: Saves the puzzle as a grayscale PNG image.
    *   `randword`: Displays a random word related to a Sudoku-solving technique.
*   **`exit`**: Exits the game.

## File Descriptions

*   `main.m`: The main script to run the Sudoku game.
*   `handle_input.m`: Handles all user input and calls the appropriate functions.
*   `print_help.m`: Displays the list of available commands.
*   `display_matrix.m`: Formats and prints the Sudoku grid to the command window.
*   `generate_matrix.m`: Generates a new Sudoku puzzle.
*   `generate_possible_solution.m`: A helper function for `generate_matrix.m` to create a solved Sudoku grid.
*   `select_random_matrix.m`: Selects a random puzzle from the `.csv` files.
*   `solve_matrix.m`: Solves the current Sudoku puzzle using a backtracking algorithm.
*   `verify_solution.m`: Verifies if the current state of the puzzle is correct and complete.
*   `easy_puzzles.csv` & `hard_puzzles.csv`: Contain the pre-loaded Sudoku puzzles.
*   `dictionary_of_techniques.txt`: A list of Sudoku-solving techniques used by the `extras randword` command.
