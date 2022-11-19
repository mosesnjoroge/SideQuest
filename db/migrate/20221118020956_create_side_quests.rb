class CreateSideQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :side_quests do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.references :category, null: false, foreign_key: true
      t.string :description
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
