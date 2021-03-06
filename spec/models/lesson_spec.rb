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

require 'spec_helper'

describe Lesson do
  let(:user) { FactoryGirl.create(:user) }
  let(:course) { FactoryGirl.create(:course) }
  before do
    @lesson = course.lessons.new(title: 'lesson one', content: 'This is lesson one, and you need to speak up!', media_file: '\home\file.avi')
  end

  subject { @lesson }

  it { should respond_to(:course_id) }
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:media_file) }

  it { should be_valid }

  describe "when course_id is not present" do
    before { @lesson.course_id = nil }
    it { should_not be_valid } 
  end

  describe "when title is not present" do
    before { @lesson.title = nil }
    it { should_not be_valid } 
  end

  describe "when content is not present" do
    before { @lesson.content = nil }
    it { should_not be_valid } 
  end

  describe "when title is too long" do
    before { @lesson.title = 'a' * 251 }
    it { should_not be_valid }
  end

  describe "when media_file is too long" do
    before { @lesson.media_file = 'a' * 251 }
    it { should_not be_valid }
  end

  describe "when title is already taken case insensitive" do
    before do
      lesson_with_same_title = @lesson.dup
      lesson_with_same_title.title = @lesson.title.upcase
      lesson_with_same_title.save
    end

    it { should_not be_valid}
  end

  describe "when title is already taken" do
    before do
      lesson_with_same_title = @lesson.dup
      lesson_with_same_title.save
    end

    it { should_not be_valid}
  end




end
