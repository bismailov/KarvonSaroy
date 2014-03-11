# == Schema Information
#
# Table name: wiki_pages
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  updator_id :integer
#  path       :string(255)
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WikiPage < ActiveRecord::Base

  acts_as_wiki_page

end
