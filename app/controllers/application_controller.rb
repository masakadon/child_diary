class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top], unless: :admin_controller?
  # before_action :configure_permitted_parameters, if: :devise_controller?
 
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_users_path
    when User
      user_path(resource)
    else
      root_path
    end
  end
  
  private

  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end
end
