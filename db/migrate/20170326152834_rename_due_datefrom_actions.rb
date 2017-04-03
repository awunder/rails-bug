class RenameDueDatefromActions < ActiveRecord::Migration[5.0]
  def change
    rename_column :actions, :due_date, :ready
  end
end
