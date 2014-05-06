def best_number
  n = 250
  n+= 1 until n % 7 == 0
  n
end


def factors(number)
  number_factors = []

  (1...number).each do |factor|
    number_factors << factor if number % factor == 0
  end

  number_factors
end


def bubble_sort(array)
  i = 0
  until i == array.length - 1
    if array[i] <= array[i + 1]
      i += 1
    else
      array[i], array[i + 1] = array[i + 1], array[i]
      i = 0
    end
  end
  array
end


def substrings(str)
  return_substrings = []

  (0...str.length).each do |index|
    (0...str.length-index).each do |chars|
      return_substrings << str[index..index+chars]
    end
  end

  return_substrings
end


def subwords(str)
  dictionary = File.readlines("./dictionary.txt")
  dictionary.map!(&:chomp)

  str_substrings = substrings(str)

  str_substrings.select {|word| dictionary.include?(word)}
end