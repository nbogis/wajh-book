class ProfilesController < ApplicationController
  before_action :require_login, except: [:show]

  def show
    @user = User.find(params[:user_id])
  end
end
