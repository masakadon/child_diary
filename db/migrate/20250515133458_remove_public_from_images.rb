class RemovePublicFromImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :public, :boolean
  end
end
