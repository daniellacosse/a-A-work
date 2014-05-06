class TreeNode #treenode is all
  attr_accessor :parent, :children, :value # :parent is node, :children is a pair of node, :value is user defined

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def ==(other_node)
    (self.object_id == other_node.object_id)
    #possible code smells, and/or horrible idea
  end

  def inspect
    puts "Node: #{value ? value : nil}"
    puts "Has Parent: #{parent ? parent.value : nil}"
    puts "Has Children: #{children.map(&:value)}"
  end

  def remove_child(child_node)
    if self.child?(child_node)
      children.delete_if { |child| child == child_node }
      child_node.parent = nil
    else
      raise "THAT'S NOT MY KID"
    end
  end

  def child?(child_node)
    children.include?(child_node)
  end

  def add_child(child_node)
    #raise "PARENT FULL" if children.size >= 2

    child_node.parent = self
    children << child_node unless children.include?(child_node)
  end

  def dfs(value)
    # base case
    return self if self.value == value
    # recursive call
    children.each do |child|
      return child.dfs(value) unless child.dfs(value).nil?
    end
    return nil
  end

  def bfs(value)
    nodes_to_search = [self]

    until nodes_to_search.empty?
      test_node = nodes_to_search.shift
      return test_node if test_node.value == value
      nodes_to_search += test_node.children
    end

    nil
  end

  def path
    return [value] if parent == nil

    parent.path << value
  end
end
