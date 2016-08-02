class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.text :description
      t.datetime :schedule
      t.integer :minutes_for_betting, default: 0
      t.timestamps
    end
  end
end
