class FriendingsController < ApplicationController

  before_action :authenticate_user!

  def create
    friending_recipient = User.find(params[:id])

    # add the user to the friended uesrs if current user is different than friending receipient
    if current_user == friending_recipient
      flash[:error] = "sorry you can't friend yourself"
    else
      if current_user.friended_users << friending_recipient
        flash[:success] = "congratulations. You are now friend with #{friending_recipient.username}"
      else
        flash[:error] = "Sorry you can't be friend with #{friending_recipient.username} for the time being"
      end
    end
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
