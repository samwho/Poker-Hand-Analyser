require_relative 'numbersandsuits'

# The HandAnalyser is a static class that will take an array of Card objects
# and extract the ranked hands from them.
#
# Usage:
#
#   hand     = [Card.new("2C"), Card.new("2H")] # Array of Cards
#   analysis = HandAnalyser.analyse hand
#
#   puts analysis.inspect
#
#   # I've shortened the cards to just strings for ease of reading
#   # so note that these are arrays of Card objects.
#   #
#   # {
#   #   :hand             => [["2C", "2H"]]
#   #   :pairs            => [["2C", "2H"]]
#   #   :trips            => []
#   #   :quads            => []
#   #   :flushes          => []
#   #   :straights        => []
#   #   :straight_flushes => []
#   # }
#
# Normally you would not do this manually. See the Hand class for
# more details.
class HandAnalyser
  extend NumbersAndSuits

  # This method takes an array of cards and returns a hash of the ranking
  # hands that the array can make.
  def self.analyse hand
    # Working with a sorted hand is easier.
    #
    # Sorting a hand is a bit of a bitch. To make sure they always stay
    # in the same order, if the numbers are the same I sort them alphabetically
    # by suit.
    hand.sort! do |prev, cur|
      spaceship = prev <=> cur
      if spaceship == 0
        prev.suit <=> cur.suit
      else
        spaceship
      end
    end

    {
      :hand             => hand,
      :pairs            => get_matches(hand, 2),
      :trips            => get_matches(hand, 3),
      :quads            => get_matches(hand, 4),
      :flushes          => get_flushes(hand),
      :straights        => get_straights(hand),
      :straight_flushes => get_straight_flushes(hand)
    }
  end

  # Gets cards that match. E.g., if you supple a count of 3, this
  # function will match all sets of trips.
  def self.get_matches hand, count = 2
    numbers.inject([]) do |pairs, number|
      remaining = hand.reject { |card| not card.number == number }
      pairs.push remaining if remaining.count == count
      pairs
    end
  end

  # Gets all of the flushes (only going to be a max of 1 in a standard
  # game of poker) that the hand has. A flush is 5 cards of the same suit.
  def self.get_flushes hand
    suits.inject([]) do |flushes, suit|
      remaining = hand.reject { |card| card.suit != suit }
      flushes.push remaining.pop(5) if remaining.count >= 5
      flushes
    end
  end

  # This method relies on the hand being sorted when it goes in.
  def self.get_straight_flushes hand
    suits.inject([]) do |straight_flushes, suit|
      remaining = hand.reject { |card| card.suit != suit }
      straights = get_straights remaining
      straight_flushes += straights unless straights.empty?
      straight_flushes
    end
  end

  # This method relies on the hand being sorted when it goes in.
  #
  # Please note that this method may not find straight flushes.
  # Use the get_straight_flushes method for that.
  def self.get_straights orig_hand
    straights   = []
    hand        = orig_hand.clone.uniq { |card| card.number }

    if hand.length >= 5
      # We want to trap all possible straights this hand could give, to do
      # this what I'm doing is assuming the hand is sorted, and then scanning
      # in groups of 5, moving the search forward 1 each time. Example:
      #
      #   hand = ["1H", "4C", "5C", "6C", "10D", "JD", "QD"]
      #
      #   # The first iteration would scan the first five:
      #
      #   ["1H", "4C", "5C", "6C", "10D"]
      #
      #   # The next scan would scan the next five:
      #
      #   ["4C", "5C", "6C", "10D", "JD"]
      #
      #   # And the last scan in this hand would scan the last five:
      #
      #   ["5C", "6C", "10D", "JD", "QD"]
      (0..hand.length - 5).each do |index|
        prev = hand[index]
        rest = hand[(index + 1)..(hand.length - 1)]
        straight = [prev]

        straight += rest.take_while do |card|
          compare = prev
          prev = card
          compare.number_index + 1 == card.number_index
        end

        straights.push straight if straight.length >= 5
      end
    else
      # Hand length not large enough to contain a straight. Return an empty
      # array.
      []
    end

    # We only want the highest 5 cards of the straight and we only want
    # straights of 5 cards or more.
    straights = straights.map    { |straight| straight.pop 5 }
    straights.uniq
  end
end
