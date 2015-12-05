require_relative 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    deck = []
      Card.suits.each do |suit|
        Card.values.each do |value|
          deck << Card.new(suit, value)
        end
      end
    deck
  end

  def removes
    @cards.pop
  end

  def shuffle
    @cards.shuffle!
  end
  
  def initialize(deck = Deck.all_cards)
    @cards = deck
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise "not enough cards" if n > @cards.count
    result = []
    n.times { result << @cards.shift}
    result
  end

  # Returns an array of cards to the bottom of the deck.
  def return(return_cards)
    return_cards.each { |card| @cards << card }
  end
end
