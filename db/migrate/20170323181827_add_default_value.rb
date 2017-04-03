class AddDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default :domains, :adjust_solution, 0
    change_column_default :domains, :adjust_skills, 0
    change_column_default :domains, :adjust_organization, 0
    change_column_default :action_fields, :solution, 0
    change_column_default :action_fields, :skills, 0
    change_column_default :action_fields, :organization, 0
  end
end
