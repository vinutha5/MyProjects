class CreateBloodGlucoseLevels < ActiveRecord::Migration
  def change
    create_table :blood_glucose_levels do |t|
      t.integer :patient_id
      t.integer :glucose_level

      t.timestamps null: false
    end
  end
end
