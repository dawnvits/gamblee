class Game < ApplicationRecord
  scope :for_betting, -> { where(for_betting: true) }
  has_many :bets

  validates :betting_time,
            :description,
            :schedule, presence: true
end
