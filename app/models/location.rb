class Location < ApplicationRecord
  has_and_belongs_to_many :trips, foreign_key: :start_location_id
  geocoded_by :address
  after_validation :geocode, if:
  :will_save_change_to_address?
end
