class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :fname
      t.string :lname
      t.string :email
      t.string :address
      t.string :account_number

      t.timestamps
    end
  end
end
