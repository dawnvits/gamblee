class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @games = Game.all.for_betting
  end

  def dashboard
    @bets = current_user.bets.latest
    @credit = current_user.credit
    @transactions = @credit.transactions.latest
  end
end
