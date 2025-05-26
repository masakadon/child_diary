module Admin
 class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user_count = User.count
    @comment_count = PostComment.count
  end
 end
end