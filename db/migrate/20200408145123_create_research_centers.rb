class CreateResearchCenters < ActiveRecord::Migration[6.0]
  def change
    create_table :research_centers do |t|
      t.string :center_name, null: false
      t.references :address, null: false, foreign_key: true

      t.timestamps
    end
  end
end
