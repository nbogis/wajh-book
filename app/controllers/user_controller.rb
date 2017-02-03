class UserController < ApplicationController
  before_action :require_login, except: [:index, :new]

  def index
    @users = User.all
  end

  def create
    if user_signed_in?
      flash[:error] = "You are already signed in as #{current_user.first_name} #{current_user.last_name}"
      redirect_to root_path
    else
      @user = User.new(whitelisted_user_params)

      if @user.save
        @user.profile.create!()
        flash[:success] = "congratulations! You are now part of WajhBook"
        sign_in @user
        redirect_to root_path
      else
        flash[:error] = "Sorry, we couldn't sign you in to WajhBook"
        redirect_to sign_in_path
      end
    end
  end

  private
  def whitelisted_user_params
    require(:user).permit(:first_name, :last_name,:email, :password, :password_confirmation)
  end
end
