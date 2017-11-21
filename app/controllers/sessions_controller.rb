class SessionsController < ApplicationController
  skip_before_action :only_signed_in, only: [:new, :create]
  before_action :only_signed_out, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user)
    @user = User.where(email: user_params[:email]).first
    if @user && @user.authenticate(user_params[:password])
      if @user.request.confirmed?
        session[:auth] = @user.id
        redirect_to dashboard_path
        flash[:notice] = "You are now connected !"
      else
        flash[:alert] = "Please confirm your email first please"
        redirect_to login_path
      end
    else
      flash[:alert] = "Wrong credentials... :)"
      redirect_to login_path
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
    flash[:notice] = "You're now disconnected"
  end

end
