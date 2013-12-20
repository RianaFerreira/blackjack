# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  suit       :string(255)
#  rank       :string(255)
#  card_value :integer
#  deck_id    :integer
#

class Card < ActiveRecord::Base
  attr_accessible :rank, :suit, :card_value
  belongs_to :deck
end
