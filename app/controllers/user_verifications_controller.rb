class UserVerificationsController < ApplicationController
  before_filter :load_user_using_perishable_token 

  def show

    if @user
      @user.verify!
      flash[:notice] = t("notifier.verify_email.thanks_for_verification")
    end

    if signed_in?
      redirect_to(root_path)
    else
      redirect_to(signin_path)
    end

  end

  def resend_activation
    if signed_in? && !@user.verified
      @user.deliver_verification_instructions!
      flash[:notice] = t("notifier.verify_email.verification_email_resent")
      redirect_to root_path
    end
  end

      

  private

    def load_user_using_perishable_token
      @user = User.find_using_perishable_token(params[:id])
      flash[:notice] = t("notifier.verify_email.unable_to_find_account") unless @user
    end

end
