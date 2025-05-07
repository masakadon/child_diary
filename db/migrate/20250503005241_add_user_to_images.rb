class AddUserToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :user, :boolean
  end
end
