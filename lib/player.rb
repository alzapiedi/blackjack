class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def return_cards(deck)
    @hand.return_cards(deck)
    @hand = nil
  end

  def get_action
    action = nil
    until action == "hit" || action == "stay"
      print "#{name}, hit or stay: "
      action = gets.chomp
    end
    action
  end

  def get_bet
    print "#{name}, enter your bet: "
    gets.chomp.to_i
  end

  def place_bet(dealer, bet_amt)
    raise "player can't cover bet" if bet_amt > @bankroll
    @bankroll -= bet_amt
    dealer.take_bet(self, bet_amt)
    end
end
