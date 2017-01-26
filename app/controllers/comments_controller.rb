class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(whitelisted_comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = "You have successfully posted a comment"
    else
      flash[:error] = "Sorry, something went wrong while posting your comment"
    end
    redirect_to post_path(@comment.post_id)
  end

  private
  def whitelisted_comment_params
    params.require(:comment).permit(:body,:user_id)
  end
end
