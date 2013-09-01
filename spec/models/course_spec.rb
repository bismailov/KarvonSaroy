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

require 'spec_helper'

describe Course do
  let (:user) { FactoryGirl.create(:user) }
  let (:subject_) { FactoryGirl.create(:subject) } # "_" so that to differenciate from subject test directive
  let (:student_level) { FactoryGirl.create(:student_level) }

  before do
    # @course = Course.new(user_id: user.id, subject_id: subject_.id, student_level_id: student_level.id, 
                         # title: "French for Us", objectives: "Lorem ipsum")
    
    @course = user.courses.build(title: "French", objectives: "lorem")
    @course.subject = subject_
    @course.student_level = student_level
  end

  subject { @course }

  it { should respond_to(:user_id) }
  it { should respond_to(:subject_id) }
  it { should respond_to(:student_level_id) }
  it { should respond_to(:title) }
  it { should respond_to(:objectives) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @course.user_id = nil }
    it { should_not be_valid }
  end

  describe "when subject_id is not present" do
    before { @course.subject_id = nil }
    it { should_not be_valid }
  end

  describe "when student_level_id is not present" do
    before { @course.student_level_id = nil }
    it { should_not be_valid }
  end

  describe "when title is not present" do
    before { @course.title = "" }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @course.title = "a" * 251 }
    it { should_not be_valid }
  end


  describe "when title is already taken" do
    before do
      course_with_same_title = @course.dup
      course_with_same_title.title = @course.title.upcase
      course_with_same_title.save
    end

    it { should_not be_valid }
  end
  
  
  describe "when objectives are not present" do
    before { @course.objectives = "" }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access user_id" do
      expect do
       Course.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end

    # it "should not allow access subject_id" do
    #   expect do
    #    Course.new(subject_id: subject_.id)
    #   end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    # end

    # it "should not allow access student_level_id" do
    #   expect do
    #    Course.new(student_level_id: student_level.id)
    #   end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    # end

  end

end

