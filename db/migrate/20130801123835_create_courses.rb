class CreateCourses < ActiveRecord::Migration def change
    create_table :courses do |t|
      t.string :title
      t.references :user
      t.references :subject
      t.references :student_level
      t.text :objectives

      t.timestamps
    end
    add_index :courses, :user_id
  end
end
