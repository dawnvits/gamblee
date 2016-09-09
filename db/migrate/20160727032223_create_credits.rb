class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits, id: :uuid do |t|
      t.uuid :user_id, index: true
      t.integer :purchased_credit, default: 0
      t.integer :free_credit, default: 0
      t.integer :total_credit, default: 0
      t.timestamps
    end
  end
end
