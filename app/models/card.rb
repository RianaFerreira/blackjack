class Card < ActiveRecord::Base
  attr_accessible :rank, :suit, :deck_id
  belongs_to :deck
end
