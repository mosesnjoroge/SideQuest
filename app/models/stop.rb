class Stop < ApplicationRecord
  belongs_to :trip
  belongs_to :side_quest
end
