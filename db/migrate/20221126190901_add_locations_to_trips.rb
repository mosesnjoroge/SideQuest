class AddLocationsToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :start_location_id, :integer
    add_column :trips, :end_location_id, :integer
  end
end
