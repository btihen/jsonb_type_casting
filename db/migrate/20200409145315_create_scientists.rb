class CreateScientists < ActiveRecord::Migration[6.0]
  def change
    create_table :scientists do |t|
      t.string :full_name,   null: false
      t.references :address, null: false, foreign_key: true
      t.references :center,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
