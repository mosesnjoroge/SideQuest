class Category < ApplicationRecord
  has_many :side_quests, dependent: :destroy

  validates :name, presence: true
  accepts_nested_attributes_for :side_quests, allow_destroy: true, reject_if: :all_blank
end
