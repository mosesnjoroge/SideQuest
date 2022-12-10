class Trip < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :side_quests, through: :stops
  has_many :stops, dependent: :destroy
end
