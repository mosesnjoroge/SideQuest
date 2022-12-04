class AddCategoriesToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :categories, :string, array: true, default: []
  end
end
