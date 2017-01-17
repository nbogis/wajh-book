class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(whitelisted_post_params) # params with author and body to submit to db

    if @post.save
      redirect_to :root
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def whitelisted_post_params
    params.require(:post).permit(:body, :author_name)
  end
end
