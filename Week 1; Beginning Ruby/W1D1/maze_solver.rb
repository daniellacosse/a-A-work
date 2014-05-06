class Coordinate
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    @x = x
    @y = y
  end

  def x=(x)
    @x = x
  end

  def y=(y)
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end
end

class Maze
  attr_accessor :maze_array, :start_coords, :end_coords, :move_tree

  def initialize(file_path)
    @start_coords = Coordinate.new
    @end_coords = Coordinate.new

    @maze_array = []
    maze_text = File.open(file_path, "r")
    maze_text.each_line do |line|
      @maze_array << line.chomp.split("")
    end

    @start_coords.y= @maze_array.index{ |row| row.include?("S") }
    @start_coords.x= @maze_array[@start_coords.y].index("S")
    @end_coords.y = @maze_array.index{ |row| row.include?("E") }
    @end_coords.x = @maze_array[@end_coords.y].index("E")
    @move_tree = []
  end

  def solve
    find_paths(@start_coords)
  end

  def find_paths(coord)
    possible_moves = []



  end

  def is_good_move?(coordinates)
    return true if @maze_array[coordinates[1]][coordinates[0]] == " "
    false
  end

  def print_maze
    #print @maze_array
    p @maze_array
  end

end

new_maze = Maze.new("/Users/appacademy/Desktop/maze.txt")
new_maze.solve