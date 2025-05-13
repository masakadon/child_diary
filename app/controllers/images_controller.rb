class ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]

  def create
    @image = Image.new(image_params)
    @image.user_id = current_user.id
    if @image.save 
     flash[:notice] = "投稿に成功しました。"
     redirect_to image_path(@image.id)
    else
     @user = current_user
     @images = Image.all
     @post_comment = PostComment.new
     render :index
    end
  end
  
  def index
    # @image = Image.find(params[:id])
    # # if user_signed_in?
    # #   @images = Image.where(public: true).or(Image.where(user: current_user))
    # # else
    # #   @images = Image.where(public: true)
    # end
    @images = Image.all
    @image = Image.new
    @user = current_user
    @post_comment = PostComment.new 
  end

  def show
    @image = Image.find(params[:id])
    @post_comment = PostComment.new
    @user = @image.user
    @image_new = Image.new
  end

  def edit
    image =Image.find(params[:id])
    unless image.user_id == current_user.id
      redirect_to image_path
    end
    @image = Image.find(params[:id])
    @user = current_user
  end

  def update
    @image =Image.find(params[:id])
    if @image.update(image_params)
     flash[:notice] = "編集に成功しました"
     redirect_to image_path(@image.id)
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    flash[:notice] = "削除に成功しました"
    redirect_to images_path
  end
  
  private

  def image_params
    params.require(:image).permit(:title, :image, :body, :public)
  end

  def correct_iamge_user
    image = Image.find(params[:id])
    unless image.user == current_user
     redirect_to images_path, alert: '他人の投稿は編集できません' 
    end
  end
end
