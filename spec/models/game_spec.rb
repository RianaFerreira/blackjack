# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Game do
  let!(:deck) {Deck.new}
  let!(:game) { Game.create }
  let!(:dealer) { game.dealer }
  let!(:player) { game.player }

  subject{ game }

  it { should have_one :deck }
  it { should have_many :players }
  it { should have(2).players }
  it { should respond_to :dealer}
  its(:dealer) { should player_with :name, 'Dealer'}
  it { should respond_to :player}
  its(:player) { should player_with :name, 'Player'}

  its(:players) { should include player_with :name, 'Dealer' }
  its(:players) { should include player_with :name, 'Player' }

  context 'when dealing' do
    let!(:card) {double()}

    before (:each) do
       game.deck = deck
       deck.stub(:take).with(1).and_return([:card])
       @cards = [:card, :card]
       deck.stub(:take).with(2).and_return(@cards)
    end

    it 'should hand the dealer one card from the deck' do
        player.stub deal: nil, reset: nil
        dealer.should_receive(:reset)
        dealer.should_receive(:deal).with([:card])
        game.deal
    end

    it 'should hand the player two cards from the deck' do
        dealer.stub deal: nil, reset: nil
        player.should_receive(:reset)
        player.should_receive(:deal).with(@cards)
        game.deal
    end
  end

  context 'blackjack' do
    before(:each) do
      dealer.stub(stand?: false)
      player.stub(stand?: false)
    end

    it 'player should win if hand value equals 21' do
      player.should_receive(:hand_value).and_return(21)
      dealer.stub(:hand_value).and_return(17)
      game.status.should include(
        status: 'win'
        )
    end

    it 'player should lose if dealer hand value equals 21' do
      player.should_receive(:hand_value).and_return(17)
      dealer.should_receive(:hand_value).and_return(21)
      game.status.should include(
        status: 'lost'
        )
    end

    it 'player and dealer are dealt hand value of 21' do
      dealer.should_receive(:hand_value).and_return(21)
      player.should_receive(:hand_value).and_return(21)
      game.status.should include(
        status: 'draw'
        )
    end
  end

  context 'neither players stand:' do
    before (:each) do
      dealer.stub(stand?: false, hand_value: 10)
      player.stub(stand?: false, hand_value: 10)
    end

    it 'should have status pending when neither player is over 21' do
      game.status.should include(
          status: 'pending'
        )
    end

    it 'player busts if hand is over 21' do
      player.should_receive(:hand_value).and_return(22)
      dealer.should_receive(:hand_value).and_return(17)
      game.status.should include(
        status: 'lost'
        )
    end

    it 'dealer busts if hand is over 21' do
      dealer.should_receive(:hand_value).and_return(22)
      player.should_receive(:hand_value).and_return(17)
      game.status.should include(
        status: 'win'
        )
    end
  end

  context 'both players stand:' do
    before(:each) do
      dealer.stub(:stand?).and_return(true)
      player.stub(:stand?).and_return(true)
    end

    it 'player wins if hand is less than 21 and higher than dealer' do
      player.should_receive(:hand_value).and_return(20)
      dealer.should_receive(:hand_value).and_return(16)
      game.status.should include(
        status: 'win'
        )
    end

    it 'player busts if hand is over 21' do
      player.should_receive(:hand_value).and_return(22)
      dealer.stub(:hand_value).and_return(16)
      game.status.should include(
        status: 'lost'
        )
    end

    it 'player loses if hand is less than dealer' do
      player.should_receive(:hand_value).and_return(16)
      dealer.should_receive(:hand_value).and_return(17)
      game.status.should include(
        status: 'lost'
        )
    end

    it 'player wins if dealer hand is over 21' do
      player.should_receive(:hand_value).and_return(16)
      dealer.should_receive(:hand_value).and_return(22)
      game.status.should include(
        status: 'win'
        )
    end

    it 'player and dealer cards are of equal value' do
      player.should_receive(:hand_value).and_return(20)
      dealer.should_receive(:hand_value).and_return(20)
      game.status.should include(
        status: 'draw'
        )
    end
  end

  context 'when playing' do
    before (:each) do
       game.deck = deck
    end

    it 'should take a card from the deck when you hit' do
      deck.should_receive(:take).with(1).and_return([Card.new])
      game.hit
    end

    it 'should simulate dealer play when player stand' do
      dealer.stub(:hand_value).and_return(16,18)
      dealer.should_receive(:hit).at_least(:once)
      game.stand
    end

    it 'dealer should hit on or below 16' do
      dealer.stub(:hand_value).and_return(16,18)
      dealer.should_receive(:hit)
      game.stand
    end

    it 'dealer should stand on 17 or above' do
      dealer.stub(:hand_value).and_return(17)
      dealer.should_not_receive(:hit)
      game.stand
    end
  end

end
