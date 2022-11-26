class Trip < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :side_quests, through: :stops
  has_many :stops, dependent: :destroy
  has_one :start_location, class_name: "Location"
end
