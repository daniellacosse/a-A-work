class Array
  def my_uniq
    uniq_arr = []
    self.each do |item|
        uniq_arr << item if !uniq_arr.include?(item)
    end
    uniq_arr
  end

  def two_sum
    two_sum_arr = []
    self.each_with_index do |item1, index1|
      self.each_with_index do |item2, index2|
        if item1 + item2 == 0 && index1 < index2
          two_sum_arr << [index1, index2]
        end
      end
    end
    two_sum_arr
  end

  def my_transpose
    number_of_rows = self.length
    number_of_columns = self[0].length
    transposed_array = []
    i = 0
    self.flatten!
    while i < number_of_columns
      temp_array = []
      j = i
      while j < number_of_rows * number_of_columns
        temp_array << self[j]
        j += number_of_rows
      end
      transposed_array << temp_array
      i += 1
    end

  transposed_array
  end
end

#new_arr = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
#p new_arr.my_transpose

def stock_picker(price_arr)
  profit = 0
  trade_days = [0,0]
  price_arr.each_with_index do |buy_value, buy_day|
    price_arr.each_with_index do |sell_value, sell_day|
      if (sell_value - buy_value) > profit
        profit = (sell_value - buy_value)
        trade_days[0] = buy_day
        trade_days[1] = sell_day
      end
    end
  end
  "buy on #{trade_days[0]} and sell on #{trade_days[1]} for a profit of #{profit}"
end

p stock_picker([51,5,2,20,200])