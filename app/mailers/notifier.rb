class Notifier < ActionMailer::Base
  default from: KarvonSaroy::Application.config.APP_EMAIL

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.verify_email.subject
  #
  def verify_email(user)
    
    @greeting = t("notifier.verify_email.greeting")

    @confirm_account_url = user_verification_url(user.perishable_token)

    mail to: user.email, 
      subject: "[#{KarvonSaroy::Application.config.APP_NAME}] #{t("notifier.verify_email.subject")}"
  end
end
