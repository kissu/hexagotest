class CheckUserToRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # useless I guess ?
  end
end
