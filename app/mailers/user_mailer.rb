class UserMailer < ApplicationMailer

  def send_confirmation_mail(user)

    mail(
      to: user.email,
      subject: 'new tests'
    )
  end

end
