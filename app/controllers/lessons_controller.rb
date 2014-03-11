class LessonsController < ApplicationController
    before_filter(only: [:new, :create, :edit, :update, :destroy]) { |c| c.authorized_for_roles("admin", "editor") } 
    before_filter :load_course
                 
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
    # @lessons = @course.lessons.paginate(page: params[:page] )
    redirect_to @course
  end

  #GET /courses/:course_id/lessons/:id
  def show
    unless signed_in?
      redirect_to signup_path, alert: t("messages.session.please_sign_in")
    end

    @lesson = @course.lessons.find(params[:id])

    @lesson_ordinal_number = @course.lessons.pluck(:id).index(params[:id].to_i)+1
    @course_progress = (100 / @course.lessons.count * @lesson_ordinal_number).to_i 

  end

  #GET /courses/:course_id/lessons/new 
  def new
    @lesson = @course.lessons.new
  end

  #GET /courses/:course_id/lessons/:id/edit
  def edit
    @lesson = @course.lessons.find(params[:id])
  end

  #POST /courses/:course_id/lessons 
  def create
    @lesson = @course.lessons.new(params[:lesson])
    if @lesson.save
      flash[:success] = t("messages.lesson_created")
      redirect_to [@course, @lesson]
    else
      render 'new'
    end
  end

  #PUT /courses/:course_id/lessons/:id 
  def update
    @lesson = @course.lessons.find(params[:id])
    if @lesson.update_attributes(params[:lesson])
      flash[:success] = t("messages.lesson_updated")
      redirect_to [@course,@lesson]
    else
      render 'edit'
    end
  end

  #DELETE /courses/:course_id/lessons/:id
  def destroy
    @lesson = @course.lessons.find(params[:id])
    @lesson.destroy
    flash[:success] = t("messages.lesson_deleted")
    redirect_to course_lessons_url
  end

  private
    def load_course
      @course = Course.find(params[:course_id])
    end

end
