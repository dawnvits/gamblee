class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.all.latest
  end

  def summary
    @game = Game.includes(:bets).find(params[:id])

    if @game.bets.any?
      @bets = @game.bets.pluck(:user_id, :bet_number_1, :bet_number_2, :amount)
    end

    if @game.winner_determined
      @winners = Bet.get_winner(@game.winning_number_1, @game.winning_number_2)
    end
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
    # TO REFACTOR WHEN TEST SUITE IS DONE

    @game = Game.find(params[:id])

    if @game.allowed_to_bet(current_user.id)

      if proper_bet && @game.accepts_bet? && current_user.credit.can_bet?(params[:amount].to_i)
        begin
          current_user.new_bet(@game.id,
            @game.description,
            params[:bet_number_1].to_i,
            params[:bet_number_2].to_i,
            params[:amount].to_i
          )

          current_user.credit.adjust_credit(params[:amount].to_i)
          flash[:notice] = "Placed bet successfully on #{@game.description} with ₱#{params[:amount]}"
        rescue
          flash[:notice] = "Sorry, but you already made that bet for the game."
        end
      else
        flash[:notice] = 'Unable to place bet. Please try again.'
      end

    else
      flash[:notice] = "You've reached the maximum number of bets for this game which is #{@game.bet_limit}."
    end
    
    redirect_to root_url
  end

  def determine_winner
    game = Game.find(params[:id])
    game.update_attributes(winning_number_1: params[:winning_number_1].to_i, winning_number_2: params[:winning_number_2].to_i)
    winners = Bet.get_winner_for_game(game.id, params[:winning_number_1].to_i, params[:winning_number_2].to_i)

    if winners.length >= 1
      winners.each do |user_id|
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
      flash[:notice] = 'Game updated successfully!'
      redirect_to games_url
    else
      flash[:notice] = 'Please make the proper changes'
      render 'edit'
    end
  end

  def destroy
    game = Game.find(params[:id])

    # deletes associations [scrappy code]
    Bet.where(game_id: game.id).delete_all
    game.game_transactions.destroy
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
    params[:amount].to_i > 0
  end
end
