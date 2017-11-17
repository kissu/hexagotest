class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to requests_thanks_path
      UserMailer.send_confirmation_mail(@user).deliver_now
      Request.create!(user: @user, status: 'unconfirmed')
    else
      render :new
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token == params[:token]
      @user.update_attributes(confirmation_token: nil,
                              wait_order: define_new_wait_order)
      @user.save(validate: false)
      @user.request.update(status: 'confirmed')
      redirect_to requests_thanks_path
      flash[:notice] = "Your account is now verified"
    else
      flash[:alert] = "Mail token is invalid"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :biography, :phone_number)
  end

  def define_new_wait_order
    User.maximum('wait_order') + 1
  end

end
