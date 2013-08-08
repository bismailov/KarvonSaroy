# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subject < ActiveRecord::Base
  attr_accessible :title

  before_save { |subject| subject.title = title.downcase }

  validates :title, presence: true, length: {maximum: 130}, uniqueness: {case_sensitive: false} 
end

# Also, to reinforce uniqueness on database level, add an index to title field. Page 310 of Tutorial
# vim db/migrate/20130801162432_add_index_to_subjects_title.rb
#
#   1 class AddIndexToSubjectsTitle < ActiveRecord::Migration
#   2   def change
#   3     add_index :subjects, :title, unique: true
#   4   end
#   5 end
#
#bundle exec rake db:migrate
#bundle exec rake db:test:prepare
