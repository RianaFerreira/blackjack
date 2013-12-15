require 'spec_helper'

describe Card do
  let(:card) {Card.new(suit: 'hearts', rank: '10')}
  subject {card}

  its(:rank) { should == '10' }
  its(:suit) { should == 'hearts'}

end
