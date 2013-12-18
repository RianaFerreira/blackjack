class PagesController < ApplicationController
  def home
    @game = Game.new
  end
end
