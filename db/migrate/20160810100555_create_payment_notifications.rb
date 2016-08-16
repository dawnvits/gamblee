class CreatePaymentNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_notifications do |t|
      t.string :payer_email
      t.string :txn_id
      t.string :ipn_track_id
      t.integer :mc_gross, default: 0
      t.timestamps
    end
  end
end
