class StaticPagesController < ApplicationController
  def home
    @user = User.new
    # @courses = Course.all
    @courses = Course.find(:all, include: [:subject, :student_level])
  end

  def about
  end

  def help
  end

end
