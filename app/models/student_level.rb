# == Schema Information
#
# Table name: student_levels
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StudentLevel < ActiveRecord::Base
  attr_accessible :title

  before_save {|student_level| student_level.title = title.downcase }

  validates :title, presence: true, length: {maximum: 130}, uniqueness: {case_sensitive: false}
end

# look at models/subject.rb for index generation
