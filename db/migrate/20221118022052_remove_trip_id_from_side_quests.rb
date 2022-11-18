class RemoveTripIdFromSideQuests < ActiveRecord::Migration[7.0]
  def change
    remove_column :side_quests, :trip_id, :bigint
  end
end
