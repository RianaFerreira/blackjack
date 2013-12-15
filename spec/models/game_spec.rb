require 'spec_helper'

describe Game do
  let!(:deck) {Deck.new}
  let!(:game) { Game.create }
  let!(:dealer){ game.dealer }
  let!(:player){ game.player }

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
        player.stub :deal
        dealer.should_receive(:deal).with([:card])
        game.deal
    end

    it 'should hand the player two cards from the deck' do
        dealer.stub :deal
        player.should_receive(:deal).with(@cards)
        game.deal
    end
  end

  context 'pending game' do
    before (:each) do
    end

    it 'should have status pending when neither player is over 21' do
      # dealer.should_receive(:show_hand).and_return(:hand)
    end


  end

end
