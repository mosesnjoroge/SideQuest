class AddEndCoordinatesToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :end_latitude, :float
    add_column :trips, :end_longitude, :float
  end
end
