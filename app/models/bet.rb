class Bet < ApplicationRecord
  
  has_many :transactions, dependent: :destroy
  belongs_to :game
  belongs_to :user

  validates_inclusion_of :bet_number_1, in: 1..9
  validates_inclusion_of :bet_number_2, in: 1..9

  validates_uniqueness_of :bet_number_1, scope: [:game_id, :bet_number_2]

  def self.get_winner_for_game(game_id, bet_number_1, bet_number_2)
    all.where('game_id = ? AND bet_number_1 = ? AND bet_number_2 = ?', game_id, bet_number_1, bet_number_2).pluck(:user_id)
  end

  def self.get_winner(bet_number_1, bet_number_2)
    all.where('bet_number_1 = ? AND bet_number_2 = ?', bet_number_1, bet_number_2).pluck(:user_id)
  end
end
