import tkinter as tk

class TicTacToe:
    def __init__(self):
        self.board = [" "] * 9
        self.players = ["X", "O"]
        self.current_player = 0
        self.game_over = False

        self.root = tk.Tk()
        self.root.title("Tic Tac Toe")
        self.buttons = []

        for i in range(3):
            for j in range(3):
                button = tk.Button(self.root, text=" ", font=("Helvetica", 20), width=4, height=2,
                                   command=lambda row=i, col=j: self.make_move(row, col))
                button.grid(row=i, column=j)
                self.buttons.append(button)

        self.status = tk.Label(self.root, text="Player X's turn", font=("Helvetica", 16))
        self.status.grid(row=3, columnspan=3)

        self.root.mainloop()

    def make_move(self, row, col):
        index = row * 3 + col

        if self.board[index] == " " and not self.game_over:
            self.board[index] = self.players[self.current_player]
            self.buttons[index].config(text=self.players[self.current_player], state=tk.DISABLED)

            if self.check_win():
                self.status.config(text=f"Player {self.players[self.current_player]} wins!")
                self.game_over = True
            elif " " not in self.board:
                self.status.config(text="Tie!")
                self.game_over = True
            else:
                self.current_player = (self.current_player + 1) % 2
                self.status.config(text=f"Player {self.players[self.current_player]}'s turn")

    def check_win(self):
        # Check rows
        for i in range(0, 9, 3):
            if self.board[i] == self.board[i+1] == self.board[i+2] != " ":
                return True

        # Check columns
        for i in range(3):
            if self.board[i] == self.board[i+3] == self.board[i+6] != " ":
                return True

        # Check diagonals
        if self.board[0] == self.board[4] == self.board[8] != " ":
            return True
        if self.board[2] == self.board[4] == self.board[6] != " ":
            return True

        return False

game = TicTacToe()
