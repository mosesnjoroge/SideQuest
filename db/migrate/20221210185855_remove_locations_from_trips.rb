class RemoveLocationsFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :start_location_id, :integer
    remove_column :trips, :end_location_id, :integer
  end
  end
