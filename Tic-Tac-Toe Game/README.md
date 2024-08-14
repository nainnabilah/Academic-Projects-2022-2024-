# Tic-Tac-Toe Game

This is a simple command-line Tic-Tac-Toe game made using Python code in Spyder. Two players, 'X' and 'O', will take turns to input their positions on the board using numbers 1-9. The game checks for valid inputs, updates the board, and determines if there is a winner or if the game ends in a tie. The game also provides an option to restart after it ends.

## Table of Contents
1. [Game Board](#game-board)
2. [How to Play](#how-to-play)
3. [Functions Overview](#functions-overview)
4. [Game Flow](#game-flow)

## Game Board

The Tic-Tac-Toe board is represented as follows:

```
 1 | 2 | 3
 ---------
 4 | 5 | 6
 ---------
 7 | 8 | 9
```

Each number corresponds to a position on the board where a player can place their mark ('X' or 'O').

## How to Play

1. Run the script to start the game.
2. The board will be displayed, and Player 'X' will be prompted to enter a number corresponding to the desired position.
3. After each valid move, the board updates and checks if there's a winner or if the board is full (a tie).
4. The game will continue until there's a winner or a tie.
5. After the game ends, players will be prompted to restart or exit the game.

## Functions Overview

### `markBoard(position, mark)`
- Updates the game board with the player's mark ('X' or 'O') at the specified position.

### `printBoard()`
- Dynamically prints the current state of the game board.

### `validateMove(position)`
- Checks if the user's input is valid:
  - The input must be a number between 1 and 9.
  - The chosen position must not be already occupied.

### `checkWin(player)`
- Checks if the current player has won by comparing the board's state with predefined winning combinations.

### `checkFull()`
- Checks if the board is full, meaning no more moves can be made (a tie).

### `resetBoard()`
- Resets the board to its initial empty state.

## Game Flow

1. **Initialisation**:
   - The game starts by initialising the board and setting `currentTurnPlayer` to 'X'.

2. **User Input**:
   - Players are prompted to input their desired position on the board. The input is validated for correctness.

3. **Board Update**:
   - If the input is valid, the board is updated with the player's mark.

4. **Win/Tie Check**:
   - After each move, the game checks if the current player has won or if the board is full.

5. **Switch Player**:
   - If there is no winner and the board is not full, the turn switches to the other player.

6. **End of Game**:
   - If a player wins or the game ends in a tie, the game prompts the players to either restart or exit.

## License

This project is open-source and available under the MIT License. Feel free to modify and distribute it as you like.
