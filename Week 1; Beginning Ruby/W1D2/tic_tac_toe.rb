#!/usr/bin/env ruby

class Board
  attr_accessor :board

  def initialize
    @board = Array.new(3) {Array.new(3, " ")}
  end

  def render
    puts "-------------"
    puts "| #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} |"
    puts "-------------"
    puts "| #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} |"
    puts "-------------"
    puts "| #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} |"
    puts "-------------"
  end

  def rows
    row_array = []
    @board.each { |row| row_array << row }
    row_array
  end

  def columns
    col_array = []
    @board.transpose.each { |col| col_array << col }
    col_array
  end

  def diagonals
    diag_array = [[@board[0][0], @board[1][1], @board[2][2]],
    [@board[2][0], @board[1][1], @board[0][2]]]
  end

  def won?
    lines = self.rows + self.columns + self.diagonals

    (lines.include?(["X", "X", "X"]) || lines.include?(["O", "O", "O"]))
  end

  def all_legal_moves
    legal_moves = []

    @board.each_index do |row|
      @board[row].each_index do |column|
        legal_moves << [row, column] if empty?([row, column])
      end
    end

    legal_moves
  end

  def empty?(pos)
    @board[pos.first][pos.last] == " "
  end

  def place_mark(pos, mark)
    @board[pos.first][pos.last] = mark
  end
end

class Game
  attr_accessor :game_board

  def initialize
    @game_board = Board.new
    @player1 = HumanPlayer.new("Dave", self, "X")
    @player2 = ComputerPlayer.new("HAL", self, "O")
    @player_order = [@player1, @player2].shuffle!
    @current_player = @player_order.first
  end

  def play
    until @game_board.won?
      # switches the player
      @player_order[0], @player_order[1] = @player_order[1], @player_order[0]
      # local variable? -- prefer small scope
      @current_player = @player_order.first

      # gets move from the player -- refactor
      if @current_player.is_a?(HumanPlayer)
        puts "It's #{@current_player.name}'s turn!"
        puts "Here's the current board:"
        @game_board.render
        @current_player.gets_command
      end

      @current_player.simulate_human_behavior if @current_player.is_a?(ComputerPlayer)
    end

    @game_board.render
    puts "#{@current_player.name} wins!"
  end

end

class Player
  attr_accessor :mark, :name, :current_game

  def initialize(name, game, mark)
    @name = name
    @current_game = game
    @mark = mark
  end

  def make_move(x_coord, y_coord)
    @current_game.game_board.place_mark([x_coord,y_coord], @mark)
  end
end

class HumanPlayer < Player
  # human is always X -- make dynamic for player type flexibility
  def gets_command
    puts "#{@name}, enter your move co-ordinates (like so: x, y):"
    pos = parse_command

    until @current_game.game_board.empty?(pos)
      puts ""
      puts "I'm afraid you can't do that, #{@name}! Try again:"
      pos = parse_command
    end

    puts ""
    self.make_move(pos.first, pos.last)
  end

  def parse_command
    x_coord, y_coord = gets.chomp.split(", ")
    x_coord, y_coord = x_coord.to_i, y_coord.to_i # Integer()
    [x_coord, y_coord]
  end

end

class ComputerPlayer < Player
  # computer is always O
  def check_for_win
    @current_game.game_board.all_legal_moves.each do |move|
      @current_game.game_board.place_mark(move, @mark) #polymorph dup for board

      if @current_game.game_board.won?
        @current_game.game_board.place_mark(move, " ")
        return move
      end

      @current_game.game_board.place_mark(move, " ")
    end

    nil
  end

  def simulate_human_behavior
    winning_move = self.check_for_win

    unless winning_move.nil?
        self.make_move(winning_move.first, winning_move.last)
    else
      move = @current_game.game_board.all_legal_moves.sample
      self.make_move(move.first, move.last)
    end

    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  tic_tac_toe = Game.new
  tic_tac_toe.play
end