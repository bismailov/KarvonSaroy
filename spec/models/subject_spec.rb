# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Subject do
  before { @subject = Subject.new(title: "English for preschool") }

  subject { @subject }

  it { should respond_to(:title) }
  it { should be_valid }

  describe "when title is not present" do
    before { @subject.title = "" }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @subject.title = "a" * 131 }
    it { should_not be_valid }
  end


  describe "when title is already taken" do
    before do
      subject_with_same_title = @subject.dup
      subject_with_same_title.title = @subject.title.upcase
      subject_with_same_title.save
    end

    it { should_not be_valid }
  end

end
