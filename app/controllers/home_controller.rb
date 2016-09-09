class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @games = Game.all.latest.select { |game| game.schedule.advance(minutes: game.minutes_for_betting) > Time.now }
  end

  def dashboard
    @bets = current_user.bets.latest
    @credit = current_user.credit
    @transactions = @credit.transactions.latest
  end
end
