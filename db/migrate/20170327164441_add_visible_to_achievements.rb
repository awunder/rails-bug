class AddVisibleToAchievements < ActiveRecord::Migration[5.0]
  def change
    add_column :achievements, :visible, :boolean, default: false
    add_column :achievements, :domain_rank, :integer, default: 9999
    add_column :achievements, :action_field_rank, :integer, default: 9999
    add_column :actions, :visible, :boolean, default: false
    add_column :actions, :domain_rank, :integer, default: 9999
    add_column :actions, :action_field_rank, :integer, default: 9999
  end
end
