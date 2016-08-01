class Bet < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  has_many :transactions
  belongs_to :game
  belongs_to :user
end
