class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @postings = Posting.order(created_at: :desc)
    @posts = Post.order(created_at: :desc)
    @posters = []
    @posts.each do |post|
      @posters.push(post.authors.last)
    end
  end

  def new
    @post = Post.new
  end

  def create
      user = current_user

      if @post = user.text_posts.create!(whitelisted_post_params)
        flash[:success] = "You successfully created a post"
        redirect_to :root
      else
        flash[:error] = "Sorry your post couldn't be created"
        render :new
      end
  end

  def show
    @post = Post.find(params[:id])
    @poster = @post.authors.last

    @comments = @post.comments.all

    @comment = Comment.new
    @comment.commentable_id = @post.id
    @comment.commentable_type = "Post"
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(whitelisted_post_params)
      flash[:success] = "You successfully updated your post"
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:success] = "Your post was successfully deleted"
      redirect_to :root
    else
      flash[:error] = "Sorry, something went wrong while deleting your post"
      redirect_to :show
    end
  end

  private
  def whitelisted_post_params
    params.require(:post).permit(:body)
  end

end
