class UsersController < ApplicationController
  before_action :authenticate_user!


  def accept_friend
    @user = User.find(params[:id])

    if User.accept_friend(@user, current_user)
      flash[:success] = "You are now friend with #{@user.username}"
    else
      flash[:error] = "Sorry we couldn't process accepting friendship"
    end
    redirect_to user_profile_path(@user)
  end

  def request_friend
    friending_recipient = User.find(params[:id])

    # add the user to the friended uesrs if current user is different than friending receipient and no existant friendhip request valid
    if User.request_friend(current_user, friending_recipient)
      flash[:success] = "You successfully requested friendship with #{friending_recipient.username}"
    else
      flash[:error] = "sorry we can't process your friending request. Keep in mind that you are not allowed to friend yourself or request friendship more than once "
    end
    redirect_to user_profile_path(friending_recipient)
  end

  def delete_friend
    unfriended_user = User.find(params[:id])

    if User.delete_friend(current_user, unfriended_user)
      flash[:success] = "You unfriended #{unfriended_user.username}"
    else
      flash[:error] = "Sorry we couldn't process your unfriending request"
    end
    redirect_to user_profile_path(unfriended_user)
  end

  def reject_friend
    rejected_user = User.find(params[:id])

    if User.reject_friend(rejected_user, current_user)
      flash[:success] = "You successfully rejected friendship request from #{rejected_user.username}"
    else
      flash[:error] = "Sorry we couldn't process your rejection request"
    end
    redirect_to user_profile_path(current_user)
  end
end
