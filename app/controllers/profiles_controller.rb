class ProfilesController < ApplicationController
  include ProfilesHelper

  before_action :require_login, except: [:show]

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile

    if @profile.dob
      @age = age(@profile.dob)
    end
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @user = current_user
    @profile = @user.profile

    if @profile.update_attributes(whitelisted_profile_params)
      flash[:success] = "You successfully updated your post"
      redirect_to user_profile_path(@user)
    else
      render :edit
    end
  end

  private
  def whitelisted_profile_params
    params.require(:profile).permit(:home_place, :current_place, :college, :high_school, :about_me,
                          :interests, :relationship, :work, :languages, :phone, :dob)
  end
end
