class GamesController < ApplicationController
  def index
    @games = Game.all.latest
  end

  def summary
    @game = Game.find(params[:id])
    @user_ids = @game.bets.pluck(:user_id)
    @lucky_numbers1 = @game.bets.pluck(:bet_number_1)
    @lucky_numbers2 = @game.bets.pluck(:bet_number_2)
    @amounts = @game.bets.pluck(:bet_amount)
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
    @current_bets = @game.bets.where(user_id: current_user.id)
  end

  def process_bet
    @game = Game.find(params[:id])

    if @game.bets.where(user_id: current_user.id).count <= 1

      if proper_bet
        if @game.accepts_bet? && current_user.credit.can_bet?(params[:bet_amount].to_i)
          current_user.new_bet(@game.id,
            @game.description,
            params[:bet_number_1].to_i,
            params[:bet_number_2].to_i,
            params[:bet_amount].to_i
          )
          flash[:notice] = "Placed bet successfully on #{@game.description} with ₱#{params[:bet_amount]}"
        else
          flash[:notice] = 'Unable to place bet. Please try again.'
        end
      else
        flash[:notice] = 'Unable to place bet. Please try again.'
      end

    else
      flash[:notice] = "You've reached the maximum number of bets for this game."
    end
    
    redirect_to root_url
  end

  def determine_winner
    game = Game.find(params[:id])
    winners_list = Bet.get_winner(game.id, params[:winning_number_1].to_i, params[:winning_number_2].to_i)

    if winners_list.length >= 1
      winners_list.each do |user_id|
        Credit.pick_winner(user_id, game.id)
      end
      flash[:notice] = 'Winners have already been selected!'
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

  def proper_bet
    params[:bet_number_1].to_i.between?(1, 9) &&
    params[:bet_number_2].to_i.between?(1, 9) &&
    params[:bet_amount].to_i > 0
  end
end
