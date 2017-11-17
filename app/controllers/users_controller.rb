class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to requests_thanks_path
      UserMailer.send_confirmation_mail(@user).deliver_now
      flash[:notice] = "Mail sent"
    else
      render :new
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      # @user.update_attributes(confirmation_token: nil)
      @user.confirmation_token = nil
      @user.save(validate: false)
      puts 'token ok'
      redirect_to requests_thanks_path
    else
      puts 'wrong token :('
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :biography, :phone_number)
  end

end
