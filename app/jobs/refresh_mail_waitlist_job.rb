class RefreshMailWaitlistJob < ApplicationJob
  queue_as :default

  def perform(*args)
    requests_accepted = Request.where("status = ?", 10)
    unless requests_accepted.nil?
      requests_accepted.each do |request|
        user_to_refresh = request.user
        UserMailer.send_confirmation_mail(user_to_refresh).deliver_now
        puts "mail sent to #{user_to_refresh.name} !"
      end
    end
  end
end
