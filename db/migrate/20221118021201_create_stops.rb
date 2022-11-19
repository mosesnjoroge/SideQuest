class CreateStops < ActiveRecord::Migration[7.0]
  def change
    create_table :stops do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :side_quest, null: false, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
