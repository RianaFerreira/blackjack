# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :deck
  has_many :players

  before_create :setup_players

  def dealer
    players[0]
  end

  def player
    players[1]
  end

  def deal
    dealer.reset
    player.reset
    dealer.deal (deck.take 1)
    player.deal (deck.take 2)
  end

  def hit
    deck.take(1).first
  end

  def stand
    # play has called stand
    while (dealer.hand_value < 17) do
      dealer.hit
    end
  end

  def status
    status = 'pending'
    player_hand_value = player.hand_value
    dealer_hand_value = dealer.hand_value

    if player_hand_value > 21
      status = 'lost'
    elsif (player_hand_value == 21 && dealer_hand_value == 21)
      status = 'draw'
    elsif (player_hand_value == 21)
      status = 'win'
    elsif (dealer_hand_value == 21)
      status = 'lost'
    elsif (dealer_hand_value > 21)
      status = 'win'
    elsif (dealer.stand? && player.stand?)
        status = 'win' if player_hand_value > dealer_hand_value
        status = 'lost' if player_hand_value < dealer_hand_value
        status = 'draw' if player_hand_value == dealer_hand_value
    end

    { status: status,
      dealer: dealer.to_json(include: :cards),
      player: player.to_json(include: :cards) }
  end

  private
  def setup_players
    players << Player.create(name: 'Dealer')
    players << Player.create(name: 'Player')
  end

end
