require 'set'

class Node
  attr_accessor :parent, :children, :value, :set

  def initialize(value, parent = nil, node_set = nil)
    @value = value
    @set = node_set
    @children = []
    @parent = parent
  end

  def inspect
    child_contents = children.map{ |c| c.value }

    puts "Parent: #{parent.value}" unless parent.nil?
    puts "^^^" unless parent.nil?
    puts "Contents: #{value}"
    puts "vvv" unless children.empty?
    puts "Children: #{child_contents}" unless children.empty?
  end

  def add_children(*args)
    args.each do |child|
      child.parent = self
      children << child
    end

    nil # side effect method
  end

  def all_children # returns all children of this node as an array
    return self if children.empty?

    children.each do |child|
      all_children << child.all_children
    end
  end

  def branch # an array of values from the node up to to trunk
    return [value] if parent.nil?

    parent.branch << value
  end

  # ***NOTE*** DRY this:
  def select_if_all(&blk) # select_if_all & select_if_none helper method
    return blk.call(value) if children.empty?

    arr_of_truths = []
    children.each do |child|
      arr_of_truths << child.select_if_all(&blk)
    end

    arr_of_truths
  end

  def select_if_any(&blk) # select_if_all & select_if_none helper method
    return blk.call(value) if children.empty?

    arr_of_truths = []
    children.each do |child|
      arr_of_truths << child.select_if_any(&blk)
    end

    arr_of_truths
  end

  def select_if_one(&blk) # select_if_all & select_if_none helper method
    return blk.call(value) if children.empty?

    arr_of_truths = []
    children.each do |child|
      arr_of_truths << child.select_if_one(&blk)
    end

    arr_of_truths
  end
end

class Tree
  attr_accessor :node_set, :trunk
  attr_reader :leaves, :branches

  # possible options:
  # => truncate on itialize (only so many layer of kids) (false)
  # => cross-paths (disallow repeated values in a branch) (true)

  def initialize(root_node)
    @trunk = root_node.value
    @node_set = Set.new([trunk, *trunk.all_children])
    @leaves = node_set.select {|node| node.children.empty?}
    @branches = leaves.each {|leaf| leaf.branch}
  end

  def self.grow(root_node, &blk)
    # set root_node to trunk
    node_queue = [root_node]

    until node_queue.empty?
      nodes_to_grow = blk.call(node_queue.first.value)
      nodes_to_grow.map!{|node| Node.new(node)}
      node_queue += nodes_to_grow
      node_queue.shift.add_children(*nodes_to_grow) # add the shifted node to the tree
    end
    # for each output from block, generates a new node
    # assigns new node to the node that outputted it
    # keeps going until there are no new nodes
    # stores sets of leaves and branches
    # return new tree
  end

  def inspect
    # start at trunk
    # recursively print children, indented through the levels
    # base case parent = nil
  end

  def [](node_val)
    # get parents and children of node?
  end

  def []=(node_val)
    # assign new value to node
  end

  def +(other_tree, at_node = self.trunk)
    # adds trees, default to at trunk
  end

  def include?(node)
    # checks if tree includes node
  end

  def split(node) # perhaps you'll take multiple args
    # returns new tree, split at node
  end

  def split!(node) # perhaps you'll take multiple args
    # returns new tree, split at node
    # multiple args returns an array of trees
  end

  def dup
    # recursively dup tree
  end

  # shortest branch = min (Tree.min returns shortest branch)
  # longest branch = max (Tree.max returns longest branch)
end