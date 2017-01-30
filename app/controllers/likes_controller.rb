class LikesController < ApplicationController

  def create
    like_type = params[:likeable_type]
    liked_model = type.find(params[:likeable_id])

    if liked_model.likes.create(:user_id = > 1)
      flash[:success] = "You like a #{type.downcase}"
    else
      flash[:error] = "Sorry you couldn't like a #{type.downcase}"
    end
    redirect_to :liked_model
  end

  def destroy

  end
end
