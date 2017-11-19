class RefreshMailWaitlistJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Request.check_for_updates
  end
end
