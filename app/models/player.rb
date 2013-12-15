class Player < ActiveRecord::Base
  attr_accessible :name
  belongs_to :game
  has_and_belongs_to_many :cards
end
