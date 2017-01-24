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
      flash[:success] = "You successfully created a post"
      redirect_to :root
    else
      flash[:error] = "Sorry could not create a new post!"
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
      flash[:error] = "Sorry could not update your post!"
      render :edit
    end
  end

  private
  def whitelisted_post_params
    params.require(:post).permit(:body, :author_name)
  end
end
