class AddImageIdToPostComments < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments, :image_id, :integer
  end
end
