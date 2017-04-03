class CreateDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :domains do |t|
      t.string :name
      t.integer :adjust_solution
      t.integer :adjust_skills
      t.integer :adjust_organization
      t.references :editor, index: true, foreign_key: { to_table: :users }
      t.references :deputy, index: true, foreign_key: { to_table: :users }
      t.references :solution_category, foreign_key: true, index: true

      t.timestamps
    end
  end
end
