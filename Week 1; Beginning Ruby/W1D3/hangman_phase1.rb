# load file
# pick random word
# create array of nils of word.length
# until array of nils.join("") == word
# gets.chomp guess
# if guess is in word, replace array of nils with character at appropriate indicies
# print array of nils.join with nils replaced by underscores
#require 'debugger'
def convert_guesses_to_str(arr)
  str = ""
  arr.each do |char|
    if char.nil?
      str << "_"
    else
      str << char
    end
  end
  str
end

words = File.readlines("dictionary.txt")
word_to_guess = words.sample.chomp.split("")

guesses = Array.new(word_to_guess.length)

puts word_to_guess.join("")
until guesses.join("") == word_to_guess.join("")


  puts "Secret word: #{convert_guesses_to_str(guesses)}"
  character_guess = gets.chomp
  word_to_guess.each_index do |idx|
    guesses[idx] = character_guess if word_to_guess[idx] == character_guess
  end
  #debugger
end

puts "Secret word: #{convert_guesses_to_str(guesses)}"
puts "You guessed it!"
