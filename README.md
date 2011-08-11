This is a poker hand analysis library. It's still very much a work in
progress so bear with me and report any bugs if you find them :)

# Usage

``` ruby
    hand = Hand.new "2C 2H 10D 10S AS"
    hand.pairs   #=> [["2C", "2H], ["10D", "10S"]]
    hand.flushes #=> []
    hand.trips   #=> []
```

While you construct a hand with a string, the arrays returned from methods
like .trips and .pairs are arrays of Card objects.

# TODO

- Flesh out this README
- Give hands ranks so that they can be compared to other hands and a
  "winner" determined.
- Write more specs.
