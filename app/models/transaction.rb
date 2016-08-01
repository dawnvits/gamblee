class Transaction < ApplicationRecord
  scope :latest, -> { order('created_at DESC') }
  belongs_to :credit
end
