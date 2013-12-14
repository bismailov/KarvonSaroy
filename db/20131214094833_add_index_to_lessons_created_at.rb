class AddIndexToLessonsCreatedAt < ActiveRecord::Migration
  def change
    add_index :lessons, :created_at, unique: true
  end
end
