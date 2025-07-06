class CreateGroupRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :group_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
