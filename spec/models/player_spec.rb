# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  stand      :boolean
#  win        :integer
#  lost       :integer
#  draw       :integer
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Player do
  let!(:player){ Player.create }
  let!(:card){ Card.new }
  let!(:game) { Game.new }

  before(:each) do
    player.game = game

  end

  it { should have_and_belong_to_many :cards }
  it { should respond_to :deal }
  it { should respond_to :stand? }
  it { should respond_to :hand_value }
  it { should respond_to :reset }
  it { should respond_to :hit }

  it 'should hold cards dealt' do
    player.deal([card])
    player.cards.should include(card)
  end

  its(:stand){ should be_false }
  it 'should stand and return the correct value' do
    player.stand = true
    player.stand?.should be_true
  end

  context '#hand_value' do
    let(:king) { Card.new(suit: 'hearts', rank: 'K', card_value: 10) }
    let(:queen) { Card.new(suit: 'hearts', rank: 'Q', card_value: 10) }

    it 'should have hand_value equal to 20 when dealt a king and a queen' do
      player.deal([king, queen])
      player.hand_value.should == 20
    end
  end

  it 'should implement reset' do
    player.deal([card])
    player.reset
    player.cards.should be_empty
  end

  it 'should implement hit' do
    game.should_receive(:hit).and_return(card)
    player.hit
    player.cards.should include(card)
  end
end
