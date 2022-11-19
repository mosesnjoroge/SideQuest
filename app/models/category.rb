class Category < ApplicationRecord
  has_many :side_quests

  validates :name, presence: true
end
