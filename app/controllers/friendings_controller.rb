class FriendingsController < ApplicationController

  before_action :authenticate_user!

  def create
    friending_recipient = User.find(params[:id])

    # add the user to the friended uesrs if current user is different than friending receipient and no existant friendhip request valid
    if Friending.request_friendship(current_user, friending_recipient)
      flash[:success] = "congratulations. You are now friend with #{friending_recipient.username}"
      Friending.request_friendship(current_user, friending_recipient)
    else
      flash[:error] = "sorry we can't process your friending request. Keep in mind that you are not allowed to friend yourself or request friendship more than once "
    end
    redirect_to user_profile_path(friending_recipient)
  end

  def destroy
    unfriended_user = User.find(params[:id])

    if Friending.delete_friend(current_user, unfriended_user)
      flash[:success] = "You unfriended #{unfriended_user.username}"
      unfriended_user.friended_users.delete(current_user)
    else
      flash[:error] = "Sorry we couldn't process your unfriending request"
    end
    redirect_to user_profile_path(unfriended_user)
  end
end
