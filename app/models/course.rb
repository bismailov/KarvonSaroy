# == Schema Information
#
# Table name: courses
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  user_id          :integer
#  subject_id       :integer
#  student_level_id :integer
#  objectives       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Course < ActiveRecord::Base
  attr_accessible :objectives, :title, :subject_id, :student_level_id

  belongs_to :user
  belongs_to :subject
  belongs_to :student_level

  before_save {|course| course.title = title.downcase }

  validates :user_id, presence: true
  validates :subject_id, presence: true
  validates :student_level_id, presence: true
  validates :title, presence: true, length: {maximum: 250}, uniqueness: {case_sensitive: false} 
  validates :objectives, presence: true
end
