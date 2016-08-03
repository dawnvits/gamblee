class CreateGameTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :game_transactions do |t|
      t.belongs_to :game, index: true
      t.text :description
      t.timestamps
    end
  end
end
