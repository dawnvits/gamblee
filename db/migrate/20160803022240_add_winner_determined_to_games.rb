class AddWinnerDeterminedToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :winner_determined, :boolean, default: false
    add_column :games, :winning_number, :integer, default: 0
  end
end
