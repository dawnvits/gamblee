class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets, id: :uuid do |t|
      t.uuid :game_id, index: true
      t.uuid :user_id, index: true
      # t.belongs_to :game, index: true
      # t.belongs_to :user, index: true
      t.text :description
      t.integer :lucky_number, default: 0
      t.timestamps
    end
  end
end
