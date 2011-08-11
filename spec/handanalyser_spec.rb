require_relative 'spec_helper'

describe HandAnalyser do
  it 'should recognise pairs' do
    hand     = Hand.new "2D 2H 5H 4H 7H"
    compare  = %([["2D", "2H"]])
    compare.should == hand.pairs.inspect
  end

  it 'should recognise two pairs' do
    hand     = Hand.new "2D 2H 5D 5H 7H"
    compare  = %([["2D", "2H"], ["5D", "5H"]])
    compare.should == hand.pairs.inspect
  end

  it 'should recognise trips' do
    hand     = Hand.new "2C 2D 2H 5D 7H"
    compare  = %([["2C", "2D", "2H"]])
    compare.should == hand.trips.inspect
  end

  it 'should recognise quads' do
    hand     = Hand.new "2C 2D 2H 2S 7H"
    compare  = %([["2C", "2D", "2H", "2S"]])
    compare.should == hand.quads.inspect
  end

  it 'should recognise flushes' do
    hand     = Hand.new "2H 4H 7H 10H JH"
    compare  = %([["2H", "4H", "7H", "10H", "JH"]])
    compare.should == hand.flushes.inspect
  end

  it 'should recognise straights' do
    hand     = Hand.new "2H 3H 4H 5C 6H 7D"
    compare  = %([["3H", "4H", "5C", "6H", "7D"]])
    compare.should == hand.straights.inspect
  end

  it 'should recognise the highest straight' do
    hand     = Hand.new "2H 3H 4H 5C 6H 7D 8H"
    compare  = %([["4H", "5C", "6H", "7D", "8H"]])
    compare.should == hand.straights.inspect
  end

  it 'should recognise straights with pairs in them' do
    hand     = Hand.new "2H 4H 4D 5C 6H 7D 8H"
    compare  = %([["4D", "5C", "6H", "7D", "8H"]])
    compare.should == hand.straights.inspect
  end

  it 'should recognise straight flushes' do
    hand     = Hand.new "2H 3H 4H 5H 6H"
    compare  = %([["2H", "3H", "4H", "5H", "6H"]])
    compare.should == hand.straight_flushes.inspect
  end

  it 'should recognise the highest straight flush' do
    hand     = Hand.new "2H 3H 4H 5H 6H 7H 8H"
    compare  = %([["4H", "5H", "6H", "7H", "8H"]])
    compare.should == hand.straight_flushes.inspect
  end
end
