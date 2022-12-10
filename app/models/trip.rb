class Trip < ApplicationRecord
  # @TODO: add start_geolocation
  # @TODO: add end_geolocation

  belongs_to :user, dependent: :destroy
  has_many :side_quests, through: :stops
  has_many :stops, dependent: :destroy
end
