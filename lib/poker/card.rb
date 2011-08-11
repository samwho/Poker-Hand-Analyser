require_relative 'numbersandsuits'

class Card
  include Comparable
  extend NumbersAndSuits
  attr_reader :number, :suit, :number_index


  # You can initialise this class by either passing a number and a suit or
  # a string that contains both in a specific format.
  #
  # The arguments must be strings, if they are not they will be converted.
  #
  # Examples:
  #
  #   Card.new '2', 'H'
  #   #=> "2H"
  #
  #   Card.new '4C'
  #   #=> "4C"
  #
  #   Card.new 5, 'D'
  #   #=> "5D"
  def initialize number, suit = nil
    if suit.nil?
      split = number.to_s.split(//)
      @suit, @number = split.pop, split.join
    else
      @suit, @number = suit.to_s, number.to_s
    end

    @number_index = self.class.numbers.index(@number)
  end

  # This only compares the card's number values. As a result, the following
  # is true:
  #
  #   Card.new('2', 'S') == Card.new('2', 'D')
  #
  # Be careful :)
  #
  # If you want to check for exact card equality, use .eql?
  def <=> other
    numbers = self.class.numbers
    if numbers.index(self.number) > numbers.index(other.number)
      1
    elsif numbers.index(self.number) < numbers.index(other.number)
      -1
    else
      0
    end
  end

  # Tests a card for exact equality: suit _and_ number.
  def eql? other
    other.number == self.number and other.suit == self.suit
  end

  def to_s
    @number + @suit
  end

  def inspect
    '"' + to_s + '"'
  end
end
