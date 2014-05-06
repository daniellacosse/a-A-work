# shuffle deck
# players each get dealt hand:
# => turn round 1: for each player, parse either bet / call / raise / fold
# => turn round 2: for each player, parse discard [0..3] && deal new cards
# => turn rounds until reveal: for each player, parse bet / call / raise / fold
# => => reveal when n-1 players call or fold
# compare each remaining (called) hand to each other hand
# => greatest hand wins
# => add pot to winning player
# start from beginning

class Poker

  attr_accessor :deck, :current_bet, :pot
  attr_reader :players

  def Poker.play
    Game.new([Player.new("player1", ), Player.new()]).play_poker
  end

  def initialize(players)
    @players = players
    @deck = Deck.all_cards
    @current_bet, @pot = 0, 0
  end

  def play
    puts "Poker.\n"
    loop do # until all other players are broke
      reset_game
      players.each {|plyr| player.parse_disc}
      until show_hands?
        players.each {|plyr| plyer.parse_cmd}
      end
      reveal_hands
      pay_winnings
    end
  end

  def reset_game
    deck.shuffle!
    players.each do |player|
      deck.return(player.hand.cards)
      player.hand = Hand.deal_from(deck)
      player.bet, player.folded, player.called = 0, false, false
      player.parse_cmd
    end
  end

  def show_hands?
    players.one? {|player| !player.called || !player.folded}
  end

  def reveal_hands
    players.each {|player| player.hand.show }
  end

  def pay_winnings
    eligible_players = players.select {|player| player.called } + players.select {|player| !player.called && !player.folded}
    winning_player = eligible_players[0]
    eligible_players.each do |elg_ply|
        winning_player = elg_ply if elg_ply.beats?(winning_player)
    end

    winning_player.pot += self.pot
    self.pot = 0

    nil
  end
end