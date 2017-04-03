class AddDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :action_fields, :domain_weight, 1
  end
end