class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street,   null: false
      t.string :city,     null: false
      t.string :postcode, null: false

      t.timestamps
    end
  end
end
