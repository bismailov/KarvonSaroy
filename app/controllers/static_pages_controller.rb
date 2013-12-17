class StaticPagesController < ApplicationController
  def home
    @user = User.new
    @courses = Course.all
  end

  def about
  end
end
