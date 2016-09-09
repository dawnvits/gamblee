class AddBetAmountToBets < ActiveRecord::Migration[5.0]
  def change
  	add_column :bets, :bet_amount, :integer, default: 0
  end
end
