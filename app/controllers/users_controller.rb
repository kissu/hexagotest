class UsersController < ApplicationController
  before_action :set_user, only: [:confirm]

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
    if @user.confirmation_token == params[:token]
      add_new_user_to_waitlist(@user)
      redirect_to requests_thanks_path
      flash[:notice] = "Your account is now verified"
    else
      flash[:alert] = "Mail token is invalid"
      redirect_to root_path
    end
  end

  def refresh
    # Request.where("updated_at > ? and status = ?", 30.minutes.ago, 10)
    # BCrypt::Password.create(SecureRandom.base64 30)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :biography,
      :phone_number)
  end

  def define_new_wait_order
    User.maximum('wait_order') + 1
  end

  def add_new_user_to_waitlist(user)
    user.update_attributes(confirmation_token: nil,
                           wait_order: define_new_wait_order)
    user.save
    user.request.update(status: 'confirmed')
  end

end
