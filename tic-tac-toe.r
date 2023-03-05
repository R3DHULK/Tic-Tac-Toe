# Define a function to display the board
display_board <- function(board) {
  cat(paste(board[1:3], collapse=" | "), "\n")
  cat("---------\n")
  cat(paste(board[4:6], collapse=" | "), "\n")
  cat("---------\n")
  cat(paste(board[7:9], collapse=" | "), "\n")
}

# Define a function to check if the game has been won
game_won <- function(board) {
  winning_rows <- list(c(1,2,3), c(4,5,6), c(7,8,9),
                        c(1,4,7), c(2,5,8), c(3,6,9),
                        c(1,5,9), c(3,5,7))
  for(row in winning_rows) {
    if(all(board[row] == "X") || all(board[row] == "O")) {
      return(TRUE)
    }
  }
  return(FALSE)
}

# Set up the game
board <- rep(" ", 9)
players <- c("X", "O")
current_player <- players[1]

# Play the game
while(!game_won(board) && " " %in% board) {
  display_board(board)
  move <- as.numeric(readline(paste(current_player, "'s move (1-9): ")))
  if(board[move] == " ") {
    board[move] <- current_player
    current_player <- players[ifelse(current_player == "X", 2, 1)]
  } else {
    cat("That square is already taken. Try again.\n")
  }
}

# Display the final state of the game
display_board(board)

# Display the result
if(game_won(board)) {
  cat(current_player, "wins!")
} else {
  cat("It's a tie.")
}
