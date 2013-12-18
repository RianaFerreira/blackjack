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
    render json: @game.status.to_json(include: :cards)
  end

  def hit
    @game = Game.find(params[:id])
    @game.player.hit
    render json: @game.status.to_json(include: :cards)
  end

  def deal
    @game = Game.find(params[:id])
    @game.deal
    render json: @game.status.to_json(include: :cards)
  end

  def stand
    @game = Game.find(params[:id])
    @game.stand
    render json: @game.status.to_json(include: :cards)
  end

end