class CreateCredits < ActiveRecord::Migration[5.0]
  def change
    create_table :credits do |t|

      t.timestamps
    end
  end
end
