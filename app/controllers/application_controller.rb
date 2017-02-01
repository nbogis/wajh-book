class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    unless user_signed_in?
      flash[:error] = "You need to sign in before accessing WajhBook"
      redirect_to sign_in_path
    end
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :email, :password, :profile_pic, :cover_pic])
  end
end
