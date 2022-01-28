#This is a work in progress 1/28/2022

create_board <- function() {
    return(matrix(0, 3, 3))
}

place <- function(board, player, position){
    if (board[c(position)] == 0) {
        board[c(position)] <- player
     }
     return (board)
}

possibilities <- function(board){
    return (which(board==0))
}

random_place <- function(board, player){
    selections = possibilities(board)
    if (length(selections) > 0){
        choice = sample(selections,1)
        board <- place(board, player, choice)
    }
    return (board)
}


row_win <- function(board, player){
    rowcheck = np.all(board == player, axis=1)
    return np.any(rowcheck == True)
}

col_win <- function(board, player){
    colcheck = np.all(board == player, axis=0)
    return np.any(colcheck == True)
}

diag_win <- function(board, player){
    diagonal = board.diagonal()
    rowcheck = np.all(diagonal == player)
    return np.any(rowcheck == True)
}








board <- create_board()
board <- place(board, 5, 3)
board <- place(board, 6, 1)
board <- random_place(board, 20)
board <- random_place(board, 11)
board

#board[1][1] = 1
#board[2][1] = 1
#board
#which(board==0)

#board[c(which(board==0))]

#cols_with_all_zeros = (board==0)
#cols_with_all_zeros
