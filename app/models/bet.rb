class Bet < ApplicationRecord
  has_many :transactions
  belongs_to :game
  belongs_to :user
end
