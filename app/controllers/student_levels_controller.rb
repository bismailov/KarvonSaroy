class StudentLevelsController < ApplicationController
  before_filter(only: [:new, :create, :edit, :update, :destroy]) { |c| c.authorized_for_roles("admin", "editor") } 

  #GET /student_levels
  def index
    # @student_levels = StudentLevel.all
    @student_levels = StudentLevel.paginate(page: params[:page] )
  end

  #GET /student_levels/1
  def show
    @student_level = StudentLevel.find(params[:id])
  end

  #GET /student_levels/new
  def new
    @student_level = StudentLevel.new
  end

  #GET /student_levels/1/edit
  def edit
    @student_level = StudentLevel.find(params[:id])
  end

  #POST /student_levels/
  def create
    @student_level = StudentLevel.new(params[:student_level])
    if @student_level.save
      flash[:success] = t("messages.student_level_created")
      redirect_to @student_level
    else
      render 'new'
    end
  end

  #PUT /student_levels/1
  def update
    @student_level = StudentLevel.find(params[:id])
    if @student_level.update_attributes(params[:student_level])
      flash[:success] = t("messages.student_level_updated")
      redirect_to @student_level
    else
      render 'edit'
    end
  end

  #DELETE /student_levels/1
  def destroy
    @student_level = StudentLevel.find(params[:id])
    @student_level.destroy
    flash[:success] = t("messages.student_level_deleted")
    redirect_to student_levels_url
  end

end
