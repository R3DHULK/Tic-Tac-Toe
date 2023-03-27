class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @current_player = "X"
  end

  def play
    loop do
      display_board
      print_turn_prompt
      row, col = get_move
      make_move(row, col)
      break if game_over?
      switch_players
    end
    display_board
    print_result
  end

  private

  def display_board
    puts "   |   |   "
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts "___|___|___"
    puts "   |   |   "
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts "___|___|___"
    puts "   |   |   "
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
    puts "   |   |   "
  end

  def print_turn_prompt
    puts "#{@current_player}'s turn. Enter row and column (e.g. 1 2):"
  end

  def get_move
    loop do
      input = gets.chomp.split.map(&:to_i)
      row, col = input[0], input[1]
      if valid_move?(row, col)
        return row, col
      else
        puts "Invalid move. Please try again."
      end
    end
  end

  def valid_move?(row, col)
    @board[row - 1][col - 1] == " "
  end

  def make_move(row, col)
    @board[row - 1][col - 1] = @current_player
  end

  def switch_players
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def game_over?
    win? || draw?
  end

  def win?
    rows_win? || cols_win? || diagonals_win?
  end

  def rows_win?
    @board.any? { |row| row.uniq.size == 1 && row[0] != " " }
  end

  def cols_win?
    @board.transpose.any? { |col| col.uniq.size == 1 && col[0] != " " }
  end

  def diagonals_win?
    diagonals = [[@board[0][0], @board[1][1], @board[2][2]],
                 [@board[0][2], @board[1][1], @board[2][0]]]
    diagonals.any? { |diag| diag.uniq.size == 1 && diag[0] != " " }
  end

  def draw?
    @board.flatten.none? { |cell| cell == " " }
  end

  def print_result
    if win?
      puts "#{@current_player} wins!"
    else
      puts "It's a draw."
    end
  end
end

game = TicTacToe.new
game.play
