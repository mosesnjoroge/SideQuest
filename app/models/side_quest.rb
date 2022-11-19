class SideQuest < ApplicationRecord
  belongs_to :trip
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :stops, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true }

  geocoded_by :address
  validates :address, presence: true
  after_validation :geocode, if:
  :will_save_change_to_address?
end
