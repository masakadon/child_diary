class Users::SessionsController < ApplicationController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end

  def after_sign_in_path_for(resource)
    user_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
