#  A simple Tic-Tac-Toe game
# Players 'X' and 'O' take turn inputing their position on the command line using numbers 1-9
# 1 | 2 | 3
# ---------
# 4 | 5 | 6
# ---------
# 7 | 8 | 9
#


# The Game Board 
board = {
    1: ' ', 2: ' ', 3: ' ',
    4: ' ', 5: ' ', 6: ' ',
    7: ' ', 8: ' ', 9: ' '
}

# TODO: update the gameboard with the user input
def markBoard(position, mark):
    board[position] = mark


# TODO: print the game board as described at the top of this code skeleton
# Will not be tested in Part 1
def printBoard():
    
    # dynamic board updating
    board_upd = ""
    for i in range(1, 10):
        if board[i] == ' ':
            board_upd += f" {i} "
        else:
            board_upd += f" {board[i]} "
        
        # aesthetic purposes (borders)
        if i % 3 != 0:
            board_upd += "|"
        else:
            if i != 9:
                board_upd += "\n ---------\n"
    
    print(board_upd)


# TODO: check for wrong input, this function should return True or False.
# True denoting that the user input is correct
# you will need to check for wrong input (user is entering invalid position) or position is out of bound
# another case is that the position is already occupied
def validateMove(position):
    # to check if the keyed in position is a number within 1 to 9
    if isinstance(position, int):
        if position < 1 or position > 9:
            print("\nINVALID MOVE: Inputs should only consist of numbers between 1-9.")
            return False
    elif position.isdigit():
        position = int(position)
        if position < 1 or position > 9:
            print("\nINVALID MOVE: Inputs should only consist of numbers between 1-9.")
            return False
    else:
        print("\nINVALID MOVE: Inputs should only consist of numbers between 1-9.")
        return False

    # to check if the position is already occupied
    if board[position] in ['X', 'O']:
        print("\nINVALID MOVE: This position is already occupied.")
        return False

    return True

# TODO: list out all the combinations of winning, you will neeed this
# one of the winning combinations is already done for you
winCombinations = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
]

# TODO: implement a logic to check if the previous winner just win
# This method should return with True or False
def checkWin(player):
    win = False
    for combination in winCombinations: #iterating through all winning combinations
        if all(board[threemarks] == player for threemarks in combination):
            win = True
            break
    return win


# TODO: implement a function to check if the game board is already full
# For tic-tac-toe, tie bascially means the whole board is already occupied
# This function should return with boolean
def checkFull():
    for value in board.values():
        if value not in ['X', 'O']: # a board with a blank spot instead of an X or O isn't full
            return False
    return True

#########################################################
## Copy all your code/functions in Part 1 to above lines
## (Without Test Cases)
#########################################################

def resetBoard():
    global board
    board = {
        1: ' ', 2: ' ', 3: ' ',
        4: ' ', 5: ' ', 6: ' ',
        7: ' ', 8: ' ', 9: ' '
    }

gameEnded = False
currentTurnPlayer = 'X'

# entry point of the whole program
print('Game started: \n\n' +
    ' 1 | 2 | 3 \n' +
    ' --------- \n' +
    ' 4 | 5 | 6 \n' +
    ' --------- \n' +
    ' 7 | 8 | 9')

# TODO: Complete the game play logic below
# You could reference the following flow
# 1. Ask for user input and validate the input
# 2. Update the board
# 3. Check win or tie situation
# 4. Switch User

while not gameEnded:
    # 1. Ask for user input and validate the input
    move = input("\n"+currentTurnPlayer + "'s turn, input: ")

    if not validateMove(move):
        print("Please try again.")
        continue

    #2. Update the board
    move = int(move)
    markBoard(move, currentTurnPlayer)

    print("\n")
    printBoard()

    # 3. Check win or tie situation
    if checkWin(currentTurnPlayer):
        print("\n\nPlayer",currentTurnPlayer,"wins!")
        gameEnded = True
    elif checkFull():
        print("\n\nIt's a tie!")
        gameEnded = True
    else:
        # 4. Switch User
        if currentTurnPlayer == 'X':
            currentTurnPlayer = 'O'
        else:
            currentTurnPlayer = 'X'

# Bonus Point: Implement the feature for the user to restart the game after a tie or game over

    if gameEnded == True:
        restart = input("Would you like to play again? (Y/N): ").lower()
        if restart == 'y':
            resetBoard()
            print("\n\n")
            printBoard()
            gameEnded = False
            currentTurnPlayer = 'X'
        else:
            print("\nThanks for playing Tic-Tac-Toe!")
            break
