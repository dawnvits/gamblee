class Game < ApplicationRecord
  validates :betting_time,
            :description,
            :schedule, presence: true
end
