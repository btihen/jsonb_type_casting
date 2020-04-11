class CreatePlots < ActiveRecord::Migration[6.0]
  def change
    create_table :research_plots do |t|
      t.string :plot_name,     null: false
      t.jsonb :boundry_points, null: false, default: []
      t.references :center,    null: false, foreign_key: true

      t.timestamps
    end
  end
end
