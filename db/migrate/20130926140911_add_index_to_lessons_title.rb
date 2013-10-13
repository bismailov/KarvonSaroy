class AddIndexToLessonsTitle < ActiveRecord::Migration
  def change
    add_index :lessons, :title, unique: true
  end
end
