class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :meter_reading
      t.integer :user_id

      t.timestamps
    end
  end
end
