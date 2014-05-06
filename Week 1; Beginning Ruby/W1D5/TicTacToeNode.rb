require './06_tic_tac_toe.rb'

class TicTacToeNode
  attr_accessor :game_board, :prev_move_pos, :next_player

  def initialize(board, next_player = :x, prev_move_pos = nil)
    @game_board = board
    @next_player = next_player
    @prev_move_pos = prev_move_pos
    # make move tree?
  end

  def children
    possible_boards = []

    (0..2).each do |x|
      (0..2).each do |y|
        if game_board.empty?([x, y])
          next_board = game_board.dup
          next_board[[x,y]] = next_player
          next_player == :x ? next_player = :o : next_player = :x
          possible_boards << TicTacToeNode.new(next_board, next_player, [x, y])
        end
      end
    end

    possible_boards
  end


  def losing_node?(player)
    return true if game_board.over? && game_board.winner != player
    # It's the player's turn and all the children nodes are losing boards for the play
    # It is the opponent's turn, and one of the children nodes is a losing board for the player
    if next_player == player
      self.children.each do |child|
        child.losing_node?(player)
      end.all?
    else
      self.children.each do |child|
        child.losing_node?(player)
      end.one?
    end
  end

  def winning_node?(player)

  end

end