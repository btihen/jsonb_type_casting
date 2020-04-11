class CreateMeasuments < ActiveRecord::Migration[6.0]
  def change
    create_table :measuments do |t|
      t.jsonb :observed_animals,  null: false, default: []
      t.jsonb :temperatures,      null: false, default: []
      t.jsonb :location,          null: false, default: {}
      t.jsonb :observer,          null: false, default: {}
      t.jsonb :center,            null: false, default: {}

      t.timestamps
    end
  end
end
