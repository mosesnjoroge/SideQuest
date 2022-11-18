class SideQuest < ApplicationRecord
  belongs_to :trip
  belongs_to :category
  belongs_to :user
end
