# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Deck do
  # test the associations
  it {should have_many :cards}

  it 'should respond_to take:integer and return [cards]' do
    deck.should_receive(1).and_return(heart: 'king')
  end
end
