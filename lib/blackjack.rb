require_relative 'hand'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'card'

class Blackjack

  def initialize(players, dealer, deck)
    @players = players
    @dealer = dealer
    @deck = deck
  end

  def deal_hand
    @deck.shuffle
    @players.each { |player| player.place_bet(@dealer, player.get_bet )}
    @players.each { |player| player.hand = Hand.deal_from(@deck) }
    @dealer.hand = Hand.deal_from(@deck)
    @dealer.hand.cards[0].up = false
  end

  def play_turn(player)
    action  = nil
    until player.hand.busted? || action == "stay"
      action = player.get_action
      if action == "hit"
        player.hand.hit(@deck)
      end
      puts "#{player.name}  -  #{player.hand}"
    end
    puts "BUSTED!" if player.hand.busted?
  end

  def play_hand
    @players.each { |player| play_turn(player) }
    puts @dealer.hand
    @dealer.play_hand(@deck)
    @dealer.pay_bets
  end


end


if __FILE__ == $PROGRAM_NAME
  nick = Player.new("Nick", 1000)
  krawldad = Player.new("Krawldad", 1000)
  georgus = Player.new("Georgus", 1000)
  mogul = Player.new("Mogul", 100000)
  henry = Dealer.new
  shoe = Deck.new

  players = [nick, krawldad, georgus, mogul]
  game = Blackjack.new(players, henry, shoe)

  game.deal_hand
  puts "Henry - #{henry.display_hand}"
  players.each { |player| puts "#{player.name}  -  #{player.hand}" }
  game.play_hand

  players.each { |player| puts player.bankroll}

end
