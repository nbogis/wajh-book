class CommentsController < ApplicationController
  before_action :require_login
  def create
    @comment = Comment.new(whitelisted_comment_params)
    # post_id is in params not commentable_id and type. This could be picture_id so we need to do get the type id to get commentable_id
    type = params[:commentable]
    type_id = type.downcase + "_id"
    @comment.commentable_type = type
    @comment.commentable_id = params[type_id]


    @comment.user_id = current_user.id 

    if @comment.save!
      flash[:success] = "You have successfully posted a comment"
    else
      flash[:error] = "Sorry, something went wrong while posting your comment"
    end

    redirect_to post_path(@comment.commentable_id)
  end

  private
  def whitelisted_comment_params
    params.require(:comment).permit(:body,:user_id)
  end


end
