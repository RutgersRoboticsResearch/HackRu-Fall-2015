class AdUserIdToStatuses < ActiveRecord::Migration
  def up
  	add_column :statuses, :user_id, :integer
  	add_index :statuses, :user_id
  end

  def down
  	remove_column :statuses, :name
  end
end
