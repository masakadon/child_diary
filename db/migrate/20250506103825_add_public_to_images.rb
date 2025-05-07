class AddPublicToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :public, :boolean
  end
end
