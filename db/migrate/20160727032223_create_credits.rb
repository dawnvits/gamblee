class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|
      t.belongs_to :user, index: true
      t.integer :purchased_credit, default: 0
      t.integer :free_credit, default: 0
      t.timestamps
    end
  end
end
