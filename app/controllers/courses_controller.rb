class CoursesController < ApplicationController
    before_filter(only: [:new, :create, :edit, :update, :destroy]) { |c| c.authorized_for_roles("admin", "editor") } 
                 
  #GET /courses
  def index
    @courses = Course.paginate( page: params[:page], include: [:subject, :student_level] )
    #moved ordering to the model (default_scope)
    # @courses = Course.order("subject_id").order("student_level_id")
  end

  #GET /courses/1
  def show
    @course = Course.find(params[:id])
    @lessons = @course.lessons.paginate(page: params[:page])
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
