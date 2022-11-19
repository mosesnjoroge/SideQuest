class Review < ApplicationRecord
  belongs_to :side_quest
  belongs_to :user
end
