class UserMailerLocal < Devise::Mailer
  include Devise::Mailers::Helpers
  layout 'mailer'

  default template_path: 'user_mailer/'
  default from: UserMailer::SENDER_NO_REPLY

  def confirmation_instructions(record, token, _opts = {})
    @title = I18n.t('mailers.user_mailer.confirmation_instructions.title')
    @name = record.email
    @link = user_confirmation_url(confirmation_token: token)
    mail(to: record.email,
         subject: @title)
  end

  def reset_password_instructions(record, token, _opts = {})
    @title = I18n.t('mailers.user_mailer.reset_password_instructions.title')
    @name = record.email
    @link = edit_user_password_url(record, reset_password_token: token)
    mail(to: record.email,
         subject: @title)
  end

  def unlock_instructions(record, token, _opts = {})
    @title = I18n.t('mailers.user_mailer.unlock_instructions.title')
    @name = record.email
    @link = user_unlock_url(:unlock_token => token)
    mail(to: record.email,
         subject: @title)
  end
end