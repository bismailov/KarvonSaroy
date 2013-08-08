class CreateStudentLevels < ActiveRecord::Migration
  def change
    create_table :student_levels do |t|
      t.string :title

      t.timestamps
    end
  end
end
