# == Schema Information
#
# Table name: student_levels
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe StudentLevel do
  before { @student_level = StudentLevel.new(title: "Mastery") }

  subject { @student_level }

  it { should respond_to(:title) }
  it { should be_valid }

  describe "when title is not present" do
    before { @student_level.title = "" }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @student_level.title = "a" * 131 }
    it { should_not be_valid }
  end


  describe "when title is already taken" do
    before do
      student_level_with_same_title = @student_level.dup
      student_level_with_same_title.title = @student_level.title.upcase
      student_level_with_same_title.save
    end

    it { should_not be_valid }
  end

end
