class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = PostComment.includes(:user, :image).order(created_at: :desc)
  end

  def destroy
    comment = PostComment.find(params[:id])
    comment.destroy
    redirect_to admin_comments_path, notice: "コメントを削除しました"
  end
end
