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

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.commentable_id)
  end

  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(@comment.commentable_id)

    if @comment.update_attributes(whitelisted_comment_params)
      flash[:success] = "You successfully updated your comment"
      redirect_to @post
    else
      flash[:error] = "Sorry we couldn't edit your comment"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    @post = Post.find(@comment.commentable_id)

    if @comment.destroy
      flash[:success] = "You successfully deleted your comment"
    else
      flash[:error] = "Sorry we couldn't delete your comment"
    end
      redirect_to @post
  end

  private
  def whitelisted_comment_params
    params.require(:comment).permit(:body)
  end


end
