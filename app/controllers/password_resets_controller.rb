class PasswordResetsController < ApplicationController

  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      redirect_to(root_path, :notice => t("notifier.password_reset_instructions.instructions_sent"))
    else
      flash[:notice] = t("notifier.password_reset_instructions.user_not_found")
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = t("notifier.password_reset_instructions.password_updated")
      redirect_to(signin_path)
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id], KarvonSaroy::Application.config.PERISHABLE_TOKEN_PASS_RESET)
    unless @user
      flash[:notice] = t("notifier.password_reset_instructions.account_not_found")
      redirect_to(root_url)
    end
  end
end
