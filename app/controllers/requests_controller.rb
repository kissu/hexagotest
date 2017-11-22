class RequestsController < ApplicationController

  def index
    @requests = Request.confirmed.order(:id)
    @user = current_user
  end

end
