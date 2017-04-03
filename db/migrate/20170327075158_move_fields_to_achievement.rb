class MoveFieldsToAchievement < ActiveRecord::Migration[5.0]
  def change
    add_column :achievements, :media, :string
    add_column :achievements, :rollout, :string
    add_column :achievements, :ready, :timestamp
    remove_column :actions, :media, :string
  end
end
