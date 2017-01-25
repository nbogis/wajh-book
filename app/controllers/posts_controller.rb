class PostsController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc )
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(whitelisted_post_params) # params with author and body to submit to db

    if @post.save
      flash[:success] = "You successfully created a post"
      redirect_to :root
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
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
    params.require(:post).permit(:body,:author_name)
  end
end
