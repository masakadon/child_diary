class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.order(:created_at)
    # @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  # def edit
  # end

  # def update
  #   if @user.update(user_params)
  #     redirect_to admin_user_path(@user), notice: '会員情報を更新しました。'
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを退会させました。'
  end
  
  private

  def authenticate_admin!
    # unless current_user&.admin?
    #   redirect_to root_path, alert: '権限がありません'
    # end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
