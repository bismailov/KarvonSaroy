class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
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
    @user = User.find(param[:id])
  end
end
