class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      flash[:notice] = 'Game created successfully!'
      redirect_to games_url
    else
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    flash[:notice] = 'Game deleted successfully!'
    redirect_to games_url
  end

  private

  def game_params
    params.require(:game).permit(:schedule, :betting_time, :description)
  end
end
