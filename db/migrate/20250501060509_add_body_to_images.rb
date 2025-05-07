class AddBodyToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :body, :text
  end
end
