class Transaction < ApplicationRecord
  belongs_to :bet
  belongs_to :credit
end
