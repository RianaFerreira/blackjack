class GamesController < ApplicationController
  def create
    @game = Game.create
    @game.deck = Deck.first
    @game.deal
    @game.save
    redirect_to @game
  end

  def show
    @game = Game.find(params[:id])
  end

  def status
    @game = Game.find(params[:id])
    render json: @game.status
  end

  def hit
    @game = Game.find(params[:id])
    @game.player.hit
    redirect_to status_game_url(@game)
  end

  def deal
    @game = Game.find(params[:id])
    @game.deal
    #redirect_to status_game_url(@game)
  end

  def stand
    @game = Game.find(params[:id])
    @game.player.stand

  end

end