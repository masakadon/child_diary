class Public::GroupRequestsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    group = Group.find(params[:group_id])
    if group.group_requests.exists?(user_id: current_user.id)
      flash[:alert] = "すでに申請済みです"
    else
      group.group_requests.create(user: current_user, status: :pending)
      flash[:notice] = "参加申請を送信しました"
    end
    redirect_to group_path(group)
  end

  def update
    request = GroupRequest.find(params[:id])
    if params[:status] == "approve"
      request.update(status: :approved)
      GroupUser.create(user: request.user, group: request.group)
    elsif params[:status] == "reject"
      request.update(status: :rejected)
    end
    redirect_to group_path(request.group)
  end

end
