class UserMailer < ApplicationMailer

  def test
    # @message = params[:message]

    mail(
      from: 'hello@kissu.io',
      to: 'konstantin.bifert@gmail.com',
      reply_to: 'konstantin.bifert@gmail.com',
      subject: 'Reporting'
    )
  end

end
