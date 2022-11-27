class RemoveAddressesFromTrips < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :start_latitude, :float
    remove_column :trips, :start_longitude, :float
    remove_column :trips, :start_point, :string
    remove_column :trips, :end_point, :string
    remove_column :trips, :end_latitude, :float
    remove_column :trips, :end_longitude, :float
  end
end
