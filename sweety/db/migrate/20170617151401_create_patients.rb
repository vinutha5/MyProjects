class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :doctor_id	
      t.text :name
      t.text :address
      t.text :email
      t.text :phone
      t.text :bloodgroup	
      t.timestamps null: false
    end
  end
end
