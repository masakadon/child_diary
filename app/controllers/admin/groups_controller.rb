module AdminPanel
 class Admin::GroupsController < ApplicationController

  layout 'admin'
  
  before_action :authenticate_admin!
  before_action :set_group, only: [:destroy]

  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "グループを削除しました"
  end

  private

  def set_group
   @group = Group.find(params[:id])
  end
 end
end