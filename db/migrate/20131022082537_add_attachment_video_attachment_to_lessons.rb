class AddAttachmentVideoAttachmentToLessons < ActiveRecord::Migration
  def self.up
    change_table :lessons do |t|
      t.attachment :video_attachment
    end
  end

  def self.down
    drop_attached_file :lessons, :video_attachment
  end
end
