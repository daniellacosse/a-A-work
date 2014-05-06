#!/usr/bin/env ruby

require "colorize"
require_relative "lib"

class Checkers
  attr_accessor :game_board, :current_player
  attr_reader :players

  def initialize
    @game_board = Board.setup
    @players = [Human.new(:red, game_board), Human.new(:black, game_board)]
    @current_player = players.first
  end

  def self.begin
    Checkers.new.play
  end

  def play
    puts "\n\n"
    puts "Premium Checkers Deluxe.".colorize(:color => :black).bold
    puts "When appropriate, use fr and fl to move forward and right\nor forward and left."
    puts "While kinged, you may also use br and bl to move backwards."
    until won?
      game_board.render
      begin
        current_player.handle_turn
      rescue MoveError
        puts "Not a valid move. Try again.".colorize(:color => :light_white, :background => :light_red)
        retry
      rescue ArgumentError
        puts "I'm afraid I don't understand. Please try again.".colorize(:color => :light_white, :background => :light_red)
        retry
      end
      @current_player = next_player
    end

    puts "#{winning_player.color} wins. Thank you for playing."
  end

  def next_player
    current_player == players.last ? players.first : players.last
  end

  def won?
    pieces = game_board.grid.flatten.compact
    if pieces.all? { |pc| pc.color == :red }
      @winning_player = :red
      return true
    elsif pieces.all?{ |pc| pc.color == :black }
      @winning_player = :black
      return true
    end

    false
  end
end

if __FILE__ == $PROGRAM_NAME
  Checkers.begin
end