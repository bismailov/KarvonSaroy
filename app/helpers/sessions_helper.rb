module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.fullpath  
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: t("messages.session.please_sign_in")
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def author_user
    redirect_to(root_path) unless current_user.author?
  end

  def authorized_for_roles(*args)
    # From: http://stackoverflow.com/a/6076035/999973
    # args.any? { |role_name| ROLES.include? role_name  }
    # ROLES = %w[admin moderator editor author banned] in user model
    # calling it:
    # before_filter(only: [:edit, :update, :destroy]) {|c| c.authorized_for_roles "admin", "editor"}
  
    # args.any? { |role_name| current_user.role == role_name }
    redirect_to(root_path) unless args.any? { |role_name| current_user.role == role_name }
  end
end
