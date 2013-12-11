class AddDescriptionToStudentLevels < ActiveRecord::Migration
  def change
    add_column :student_levels, :description, :text
  end
end
