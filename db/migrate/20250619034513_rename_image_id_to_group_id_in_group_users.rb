class RenameImageIdToGroupIdInGroupUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_users, :image_id, :group_id
  end
end
