module Minesweeper

  ADJACENT_TILES = [
    [1,   0], [1,   1],
    [0,   1], [-1,  1],
    [-1,  0], [-1, -1],
    [0,  -1], [1,  -1]  ]

  class Tile
    attr_accessor :explored, :contains, :flagged, :won
    attr_reader :neighbors, :coordinates

    def initialize(coordinates, game)
      @game = game
      @coordinates = coordinates
      @neighbors = howdy_neighbors

      @explored = false
      @contains = :B if rand(20) == 1
      @flagged = false
      @won = nil
    end

    def howdy_neighbors
      future_neighbors = []
      ADJACENT_TILES.each do |dif|
        poss_neighbor = [@coordinates[0] + dif[0], @coordinates[1] + dif[1]]
        next unless poss_neighbor[0].between?(0,8)
        next unless poss_neighbor[1].between?(0,8)
        future_neighbors << poss_neighbor
      end

      future_neighbors
    end

    def inspect
      return "F" if flagged
      return "*" if !explored
      return "B" if contains == :B
      return neighboring_bombs if neighboring_bombs > 0
      return "_"
    end

    def neighboring_bombs
      bomb_count = 0
      @neighbors.each do |coords|
        if @game.board[coords.first][coords.last].contains == :B
          bomb_count += 1
        end
      end
      bomb_count
    end

    def is_bomb?
      @contains == :B
    end
  end

  class Board

    def set_tiles
      board = arr=Array.new(9){ Array.new(9) }
      arr.each do |cols|
        cols.each_index do |row|
          #p cols[row] # = Tile.new([cols, row])
          cols[row] = Tile.new([board.index(cols), row], self)
        end
      end
      arr
    end

    def initialize(board=self.set_tiles)
      @board = board
    end

    #
    # def reveal(coordinate)
    #   tile = @board[coordinate.first][coordinate.last]
    #
    #   unless tile.flagged || tile.explored || tile.contains == :B
    #     tile.explored = true
    #     bomb_count = tile.neighboring_bombs
    #     tile.neighbors.each { |coords| reveal(coords) } unless bomb_count > 0
    #   end
    # end
    #
    # def flag(coordinate)
    #   tile = @board[coordinate.first][coordinate.last]
    #   if tile.explored || tile.flagged
    #     puts "Move is invalid."
    #     parse(gets.chomp)
    #   else
    #     tile.flagged = true
    #   end
    #   nil
    # end
    #
    # def unflag(coordinate)
    #   tile = @board[coordinate.first][coordinate.last]
    #   if !tile.flagged
    #     puts "Move is invalid."
    #     parse(gets.chomp)
    #   else
    #     tile.flagged = false
    #   end
    #   nil
    # end










  end

end