class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.text :name
      t.text :address
      t.text :email
      t.text :phone
      t.text :specialization	
      t.timestamps null: false
    end
  end
end
