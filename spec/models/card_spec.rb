# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  suit       :string(255)
#  rank       :string(255)
#  card_value :integer
#  deck_id    :integer
#

require 'spec_helper'

describe Card do
  let(:card) { Card.new(suit: 'hearts', rank: '10') }
  subject { card }

  its(:rank) { should == '10' }
  its(:suit) { should == 'hearts' }

end
