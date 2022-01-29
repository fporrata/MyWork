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
    return (any( c(all(board[c(1,4,7)] == player), all(board[c(2,5,8)] == player), all(board[c(3,6,9)] == player))))

}

col_win <- function(board, player){
    return (any( c(all(board[c(1,2,3)] == player), all(board[c(4,5,6)] == player), all(board[c(7,8,9)] == player))))
}

diag_win <- function(board, player){
    return (any( c(all(board[c(1,5,9)] == player), all(board[c(3,5,7)] == player))))
}








board <- create_board()
board <- place(board, 5, 3)
board <- place(board, 5, 6)
board <- place(board, 5, 9)
board
#board <- random_place(board, 20)
#board <- random_place(board, 11)
diag_win(board, 5)
col_win(board, 5)
row_win(board, 5)


#board[1][1] = 1
#board[2][1] = 1
#board
#which(board==0)

#board[c(which(board==0))]

#cols_with_all_zeros = (board==0)
#cols_with_all_zeros
