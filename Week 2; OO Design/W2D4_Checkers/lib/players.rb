require "colorize"

class Player
  attr_accessor :color, :board

  def initialize(color, board)
    @color, @board = color, board
  end

  def handle_turn
    # overwritten by subclass
    raise NotImplementedError
  end
end

class Human < Player
  def handle_turn
    # if there are no required moves:
    cap_color = color.to_s.capitalize
    puts "Hello, #{cap_color} Player. It's your turn now. Which piece will you move?".colorize(color)
    piece = gets.chomp
    pc_to_move = parse_coord(piece)

    raise MoveError if board[pc_to_move].nil?
    raise MoveError if board[pc_to_move].color != self.color

    puts "Very well. Enter in your sequence of moves:".colorize(color)
    dir = gets.chomp
    board[pc_to_move].perform_moves(dir)

    #if there are:
    # puts "I apologize #{color}, but there is a move you must make. Press any key."

  end

  def parse_coord(str)
    digits = str.scan(/\d/)
    raise ArgumentError if digits.length < 2

    digits.map!{ |dig| Integer(dig) }

    [ digits.first, inv_y(digits.last) ]
  end

  def inv_y(int) # invert y - axis
    (int-7).abs
  end
end

class Computer < Player
  def handle_turn
    #Tree.grow(board, truncate to 5 or so){ possible_moves(color) }
    #cascading select. sample
  end
end