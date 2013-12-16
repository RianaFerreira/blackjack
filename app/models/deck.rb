# == Schema Information
#
# Table name: decks
#
#  id      :integer          not null, primary key
#  game_id :integer
#

class Deck < ActiveRecord::Base
  #attr_accessible :game_id

  has_many :cards

  def take(cards_needed)
    cards.shuffle.take(cards_needed)
    # deck should contain 52 cards
    # cards should be stored in an array
    # cards should be shuffled
    # number of cards needed should be randomly removed from the array
  end
end
