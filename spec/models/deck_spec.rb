require 'spec_helper'

describe Deck do
  it {should have_many :cards}
  it 'should respond_to take:integer and return [cards]'
end
