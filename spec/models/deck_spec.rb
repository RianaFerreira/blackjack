# == Schema Information
#
# Table name: decks
#
#  id      :integer          not null, primary key
#  game_id :integer
#

require 'spec_helper'

describe Deck do
  it { should have_many :cards }

  context 'deck #take' do
    let!(:deck) do
      deck = Deck.new
      ['hearts','spades','diamonds','clubs'].each do |suit|
         ((2..10).to_a + ['A','K','Q','J']).each do |rank|
            deck.cards << Card.new(suit: suit, rank: rank)
          end
      end
      deck
    end

    subject { deck }

    it { should have(52).cards }
    it 'should return cards when take is called' do
      deck.take(1).length.should == 1
    end
  end

end
