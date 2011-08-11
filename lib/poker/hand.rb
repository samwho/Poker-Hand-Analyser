class Hand
  include Enumerable

  # Creates a new hand. The argument passed must either be a valid hand string
  # or an array of Card objects.
  #
  # Valid hand strings look like this:
  #
  #   "2H 3D 4C 8H"
  #
  # Internally they get split on space and then are used to make Card objects.
  def initialize hand
    if hand.is_a? String
      @hand = create_hand hand
    else
      @hand = hand
    end

    @analysis = analyse @hand
  end

  def hand_array
    @hand
  end

  def rank
    #TODO Write this.
  end

  # Adds a new Card to this hand. The card passed in must either be a Card
  # object or something that can be passed to the Card constructor.
  def add card
    if card.is_a? Card
      @hand.push card
    else
      @hand.push Card.new(card)
    end

    @analysis = analyse @hand
  end

  # Returns an array of the pairs in this hand. If there are no pairs, an
  # empty array is returned.
  def pairs
    @analysis[:pairs]
  end

  # Returns an array of the trips in this hand. If there are no trips, an
  # empty array is returned.
  def trips
    @analysis[:trips]
  end

  # Returns an array of the quads in this hand. If there are no quads, an
  # empty array is returned.
  def quads
    @analysis[:quads]
  end

  # Returns an array of the straights in this hand. If there are no straights,
  # an empty array is returned.
  #
  # If the hand contains pairs and the card that is paired is used in the
  # straight, only one of the available straights is returned. This means
  # that this method will not reliably find straight flushes, please use
  # the straight_flushes method for that.
  #
  # If there is a straight with more than 5 cards in it, only the highest
  # five cards are returned.
  def straights
    @analysis[:straights]
  end

  # Returns an array of the flushes in this hand. If there are no flushes, an
  # empty array is returned.
  #
  # If there are more than 5 cards in a flush, only the highest five cards are
  # returned.
  def flushes
    @analysis[:flushes]
  end

  # Returns an array of the straight flushes in this hand. If there are no straight
  # flushes, an empty array is returned.
  #
  # If there are more than 5 cards in a straight flush, only the highest five cards
  # are returned.
  def straight_flushes
    @analysis[:straight_flushes]
  end

  # This method just passes the call through to the hand array so that
  # you can access Hand objects like arrays.
  def [](index, length = nil)
    if length.nil?
      @hand[index]
    else
      @hand[index, length]
    end
  end

  # Passes the inspect call on to the @hand array.
  def inspect
    @hand.inspect
  end

  # Passes the to_s call on to the @hand array.
  def to_s
    @hand.to_s
  end

  # Passes the each call to the @hand block.
  def each &block
    @hand.each block
  end

  def eql? other
    @hand == other.hand_array
  end

  def to_a
    @hand.map { |card| card.to_s }
  end

  private

  # Convenience method for analysing hands.
  def analyse hand
    HandAnalyser.analyse hand
  end

  # Convenience method for creating hands.
  def create_hand string
    string.split(/\s+/).inject([]) do |memo, card_str|
      memo.push Card.new(card_str)
    end
  end

end
