class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
    add_index :courses, :subject_id
    add_index :courses, :student_level_id
  end
end
