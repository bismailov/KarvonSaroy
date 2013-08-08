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
  belongs_to :user
  belongs_to :subject
  belongs_to :student_level
  attr_accessible :objectives, :title
end
