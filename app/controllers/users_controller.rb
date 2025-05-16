class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, :only => [:show, :destroy]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    if @user != current_user && !@user.is_public?
      redirect_to users_path, alert: "このユーザーのプロフィールは非公開です。"
      return
    end
    @images = @user.images
    @image = Image.new
  end

  def index
    @users = User.all
    @user = current_user
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "編集に成功しました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to root_path
  end

  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

  def user_params
    params.require(:user).permit(:name, :introduction, :email, :profile_image, :is_public)
  end

  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def correct_user
    user = User.find(params[:id])
    if user != current_user
     redirect_to user_path(user), alert: '他人のプロフィールは編集できません'
    end
  end
end
