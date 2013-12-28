class WikiPagesController < ApplicationController

  acts_as_wiki_pages_controller

  def edit_allowed?
    if ["admin", "editor"].include? current_user.try(:role) 
      return true
    else
      return false
    end
  end

end
