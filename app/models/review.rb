class Review < ApplicationRecord
  belongs_to :side_quest
  belongs_to :user

  validates :body, presence: true
  validates :rating, presence: true, numericality: true, inclusion: { in: 0..5 }
end
