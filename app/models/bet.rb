class Bet < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  has_many :transactions
  belongs_to :game
  belongs_to :user

  validates_inclusion_of :lucky_number, in: 1..99

  def self.get_winner_ids(game_id, lucky_number)
    all.where('game_id = ? AND lucky_number = ?', game_id, lucky_number).pluck(:user_id)
  end
end
