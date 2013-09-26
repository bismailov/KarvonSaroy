class RemoveEditorFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :editor
  end

  def down
    add_column :users, :editor, :boolean
  end
end
