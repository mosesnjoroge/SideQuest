class SideQuest < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :stops, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { only_integer: true }

  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
