class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.text :description
      t.datetime :schedule
      t.boolean :for_betting, default: :false
      t.timestamps
    end
  end
end
