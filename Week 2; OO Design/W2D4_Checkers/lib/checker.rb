# coding: utf-8

require "debugger"

class Checker
  attr_accessor :pos, :kinged
  attr_reader :color, :board

  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
    @kinged = false
  end

  def to_s
    kinged ? "☹" : "☺"
  end

  def perform_moves(dirs)
    if valid_move_seq?(dirs)
      perform_moves!(dirs)
    else
      raise MoveError
    end
  end

  def perform_moves!(dirs)
    dirs_arr = dirs.split(" ")
    if dirs_arr.length > 1
      dirs_arr.each{ |dir| perform_jump(dir) }
    else
      begin
        perform_slide(dirs_arr.first)
      rescue MoveError
        perform_jump(dirs_arr.first)
      end
    end
  end

  def valid_move_seq?(dirs)
    board_dup = board.deep_dup
    begin
      board_dup[pos].perform_moves!(dirs)
    rescue MoveError
      return false
    end

    true
  end

  def required_move?
    unless any_valid_jumps?.empty?

    # grow any_valid_jumps?
    # get longest branch

  end

  def any_valid_jumps?
    valid_jumps = ['l', 'r', 'bl', 'br'].select do |cmd|
      valid_jump = true
      pos_jump_move = direction_toggle(cmd, 2)
      begin
        perform_jump(pos_jump_move)
      rescue MoveError
        vaild_jump = false
      end
      valid_jump
    end
    # return coordinates of valid jumps -- test each for more valid jumps
  end

  private
  def perform_slide(dir)

    raise MoveError if !kinged && dir.include?("b")

    new_pos = direction_toggle(dir)

    handle_mov_errors(new_pos)

    move_to!(new_pos)

    nil
  end

  def perform_jump(dir)

    raise MoveError if !kinged && dir.include?("b")

    new_pos = direction_toggle(dir, 2)
    jum_pos = direction_toggle(dir)

    handle_mov_errors(new_pos)
    handle_jump_errors(jum_pos)

    move_to!(new_pos)
    board[jum_pos] = nil

    nil
  end

  def direction_toggle(char, mag = 1)
    case char
    when 'l'
      return delt(-mag, mag)
    when 'r'
      return delt(mag, mag)
    when 'bl'
      return delt(-mag, -mag)
    when 'br'
      return delt(mag, -mag)
    else
      raise ArgumentError
    end
  end

  def move_to!(new_pos)
    board[pos], board[new_pos] = nil, board[pos]
    self.pos = new_pos
    maybe_promote

    nil
  end

  def maybe_promote
    self.kinged = true if (pos.last == 0) && (color == :red)
    self.kinged = true if (pos.last == 7) && (color == :black)
  end

  def delt(dx, dy)
    dy = (color == :black) ? dy : -dy
    [pos.first + dx, pos.last + dy]
  end

  def handle_mov_errors(new_pos)
    raise MoveError unless board.in_grid?(new_pos)
    raise MoveError if board[new_pos]
  end

  def handle_jump_errors(jum_pos)
    raise MoveError unless board[jum_pos] && board[jum_pos].color != color
  end
end

class MoveError < StandardError
end