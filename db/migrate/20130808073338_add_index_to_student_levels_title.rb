class AddIndexToStudentLevelsTitle < ActiveRecord::Migration
  def change
    add_index :student_levels, :title, unique: true
  end
end
