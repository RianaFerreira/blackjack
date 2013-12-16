# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Player do

  it 'should respond_to :deal'
  it 'should respond_to :hand_value'
  it 'should respond_to :stand?'
end
