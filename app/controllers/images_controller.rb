class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @image = Image.new(image_params)
    @image.user_id = current_user.id
    @image.save 
    redirect_to image_path(@image.id)
  end
  
  def index
    @images = Image.all
    @image = Image.new
    @user = current_user
  end

  def show
    @image = Image.find(params[:id])
    @user = @image.user
    @image_new = Image.new
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private

  def image_params
    params.require(:image).permit(:title, :image, :body)
end
