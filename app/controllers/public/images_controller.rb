class Public::ImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :show]
  before_action :correct_image_user, only: [:edit, :update]

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
    @images = Image.all
    @user = current_user 
    @image = Image.new
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
    user = image.user
    image.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to user_path(user)
  end
  
  private

  def image_params
    params.require(:image).permit(:title, :image, :body, :is_published)
  end

  def correct_image_user
    image = Image.find(params[:id])
    unless image.user == current_user
     redirect_to images_path, alert: '他人の投稿は編集できません' 
    end
  end
end
