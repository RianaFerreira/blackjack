class Deck < ActiveRecord::Base
  attr_accessible :title, :body

  has_many :cards
end
