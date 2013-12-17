# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  stand      :boolean
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base
  attr_accessible :name, :stand
  belongs_to :game
  has_and_belongs_to_many :cards

  def deal(dealt_cards)
    # add undetermined number of dealt cards to the cards array
    cards.push(*dealt_cards)
  end

  def stand?
    # player status set
    stand
  end

  def hand_value
    # &: converts method card_value to a proc and runs it for each array object
    # inject method on enumerable, applied operation + to every element in the array
    # http://ruby-doc.org/core-1.9.3/Enumerable.html
    cards.map( &:card_value).inject(:+)
  end

  def reset
    # remove all cards from the array
    cards.clear
  end

  def hit
    # add the taken card to the array
    cards << game.hit
  end
end
