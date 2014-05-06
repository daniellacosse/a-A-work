#!/usr/bin/env ruby

# require 'debugger'
MASTERMIND_COLORS = { "Y" => :yellow,
                      "R" => :red,
                      "G" => :green,
                      "B" => :blue,
                      "O" => :orange,
                      "P" => :purple }

class Code
  attr_accessor :seq

  def self.random
    Array.new(4) {|el| MASTERMIND_COLORS.values.sample }
  end

  def self.parse(str)
    sequence = str.split("").map{ |item| MASTERMIND_COLORS[item] }
    self.new(sequence)
  end

  def initialize(seq = self.class.random)
    @seq = seq
  end

  def ==(code)
    return true if self.seq == code.seq

    false
  end

  def get_matches(code)
    # debugger

    exact_matches = 0
    near_matches = 0
    user_guess = self.seq.dup
    answers = code.seq.dup
    leftover_indicies = []

    user_guess.each_index do |color|
      if user_guess[color] == answers[color]
        exact_matches += 1
      else
        leftover_indicies << color
      end
    end

    user_guess_leftovers = user_guess.values_at(*leftover_indicies)
    answer_leftovers = answers.values_at(*leftover_indicies)

    answer_leftovers.each_index do |color|
       if answer_leftovers.include?(user_guess_leftovers[color])
         near_matches += 1
         first_index_of_color = answer_leftovers.index(user_guess_leftovers[color])
         answer_leftovers[first_index_of_color] = nil
       end
    end

    [exact_matches, near_matches]
  end
end


class Game
  def initialize(game = Code.new)
    @game_board = game
  end

  def play
    puts "Game is running"
    puts "Board is #{@game_board.seq.to_s}"

    10.times do |turns|
      puts "You have #{10-turns} turns left."
      user_guess = user_move
      if user_guess == @game_board
        puts "You Win"
        break
      else
        exact_and_near_matches = user_guess.get_matches(@game_board)
        puts "Exact Matches: #{exact_and_near_matches.first}"
        puts "Near Matches: #{exact_and_near_matches.last}"
      end
    end

    puts "Board was #{@game_board.seq.to_s}, Game Over"
  end

  private
  def user_move
    user_move = gets.chomp
    Code.parse(user_move)
  end
end

if __FILE__ == $PROGRAM_NAME
  mastermind = Game.new
  mastermind.play
end