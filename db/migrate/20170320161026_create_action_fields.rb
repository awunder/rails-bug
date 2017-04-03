class CreateActionFields < ActiveRecord::Migration[5.0]
  def change
    create_table :action_fields do |t|
      t.string :name
      t.string :target
      t.integer :solution
      t.integer :skills
      t.integer :organization
      t.float :domain_weight
      t.references :domain, foreign_key: true, index: true
      t.references :editor, index: true, foreign_key: { to_table: :users }
      t.references :deputy, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
