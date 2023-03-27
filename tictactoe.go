package main

import (
    "fmt"
)

func main() {
    // Initialize the board
    board := [9]string{" ", " ", " ", " ", " ", " ", " ", " ", " "}

    // Define the player symbols
    playerSymbols := [2]string{"X", "O"}

    // Initialize the current player index
    currentPlayer := 0

    // Display the initial board
    printBoard(board)

    // Start the game loop
    for {
        // Prompt the current player to make a move
        fmt.Printf("Player %s, enter a move (1-9): ", playerSymbols[currentPlayer])
        var move int
        _, err := fmt.Scan(&move)
        if err != nil {
            fmt.Println("Invalid input")
            continue
        }

        // Check if the move is valid
        if move < 1 || move > 9 {
            fmt.Println("Invalid move")
            continue
        }
        if board[move-1] != " " {
            fmt.Println("Position already taken")
            continue
        }

        // Make the move
        board[move-1] = playerSymbols[currentPlayer]

        // Display the updated board
        printBoard(board)

        // Check if the game is over
        winner := checkWinner(board)
        if winner != "" {
            fmt.Printf("Player %s wins!\n", winner)
            break
        }
        if isBoardFull(board) {
            fmt.Println("Tie game")
            break
        }

        // Switch to the next player
        currentPlayer = (currentPlayer + 1) % 2
    }
}

func printBoard(board [9]string) {
    fmt.Println(" 1 | 2 | 3 ")
    fmt.Println("---+---+---")
    fmt.Println(" 4 | 5 | 6 ")
    fmt.Println("---+---+---")
    fmt.Println(" 7 | 8 | 9 ")
    fmt.Println()

    for i, symbol := range board {
        if i%3 == 0 {
            fmt.Print(" ")
        }
        fmt.Print(symbol)
        if i%3 == 2 {
            fmt.Println()
        } else {
            fmt.Print(" | ")
        }
    }

    fmt.Println()
}

func checkWinner(board [9]string) string {
    // Check rows
    for i := 0; i < 9; i += 3 {
        if board[i] != " " && board[i] == board[i+1] && board[i] == board[i+2] {
            return board[i]
        }
    }

    // Check columns
    for i := 0; i < 3; i++ {
        if board[i] != " " && board[i] == board[i+3] && board[i] == board[i+6] {
            return board[i]
        }
    }

    // Check diagonals
    if board[0] != " " && board[0] == board[4] && board[0] == board[8] {
        return board[0]
    }
    if board[2] != " " && board[2] == board[4] && board[2] == board[6] {
        return board[2]
    }

    // No winner
    return ""
}

func isBoardFull(board [9]string) bool {
    for _, symbol := range board {
        if symbol == " " {
            return false
        }
    }
    return true
}
