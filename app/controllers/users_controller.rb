class UsersController < ApplicationController
  before_action :set_user, only: [:confirm, :refresh]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.send_confirmation_mail(@user).deliver_later
      redirect_to requests_thanks_path
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
    if @user.confirmation_token == params[:token]
      @user.nillify_confirmation_token
      @user.save
      @user.request.update(status: 'confirmed')
      redirect_to requests_thanks_path
      flash[:notice] = "Thanks for your refresh ! :)"
    else
      flash[:alert] = "Incorect token.."
      redirect_to root_path
    end
  end

  private

  def define_next_wait_order
    User.maximum('wait_order') + 1
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :biography,
      :phone_number)
  end

  def add_new_user_to_waitlist(user)
    user.update_attributes(confirmation_token: nil,
                           wait_order: define_next_wait_order)
    # maybe change for `update_attributes!` ??
    user.save
    user.request.update(status: 'confirmed')
  end

end
