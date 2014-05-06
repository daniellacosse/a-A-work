require 'rspec'
require 'card'
require 'deck'


describe Deck do
  describe "::all_cards" do
    subject(:all_cards) {Deck.all_cards}
    its(:count) { should == 52 }
  end

  describe "#intialize" do
    it "defaults to 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end

    it "can take a custom set of cards" do
      deck = Deck.new([card1 = double("card"), card2 = double("card2")])
      expect(deck.count).to eq(2)
    end
  end

  let(:cards) do
      cards = [
        Card.new(:spades, :king),
        Card.new(:spades, :queen),
        Card.new(:spades, :jack)
      ]
  end

  let(:deck) do
    Deck.new(cards.dup)
  end

  it "does not expose its own cards" do
    expect(deck).not_to respond_to(:cards)
  end

  describe "#take" do

    it "should take cards from top of deck" do
      expect(deck.take(1)).to eq(cards[0..0])
      expect(deck.take(2)).to eq(cards[1..2])
    end

    it "should remove cards from deck" do
      deck.take(2)
      expect(deck.count).to eq(1)
    end

    it "doesn't allow you to take more cards than are in deck" do
      expect do
        deck.take(4)
      end.to raise_error("not enough cards")
    end

  end

  describe "#return" do
    let(:more_cards) do
       [ Card.new(:hearts, :four),
         Card.new(:hearts, :five),
         Card.new(:hearts, :six) ]
     end

     it "returns cards to the deck" do
       deck.return(more_cards)
       expect(deck.count).to eq(6)
     end

     it "adds new cards to the bottom of the deck" do
       deck.return(more_cards)
       deck.take(3)

       expect(deck.take(1)).to eq(more_cards[0..0])
       expect(deck.take(1)).to eq(more_cards[1..1])
       expect(deck.take(1)).to eq(more_cards[2..2])
     end
  end
end