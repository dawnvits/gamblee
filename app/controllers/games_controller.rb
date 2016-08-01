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

  def process_bet
    @game = Game.find(params[:id])

    if current_user.credit.can_bet?(params[:bet_amount].to_i)
      Bet.create!(
        game_id: @game.id,
        user_id: current_user.id,
        lucky_number: params[:lucky_number],
        description: "Your lucky number for #{@game.description} is #{params[:lucky_number]}"
      )

      flash[:notice] = "Placed bet successfully on #{@game.description} with ₱#{params[:bet_amount]}"
    else
      flash[:notice] = 'Unable to place bet. Please check your game credits.'
    end

    redirect_to root_url
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.assign_attributes(game_params)

    if @game.changed?
      if @game.save
        flash[:notice] = 'Game updated successfully!'
        redirect_to games_url
      end
    else
      flash[:notice] = 'Please make the proper changes'
      render 'edit'
    end
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    flash[:notice] = 'Game deleted successfully!'
    redirect_to games_url
  end

  private

  def game_params
    params.require(:game).permit(:schedule, :betting_time, :description, :for_betting)
  end
end
