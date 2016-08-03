class RenameColumnInCredits < ActiveRecord::Migration[5.0]
  def change
  	rename_column :credits, :purchased_credit, :game_credit
  end
end
