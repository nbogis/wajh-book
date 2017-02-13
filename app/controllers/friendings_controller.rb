class FriendingsController < ApplicationController

  before_action :authenticate_user!

  def create
    friending_recipient = User.find(params[:id])

    # add the user to the friended uesrs if current user is different than friending receipient

    if Friending.can_add_friend?(current_user, friending_recipient)
      flash[:error] = "sorry we can't process your friending request. Keep in mind that you are not allowed to friend yourself or request friendhip  "
    else
      flash[:success] = "congratulations. You are now friend with #{friending_recipient.username}"
    end

    # if current_user == friending_recipient
    #   flash[:error] = "sorry you can't friend yourself"
    #
    # # check if the friending request exist from the friending_recipient side
    # elsif friending_recipient.friended_users.include?(current_user)
    #   flash[:error] = "sorry a friendship request with #{friending_recipient.username} already exist"
    # else
    #
    #   if current_user.friended_users << friending_recipient
    #     flash[:success] = "congratulations. You are now friend with #{friending_recipient.username}"
    #   else
    #     flash[:error] = "Sorry you can't be friend with #{friending_recipient.username} for the time being"
    #   end
    # end
    redirect_to user_profile_path(friending_recipient)
  end

  def destroy
    unfriended_user = User.find(params[:id])

    if current_user.friended_users.delete()
      flash[:success] = "You unfriended #{unfriended_user}"
    else
      flash[:error] = "Sorry we couldn't process your unfriending request"
    end
    redirect_to user_profile_path(unfriended_user)
  end
end
