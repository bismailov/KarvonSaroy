class CoursesController < ApplicationController
  before_filter :editor_user, only: [:edit, :update, :destroy] 

  #GET /courses
  def index
    # @courses = Course.all
    @courses = Course.paginate(page: params[:page] )
  end

  #GET /courses/1
  def show
    @course = Course.find(params[:id])
  end

  #GET /courses/new
  def new
    @course = current_user.courses.new
    # @subjects = Subject.all
    # @student_levels = StudentLevel.all
  end

  #GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
    # @subjects = Subject.all
    # @student_levels = StudentLevel.all
  end

  #POST /courses/
  def create
    # @course = Course.new(params[:course])
    @course = current_user.courses.new(params[:course])
    if @course.save
      flash[:success] = t("messages.course_created")
      redirect_to @course
    else
      render 'new'
    end
  end

  #PUT /courses/1
  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = t("messages.course_updated")
      redirect_to @course
    else
      render 'edit'
    end
  end

  #DELETE /courses/1
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:success] = t("messages.course_deleted")
    redirect_to courses_url
  end

end