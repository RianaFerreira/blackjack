# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  suit       :string(255)
#  rank       :string(255)
#  deck_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Card < ActiveRecord::Base
  attr_accessible :rank, :suit, :deck_id
  belongs_to :deck
end
