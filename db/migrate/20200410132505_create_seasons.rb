class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.jsonb :temperature

      t.timestamps
    end
  end
end
