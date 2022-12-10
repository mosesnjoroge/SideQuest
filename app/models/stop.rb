class Stop < ApplicationRecord
  belongs_to :trip
  belongs_to :side_quest
  # validates :order, numericality: { only_integer: true }

end
