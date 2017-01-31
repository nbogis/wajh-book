class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    unless user_signed_in?
      flash[:error] = "You need to sign in before accessing WajhBook"
      redirect_to sign_in_path
    end
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :profile_pic, :cover_pic])
  end
end
