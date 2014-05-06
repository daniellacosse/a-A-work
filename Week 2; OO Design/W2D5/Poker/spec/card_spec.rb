require 'rspec'
require 'card'

describe Card do

  subject(:card) { Card.new(:clubs, :deuce) }

  describe "#initialize" do

    it "make a card" do
      expect(Card.new(:clubs, :deuce).class).to eq(Card)
    end

    it "raises an error if suit/value non-existant" do
      expect{Card.new(:clubs, :douche)}.to raise_error(RuntimeError)
    end

  end

  describe "#==" do

    it "correctly equates two cards" do
      expect(card == Card.new(:clubs, :deuce)).to be_true
    end

    it "correctly disequates two cards" do
     expect(card == Card.new(:clubs, :three)).to be_false
    end

  end

  describe "#to_s" do

    it "correctly convert card to string" do
      expect(card.to_s).to eq("2♣")
    end

  end

end