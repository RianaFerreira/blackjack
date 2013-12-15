module PlayerAttribute
  class Matcher
    # codeschool rspec
    def initialize(attribute, value)
      @attribute = attribute
      @value = value
    end
    def matches?(player)
      @model = player
      player[@attribute] == @value
    end

    def description
      "expect #{@model.class} to have #{@attribute} equal to '#{@value}'"
    end

    def failure_message
      "#{@model.class} expected #{@attribute} to be #{@value} but was #{@model[@attribute]}"
    end

  end

  def player_with(attribute, value)
    Matcher.new(attribute, value)
  end
end

RSpec.configure do |config|
  config.include PlayerAttribute, type: :model
end