class Array
  def my_uniq
    unique = []

    self.each do |el|
      next if unique.include?(el)
      unique << el
    end

    unique
  end

  def two_sum
    two_sum_arr = []
    each_index do |i|
      ((i+1)...length).each do |j|
        two_sum_arr << [i, j] if self[i] + self[j] == 0
      end
    end

    two_sum_arr
  end

  def my_transpose
    transposed = Array.new(length){Array.new(length)}
    count.times do |i|
      self[i].count.times do |j|
        transposed[j][i] = self[i][j]
      end
    end

    transposed
  end

  def stock_picker
    profit = 0
    days = []
    count.times do |buy|
      ((buy+1)...length).each do |sell|
        diff = self[sell] - self[buy]
        if profit < diff
          profit = diff
          days = [buy, sell]
        end
      end
    end

    days
  end
end

class Towers
  attr_accessor :stacks

  def initialize
    @stacks = [[1, 2, 3], [], []]
  end

  def move(from, to)
    if stacks[to].empty? || stacks[from].first < stacks[to].first
      stacks[to].unshift(stacks[from].shift)
    end
  end

  def won?
    stacks == [[], [], [1,2,3]]
  end
end