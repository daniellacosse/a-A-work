require 'debugger'
class Array
  def my_each(&proc)
    self.length.times do |index|
      proc.call(self[index])
    end

    self
  end

  def my_map(&proc)
    new_arr  = []
    self.length.times do |index|
      new_arr << proc.call(self[index])
    end

    new_arr
  end

  def my_select(&proc)
    new_arr  = []
    self.length.times do |index|
      new_arr << self[index] if proc.call(self[index])
    end

    new_arr
  end

  def my_inject(base = nil, &proc)
    accumulator = base || self[0]

    self.length.times do |index|
      next unless base.nil? && index == 0
      accumulator = proc.call(accumulator, self[index])
    end

    accumulator
  end

  def my_sort!(&proc)
    proc = Proc.new{ |num1, num2| num1 <=> num2 } if proc.nil?

    sorted = false
    until sorted
      sorted = true

      self.length.times do |index|
        next if index + 1 == self.length

        if proc.call(self[index], self[index + 1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = false
          break
        end
      end
    end

    self
  end
end

def eval_block(*args, &proc)
  raise "NO BLOCK GIVEN" if proc.nil?

  proc.call(*args)
end

