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
    dealer.deal (deck.take 1)
    player.deal (deck.take 2)
  end

  private
  def setup_players
    players << Player.create(name: 'Dealer')
    players << Player.create(name: 'Player')
  end

end
