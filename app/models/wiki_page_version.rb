# == Schema Information
#
# Table name: wiki_page_versions
#
#  id         :integer          not null, primary key
#  page_id    :integer          not null
#  updator_id :integer
#  number     :integer
#  comment    :string(255)
#  path       :string(255)
#  title      :string(255)
#  content    :text
#  updated_at :datetime
#

class WikiPageVersion < ActiveRecord::Base

  acts_as_wiki_page_version

end
