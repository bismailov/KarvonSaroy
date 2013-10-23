# == Schema Information
#
# Table name: lessons
#
#  id                            :integer          not null, primary key
#  title                         :string(255)
#  content                       :text
#  media_file                    :string(255)
#  course_id                     :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  video_attachment_file_name    :string(255)
#  video_attachment_content_type :string(255)
#  video_attachment_file_size    :integer
#  video_attachment_updated_at   :datetime
#

class Lesson < ActiveRecord::Base
  attr_accessible :content, :media_file, :title, :video_attachment
  attr_protected :course_id

  has_attached_file :video_attachment

  belongs_to :course

  before_save {|lesson| lesson.title = title.downcase }

  validates :course_id, presence: true
  validates :title, presence: true, length: {maximum: 250}, uniqueness: {case_sensitive: false}
  validates :content, presence: true
  validates :media_file, length: {maximum: 250}
end

# look at models/subject.rb for index generation
