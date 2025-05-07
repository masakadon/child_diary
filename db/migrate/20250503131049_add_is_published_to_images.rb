class AddIsPublishedToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :is_published, :boolean
  end
end
