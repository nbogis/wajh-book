class PicturesController < ApplicationController

  before_action :authenticate_user!

  # def index
  #   @user = User.find(params[:user_id])
  #   @pictures = @user.pic_posts.order(created_at: :desc)
  # end

  def new
    @user = User.find(params[:user_id])
    @picture = Picture.new
  end

  def create
    if user_signed_in?
      @user = User.find(params[:user_id])
      @picture = Picture.create(white_listed_pics_params)

      if @picture
        flash[:success] = "You successfully uploaded a picture"
        redirect_to user_pictures(@user)
      else
        flash[:error] = "Sorry, we couldn't upload your picture"
        redirect_to :new
      end
    else
      flash[:error] = "You need to sign in to upload a post"
      redirect_to sign_in_path
    end
  end

  def destroy
    if user_signed_in?
      @user = User.find(params[:user_id])
      @picture = Picture.find(params[:id])

      if @picture
        flash[:success] = "You successfully deleted your picture"
      else
        flash[:error] = "Sorry, we couldn't delete your picture"
      end
      redirect_to user_pictures(@user)
    else
      flash[:error] = "You need to sign in to delete a picture"
      redirect_to sign_in_path
    end
  end

  private
  def white_listed_pics_param
    require(:picture).permit(:details, :file)
  end


end
