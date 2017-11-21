class RequestsController < ApplicationController

  def index
    @requests = Request.confirmed
    @user = current_user
  end

end
