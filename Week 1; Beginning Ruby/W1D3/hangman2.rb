require 'debugger'

class Hangman
  # @guesses, @guessing_player, @checking_player

  def self.human_guesses
    self.new(Human.new, Computer.new)
  end

  def self.computer_guesses
    self.new(Computer.new, Human.new)
  end

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
  end

  def play
    picked_word = @checking_player.picks_word
    @guesses = Array.new(picked_word)

    while @guesses.include?(nil)
      puts "Secret word: #{convert_guesses_to_str(@guesses)}"

      letter = @guessing_player.guess_letter(@guesses)

      @guesses = @checking_player.check_word(letter, @guesses)
    end

    puts "Secret word: #{convert_guesses_to_str(@guesses)}"
    puts "#{@guessing_player.name} guessed it!"
  end

  private
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
end

$INCORRECT_GUESSES = []

class Player
  attr_reader :name

  def initialize(name = "player")
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @name = name
    @alphabet = ('a'..'z').to_a
  end
end

class Human < Player
  def picks_word
    puts "How long is your word?"
    Integer(gets.chomp)
  end

  def check_word(char, guesses)
    puts "Picked #{char}. Where is this letter in your word (if at all)?"
    puts "(If this letter isn't in your word, press RETURN)"
    correct_indicies = gets.chomp.split(", ")

    if !(correct_indicies.empty?)
      correct_indicies.each { |i| guesses[i.to_i] = char }
    else
      $INCORRECT_GUESSES << char
      p $INCORRECT_GUESSES
    end

    guesses
  end

  def guess_letter(guesses)
    puts "Guess a letter:"
    gets.chomp
  end
end

class Computer < Player
  # unique instance var: @word_to_guess
  def picks_word
    @word_to_guess = @dictionary.sample.chomp.split("")

    @word_to_guess.length
  end

  def check_word(char, guesses)
    @word_to_guess.each_index do |idx|
      guesses[idx] = char if @word_to_guess[idx] == char
    end

    guesses
  end

  def guess_letter(guesses)
    dictionary_filter(guesses)
    get_most_likely_character(guesses)
  end

  private
  def dictionary_filter(guesses)
    #debugger
    @dictionary.select! { |word| word.length == guesses.length}

    $INCORRECT_GUESSES.each do |char|
      @dictionary.select! { |word| !(word.include?(char)) }
    end

    @dictionary.select! do |word|
      word_chars = word.split("")
      boolean_array = []

      word_chars.each_index do |idx|
        next if guesses[idx].nil?
        boolean_array << (guesses[idx] == word_chars[idx])
      end

      boolean_array.all?
    end

    nil
  end

  def get_most_likely_character(guesses)
    all_characters = @dictionary.join("").split("")

    character_count = Hash.new(0)

    all_characters.each do |char|
      character_count[char] += 1
    end

    guesses.each {|letter| character_count[letter] = 0 unless letter.nil? }
    p character_count

    character_count.sort_by { |a, b| b }.last[0]
  end
end

# filter function >
# filter dictionary by length            (mutate @dictionary)
# by incorrectly guessed letters (if there are past guessed letters) [X]
# filter by correctly guessed letter position   (if Hangman.guesses any not nils) [x]

# function >
# join @dictionary and then split("")
# count up all the letters w/ hash (local to method) & pull out max



if __FILE__ == $PROGRAM_NAME
  hangman_human_guesses = Hangman.computer_guesses
  hangman_human_guesses.play
end