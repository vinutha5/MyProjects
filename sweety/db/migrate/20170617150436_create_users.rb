class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :account_id
      t.text :username
      t.text :password
      t.text :account_type
      t.timestamps null: false
    end
  end
end
