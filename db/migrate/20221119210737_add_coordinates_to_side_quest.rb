class AddCoordinatesToSideQuest < ActiveRecord::Migration[7.0]
  def change
    add_column :side_quests, :latitude, :float
    add_column :side_quests, :longitude, :float
  end
end
