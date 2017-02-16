class ProfilesController < ApplicationController
  include ProfilesHelper

  before_action :authenticate_user!

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile

    if @profile.dob
      @age = age(@profile.dob)
    end
    @postings = Posting.where(:user_id => @user.id).order(created_at: :desc)
    @friends = @user.friended_users
    @pending_friends = User.find_friends_with_status(@user, "pending")
    @requested_friends = User.find_friends_with_status(@user, "requested")
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def update
    @user = current_user
    @profile = @user.profile

    if @profile.update_attributes(whitelisted_profile_params)
      flash[:success] = "You successfully updated your profile"
      redirect_to user_profile_path(@user)
    else
      flash[:error] = "Sorry couldn't update your profile"
      render :edit
    end
  end

  private
  def whitelisted_profile_params
    params.require(:profile).permit(:home_place, :current_place, :college, :high_school, :about_me,
                          :interests, :relationship, :work, :languages, :phone, :dob, :profile_pic, :cover_pic)
  end
end
