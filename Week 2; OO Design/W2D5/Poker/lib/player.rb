require_relative './card'
require_relative './deck'
require_relative './hand'

class Player

  attr_accessor :folded, :called, :hand, :pot
  attr_reader :game

  def initialize(name, pot = 0, game)
    @name, @pot, @game = name, pot, game

    @my_bet = 0
    @folded = false

    nil
  end

  def bet(amt)
    raise "bet has been placed" unless game.current_bet == 0
    raise "not enough funds" if amt > self.pot

    self.pot -= amt
    game.pot += amt
    game.current_bet = amt
    my_bet = amt

    nil
  end

  def raise_bet(amt)
    raise "no bet to raise" if game.current_bet == 0
    raise "not enough funds" if game.current_bet + amt > self.pot

    self.pot -= my_bet - amt
    game.pot -= my_bet - amt
    game.current_bet = amt
    my_bet = amt

    nil
  end

  def call
    raise "not enough funds" if game.current_bet > self.pot

    self.pot -= game.current_bet
    game.pot += game.current_bet
    my_bet = amt

    nil
  end

  def discard(disc_crds)
    disc_crds.each do |d_crd|
      next unless hand.include?(d_crd)
      hand.delete_if{|card| card == d_crd}
      game.deck.return(d_crd)
    end

    self.hand.concat(game.deck.take(5 - hand.length))

    nil
  end

  def parse_cmd
    puts "Current bet: #{game.current_bet}"
    puts "#{name}, do you bet / call / raise / fold?"
    input = gets.chomp.split(" ")
    input.last = Integer(input.last) if input.length == 2

    case input.first
    when "bet"
      bet(input.last)
    when "call"
      call
    when "raise"
      raise_bet(input.last)
    when "fold"
      folded = true
    end

    nil
  end

  def parse_disc
    puts "#{name}, how many cards do you discard?"

    input = Integer(gets.chomp)

    discard(input)
  end
end