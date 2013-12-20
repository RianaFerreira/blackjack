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
    dealer.save
    player.save
  end

  def hit
    deck.take(1).first
  end

  def stand
    player.stand = true
    # player has called stand
    while (dealer.hand_value < 17) do
      dealer.hit
    end
    dealer.stand = true
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

    if status == 'win'
      player.win += 1
      player.save
    elsif status == 'lost'
      player.lost += 1
      player.save
    elsif status == 'draw'
      player.draw += 1
      player.save
    end

    # json data to be returned
    { status: status,
      dealer: dealer,
      player: player }
  end

  private
  def setup_players
    players << Player.create(name: 'Dealer', win: 0, lost: 0, draw: 0)
    players << Player.create(name: 'Player', win: 0, lost: 0, draw: 0)
  end

end
