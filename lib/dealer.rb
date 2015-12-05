require_relative 'player'

class Dealer < Player
  attr_reader :bets
  attr_accessor :hand
  def initialize
    super("dealer", 0)

    @bets = {}
  end

  def place_bet(dealer, amt)
    raise "Dealer doesn't bet"
  end

  def display_hand
    hand.cards[1]
  end

  def play_hand(deck)
    until hand.busted? || hand.points >= 17
      hand.hit(deck)
      sleep(1)
      puts "Henry - #{hand}"
    end

  end

  def take_bet(player, amt)
    @bets[player] = amt
  end

  def pay_bets
    @bets.each do |player, amt|
      player.pay_winnings(2*amt) if player.hand.beats?(self.hand)
    end
  end
end
