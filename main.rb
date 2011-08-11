require_relative 'lib/poker'

deck = Deck.new

# puts HandAnalyser.analyse [(Card.new('2', 'H')),
#                            (Card.new('3', 'H')),
#                            (Card.new('4', 'H')),
#                            (Card.new('5', 'H')),
#                            (Card.new('6', 'H')),
#                            (Card.new('10', 'C')),
#                            (Card.new('A', 'S'))]

puts HandAnalyser.analyse deck.draw(7)
