class SubjectsController < ApplicationController
  # before_filter :admin_user 
  before_filter(only: [:new, :create, :edit, :update, :destroy]) { |c| c.authorized_for_roles("admin", "editor") } 

  #GET /subjects
  def index
    # @subjects = Subject.all
    @subjects = Subject.paginate(page: params[:page] )
  end

  #GET /subjects/1
  def show
    @subject = Subject.find(params[:id])
  end

  #GET /subjects/new
  def new
    @subject = Subject.new
  end

  #GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  #POST /subjects/
  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      flash[:success] = t("messages.subject_created")
      redirect_to @subject
    else
      render 'new'
    end
  end

  #PUT /subjects/1
  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      flash[:success] = t("messages.subject_updated")
      redirect_to @subject
    else
      render 'edit'
    end
  end

  #DELETE /subjects/1
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:success] = t("messages.subject_deleted")
    redirect_to subjects_url
  end

end
