def times_two(arr)
  arr.map{ |element| element * 2}
end

# arr = [1,2,3,4,5]
# p times_two(arr)

class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    self
  end

  def my_median
    sorted_arr = self.sort
    if self.length.odd?
      return sorted_arr[self.length/2]
    else
      return (sorted_arr[self.length/2] + sorted_arr[self.length/2 -1])/2
    end
  end
end

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end
#
# p return_value

# p [2, 3, 4, 4, 5].my_median
# p [1, 6, 3, 5, 2, 5].my_median




def concatenate(arr)
  arr.inject(:+) unless arr.empty?
end

p concatenate(["Yay ", "for ", "strings!"])