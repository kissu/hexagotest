class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to requests_thanks_path
      UserMailer.send_confirmation_mail(@user).deliver_now
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :biography, :phone_number)
  end

end
