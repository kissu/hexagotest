class RequestsController < ApplicationController

  def index
    @requests = Request.confirmed.order(:id).includes(:user)
    @user = current_user
  end

end
