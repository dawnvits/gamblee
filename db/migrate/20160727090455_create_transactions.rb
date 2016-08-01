class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :credit, index: true
      t.text :description
      t.timestamps
    end
  end
end
