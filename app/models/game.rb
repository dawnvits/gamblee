class Game < ApplicationRecord
  has_many :bets
  
  validates :betting_time,
            :description,
            :schedule, presence: true
end
