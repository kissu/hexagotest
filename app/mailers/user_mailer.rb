class UserMailer < ApplicationMailer

  def send_confirmation_mail(user)
    @user = user
    mail(
      to: user.email,
      subject: 'Your confirmation mail'
    )
  end

  def send_refresh_mail(user)
    @user = user
    mail(
      to: user.email,
      subject: 'Still interested in our coworking ?'
    )
  end

  def send_expired_mail(user)
    @user = user
    mail(
      to: user.email,
      subject: "We are sad that you're leaving"
    )
  end

end
