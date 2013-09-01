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

  has_many :courses

  before_save {|student_level| student_level.title = title.downcase }

  validates :title, presence: true, length: {maximum: 130}, uniqueness: {case_sensitive: false}

  private
    def title_for_select
      title.capitalize
    end

end

# look at models/subject.rb for index generation
