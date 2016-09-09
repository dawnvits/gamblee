class ModifyGamesFields < ActiveRecord::Migration[5.0]
  def up
    rename_column :games, :winning_number, :winning_number_1
    add_column :games, :winning_number_2, :integer, default: 0
    rename_column :bets, :lucky_number, :bet_number_1
    add_column :bets, :bet_number_2, :integer, default: 0
  end

  def down
	  rename_column :games, :winning_number_1, :winning_number
    remove_column :games, :winning_number_2
    rename_column :bets, :bet_number_1, :lucky_number
    remove_column :bets, :bet_number_2 	
  end
end
