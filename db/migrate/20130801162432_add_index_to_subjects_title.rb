class AddIndexToSubjectsTitle < ActiveRecord::Migration
  def change
    add_index :subjects, :title, unique: true
  end
end
