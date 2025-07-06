class Public::GroupMembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    group = Group.find(params[:group_id])
    membership = group.group_memberships.build(user: current_user, status: :pending)
    if membership.save
      redirect_to group_path(group), notice: "参加申請を送りました"
    else
      redirect_to group_path(group), alert: "申請に失敗しました"
    end
  end

  def update
    membership = GroupMembership.find(params[:id])
    if membership.group.owner_id == current_user.id
      membership.update(status: params[:status])
      redirect_to group_path(membership.group), notice: "申請を処理しました"
    else
      redirect_to groups_path, alert: "権限がありません"
    end
  end

  def destroy
    membership = GroupMembership.find(params[:id])
    if membership.user == current_user
      membership.destroy
      redirect_to group_path(membership.group), notice: "グループから退会しました"
    else
      redirect_to groups_path, alert: "権限がありません"
    end
  end

end
