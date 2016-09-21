class Game < ApplicationRecord
  
  has_many :bets
  has_many :game_transactions

  validates :minutes_for_betting,
            :description,
            :schedule, presence: true

  def accepts_bet?
    Time.now < self.schedule.advance(minutes: self.minutes_for_betting)
  end

  def has_winner?
    self.winner_determined
  end

  def self.for_betting
    all.where('winner_determined = ?', false).order('created_at DESC')
  end

  def bet_limit
    20
  end

  def allowed_to_bet(user_id)
    bets.where(user_id: user_id).count < bet_limit
  end

  def unique_bets_for_game(user_id)
    bets.where(user_id: user_id).count
  end
end
