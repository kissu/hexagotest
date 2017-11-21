class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :only_signed_in
  helper_method :current_user

  private

  def only_signed_in
    if !current_user
      redirect_to login_path
      flash[:alert] = "Please sign-in"
    end
  end

  def current_user
    return nil if !session[:auth] || !session[:auth]
    return @user if @user
    @user = User.find_by_id(session[:auth])
  end
end
