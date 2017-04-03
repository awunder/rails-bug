class CreateAchievements < ActiveRecord::Migration[5.0]
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :additional_info
      t.datetime :due_date
      t.integer :achievementable_id
      t.string :achievementable_type

      t.timestamps
    end
  end
end
