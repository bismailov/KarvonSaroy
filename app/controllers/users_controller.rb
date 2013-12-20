class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_filter :correct_user, only: [:edit, :update]
  before_filter(only: [:destroy]) {|c| c.authorized_for_roles "admin"}
  before_filter(only: [:index]) {|c| c.authorized_for_roles "admin", "editor", "author"}

  # before_filter :admin_user, only: :destroy

  def index
    # @users = User.all
    @users = User.paginate( page: params[:page] )
  end

  def show
    @user = User.find(params[:id])
    # redirect_to root_path unless currect_user?(@user)

    if !current_user?(@user) and !["admin", "editor", "author"].include?(current_user.role)
      redirect_to root_path
    end

  end

  def new
      redirect_to root_path if signed_in?

    @user = User.new
  end

  def create
    redirect_to root_path if signed_in?

    @user = User.new(params[:user])
    if @user.save
      @user.deliver_verification_instructions!
      sign_in @user
      flash[:success] = t("messages.registration_welcome")
      redirect_to @user
    else
      render 'new'
  end
    end

  def edit
    # @user = User.find(params[:id])
    # because it is defined in correct_user()
  end

  def update
    # @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = t("messages.profile_updated")
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t("messages.user_destroyed")
    redirect_to users_path
  end

  # private
  # def signed_in_user
  # def correct_user
  # def admin_user :::: these were moved to sessions_helper

end
