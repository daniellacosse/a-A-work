class Code

  attr_accessor :seq



  def self.parse(str)
    sequence = str.split("")
    self.new(sequence)
  end

  def initialize(seq = )
    @seq = seq
  end

end

class Game
  attr_accessor :guessing_player, :wordpick_player

  def self.human_guesses
    self.new(Human.new, Computer.new(false))
  end

  def self.computer_guesses
    self.new(Computer.new, Human.new(false))
  end

  def initialize(guessing, wordpick)

    @guessing_player = guessing
    @wordpick_player = wordpick
  end

  def play
    puts "Game is running"
    puts "Board is #{@game_board.seq.to_s}"

  end

  def user_move
    user_move = gets.chomp
    Code.parse(user_move)
  end

end

if __FILE__ == $PROGRAM_NAME
  hangman = Game.new
  hangman.play
end

class Player
  attr_accessor :is_guessing, :guesses, :answer, :game

  def initialize(guessing = true)
    @is_guessing = guessing
    self.additional_setup
  end

  def answer
  end

end

class Human < Player
  def additional_setup
  end
end

class Computer < Player
  def additional_setup
    @words = File.readlines("dictionary.txt")
    @answer = @words.sample
  end

end













