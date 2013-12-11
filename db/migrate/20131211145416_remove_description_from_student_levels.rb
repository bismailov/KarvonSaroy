class RemoveDescriptionFromStudentLevels < ActiveRecord::Migration
  def up
    remove_column :student_levels, :description
  end

  def down
    add_column :student_levels, :description, :string
  end
end
