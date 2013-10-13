class LessonsController < ApplicationController
    before_filter(only: [:new, :create, :edit, :update, :destroy]) { |c| c.authorized_for_roles("admin", "editor") } 
                 
    # course_lessons GET    /courses/:course_id/lessons(.:format)          lessons#index
                   # POST   /courses/:course_id/lessons(.:format)          lessons#create
 # new_course_lesson GET    /courses/:course_id/lessons/new(.:format)      lessons#new
# edit_course_lesson GET    /courses/:course_id/lessons/:id/edit(.:format) lessons#edit
     # course_lesson GET    /courses/:course_id/lessons/:id(.:format)      lessons#show
                   # PUT    /courses/:course_id/lessons/:id(.:format)      lessons#update
                   # DELETE /courses/:course_id/lessons/:id(.:format)      lessons#destroy

  #GET /courses/:course_id/lessons
  def index
    # @lessons = Course.all
    @lessons = Lesson.paginate(page: params[:page] )
  end

  #GET /courses/:course_id/lessons/:id
  def show
    @lesson = Lesson.find(params[:id])
  end

  #GET /courses/:course_id/lessons/new 
  def new
    @lesson = @course.lessons.new
  end

  #GET /courses/:course_id/lessons/:id/edit
  def edit
    @lesson = Lesson.find(params[:id])
  end

  #POST /courses/:course_id/lessons 
  def create
    # @course = Course.new(params[:course])
    @lesson = @course.lesson.new(params[:lesson])
    if @lesson.save
      flash[:success] = t("messages.lesson_created")
      redirect_to @lesson
    else
      render 'new'
    end
  end

  #PUT /courses/:course_id/lessons/:id 
  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      flash[:success] = t("messages.lesson_updated")
      redirect_to @lesson
    else
      render 'edit'
    end
  end

  #DELETE /courses/:course_id/lessons/:id
  def destroy
    @lesson = Lesson.find(params[:id])
    @lesson.destroy
    flash[:success] = t("messages.lesson_deleted")
    redirect_to lessons_url
  end

end
