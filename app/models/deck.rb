# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deck < ActiveRecord::Base
  attr_accessible :title, :body

  has_many :cards
end
