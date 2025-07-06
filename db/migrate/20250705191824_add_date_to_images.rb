class AddDateToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :date, :datetime
  end
end
