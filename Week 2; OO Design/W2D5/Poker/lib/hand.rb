require_relative './deck'
require_relative './card'

class Hand

  VALUES = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  DA_GOOD_HANDZ = [
    :straight_flush,
    :four_kind,
    :full_house,
    :flush,
    :straight,
    :three_kind,
    :two_pair,
    :pair,
    :high
  ]

  attr_reader :cards

  def self.deal_from(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    @cards = cards
  end

  def type
    type = nil
    straight, flush = false, false

    value_count = Hash.new(0)
    suit_count = Hash.new(0)

    cards.each do |card|
      value_count[card.value] += 1
      suit_count[card.suit] += 1
    end

    flush = true if suit_count.length == 1

    numerical_card_values = value_count.keys.map {|x| VALUES[x] }.sort
    straight = numerical_card_values.consecutive?

    case value_count.values.sort
    when [1, 4]
     type =  :four_kind
    when [2, 3]
     type = :full_house
    when [1, 1, 3]
     type =  :three_kind
    when [1, 2, 2]
      type =  :two_pair
    when [1, 1, 1, 2]
      type = :pair
    else
     type = :high
    end

    type = :flush if flush
    type = :straight if straight
    type = :straight_flush if straight && flush

    type
  end

  def beats?(other_hand)
    if DA_GOOD_HANDZ.index(self.type) < DA_GOOD_HANDZ.index(other_hand.type)
      return true
    elsif DA_GOOD_HANDZ.index(self.type) == DA_GOOD_HANDZ.index(other_hand.type)

      value_count = Hash.new(0)
      o_value_count = Hash.new(0)
      cards.each{|card| value_count[card.value] += 1 }
      other_hand.cards.each{|card| o_value_count[card.value] += 1 }

      key_arr = value_count.keys
      val_arr = value_count.values

      max_val = val_arr.max
      max_val_idx = val_arr.index(max_val)
      max_key = key_arr[max_val_idx]

      o_key_arr = o_value_count.keys
      o_val_arr = o_value_count.values

      o_max_val = o_val_arr.max
      o_max_val_idx = o_val_arr.index(o_max_val)
      o_max_key = o_key_arr[o_max_val_idx]

      return true if VALUES[max_key] > VALUES[o_max_key]
      return nil if VALUES[max_key] == VALUES[o_max_key]
      return false if VALUES[max_key] < VALUES[o_max_key]

    else
      false
    end
  end

  def show
    cards.each {|card| print card.to_s }
  end
end

class Array

  def consecutive?
    start = self[0]+1
    consecutive = true

    self.sort.each_index do |index|
      next if index == length - 1
      consecutive = false unless start == self[index+1]
      start += 1
    end
    consecutive
  end

end