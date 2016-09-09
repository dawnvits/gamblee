class CreateGameTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :game_transactions, id: :uuid do |t|
      t.uuid :game_id, index: true
      # t.belongs_to :game, index: true
      t.text :description
      t.timestamps
    end
  end
end
