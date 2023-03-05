# Define the initial game board
board <- matrix(rep(" ", 9), ncol = 3)

# Define a function to print the game board
print_board <- function(board) {
  cat(" ", "1", "2", "3", "\n")
  cat("1", board[1,], "\n")
  cat("2", board[2,], "\n")
  cat("3", board[3,], "\n")
}

# Define a function to check if the game is over
game_over <- function(board) {
  # Check for horizontal wins
  for (i in 1:3) {
    if (board[i,1] != " " && all(board[i,] == board[i,1])) {
      return(TRUE)
    }
  }
  
  # Check for vertical wins
  for (j in 1:3) {
    if (board[1,j] != " " && all(board[,j] == board[1,j])) {
      return(TRUE)
    }
  }
  
  # Check for diagonal wins
  if (board[1,1] != " " && all(diag(board) == board[1,1])) {
    return(TRUE)
  }
  if (board[1,3] != " " && all(diag(board[,3:1]) == board[1,3])) {
    return(TRUE)
  }
  
  # Check for a tie
  if (!any(board == " ")) {
    return(TRUE)
  }
  
  # If we get here, the game is not over
  return(FALSE)
}

# Define a function to get the user's move
get_move <- function(player) {
  repeat {
    move <- readline(paste0(player, "'s turn (row,column): "))
    move <- as.numeric(strsplit(move, ",")[[1]])
    if (length(move) == 2 && all(move %in% 1:3) && board[move[1],move[2]] == " ") {
      return(move)
    }
    cat("Invalid move. Please try again.\n")
  }
}

# Define the main game loop
print_board(board)
while (!game_over(board)) {
  # Player X's turn
  move <- get_move("X")
  board[move[1],move[2]] <- "X"
  print_board(board)
  if (game_over(board)) {
    break
  }
  
  # Player O's turn
  move <- get_move("O")
  board[move[1],move[2]] <- "O"
  print_board(board)
}

# Print the final game board and outcome
print_board(board)
if (any(diag(board) == "X") || all(diag(board) == "O")) {
  cat("Player ", board[1,1], " wins!\n")
} else {
  cat("Tie game.\n")
}
