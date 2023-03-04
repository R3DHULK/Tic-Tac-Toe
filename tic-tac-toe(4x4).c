#include <stdio.h>
#include <stdbool.h>

#define BOARD_SIZE 4

void printBoard(int board[][BOARD_SIZE]) {
    printf("  0 1 2 3\n");
    for (int i = 0; i < BOARD_SIZE; i++) {
        printf("%d ", i);
        for (int j = 0; j < BOARD_SIZE; j++) {
            if (board[i][j] == 0) {
                printf(". ");
            } else if (board[i][j] == 1) {
                printf("X ");
            } else {
                printf("O ");
            }
        }
        printf("\n");
    }
}

bool isValidMove(int board[][BOARD_SIZE], int row, int col) {
    return row >= 0 && row < BOARD_SIZE && col >= 0 && col < BOARD_SIZE && board[row][col] == 0;
}

bool hasWon(int board[][BOARD_SIZE], int player) {
    // Check horizontal lines
    for (int i = 0; i < BOARD_SIZE; i++) {
        int count = 0;
        for (int j = 0; j < BOARD_SIZE; j++) {
            if (board[i][j] == player) {
                count++;
            }
        }
        if (count == BOARD_SIZE) {
            return true;
        }
    }
    // Check vertical lines
    for (int j = 0; j < BOARD_SIZE; j++) {
        int count = 0;
        for (int i = 0; i < BOARD_SIZE; i++) {
            if (board[i][j] == player) {
                count++;
            }
        }
        if (count == BOARD_SIZE) {
            return true;
        }
    }
    // Check diagonal lines
    int count = 0;
    for (int i = 0; i < BOARD_SIZE; i++) {
        if (board[i][i] == player) {
            count++;
        }
    }
    if (count == BOARD_SIZE) {
        return true;
    }
    count = 0;
    for (int i = 0; i < BOARD_SIZE; i++) {
        if (board[i][BOARD_SIZE-i-1] == player) {
            count++;
        }
    }
    if (count == BOARD_SIZE) {
        return true;
    }
    return false;
}

int main() {
    int board[BOARD_SIZE][BOARD_SIZE] = {0};
    int currentPlayer = 1;
    int numMoves = 0;
    while (numMoves < BOARD_SIZE * BOARD_SIZE) {
        printf("Current board:\n");
        printBoard(board);
        printf("Player %d's turn:\n", currentPlayer);
        int row, col;
        do {
            printf("Enter row and column (e.g. 1 2): ");
            scanf("%d %d", &row, &col);
        } while (!isValidMove(board, row, col));
        board[row][col] = currentPlayer;
        numMoves++;
        if (hasWon(board, currentPlayer)) {
            printf("Player %d has won!\n", currentPlayer);
            return 0;
        }
        currentPlayer = currentPlayer == 1 ? 2 : 1;
    }
    printf("It's a tie!\n");
    return 0;
}
