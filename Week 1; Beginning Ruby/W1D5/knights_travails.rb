require './tree_node.rb'

class KnightPathFinder

  attr_reader :starting_position, :move_tree

  POSSIBLE_MOVES = [[1,2],[-1,2], [1,-2], [-1, -2],
                      [2,1], [2,-1], [-2,1], [-2,-1]]

  def initialize(position = [0, 0])
    @starting_position = position
    @move_tree = build_move_tree(position)
  end

  def build_move_tree(position)

    root = TreeNode.new(starting_position)

    node_queue = [root]

    seen_positions = [starting_position]

    until node_queue.empty?
      current_node = node_queue.shift
      found_children = legal_moves(current_node.value) # one_move_away
      found_children -= seen_positions

      found_children.each do |pos|
        new_node = TreeNode.new(pos)
        current_node.add_child(new_node)
        node_queue << new_node
        seen_positions << pos
      end
    end

    root
  end

  def find_path(position)
    target_node = move_tree.bfs(position)

    target_node.path
  end

  private
  def legal_moves(position)
    result = []

    POSSIBLE_MOVES.each do |diff|
      new_pos = [position[0] + diff[0], position[1] + diff[1]]
      result << new_pos if (0..7).include?(new_pos[0]) && (0..7).include?(new_pos[1])
    end

    result
  end

end