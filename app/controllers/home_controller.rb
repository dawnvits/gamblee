class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @games = Game.all
  end
end
