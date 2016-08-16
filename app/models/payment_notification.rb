class PaymentNotification < ApplicationRecord
  validates :txn_id, :ipn_track_id, uniqueness: true
end
