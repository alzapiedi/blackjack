class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck)
    Hand.new(deck.take(2))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end

  def points
    points = 0
    aces = 0
    @cards.each do |card|
      if card.value == :ace
        points += 11
        aces += 1
      else
        points += card.blackjack_value
      end
    end
      aces.times { points -= 10 if points > 21 }
      points
  end

  def busted?
    points > 21
  end

  def hit(deck)
    raise "already busted" if busted?
      new_card = deck.take(1)
      @cards += new_card

  end

  def beats?(other_hand)
    case points <=> other_hand.points
    when -1
      other_hand.busted? && !busted?
    when 0
      false
    when 1
      !busted?
    end
  end

  def return_cards(deck)
    deck.return(@cards)
    @cards = []
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end
end
