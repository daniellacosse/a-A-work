require "colorize"
require "debugger"

class Board
  attr_accessor :grid

  def self.setup
    opening_board = Board.new
    opening_board.place_opening_pieces
    opening_board
  end

  def initialize(grid = Array.new(8){Array.new(8)})
    @grid = grid
  end

  def render
    puts ""
    grid.length.times do |i|
      render_row(i){ |_| " " } # makes an empty row
      render_row(i){ |sp| sp }
      render_row(i){ |_| " " }
    end
    puts ""
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def []=(pos, val)
    x, y = pos
    @grid[y][x] = val
  end

  def in_grid?(pos)
    pos.all? {|crd| crd.between?(0, 7)}
  end



  def deep_dup
    duped_board = Board.new

    grid.each do |row|
      row.each do |pc|
        next if pc.nil?
        pc_new = Checker.new(pc.pos.dup, pc.color, duped_board)
        pc_new.kinged = true if pc.kinged
        duped_board[pc.pos] = pc_new
      end
    end

    duped_board
  end

  def place_opening_pieces
    place_opening_rows(:black, 0, 1, 2)
    place_opening_rows(:red, 5, 6, 7)

    nil
  end

  def place_opening_rows(color, *rows)
    rows.each do |row|
      grid[row].each_index do |sp|
        if row.even? == sp.odd?
          self[[sp, row]] = Checker.new([sp, row], color, self)
        end
      end
    end
  end

  private
  def render_row(row_num, &blk)
    bkg_color = row_num.even? ? :light_red : :light_white
    row_str = ""
    grid[row_num].each do |sp|
      if sp.nil?
        row_str << "     ".colorize(:background => bkg_color)
      else
        row_str << "  #{blk.call(sp)}  ".colorize(:color => sp.color, :background => bkg_color)
      end
      bkg_color = (bkg_color == :light_red) ? :light_white : :light_red
    end

    puts row_str
  end
end