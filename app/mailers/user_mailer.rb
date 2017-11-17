class UserMailer < ApplicationMailer

  def send_confirmation_mail(user)
    @user = user
    mail(
      to: user.email,
      subject: 'Your confirmation mail'
    )
  end

end
