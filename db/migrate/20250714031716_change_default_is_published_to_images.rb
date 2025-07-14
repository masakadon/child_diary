class ChangeDefaultIsPublishedToImages < ActiveRecord::Migration[6.1]
  def change
    change_column_default :images, :is_published, from: nil, to: false
  end
end
