class Bet < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  
  has_many :transactions, dependent: :destroy
  belongs_to :game
  belongs_to :user

  validates_inclusion_of :bet_number_1, in: 1..9
  validates_inclusion_of :bet_number_2, in: 1..9

  def self.get_winner(game_id, bet_number_1, bet_number_2)
    all.where('game_id = ? AND bet_number_1 = ? AND bet_number_2 = ?', game_id, bet_number_1, bet_number_2).pluck(:user_id)
  end
end
