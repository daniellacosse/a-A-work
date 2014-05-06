require 'rspec'
require 'card'
require 'deck'
require 'hand'
require 'player'

describe Player do
  describe "#initialize" do
    it "initializes" do
      name = "Wimbleton"
      pot = 5000
      game = double("game")

      player = Player.new(name, pot, game)

      expect(player.name).to eq("Wimbleton")
      expect(player.pot).to eq(5000)
      expect(player.my_bet).to eq(0)
      expect(player.folded).to be_false
    end
  end

  describe "#bet" do
    it "places a bet" do
      game = double("game")
      player = Player.new("Mark", 50, game)

      game.expect_to_recieve(:pot).with()

    end

end