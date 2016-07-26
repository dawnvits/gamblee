class AddMinutesAvailableForBettingAfterSchedule < ActiveRecord::Migration[5.0]
  def change
  	add_column :games, :betting_time, :decimal, default: 0
  end
end
