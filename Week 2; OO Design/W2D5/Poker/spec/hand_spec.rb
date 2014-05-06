require 'rspec'
require 'card'
require 'deck'
require 'hand'

describe Hand do
  describe "::deal_from" do
    it "deals a hand of five cards" do
      deck_cards = [
              card1 = double("card1"),
              card2 = double("card1"),
              card3 = double("card1"),
              card4 = double("card1"),
              card5 = double("card1"),
            ]

      deck = double("deck")
      deck.should_receive(:take).with(5).and_return(deck_cards)

      hand = Hand.deal_from(deck)

      hand.cards.should =~ deck_cards
    end
  end

  describe "#initialize" do
    it "can take a rigged hand" do
      rigged_hand = [
              card1 = double("card1"),
              card2 = double("card1"),
              card3 = double("card1"),
              card4 = double("card1"),
              card5 = double("card1"),
            ]

      hand = Hand.new(rigged_hand)
      hand.cards.should =~ rigged_hand
    end
  end


  describe "#type" do
    let(:ace_hearts)   { Card.new(:hearts, :ace) }
    let(:ace_spades)   { Card.new(:spades, :ace) }
    let(:ace_diamonds) { Card.new(:diamonds, :ace) }
    let(:ace_clubs)    { Card.new(:clubs, :ace) }
    let(:king_hearts)  { Card.new(:hearts, :king) }
    let(:queen_hearts) { Card.new(:hearts, :queen) }
    let(:jack_hearts)  { Card.new(:hearts, :jack) }
    let(:ten_hearts)   { Card.new(:hearts, :ten) }
    let(:nine_hearts)   { Card.new(:hearts, :nine) }
    let(:ten_diamonds)  { Card.new(:diamonds, :ten) }
    let(:nine_diamonds) { Card.new(:diamonds, :nine) }
    let(:three_clubs)   { Card.new(:clubs, :three) }
    let(:king_diamonds) { Card.new(:diamonds, :king) }
    let(:queen_diamonds){ Card.new(:diamonds, :queen) }
    let(:jack_diamonds) { Card.new(:diamonds, :jack) }

    it "identifies straight_flush" do
      hand = Hand.new([ace_hearts, king_hearts, queen_hearts, jack_hearts, ten_hearts])
      expect(hand.type).to eq(:straight_flush)
    end

    it "identifies four_kind" do
      hand = Hand.new([ace_hearts, ace_spades, ace_clubs, ace_diamonds, ten_hearts])
      expect(hand.type).to eq(:four_kind)
    end

    it "identifies full_house" do
      hand = Hand.new([ace_hearts, ace_spades, ace_clubs, ten_diamonds, ten_hearts])
      expect(hand.type).to eq(:full_house)
    end

    it "identifies flush" do
      hand = Hand.new([ace_hearts, king_hearts, queen_hearts, jack_hearts, nine_hearts])
      expect(hand.type).to eq(:flush)
    end

    it "identifies straight" do
      hand = Hand.new([ace_spades, king_hearts, queen_hearts, jack_hearts, ten_hearts])
      expect(hand.type).to eq(:straight)
    end

    it "identifies three_kind" do
      hand = Hand.new([ace_hearts, ace_spades, ace_clubs, nine_diamonds, ten_hearts])
      expect(hand.type).to eq(:three_kind)
    end

    it "identifies two_pair" do
      hand = Hand.new([ace_hearts, ace_spades, ten_diamonds, nine_diamonds, ten_hearts])
      expect(hand.type).to eq(:two_pair)
    end

    it "identifies one_pair" do
      hand = Hand.new([ace_hearts, ace_spades, jack_hearts, nine_diamonds, ten_hearts])
      expect(hand.type).to eq(:pair)
    end

    it "identifies high_card" do
      hand = Hand.new([ace_hearts, three_clubs, jack_hearts, nine_diamonds, ten_hearts])
      expect(hand.type).to eq(:high)
    end

  end

  describe "#beats?" do
    let(:ace_hearts)   { Card.new(:hearts, :ace) }
    let(:ace_spades)   { Card.new(:spades, :ace) }
    let(:ace_diamonds) { Card.new(:diamonds, :ace) }
    let(:ace_clubs)    { Card.new(:clubs, :ace) }
    let(:king_hearts)  { Card.new(:hearts, :king) }
    let(:queen_hearts) { Card.new(:hearts, :queen) }
    let(:jack_hearts)  { Card.new(:hearts, :jack) }
    let(:ten_hearts)   { Card.new(:hearts, :ten) }
    let(:nine_hearts)   { Card.new(:hearts, :nine) }
    let(:ten_diamonds)  { Card.new(:diamonds, :ten) }
    let(:nine_diamonds) { Card.new(:diamonds, :nine) }
    let(:three_clubs)   { Card.new(:clubs, :three) }
    let(:king_diamonds) { Card.new(:diamonds, :king) }
    let(:queen_diamonds){ Card.new(:diamonds, :queen) }
    let(:jack_diamonds) { Card.new(:diamonds, :jack) }



    it "compares two different hand_types and chooses right winner" do
      hand1 = Hand.new([ace_hearts, three_clubs, jack_hearts, nine_diamonds, ten_hearts])
      hand2 = Hand.new([ace_hearts, ace_spades, ace_clubs, nine_diamonds, ten_hearts])
      expect(hand1.beats?(hand2)).not_to be_true
    end

    it "compares same hand_types and chooses winner or tie" do
      hand1 = Hand.new([ace_hearts, king_hearts, queen_hearts, jack_hearts, ten_hearts])
      hand2 = Hand.new([king_diamonds, queen_diamonds, jack_diamonds, ten_diamonds, nine_diamonds])
      expect(hand1.beats?(hand2)).to be_true
    end
  end

end
