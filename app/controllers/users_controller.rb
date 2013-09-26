class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  # before_filter :admin_user, only: :destroy
  before_filter(only: [:destroy]) {|c| c.authorized_for_roles "admin"}

  def index
    # @users = User.all
    @users = User.paginate( page: params[:page] )
  end

  def show
    @user = User.find(params[:id])
  end

  def new
      redirect_to root_path if signed_in?

    @user = User.new
  end

  def create
    redirect_to root_path if signed_in?

    @user = User.new(params[:user])
    if @user.save
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
