class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.string :name
      t.text :additional_info
      t.string :media
      t.datetime :due_date
      t.string :rollout
      t.integer :actionable_id
      t.string :actionable_type

      t.timestamps
    end
    add_index :actions, [:actionable_id, :actionable_type]
  end
end
