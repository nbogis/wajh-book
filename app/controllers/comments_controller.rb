class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(whitelisted_comment_params)
    # post_id is in params not commentable_id and type. This could be picture_id so we need to do get the type id to get commentable_id
      dfadsf
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
    if @comment.commentable_type == "Post"
      redirect_to post_path(@comment.commentable_id)
    else
      user = Picture.find(@comment.commentable_id).authors
      redirect_to user_picture_path(user,@comment.commentable_id)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    type = @comment.commentable_type

    if type == "Post"
      @post = Post.find(@comment.commentable_id)
      @poster = @post.authors.last
    else
      @picture = Picture.find(@comment.commentable_id)
    end
  end

  def update
    @comment = Comment.find(params[:id])
    type = params[:commentable]

    if type == "Post"
      @post = Post.find(@comment.commentable_id)
    else
      @picture = Picture.find(@comment.commentable_id)
    end

    if @comment.update_attributes(whitelisted_comment_params)
      flash[:success] = "You successfully updated your comment"
      if type == "Post"
        redirect_to @post
      else
        redirect_to user_picture_path(@picture.authors, @picture)
      end
    else
      flash[:error] = "Sorry we couldn't edit your comment"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    type = params[:commentable]

    if type == "Post"
      @post = Post.find(@comment.commentable_id)
    else
      @picture = Picture.find(@comment.commentable_id)
    end

    if @comment.destroy
      flash[:success] = "You successfully deleted your comment"
    else
      flash[:error] = "Sorry we couldn't delete your comment"
    end
    if type == "Post"
      redirect_to @post
    else
      redirect_to user_picture_path(@picture.authors, @picture)
    end
  end

  private
    def whitelisted_comment_params
      params.require(:comment).permit(:body)
    end


end
