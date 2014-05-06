class Fixnum
  def three_digit_word(digits)
    digits = digits.to_i
    three_digit_str = []
    tens = {
      100 => "hundred",
      90 => "ninety",
      80 => "eighty",
      70 => "seventy",
      60 => "sixty",
      50 => "fifty",
      40 => "forty",
      30 => "thirty",
      20 => "twenty"
    }

    teens = {
      19 => "nineteen",
      18 => "eighteen",
      17 => "seventeen",
      16 => "sixteen",
      15 => "fifteen",
      14 => "fourteen",
      13 => "thirteen",
      12 => "twelve",
      11 => "eleven",
      10 => "ten",
    }

    ones = {
      9 => "nine",
      8 => "eight",
      7 => "seven",
      6 => "six",
      5 => "five",
      4 => "four",
      3 => "three",
      2 => "two",
      1 => "one"
    }

    remainder = digits
    if remainder >= 100
      times_into = digits / 100
      remainder %= 100
      three_digit_str << ones[times_into]
      three_digit_str << "hundred"
    end
    if remainder >= 10
      times_into = remainder / 10
      remainder %= 10
      if times_into == 1
        three_digit_str << teens[10 + remainder]
        remainder = 0
      else
        three_digit_str << tens[times_into * 10]
      end
    end
    if remainder < 10 && remainder > 0
      three_digit_str << ones[remainder]
    end
    three_digit_str.join(" ")

  end

  def in_words
    return "zero" if self == 0

    powers_of_ten = ["", "thousand", "million", "billion", "trillion"]

    numbers_as_string = self.to_s
    number_array = []
    i = numbers_as_string.length
    while i > 0
      if i == 1
        number_array << numbers_as_string[i-1]
        break
      end
      if i == 2
        number_array << numbers_as_string[(i-2)..(i-1)]
        break
      end
      number_array << numbers_as_string[(i-3)..(i-1)]
      i -= 3
    end
    p number_array


    number_in_words = []
    number_array.each_with_index do |element, index|
      next if three_digit_word(element) == ""
      number_in_words << three_digit_word(element) + " " + powers_of_ten[index]
    end

    number_in_words.reverse.join(" ").strip
  end
end

p 10.in_words