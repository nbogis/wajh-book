class LikesController < ApplicationController

  before_action :require_login

  def create
    type = params[:likeable]
    type_id = type.downcase + "_id"

    if type == "Post"
      @liked_record = Post.find(params[type_id])
    elsif type == "Comment"
      @liked_record = Comment.find(params[type_id])
    end

    if @liked_record.likes.create(:user_id => current_user.id)
      flash[:success] = "You like a #{type.downcase}"
    else
      flash[:error] = "Sorry you couldn't like a #{type.downcase}"
    end
    redirect_to :back
  end

  def destroy
    @like = Like.find(params[:id])

    if @like.destroy
      flash[:success] = "You disliked the post"
    else
      flash[:success] = "Sorry we couldn't process your dislike"
    end
    redirect_to :back
  end
end
