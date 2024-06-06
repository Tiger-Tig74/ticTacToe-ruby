class TicTacToe
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
  end

  def play
    loop do
      display_board
      player_move
      if winner?
        display_board
        puts "\nPlayer #{@current_player} wins!"
        break
      elsif draw?
        display_board
        puts "\nIt's a draw!"
        break
      end
      switch_player
    end
  end

  private

  def display_board
    system('clear') || system('cls')
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts '---+---+---'
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts '---+---+---'
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
  end

  def player_move
    row = nil
    col = nil
    loop do
      puts "\nPlayer #{@current_player}, enter your move (row and column) separated by a space: "
      input = gets.chomp.split.map(&:to_i)
      row, col = input.map { |i| i - 1 } if input.size == 2
      break if valid_move?(row, col)

      puts 'Invalid move. Please try again.'
    end
    @board[row][col] = @current_player
  end

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == ' '
  end

  def winner?
    winning_positions.any? do |positions|
      positions.all? { |row, col| @board[row][col] == @current_player }
    end
  end

  def winning_positions
    rows = [[0, 0], [0, 1], [0, 2]], [[1, 0], [1, 1], [1, 2]], [[2, 0], [2, 1], [2, 2]]
    cols = [[0, 0], [1, 0], [2, 0]], [[0, 1], [1, 1], [2, 1]], [[0, 2], [1, 2], [2, 2]]
    diags = [[0, 0], [1, 1], [2, 2]], [[0, 2], [1, 1], [2, 0]]
    rows + cols + diags
  end

  def draw?
    @board.flatten.none? { |cell| cell == ' ' }
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end
end

TicTacToe.new.play
