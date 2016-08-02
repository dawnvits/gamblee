class Bet < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  has_many :transactions
  belongs_to :game
  belongs_to :user

  validates_inclusion_of :lucky_number, in: 1..99
end
