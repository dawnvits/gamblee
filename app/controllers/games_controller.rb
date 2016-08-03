class GamesController < ApplicationController
  def index
    @games = Game.all.latest
  end

  def summary
    @game = Game.find(params[:id])
    @user_ids = @game.bets.pluck(:user_id)
    @lucky_numbers = @game.bets.pluck(:lucky_number)
    @amounts = @game.bets.pluck(:amount)
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

    if @game.accepts_bet? && current_user.credit.can_bet?(params[:bet_amount].to_i, params[:lucky_number].to_i)
      current_user.new_bet(@game.id, @game.description, params[:lucky_number].to_i, params[:bet_amount].to_i)
      flash[:notice] = "Placed bet successfully on #{@game.description} with ₱#{params[:bet_amount]}"
    else
      flash[:notice] = 'Unable to place bet. Please try again.'
    end

    redirect_to root_url
  end

  def determine_winner
    game = Game.find(params[:id])
    winner_user_ids = Bet.get_winner_ids(game.id, params[:winning_number].to_i)

    if winner_user_ids.length >= 1
      winner_user_ids.each do |id|
        Credit.update_for_winner(id, game.id)
      end
      flash[:notice] = 'Congratulations to the winner/s!'
    else
      flash[:notice] = 'No Winner!'
    end

    redirect_to summary_game_url(game)
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
    params.require(:game).permit(:schedule, :minutes_for_betting, :description)
  end
end
