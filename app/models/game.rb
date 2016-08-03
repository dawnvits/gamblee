class Game < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  has_many :bets
  has_many :game_transactions

  validates :minutes_for_betting,
            :description,
            :schedule, presence: true

  def accepts_bet?
    Time.now < self.schedule.advance(minutes: self.minutes_for_betting)
  end
 end
