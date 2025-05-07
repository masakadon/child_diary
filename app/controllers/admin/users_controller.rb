class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: '会員情報を更新しました。'
    else
      render :edit
    end
  end
  
  private

  def authenticate_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: '権限がありません'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
