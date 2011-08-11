require_relative 'numbersandsuits'
require_relative 'card'

class Deck
  extend NumbersAndSuits

  def initialize
    @deck = self.class.numbers.inject([]) do |deck, number|
      self.class.suits.each { |suit| deck.push Card.new(number, suit) }
      deck
    end.shuffle
  end

  def cards_left
    @deck.count
  end

  def cards_left?
    @deck.count != 0
  end

  def empty?
    not cards_left?
  end

  def draw cards = 1
    cards = cards_left if cards > cards_left
    @deck.pop cards
  end
end
