class AddCoordinatesToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :start_latitude, :float
    add_column :trips, :start_longitude, :float
  end
end
