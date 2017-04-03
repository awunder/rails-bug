class RenameReadyfromActions < ActiveRecord::Migration[5.0]
  def change
    rename_column :actions, :ready, :due_date
  end
end
